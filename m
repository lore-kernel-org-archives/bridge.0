Return-Path: <Joseph.Huang@garmin.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pps1;
 bh=s+HR9JQYUp+nkFXI9Gvgl9YT5FYywAz7O3lXDrLaiW4=;
 b=YkOXwF5hEivWTNou1MWiJYjCLjERdMwVvsGE0GDe3g7ZrIqtpOS2ujLHsteNUKXoPmm8
 QphcZ9+xRXBsqoJVhh/6GYh8eTj6En5ciZAnaoa9In9En8Sgi6gGbu6OQEsGvRh/svP7
 oim/hWNbka6C4ZXmOU5zddhacH50hpPxDsktHZ7RfExgWt77DrXktB0RlE94FlPu5uLX
 76PIB9qIPpjsXkN7of0/u+gRQ/VlvXPy//avdjTbzICLrnIwROEqofM8rUM+TjYx2L0q
 0AGItmZLcn9VToUO+0zGULEpmyNbmgCCnnXOVMVGEvYm/QCVz3zj5vkfcrZYTZMrvXoJ Yw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+HR9JQYUp+nkFXI9Gvgl9YT5FYywAz7O3lXDrLaiW4=;
 b=g49CpVfLImxCyAS1317l0pX7EFpLEjsFQwJqZGvJ/DDLLngZ98HCRE9X6syHezoPBZ5i0HQReiMX+kJvSMcmUZ9jKJ+aUnO85/vF4NeZcE3f5z8qDbNmM/09M72MRcJEgdfF/te0MD4e2gQuKFY78A6NyLUvyynnftT65ldsTk5c7ZjY+Rbbwo3dyEgWEMunZQp/KEop8uOJU/0+cOh2cwTSkrGfGv7YFwexl0RUt1h6291iNGV8Ha7LNLvfERk+tC/GAwR88aueJVXlK0w99hsX654E5whKZFC30G4mPMUsfXTr9VL5VdrYDuwZKzt//OZBpz2UuytUi1iOe3TboQ==
From: Joseph Huang <Joseph.Huang@garmin.com>
Date: Tue, 4 May 2021 14:22:59 -0400
Message-ID: <20210504182259.5042-7-Joseph.Huang@garmin.com>
In-Reply-To: <20210504182259.5042-1-Joseph.Huang@garmin.com>
References: <20210504182259.5042-1-Joseph.Huang@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH 6/6] bridge: Always multicast_flood Reports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joseph Huang <Joseph.Huang@garmin.com>

Modify the forwarding path so that IGMPv1/2/MLDv1 Reports are always
flooded by br_multicast_flood, regardless of the check done
by br_multicast_querier_exists.

This patch fixes the problems where after a system boots up, the first
couple of Reports are not handled properly in that:

1) the Report from the Host is being flooded (via br_flood) to all
   bridge ports, and
2) if the mrouter port's mcast_flood is disabled, the Reports received
   from other hosts will not be forwarded to the Querier.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 net/bridge/br_device.c    | 5 +++--
 net/bridge/br_input.c     | 5 +++--
 net/bridge/br_multicast.c | 3 +++
 net/bridge/br_private.h   | 3 +++
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index e8b626cc6bfd..ff75ba242f38 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -88,8 +88,9 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 
 		mdst = br_mdb_get(br, skb, vid);
-		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(br, eth_hdr(skb), mdst))
+		if (((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
+		    br_multicast_querier_exists(br, eth_hdr(skb), mdst)) ||
+		    BR_INPUT_SKB_CB_FORCE_MC_FLOOD(skb))
 			br_multicast_flood(mdst, skb, false, true);
 		else
 			br_flood(br, skb, BR_PKT_MULTICAST, false, true);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 8875e953ac53..572d7f20477f 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -129,8 +129,9 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	switch (pkt_type) {
 	case BR_PKT_MULTICAST:
 		mdst = br_mdb_get(br, skb, vid);
-		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(br, eth_hdr(skb), mdst)) {
+		if (((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
+		    br_multicast_querier_exists(br, eth_hdr(skb), mdst)) ||
+		    BR_INPUT_SKB_CB_FORCE_MC_FLOOD(skb)) {
 			if ((mdst && mdst->host_joined) ||
 			    br_multicast_is_router(br)) {
 				local_rcv = true;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b7d9c491abe0..dfdbe19f3e93 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3231,6 +3231,7 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
 	case IGMP_HOST_MEMBERSHIP_REPORT:
 	case IGMPV2_HOST_MEMBERSHIP_REPORT:
 		BR_INPUT_SKB_CB(skb)->mrouters_only = 1;
+		BR_INPUT_SKB_CB(skb)->force_mc_flood = 1;
 		err = br_ip4_multicast_add_group(br, port, ih->group, vid, src,
 						 true);
 		break;
@@ -3294,6 +3295,7 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
 	case ICMPV6_MGM_REPORT:
 		src = eth_hdr(skb)->h_source;
 		BR_INPUT_SKB_CB(skb)->mrouters_only = 1;
+		BR_INPUT_SKB_CB(skb)->force_mc_flood = 1;
 		err = br_ip6_multicast_add_group(br, port, &mld->mld_mca, vid,
 						 src, true);
 		break;
@@ -3325,6 +3327,7 @@ int br_multicast_rcv(struct net_bridge *br, struct net_bridge_port *port,
 	BR_INPUT_SKB_CB(skb)->igmp = 0;
 	BR_INPUT_SKB_CB(skb)->mrouters_only = 0;
 	BR_INPUT_SKB_CB(skb)->force_flood = 0;
+	BR_INPUT_SKB_CB(skb)->force_mc_flood = 0;
 
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		return 0;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 59af599d48eb..6d4f20d7f482 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -492,6 +492,7 @@ struct br_input_skb_cb {
 	u8 igmp;
 	u8 mrouters_only:1;
 	u8 force_flood:1;
+	u8 force_mc_flood:1;
 #endif
 	u8 proxyarp_replied:1;
 	u8 src_port_isolated:1;
@@ -512,9 +513,11 @@ struct br_input_skb_cb {
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 # define BR_INPUT_SKB_CB_MROUTERS_ONLY(__skb)	(BR_INPUT_SKB_CB(__skb)->mrouters_only)
 # define BR_INPUT_SKB_CB_FORCE_FLOOD(__skb)		(BR_INPUT_SKB_CB(__skb)->force_flood)
+# define BR_INPUT_SKB_CB_FORCE_MC_FLOOD(__skb)	(BR_INPUT_SKB_CB(__skb)->force_mc_flood)
 #else
 # define BR_INPUT_SKB_CB_MROUTERS_ONLY(__skb)	(0)
 # define BR_INPUT_SKB_CB_FORCE_FLOOD(__skb)		(0)
+# define BR_INPUT_SKB_CB_FORCE_MC_FLOOD(__skb)	(0)
 #endif
 
 #define br_printk(level, br, format, args...)	\
-- 
2.17.1

