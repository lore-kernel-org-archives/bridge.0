Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RIR/ZHl5ZiFHgx6+6/Rsb1UvqXAuRfjaxLhenAF2JJI=;
 b=lpBHWyld2PQijqIzQlkNniBq/I0nMhLWr2VIsEI0rkRZH1/1whYuvxToynpfR7JTr5
 3Xgl4SqVJO1JjsR1wAcpuCjm70v+RkS/Hg7T1jUdGNFz3itNqosbMCgH69NppQtGNUgC
 76yH6xcKdP1HtO2P/Ej+k3uq/Z4kGHVszJONO/OSs/aYeRXWE53tUUS0R/11uO5yNBpe
 Yc2oYqneWejwOmgK5lsYaGiFEb/8aX4Noc4sK5Mb6liMatA9CeKrQQGn4Jdf22pJkHC/
 W0DkiN/F4VlOr2bd4c0pcZ53pJ6Oc61NvB32f/yLut7P2SwK7pqK+Fn0C5u5HMolx/jJ
 iukA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 11 Apr 2022 20:29:28 +0300
Message-Id: <20220411172934.1813604-3-razor@blackwall.org>
In-Reply-To: <20220411172934.1813604-1-razor@blackwall.org>
References: <20220411172934.1813604-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 2/8] net: add ndo_fdb_flush op
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

Add a new netdev op called ndo_fdb_flush, it will be later used for
driver-specific flush implementation dispatched from rtnetlink. The first
user will be the bridge.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/linux/netdevice.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 28ea4f8269d4..16d67e40053c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1265,6 +1265,12 @@ struct netdev_net_notifier {
  *		       int *idx)
  *	Used to add FDB entries to dump requests. Implementers should add
  *	entries to skb and update idx with the number of entries.
+ * int (*ndo_fdb_flush)(struct ndmsg *ndm, struct nlattr *tb[],
+ *			struct net_device *dev,
+ *			u16 vid,
+ *			struct netlink_ext_ack *extack);
+ *	Used to flush FDB entries. Filter attributes can be specified to delete
+ *	only matching FDB entries if implementers support it.
  *
  * int (*ndo_bridge_setlink)(struct net_device *dev, struct nlmsghdr *nlh,
  *			     u16 flags, struct netlink_ext_ack *extack)
@@ -1515,6 +1521,11 @@ struct net_device_ops {
 						struct net_device *dev,
 						struct net_device *filter_dev,
 						int *idx);
+	int			(*ndo_fdb_flush)(struct ndmsg *ndm,
+						 struct nlattr *tb[],
+						 struct net_device *dev,
+						 u16 vid,
+						 struct netlink_ext_ack *extack);
 	int			(*ndo_fdb_get)(struct sk_buff *skb,
 					       struct nlattr *tb[],
 					       struct net_device *dev,
-- 
2.35.1

