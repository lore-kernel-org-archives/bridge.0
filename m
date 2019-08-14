Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=zLOU89kM0wwKVTB1UPD2cV0f8y3hOpOztYSgdhvell4=;
	b=W0v/34bb+R0t8/FtoFPWcg9lKzEZGSjF6tCn9906Wc61iSdL28yBtox3OkBC+wSXTH
	oj1SJwR12w6ETdbPkfkYI1GAeFWW7I+dkbPxi8tSOoUWLB0I2CVzpMMzhp6dCqu6wd/W
	sh68A4Ceq5sIZsCVdKaTXDVWv6EHamHivP4IM=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 14 Aug 2019 17:40:21 +0300
Message-Id: <20190814144024.9710-2-nikolay@cumulusnetworks.com>
In-Reply-To: <20190814144024.9710-1-nikolay@cumulusnetworks.com>
References: <20190814144024.9710-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/4] net: bridge: mdb: move vlan comments
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Trivial patch to move the vlan comments in their proper places above the
vid 0 checks.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_mdb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 428af1abf8cc..ee6208c6d946 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -653,9 +653,6 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	br = netdev_priv(dev);
 
-	/* If vlan filtering is enabled and VLAN is not specified
-	 * install mdb entry on all vlans configured on the port.
-	 */
 	pdev = __dev_get_by_index(net, entry->ifindex);
 	if (!pdev)
 		return -ENODEV;
@@ -665,6 +662,9 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 
 	vg = nbp_vlan_group(p);
+	/* If vlan filtering is enabled and VLAN is not specified
+	 * install mdb entry on all vlans configured on the port.
+	 */
 	if (br_vlan_enabled(br->dev) && vg && entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			entry->vid = v->vid;
@@ -745,9 +745,6 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	br = netdev_priv(dev);
 
-	/* If vlan filtering is enabled and VLAN is not specified
-	 * delete mdb entry on all vlans configured on the port.
-	 */
 	pdev = __dev_get_by_index(net, entry->ifindex);
 	if (!pdev)
 		return -ENODEV;
@@ -757,6 +754,9 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 
 	vg = nbp_vlan_group(p);
+	/* If vlan filtering is enabled and VLAN is not specified
+	 * delete mdb entry on all vlans configured on the port.
+	 */
 	if (br_vlan_enabled(br->dev) && vg && entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			entry->vid = v->vid;
-- 
2.21.0

