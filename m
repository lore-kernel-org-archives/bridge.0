Return-Path: <razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 12 Oct 2015 13:41:07 +0200
Message-Id: <1444650069-32572-3-git-send-email-razor@blackwall.org>
In-Reply-To: <1444650069-32572-1-git-send-email-razor@blackwall.org>
References: <1444650069-32572-1-git-send-email-razor@blackwall.org>
Subject: [Bridge] [PATCH net-next 2/4] bridge: vlan: use rcu for vlan_list
	traversal in br_fill_ifinfo
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: idosch@mellanox.com, shm@cumulusnetworks.com, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

br_fill_ifinfo is called by br_ifinfo_notify which can be called from
many contexts with different locks held, sometimes it relies upon
bridge's spinlock only which is a problem for the vlan code, so use
explicitly rcu for that to avoid problems.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netlink.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index edee48e9aa8f..e27bde2642cc 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -253,7 +253,7 @@ static int br_fill_ifvlaninfo_compressed(struct sk_buff *skb,
 	 * if vlaninfo represents a range
 	 */
 	pvid = br_get_pvid(vg);
-	list_for_each_entry(v, &vg->vlan_list, vlist) {
+	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
 		flags = 0;
 		if (!br_vlan_should_use(v))
 			continue;
@@ -303,7 +303,7 @@ static int br_fill_ifvlaninfo(struct sk_buff *skb,
 	u16 pvid;
 
 	pvid = br_get_pvid(vg);
-	list_for_each_entry(v, &vg->vlan_list, vlist) {
+	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
 		if (!br_vlan_should_use(v))
 			continue;
 
@@ -386,22 +386,27 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		struct nlattr *af;
 		int err;
 
+		/* RCU needed because of the VLAN locking rules (rcu || rtnl) */
+		rcu_read_lock();
 		if (port)
-			vg = nbp_vlan_group(port);
+			vg = nbp_vlan_group_rcu(port);
 		else
-			vg = br_vlan_group(br);
+			vg = br_vlan_group_rcu(br);
 
-		if (!vg || !vg->num_vlans)
+		if (!vg || !vg->num_vlans) {
+			rcu_read_unlock();
 			goto done;
-
+		}
 		af = nla_nest_start(skb, IFLA_AF_SPEC);
-		if (!af)
+		if (!af) {
+			rcu_read_unlock();
 			goto nla_put_failure;
-
+		}
 		if (filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED)
 			err = br_fill_ifvlaninfo_compressed(skb, vg);
 		else
 			err = br_fill_ifvlaninfo(skb, vg);
+		rcu_read_unlock();
 		if (err)
 			goto nla_put_failure;
 		nla_nest_end(skb, af);
-- 
2.4.3

