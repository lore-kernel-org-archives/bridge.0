Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TL0c+Hs+0lBMqasciNPJrqUQXbgHwj7xsTQadVbU8KQ=;
 b=nOemDcgk5r0VlAKSVFNceh7dNh1uBqsIVQwLdnbY5q/cBVo39X4dUlRJlTF5Qurn5q
 beCBvCeRL3+X8pe82zI1Al4cih9Y1uHj/sGrCfUAsXLdvUCv/TtxUSowA6gLXCdpNxuu
 NCKs7HvTtrIGNAUO8Py93bu1fRsJudXEOetSGPOYkX5+1F+4PBVHk6rFkI8VXVX/FI77
 zwCvbLKIIUZ3P/O20X26/vZCjzvBNpcsvBzyoGvEFubC28twGcjOYklmqbo1c3nWNnWn
 DL8JBQfxeYKIv2kt/VoYHSLG9fyTrDdvcVo5/S7G/HkLGw7lii/TzM9CvGmZik9mWU4E
 7I2A==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 13 Apr 2022 13:51:56 +0300
Message-Id: <20220413105202.2616106-7-razor@blackwall.org>
In-Reply-To: <20220413105202.2616106-1-razor@blackwall.org>
References: <20220413105202.2616106-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 06/12] net: add ndo_fdb_del_bulk
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>, dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Add a new netdev op called ndo_fdb_del_bulk, it will be later used for
driver-specific bulk delete implementation dispatched from rtnetlink. The
first user will be the bridge, we need it to signal to rtnetlink from
the driver that we support bulk delete operation (NLM_F_BULK).

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/linux/netdevice.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 28ea4f8269d4..a602f29365b0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1260,6 +1260,10 @@ struct netdev_net_notifier {
  *		      struct net_device *dev,
  *		      const unsigned char *addr, u16 vid)
  *	Deletes the FDB entry from dev coresponding to addr.
+ * int (*ndo_fdb_del_bulk)(struct ndmsg *ndm, struct nlattr *tb[],
+ *			   struct net_device *dev,
+ *			   u16 vid,
+ *			   struct netlink_ext_ack *extack);
  * int (*ndo_fdb_dump)(struct sk_buff *skb, struct netlink_callback *cb,
  *		       struct net_device *dev, struct net_device *filter_dev,
  *		       int *idx)
@@ -1510,6 +1514,11 @@ struct net_device_ops {
 					       struct net_device *dev,
 					       const unsigned char *addr,
 					       u16 vid);
+	int			(*ndo_fdb_del_bulk)(struct ndmsg *ndm,
+						    struct nlattr *tb[],
+						    struct net_device *dev,
+						    u16 vid,
+						    struct netlink_ext_ack *extack);
 	int			(*ndo_fdb_dump)(struct sk_buff *skb,
 						struct netlink_callback *cb,
 						struct net_device *dev,
-- 
2.35.1

