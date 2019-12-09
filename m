Return-Path: <vivien.didelot@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tck+Nhv2b/sVGzVhvefzQX+0sDVc0C2xky/4jXyT/vA=;
 b=oaW6tNV0UmLbVGY+zMcR887H34jET8qZ4u47t7JK168lOky24xA57wDTQ3HggOBqFg
 UOKh/jJ2bU7JRDCNHk9xc2HyHdUTw4Cq1bauel4BUd8D4jOpE7D7P+YoIrY56V7NuFnP
 Qk8X1WQdJvtzxy4lt0Nb6aIEyjl3px6eiXRNeiMzioX4yo9cpYVIHeHSycl7nlZkNYNf
 46sPybXbhlAZkSDYRJMx/nYrujGSd2NRqk32SnuThLMuY6+rJ+kFOpaPHFmFm9e7nE9h
 Kdz8mjIHNvtwnP/PxmdcXtTwnhsuaRmOlol68x2pSVD3UQwSLfn9wWeP46TbtQspTvdY
 +IDw==
From: Vivien Didelot <vivien.didelot@gmail.com>
Date: Mon,  9 Dec 2019 18:05:22 -0500
Message-Id: <20191209230522.1255467-2-vivien.didelot@gmail.com>
In-Reply-To: <20191209230522.1255467-1-vivien.didelot@gmail.com>
References: <20191209230522.1255467-1-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH iproute2 v2] iplink: add support for STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Vivien Didelot <vivien.didelot@gmail.com>

Add support for the BRIDGE_XSTATS_STP xstats, as follow:

    # ip link xstats type bridge_slave dev lan5
                        STP BPDU:
                          RX: 0
                          TX: 39
                        STP TCN:
                          RX: 0
                          TX: 0
                        STP Transitions:
                          Blocked: 0
                          Forwarding: 1
                        IGMP queries:
                          RX: v1 0 v2 0 v3 0
                          TX: v1 0 v2 0 v3 0
    ...

Or below as JSON:

    # ip -j -p link xstats type bridge_slave dev lan0 | head
    [ {
            "ifname": "lan0",
            "stp": {
                "rx_bpdu": 0,
                "tx_bpdu": 500,
                "rx_tcn": 0,
                "tx_tcn": 0,
                "transition_blk": 0,
                "transition_fwd": 1
            },
    ...

Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
---
 include/uapi/linux/if_bridge.h | 10 ++++++++++
 ip/iplink_bridge.c             | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 31fc51bd..42f76697 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -156,6 +156,15 @@ struct bridge_vlan_xstats {
 	__u32 pad2;
 };
 
+struct bridge_stp_xstats {
+	__u64 transition_blk;
+	__u64 transition_fwd;
+	__u64 rx_bpdu;
+	__u64 tx_bpdu;
+	__u64 rx_tcn;
+	__u64 tx_tcn;
+};
+
 /* Bridge multicast database attributes
  * [MDBA_MDB] = {
  *     [MDBA_MDB_ENTRY] = {
@@ -261,6 +270,7 @@ enum {
 	BRIDGE_XSTATS_UNSPEC,
 	BRIDGE_XSTATS_VLAN,
 	BRIDGE_XSTATS_MCAST,
+	BRIDGE_XSTATS_STP,
 	BRIDGE_XSTATS_PAD,
 	__BRIDGE_XSTATS_MAX
 };
diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 06f736d4..92e051c8 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -688,6 +688,7 @@ static void bridge_print_xstats_help(struct link_util *lu, FILE *f)
 static void bridge_print_stats_attr(struct rtattr *attr, int ifindex)
 {
 	struct rtattr *brtb[LINK_XSTATS_TYPE_MAX+1];
+	struct bridge_stp_xstats *sstats;
 	struct br_mcast_stats *mstats;
 	struct rtattr *i, *list;
 	const char *ifname = "";
@@ -807,6 +808,35 @@ static void bridge_print_stats_attr(struct rtattr *attr, int ifindex)
 				  mstats->mld_parse_errors);
 			close_json_object();
 			break;
+		case BRIDGE_XSTATS_STP:
+			sstats = RTA_DATA(i);
+			open_json_object("stp");
+			print_string(PRINT_FP, NULL,
+				     "%-16s    STP BPDU:\n", "");
+			print_string(PRINT_FP, NULL, "%-16s      ", "");
+			print_u64(PRINT_ANY, "rx_bpdu", "RX: %llu\n",
+				  sstats->rx_bpdu);
+			print_string(PRINT_FP, NULL, "%-16s      ", "");
+			print_u64(PRINT_ANY, "tx_bpdu", "TX: %llu\n",
+				  sstats->tx_bpdu);
+			print_string(PRINT_FP, NULL,
+				     "%-16s    STP TCN:\n", "");
+			print_string(PRINT_FP, NULL, "%-16s      ", "");
+			print_u64(PRINT_ANY, "rx_tcn", "RX: %llu\n",
+				  sstats->rx_tcn);
+			print_string(PRINT_FP, NULL, "%-16s      ", "");
+			print_u64(PRINT_ANY, "tx_tcn", "TX: %llu\n",
+				  sstats->tx_tcn);
+			print_string(PRINT_FP, NULL,
+				     "%-16s    STP Transitions:\n", "");
+			print_string(PRINT_FP, NULL, "%-16s      ", "");
+			print_u64(PRINT_ANY, "transition_blk", "Blocked: %llu\n",
+				  sstats->transition_blk);
+			print_string(PRINT_FP, NULL, "%-16s      ", "");
+			print_u64(PRINT_ANY, "transition_fwd", "Forwarding: %llu\n",
+				  sstats->transition_fwd);
+			close_json_object();
+			break;
 		}
 	}
 	close_json_object();
@@ -843,6 +873,8 @@ int bridge_parse_xstats(struct link_util *lu, int argc, char **argv)
 	while (argc > 0) {
 		if (strcmp(*argv, "igmp") == 0 || strcmp(*argv, "mcast") == 0) {
 			xstats_print_attr = BRIDGE_XSTATS_MCAST;
+		} else if (strcmp(*argv, "stp") == 0) {
+			xstats_print_attr = BRIDGE_XSTATS_STP;
 		} else if (strcmp(*argv, "dev") == 0) {
 			NEXT_ARG();
 			filter_index = ll_name_to_index(*argv);
-- 
2.24.0

