Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vBKU578/NOgzhCq08tPezZ4CiQpthseCn3vP7eUHtc=;
 b=VAaEviyFmGIVSBvW0ZytKjx/t9/Y6WWxdDIkNhHf5ikqFCvfQZgguesjaxnfwxlXnHWWiTOV5xllOunO3gyRTGJm13KcTQOO+40niTsP5JNALpWRqkUkFrtHb+6Eb9bGgocEuZVgVGiXDFujoNiLoV06ggNRoNO6RxLG/v7+Rlo=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon,  2 Aug 2021 02:17:30 +0300
Message-Id: <20210801231730.7493-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net] net: bridge: validate the NUD_PERMANENT bit
	when adding an extern_learn FDB entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>

Currently it is possible to add broken extern_learn FDB entries to the
bridge in two ways:

1. Entries pointing towards the bridge device that are not local/permanent:

ip link add br0 type bridge
bridge fdb add 00:01:02:03:04:05 dev br0 self extern_learn static

2. Entries pointing towards the bridge device or towards a port that
are marked as local/permanent, however the bridge does not process the
'permanent' bit in any way, therefore they are recorded as though they
aren't permanent:

ip link add br0 type bridge
bridge fdb add 00:01:02:03:04:05 dev br0 self extern_learn permanent

Since commit 52e4bec15546 ("net: bridge: switchdev: treat local FDBs the
same as entries towards the bridge"), these incorrect FDB entries can
even trigger NULL pointer dereferences inside the kernel.

This is because that commit made the assumption that all FDB entries
that are not local/permanent have a valid destination port. For context,
local / permanent FDB entries either have fdb->dst == NULL, and these
point towards the bridge device and are therefore local and not to be
used for forwarding, or have fdb->dst == a net_bridge_port structure
(but are to be treated in the same way, i.e. not for forwarding).

That assumption _is_ correct as long as things are working correctly in
the bridge driver, i.e. we cannot logically have fdb->dst == NULL under
any circumstance for FDB entries that are not local. However, the
extern_learn code path where FDB entries are managed by a user space
controller show that it is possible for the bridge kernel driver to
misinterpret the NUD flags of an entry transmitted by user space, and
end up having fdb->dst == NULL while not being a local entry. This is
invalid and should be rejected.

Before, the two commands listed above both crashed the kernel in this
check from br_switchdev_fdb_notify:

	struct net_device *dev = info.is_local ? br->dev : dst->dev;

info.is_local == false, dst == NULL.

After this patch, the invalid entry added by the first command is
rejected:

ip link add br0 type bridge && bridge fdb add 00:01:02:03:04:05 dev br0 self extern_learn static; ip link del br0
Error: bridge: FDB entry towards bridge must be permanent.

and the valid entry added by the second command is properly treated as a
local address and does not crash br_switchdev_fdb_notify anymore:

ip link add br0 type bridge && bridge fdb add 00:01:02:03:04:05 dev br0 self extern_learn permanent; ip link del br0

Fixes: eb100e0e24a2 ("net: bridge: allow to add externally learned entries from user-space")
Reported-by: syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/bridge/br.c         |  3 ++-
 net/bridge/br_fdb.c     | 30 ++++++++++++++++++++++++------
 net/bridge/br_private.h |  2 +-
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index ef743f94254d..bbab9984f24e 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -166,7 +166,8 @@ static int br_switchdev_event(struct notifier_block *unused,
 	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
 		fdb_info = ptr;
 		err = br_fdb_external_learn_add(br, p, fdb_info->addr,
-						fdb_info->vid, false);
+						fdb_info->vid,
+						fdb_info->is_local, false);
 		if (err) {
 			err = notifier_from_errno(err);
 			break;
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index a16191dcaed1..835cec1e5a03 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1019,7 +1019,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 
 static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 			struct net_bridge_port *p, const unsigned char *addr,
-			u16 nlh_flags, u16 vid, struct nlattr *nfea_tb[])
+			u16 nlh_flags, u16 vid, struct nlattr *nfea_tb[],
+			struct netlink_ext_ack *extack)
 {
 	int err = 0;
 
@@ -1038,7 +1039,15 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 		rcu_read_unlock();
 		local_bh_enable();
 	} else if (ndm->ndm_flags & NTF_EXT_LEARNED) {
-		err = br_fdb_external_learn_add(br, p, addr, vid, true);
+		if (!p && !(ndm->ndm_state & NUD_PERMANENT)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "FDB entry towards bridge must be permanent");
+			return -EINVAL;
+		}
+
+		err = br_fdb_external_learn_add(br, p, addr, vid,
+						ndm->ndm_state & NUD_PERMANENT,
+						true);
 	} else {
 		spin_lock_bh(&br->hash_lock);
 		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
@@ -1110,9 +1119,11 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		}
 
 		/* VID was specified, so use it. */
-		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, vid, nfea_tb);
+		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, vid, nfea_tb,
+				   extack);
 	} else {
-		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, 0, nfea_tb);
+		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, 0, nfea_tb,
+				   extack);
 		if (err || !vg || !vg->num_vlans)
 			goto out;
 
@@ -1124,7 +1135,7 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 			if (!br_vlan_should_use(v))
 				continue;
 			err = __br_fdb_add(ndm, br, p, addr, nlh_flags, v->vid,
-					   nfea_tb);
+					   nfea_tb, extack);
 			if (err)
 				goto out;
 		}
@@ -1264,7 +1275,7 @@ void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
 }
 
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
-			      const unsigned char *addr, u16 vid,
+			      const unsigned char *addr, u16 vid, bool is_local,
 			      bool swdev_notify)
 {
 	struct net_bridge_fdb_entry *fdb;
@@ -1281,6 +1292,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 
 		if (swdev_notify)
 			flags |= BIT(BR_FDB_ADDED_BY_USER);
+
+		if (is_local)
+			flags |= BIT(BR_FDB_LOCAL);
+
 		fdb = fdb_create(br, p, addr, vid, flags);
 		if (!fdb) {
 			err = -ENOMEM;
@@ -1307,6 +1322,9 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 		if (swdev_notify)
 			set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 
+		if (is_local)
+			set_bit(BR_FDB_LOCAL, &fdb->flags);
+
 		if (modified)
 			fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 2b48b204205e..aa64d8d63ca3 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -711,7 +711,7 @@ int br_fdb_get(struct sk_buff *skb, struct nlattr *tb[], struct net_device *dev,
 int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
 void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
-			      const unsigned char *addr, u16 vid,
+			      const unsigned char *addr, u16 vid, bool is_local,
 			      bool swdev_notify);
 int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
-- 
2.25.1

