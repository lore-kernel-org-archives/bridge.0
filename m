Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D351441955
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B41F41954
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWd4gmYMWTJNIY6UR/Q82q/yeeGIVgy1sy8lW2yc3Gk=;
 b=HVYKLkMk5iNUQ11YWiNzWzf/W86DTqjoAZ4NqdO1LLQl/V4eT/rIGuFmgu88oy4XvzBD9im+Z4pVovsDRRO3OR6XYGPt9sVy3tYetqjr7FgFX98WxNqKJrB2q33vQ1ShRtdueP1a78NnjvPWMGvxQosL2GbVA0cgua/18Ns8BkGnbhN+uXtQaezYhrysIy+rjWVIFxDbmQ+nl7KKsRMGyR87jj73n5ENhZyvUKjXH88q2dE0iC94Al595YtCcPT54P/Tlju2a8RAAiXuBrvD3pw/YezKen1ZYE5lfwdmsNKS4KNpu2B9dT3Z7Uw6q3cMbiuhKdqifAbsFqEdspqtjA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 15:04:19 +0300
Message-Id: <20221018120420.561846-19-idosch@nvidia.com>
In-Reply-To: <20221018120420.561846-1-idosch@nvidia.com>
References: <20221018120420.561846-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 18/19] bridge: mcast: Allow user space
	to specify MDB entry routing protocol
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
 include/uapi/linux/if_bridge.h |  1 +
 net/bridge/br_mdb.c            | 10 ++++++++--
 net/bridge/br_private.h        |  1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

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
index 909b0fb49a0c..7ee6d383ad07 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -682,6 +682,7 @@ static const struct nla_policy br_mdbe_attrs_pol[MDBE_ATTR_MAX + 1] = {
 	[MDBE_ATTR_GROUP_MODE] = NLA_POLICY_RANGE(NLA_U8, MCAST_EXCLUDE,
 						  MCAST_INCLUDE),
 	[MDBE_ATTR_SRC_LIST] = NLA_POLICY_NESTED(br_mdbe_src_list_pol),
+	[MDBE_ATTR_RTPROT] = NLA_POLICY_MIN(NLA_U8, RTPROT_STATIC),
 };
 
 static bool is_valid_mdb_entry(struct br_mdb_entry *entry,
@@ -823,7 +824,7 @@ static int br_mdb_add_group_sg(struct br_mdb_config *cfg,
 	}
 
 	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, flags, NULL,
-					MCAST_INCLUDE, RTPROT_STATIC);
+					MCAST_INCLUDE, cfg->rt_protocol);
 	if (unlikely(!p)) {
 		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new (S, G) port group");
 		return -ENOMEM;
@@ -882,6 +883,7 @@ static int br_mdb_add_group_src_fwd(struct br_mdb_config *cfg,
 	sg_cfg.group = sg_ip;
 	sg_cfg.src_entry = true;
 	sg_cfg.filter_mode = MCAST_INCLUDE;
+	sg_cfg.rt_protocol = cfg->rt_protocol;
 	return br_mdb_add_group_sg(&sg_cfg, sgmp, brmctx, flags, extack);
 }
 
@@ -983,7 +985,7 @@ static int br_mdb_add_group_star_g(struct br_mdb_config *cfg,
 	}
 
 	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, flags, NULL,
-					cfg->filter_mode, RTPROT_STATIC);
+					cfg->filter_mode, cfg->rt_protocol);
 	if (unlikely(!p)) {
 		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new (*, G) port group");
 		return -ENOMEM;
@@ -1191,6 +1193,9 @@ static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
 		return -EINVAL;
 	}
 
+	if (mdb_attrs[MDBE_ATTR_RTPROT])
+		cfg->rt_protocol = nla_get_u8(mdb_attrs[MDBE_ATTR_RTPROT]);
+
 	return 0;
 }
 
@@ -1216,6 +1221,7 @@ static int br_mdb_config_init(struct net *net, struct sk_buff *skb,
 	memset(cfg, 0, sizeof(*cfg));
 	cfg->filter_mode = MCAST_EXCLUDE;
 	INIT_LIST_HEAD(&cfg->src_list);
+	cfg->rt_protocol = RTPROT_STATIC;
 
 	bpm = nlmsg_data(nlh);
 	if (!bpm->ifindex) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 0189fce6f3b7..73f0e98de33b 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -105,6 +105,7 @@ struct br_mdb_config {
 	struct br_ip			group;
 	bool				src_entry;
 	u8				filter_mode;
+	u8				rt_protocol;
 	struct list_head		src_list;
 };
 #endif
-- 
2.37.3

