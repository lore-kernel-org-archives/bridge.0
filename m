Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dNyNzOzmDc1f/pBDx4/a2ruUbQq4AUD3l7VG1GzL5dE=;
 b=DjoyoEa5SBJt3hqwkb9DF+bYBRu/wLQsubSS2953Gkp4QRuJGRUbRTJIqT/76L2o7q
 LIj4IsVyTbEKPYKxQFo8gbjxVn1aZM0XAAjabs6CRiIzZRRpAtPjjGZaF8BnWZXgg1lg
 rsqmH5r6esv/3MlJcXaXb7el2YwVANoDkyI+WX7IIMsSql+S4JzT+epU3z37FDU3srFA
 2m7RMEQP3CNrBDdkZsfFpaQdVZlTyG/6mUAAVrAJYQLN0/tpRokYODZmAPtrQLQ1DaBv
 KcESQyYDfFe2FFqSdCCCmLuRDNb+Ubn/dN13hAV3ar10OHYm9EK7bGvFHbfglNgQOKxx
 LUCg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 11 Apr 2022 20:29:30 +0300
Message-Id: <20220411172934.1813604-5-razor@blackwall.org>
In-Reply-To: <20220411172934.1813604-1-razor@blackwall.org>
References: <20220411172934.1813604-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 4/8] net: rtnetlink: register a generic
	rtnl_fdb_flush call
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

Register a generic PF_BRIDGE rtnl_fdb_flush call which does basic
validation and dispatches the call to the appropriate device based on
ndm flags (NTF_MASTER and NTF_SELF). The flags are interepreted in a
similar way to the already existing fdb add and del.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/neighbour.h |  6 ++++
 net/core/rtnetlink.c           | 52 ++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index db05fb55055e..60e728319a50 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -212,4 +212,10 @@ enum {
 };
 #define NFEA_MAX (__NFEA_MAX - 1)
 
+enum {
+	NDFA_UNSPEC,
+	__NDFA_MAX
+};
+#define NDFA_MAX (__NDFA_MAX - 1)
+
 #endif
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 4041b3e2e8ec..7325b60d1aa2 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4659,6 +4659,56 @@ static int rtnl_fdb_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	return err;
 }
 
+static const struct nla_policy fdb_flush_policy[NDFA_MAX + 1] = {
+	[NDFA_UNSPEC] = { .type = NLA_REJECT },
+};
+
+static int rtnl_fdb_flush(struct sk_buff *skb, struct nlmsghdr *nlh,
+			  struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct nlattr *tb[NDFA_MAX + 1];
+	struct net_device *dev;
+	struct ndmsg *ndm;
+	int err;
+
+	err = nlmsg_parse(nlh, sizeof(*ndm), tb, NDFA_MAX, fdb_flush_policy,
+			  extack);
+	if (err < 0)
+		return err;
+
+	ndm = nlmsg_data(nlh);
+	if (ndm->ndm_ifindex == 0) {
+		NL_SET_ERR_MSG(extack, "Invalid ifindex");
+		return -EINVAL;
+	}
+
+	dev = __dev_get_by_index(net, ndm->ndm_ifindex);
+	if (!dev) {
+		NL_SET_ERR_MSG(extack, "Unknown ifindex");
+		return -ENODEV;
+	}
+
+	err = -EOPNOTSUPP;
+	if ((!ndm->ndm_flags || ndm->ndm_flags & NTF_MASTER) &&
+	    netif_is_bridge_port(dev)) {
+		struct net_device *br_dev = netdev_master_upper_dev_get(dev);
+
+		err = br_dev->netdev_ops->ndo_fdb_flush(ndm, tb, dev, 0, extack);
+		if (err)
+			goto out;
+		else
+			ndm->ndm_flags &= ~NTF_MASTER;
+	}
+	if ((ndm->ndm_flags & NTF_SELF) && dev->netdev_ops->ndo_fdb_flush) {
+		err = dev->netdev_ops->ndo_fdb_flush(ndm, tb, dev, 0, extack);
+		if (!err)
+			ndm->ndm_flags &= ~NTF_SELF;
+	}
+out:
+	return err;
+}
+
 static int brport_nla_put_flag(struct sk_buff *skb, u32 flags, u32 mask,
 			       unsigned int attrnum, unsigned int flag)
 {
@@ -6144,6 +6194,8 @@ void __init rtnetlink_init(void)
 	rtnl_register(PF_BRIDGE, RTM_DELLINK, rtnl_bridge_dellink, NULL, 0);
 	rtnl_register(PF_BRIDGE, RTM_SETLINK, rtnl_bridge_setlink, NULL, 0);
 
+	rtnl_register(PF_BRIDGE, RTM_FLUSHNEIGH, rtnl_fdb_flush, NULL, 0);
+
 	rtnl_register(PF_UNSPEC, RTM_GETSTATS, rtnl_stats_get, rtnl_stats_dump,
 		      0);
 	rtnl_register(PF_UNSPEC, RTM_SETSTATS, rtnl_stats_set, NULL, 0);
-- 
2.35.1

