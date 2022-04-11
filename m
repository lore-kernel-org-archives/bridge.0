Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gXs4PLlNleG26f62x9RTRqzIlUWK/kMjrVCPwUa1nnA=;
 b=h/abJgZ7Xi7Z8GrRRVLZ9oJrGOddEMunkLHKWxtlp+fwN2PldD4vnxb64qRFtcMtnG
 7ud6gDPS5htQEfOasOEaqV0IoLDMIXOci2yXz8OFVmtmDnfKNvwzGMnJulOiXwzC836r
 KIa2tpBzt5Vczm85ycT/Vqm3OEmiP4b+rNwaETRlpMR4qjgNEz8Sha3JQStB77hSerJW
 sA2GNp+VhAACxEbyKUdL/tByb2bkkeV+8AwxBPtrWvCnpMJn6JZ892xznxuHHPsrNm+J
 ocw0SDU6unmkqZ+1XBsrzaDoKF4nTfV4XZ1gi5yN5aTo07U4LsirxK/7ELhNecAscgbf
 SM1g==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 11 Apr 2022 20:29:31 +0300
Message-Id: <20220411172934.1813604-6-razor@blackwall.org>
In-Reply-To: <20220411172934.1813604-1-razor@blackwall.org>
References: <20220411172934.1813604-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 5/8] net: rtnetlink: add common flush
	attributes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Add common fdb flush attributes - ifindex, vlan id, ndm flags/state masks.
All of these are used by the bridge and vxlan drivers. Also minimal attr
policy validation is added, it is up to ndo_fdb_flush implementers to
further validate them.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/neighbour.h |  4 ++++
 net/core/rtnetlink.c           | 16 +++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index 60e728319a50..5ab4e9b5edc8 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -214,6 +214,10 @@ enum {
 
 enum {
 	NDFA_UNSPEC,
+	NDFA_IFINDEX,
+	NDFA_VLAN,
+	NDFA_NDM_STATE_MASK,
+	NDFA_NDM_FLAGS_MASK,
 	__NDFA_MAX
 };
 #define NDFA_MAX (__NDFA_MAX - 1)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7325b60d1aa2..379b6a066fbd 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4660,7 +4660,11 @@ static int rtnl_fdb_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 }
 
 static const struct nla_policy fdb_flush_policy[NDFA_MAX + 1] = {
-	[NDFA_UNSPEC] = { .type = NLA_REJECT },
+	[NDFA_UNSPEC]	= { .type = NLA_REJECT },
+	[NDFA_IFINDEX]	= NLA_POLICY_MIN(NLA_S32, 1),
+	[NDFA_VLAN]	= { .type = NLA_U16 },
+	[NDFA_NDM_STATE_MASK]	= { .type = NLA_U16 },
+	[NDFA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
 };
 
 static int rtnl_fdb_flush(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -4670,6 +4674,7 @@ static int rtnl_fdb_flush(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct nlattr *tb[NDFA_MAX + 1];
 	struct net_device *dev;
 	struct ndmsg *ndm;
+	u16 vid;
 	int err;
 
 	err = nlmsg_parse(nlh, sizeof(*ndm), tb, NDFA_MAX, fdb_flush_policy,
@@ -4689,19 +4694,24 @@ static int rtnl_fdb_flush(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -ENODEV;
 	}
 
+	err = fdb_vid_parse(tb[NDFA_VLAN], &vid, extack);
+	if (err)
+		return err;
+
 	err = -EOPNOTSUPP;
 	if ((!ndm->ndm_flags || ndm->ndm_flags & NTF_MASTER) &&
 	    netif_is_bridge_port(dev)) {
 		struct net_device *br_dev = netdev_master_upper_dev_get(dev);
 
-		err = br_dev->netdev_ops->ndo_fdb_flush(ndm, tb, dev, 0, extack);
+		err = br_dev->netdev_ops->ndo_fdb_flush(ndm, tb, dev, vid,
+							extack);
 		if (err)
 			goto out;
 		else
 			ndm->ndm_flags &= ~NTF_MASTER;
 	}
 	if ((ndm->ndm_flags & NTF_SELF) && dev->netdev_ops->ndo_fdb_flush) {
-		err = dev->netdev_ops->ndo_fdb_flush(ndm, tb, dev, 0, extack);
+		err = dev->netdev_ops->ndo_fdb_flush(ndm, tb, dev, vid, extack);
 		if (!err)
 			ndm->ndm_flags &= ~NTF_SELF;
 	}
-- 
2.35.1

