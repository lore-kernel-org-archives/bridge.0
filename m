Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=TlNchQ/vtVIj+X/dPogW/VhRCNvW7uKobaOaSR9wIVw=;
	b=XztUXeM97JDaihnB0HagW5xvRBMhRYAr79vQdfBG04yIqoZYcKub3kXOUsu9ULFsjm
	BIzlEU01i72gcZwbffxBob+Ml856DF5tWt2iinloyTic4HrdjAPmJmjuHsJ1aFytONGB
	EsMVjzQJwTbx1vE/QlYDqe3xTgtpoPu9BXczg=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 30 Jul 2019 15:20:41 +0300
Message-Id: <20190730122041.14647-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: mcast: add delete due to
	fast-leave mdb flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

In user-space there's no way to distinguish why an mdb entry was deleted
and that is a problem for daemons which would like to keep the mdb in
sync with remote ends (e.g. mlag) but would also like to converge faster.
In almost all cases we'd like to age-out the remote entry for performance
and convergence reasons except when fast-leave is enabled. In that case we
want explicit immediate remote delete, thus add mdb flag which is set only
when the entry is being deleted due to fast-leave.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_bridge.h | 1 +
 net/bridge/br_mdb.c            | 2 ++
 net/bridge/br_multicast.c      | 2 +-
 net/bridge/br_private.h        | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 773e476a8e54..1b3c2b643a02 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -237,6 +237,7 @@ struct br_mdb_entry {
 #define MDB_PERMANENT 1
 	__u8 state;
 #define MDB_FLAGS_OFFLOAD	(1 << 0)
+#define MDB_FLAGS_FAST_LEAVE	(1 << 1)
 	__u8 flags;
 	__u16 vid;
 	struct {
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index bf6acd34234d..428af1abf8cc 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -60,6 +60,8 @@ static void __mdb_entry_fill_flags(struct br_mdb_entry *e, unsigned char flags)
 	e->flags = 0;
 	if (flags & MDB_PG_FLAGS_OFFLOAD)
 		e->flags |= MDB_FLAGS_OFFLOAD;
+	if (flags & MDB_PG_FLAGS_FAST_LEAVE)
+		e->flags |= MDB_FLAGS_FAST_LEAVE;
 }
 
 static void __mdb_entry_to_br_ip(struct br_mdb_entry *entry, struct br_ip *ip)
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3d8deac2353d..3d4b2817687f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1393,7 +1393,7 @@ br_multicast_leave_group(struct net_bridge *br,
 			del_timer(&p->timer);
 			kfree_rcu(p, rcu);
 			br_mdb_notify(br->dev, port, group, RTM_DELMDB,
-				      p->flags);
+				      p->flags | MDB_PG_FLAGS_FAST_LEAVE);
 
 			if (!mp->ports && !mp->host_joined &&
 			    netif_running(br->dev))
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index e8cf03b43b7d..c4fd307fbfdc 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -199,6 +199,7 @@ struct net_bridge_fdb_entry {
 
 #define MDB_PG_FLAGS_PERMANENT	BIT(0)
 #define MDB_PG_FLAGS_OFFLOAD	BIT(1)
+#define MDB_PG_FLAGS_FAST_LEAVE	BIT(2)
 
 struct net_bridge_port_group {
 	struct net_bridge_port		*port;
-- 
2.21.0

