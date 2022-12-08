Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53F92820B1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64872820AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9o/bF6xuTdH6T3TYMYoUxE4lUviYjclDl822kTUzak=;
 b=fBZE7WZFS4WYMZTPz8e2UcgJ3vbMCDjpi1HKPpyS15K25I0a3bMu++3FyG3g5QPvuek2pu7Yhhi74EyeSDGfBQMKKPJgWI5ohYoZ/a07/Y1hULcC0c0q7MYnGujJIWEJl7oIjVfm0kAatn+1L+dsxI+yknDzgfOEo5MkNwx4yBOjaHLDf6P2zOcPoStKnvbgKMUh7F5Se+qg59aRRluAjelcAaki9rtttqnyvDmX+yQqkEj5m+aRg2/I93QT/GKY8rFxEYGMeX31Dvenj6S7DOwS2FFkSM/NICIHvmAc0m5NM9YFqQGEmvE7CAZDt0CDhCjCREW8++k57LCcJ1F5ag==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu,  8 Dec 2022 17:28:36 +0200
Message-Id: <20221208152839.1016350-12-idosch@nvidia.com>
In-Reply-To: <20221208152839.1016350-1-idosch@nvidia.com>
References: <20221208152839.1016350-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 11/14] bridge: mcast: Allow user space to
	specify MDB entry routing protocol
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Add the 'MDBE_ATTR_RTPORT' attribute to allow user space to specify the
routing protocol of the MDB port group entry. Enforce a minimum value of
'RTPROT_STATIC' to prevent user space from using protocol values that
should only be set by the kernel (e.g., 'RTPROT_KERNEL'). Maintain
backward compatibility by defaulting to 'RTPROT_STATIC'.

The protocol is already visible to user space in RTM_NEWMDB responses
and notifications via the 'MDBA_MDB_EATTR_RTPROT' attribute.

The routing protocol allows a routing daemon to distinguish between
entries configured by it and those configured by the administrator. Once
MDB flush is supported, the protocol can be used as a criterion
according to which the flush is performed.

Examples:

 # bridge mdb add dev br0 port dummy10 grp 239.1.1.1 permanent proto kernel
 Error: integer out of range.

 # bridge mdb add dev br0 port dummy10 grp 239.1.1.1 permanent proto static

 # bridge mdb add dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.1 permanent proto zebra

 # bridge mdb add dev br0 port dummy10 grp 239.1.1.2 permanent source_list 198.51.100.1,198.51.100.2 filter_mode include proto 250

 # bridge -d mdb show
 dev br0 port dummy10 grp 239.1.1.2 src 198.51.100.2 permanent filter_mode include proto 250
 dev br0 port dummy10 grp 239.1.1.2 src 198.51.100.1 permanent filter_mode include proto 250
 dev br0 port dummy10 grp 239.1.1.2 permanent filter_mode include source_list 198.51.100.2/0.00,198.51.100.1/0.00 proto 250
 dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.1 permanent filter_mode include proto zebra
 dev br0 port dummy10 grp 239.1.1.1 permanent filter_mode exclude proto static

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v1:
    * Reject protocol for host entries.

 include/uapi/linux/if_bridge.h |  1 +
 net/bridge/br_mdb.c            | 15 +++++++++++++--
 net/bridge/br_private.h        |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 0d9fe73fc48c..d9de241d90f9 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -725,6 +725,7 @@ enum {
 	MDBE_ATTR_SOURCE,
 	MDBE_ATTR_SRC_LIST,
 	MDBE_ATTR_GROUP_MODE,
+	MDBE_ATTR_RTPROT,
 	__MDBE_ATTR_MAX,
 };
 #define MDBE_ATTR_MAX (__MDBE_ATTR_MAX - 1)
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 61d46b0a31b6..72d4e53193e5 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -682,6 +682,7 @@ static const struct nla_policy br_mdbe_attrs_pol[MDBE_ATTR_MAX + 1] = {
 	[MDBE_ATTR_GROUP_MODE] = NLA_POLICY_RANGE(NLA_U8, MCAST_EXCLUDE,
 						  MCAST_INCLUDE),
 	[MDBE_ATTR_SRC_LIST] = NLA_POLICY_NESTED(br_mdbe_src_list_pol),
+	[MDBE_ATTR_RTPROT] = NLA_POLICY_MIN(NLA_U8, RTPROT_STATIC),
 };
 
 static bool is_valid_mdb_entry(struct br_mdb_entry *entry,
@@ -823,7 +824,7 @@ static int br_mdb_add_group_sg(const struct br_mdb_config *cfg,
 	}
 
 	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, flags, NULL,
-					MCAST_INCLUDE, RTPROT_STATIC);
+					MCAST_INCLUDE, cfg->rt_protocol);
 	if (unlikely(!p)) {
 		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new (S, G) port group");
 		return -ENOMEM;
@@ -881,6 +882,7 @@ static int br_mdb_add_group_src_fwd(const struct br_mdb_config *cfg,
 	sg_cfg.group = sg_ip;
 	sg_cfg.src_entry = true;
 	sg_cfg.filter_mode = MCAST_INCLUDE;
+	sg_cfg.rt_protocol = cfg->rt_protocol;
 	return br_mdb_add_group_sg(&sg_cfg, sgmp, brmctx, flags, extack);
 }
 
@@ -982,7 +984,7 @@ static int br_mdb_add_group_star_g(const struct br_mdb_config *cfg,
 	}
 
 	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, flags, NULL,
-					cfg->filter_mode, RTPROT_STATIC);
+					cfg->filter_mode, cfg->rt_protocol);
 	if (unlikely(!p)) {
 		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new (*, G) port group");
 		return -ENOMEM;
@@ -1193,6 +1195,14 @@ static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
 		return -EINVAL;
 	}
 
+	if (mdb_attrs[MDBE_ATTR_RTPROT]) {
+		if (!cfg->p) {
+			NL_SET_ERR_MSG_MOD(extack, "Protocol cannot be set for host groups");
+			return -EINVAL;
+		}
+		cfg->rt_protocol = nla_get_u8(mdb_attrs[MDBE_ATTR_RTPROT]);
+	}
+
 	return 0;
 }
 
@@ -1212,6 +1222,7 @@ static int br_mdb_config_init(struct net *net, const struct nlmsghdr *nlh,
 
 	memset(cfg, 0, sizeof(*cfg));
 	cfg->filter_mode = MCAST_EXCLUDE;
+	cfg->rt_protocol = RTPROT_STATIC;
 
 	bpm = nlmsg_data(nlh);
 	if (!bpm->ifindex) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 368f5f6fa42b..cdc9e040f1f6 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -106,6 +106,7 @@ struct br_mdb_config {
 	u8				filter_mode;
 	struct br_mdb_src_entry		*src_entries;
 	int				num_src_entries;
+	u8				rt_protocol;
 };
 #endif
 
-- 
2.37.3

