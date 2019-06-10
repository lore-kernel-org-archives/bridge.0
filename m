Return-Path: <wenxu@ucloud.cn>
From: wenxu@ucloud.cn
Date: Mon, 10 Jun 2019 17:44:06 +0800
Message-Id: <1560159846-29933-1-git-send-email-wenxu@ucloud.cn>
Subject: [Bridge] [PATCH net-next] bridge: Set the pvid for untaged packet
	before prerouting
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: wenxu <wenxu@ucloud.cn>

bridge vlan add dev veth1 vid 200 pvid untagged
bridge vlan add dev veth2 vid 200 pvid untagged

nft add table bridge firewall
nft add chain bridge firewall zones { type filter hook prerouting priority - 300 \; }
nft add rule bridge firewall zones counter ct zone set vlan id map { 100 : 1, 200 : 2 }

As above set the bridge port with pvid, the received packet don't contain
the vlan tag which means the packet should belong to vlan 200 through pvid.
User can do conntrack base base on vlan id and map the vlan id to zone id
in the prerouting hook.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 net/bridge/br_input.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 21b74e7..31b44bc 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -341,6 +341,13 @@ rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 	}
 
 forward:
+	if (br_opt_get(p->br, BROPT_VLAN_ENABLED) && !skb_vlan_tag_present(skb)) {
+		u16 pvid = br_get_pvid(nbp_vlan_group_rcu(p));
+
+		if (pvid)
+			__vlan_hwaccel_put_tag(skb, p->br->vlan_proto, pvid);
+	}
+
 	switch (p->state) {
 	case BR_STATE_FORWARDING:
 	case BR_STATE_LEARNING:
-- 
1.8.3.1

