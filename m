Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0C8B40B74
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E28294060B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX3ZXapMoybqW9SxbIxK65G+JaqV1YHwVd/wK5hmo1U=;
 b=afrUuKCbsY6iJgJDzVWcreeB9AyFHJc0dpdouhqT/hMSQhAdFst9Wxq2E6SvUIitecW+QlI9S3PNFBzx0qtZ59L5zpFgHHYsTfPi+wdJekRc35/ui5BrE684/lQ9Am5iO9uLc6IIt7UnrXZVaLrPLnxUM1HYJuPWY/HQdCpbLAaDCWT/PdIP8jEi0n2s3eg34Z0iwR9jMhOcGhfZT+gsghUtBRMlPz7XkmHv2qpwIfTO4xyLrmvZSOxgGId7Dcn4Yky8ALMdJufvMCOlpqsFqTO+CxLBJtkKm/cNwdKd6SZo2Npqv1awvJUnvcUEB5AGb/oUj4FEePCTdehHc/6yYg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 29 May 2023 14:48:29 +0300
Message-ID: <20230529114835.372140-3-idosch@nvidia.com>
In-Reply-To: <20230529114835.372140-1-idosch@nvidia.com>
References: <20230529114835.372140-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 2/8] flow_dissector: Dissect layer 2
	miss from tc skb extension
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, leon@kernel.org, vladimir.oltean@nxp.com, razor@blackwall.org, roopa@nvidia.com, claudiu.manoil@nxp.com, Ido Schimmel <idosch@nvidia.com>, UNGLinuxDriver@microchip.com, edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, simon.horman@corigine.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

Extend the 'FLOW_DISSECTOR_KEY_META' key with a new 'l2_miss' field and
populate it from a field with the same name in the tc skb extension.
This field is set by the bridge driver for packets that incur an FDB or
MDB miss.

The next patch will extend the flower classifier to be able to match on
layer 2 misses.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * Split from flower patch.
    * Use tc skb extension instead of 'skb->l2_miss'.

 include/net/flow_dissector.h |  2 ++
 net/core/flow_dissector.c    | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 85b2281576ed..8b41668c77fc 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -243,10 +243,12 @@ struct flow_dissector_key_ip {
  * struct flow_dissector_key_meta:
  * @ingress_ifindex: ingress ifindex
  * @ingress_iftype: ingress interface type
+ * @l2_miss: packet did not match an L2 entry during forwarding
  */
 struct flow_dissector_key_meta {
 	int ingress_ifindex;
 	u16 ingress_iftype;
+	u8 l2_miss;
 };
 
 /**
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 25fb0bbc310f..481ca4080cbd 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -27,6 +27,7 @@
 #include <linux/tcp.h>
 #include <linux/ptp_classify.h>
 #include <net/flow_dissector.h>
+#include <net/pkt_cls.h>
 #include <scsi/fc/fc_fcoe.h>
 #include <uapi/linux/batadv_packet.h>
 #include <linux/bpf.h>
@@ -241,6 +242,15 @@ void skb_flow_dissect_meta(const struct sk_buff *skb,
 					 FLOW_DISSECTOR_KEY_META,
 					 target_container);
 	meta->ingress_ifindex = skb->skb_iif;
+#if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
+	if (tc_skb_ext_tc_enabled()) {
+		struct tc_skb_ext *ext;
+
+		ext = skb_ext_find(skb, TC_SKB_EXT);
+		if (ext)
+			meta->l2_miss = ext->l2_miss;
+	}
+#endif
 }
 EXPORT_SYMBOL(skb_flow_dissect_meta);
 
-- 
2.40.1

