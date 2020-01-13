Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M7dGQIqTzWEMkio4akH4cg6mHCfmnNJAqzweWg3IPew=;
 b=EU4bgx6u3way6NIjZxOKnjaxf5SMcZiKh9iSgZ5u9/HIZCReVaZuyG69vKvYSBobDb
 Nsx/vpkTqKnICdEWR9BlIpGxlST3LRbGo1z1E+ytuGEFM4n/Wf2sz0OJjsEb5MQUJwbS
 ynrIClQV+ZYNfFgSemAMwnqXgIPTukyJbrVJI=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 13 Jan 2020 17:52:26 +0200
Message-Id: <20200113155233.20771-2-nikolay@cumulusnetworks.com>
In-Reply-To: <20200113155233.20771-1-nikolay@cumulusnetworks.com>
References: <20200113155233.20771-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/8] net: bridge: vlan: add helpers to
	check for vlan id/range validity
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

Add helpers to check if a vlan id or range are valid. The range helper
must be called when range start or end are detected.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netlink.c | 13 +++----------
 net/bridge/br_private.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 60136575aea4..14100e8653e6 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -568,17 +568,13 @@ static int br_process_vlan_info(struct net_bridge *br,
 				bool *changed,
 				struct netlink_ext_ack *extack)
 {
-	if (!vinfo_curr->vid || vinfo_curr->vid >= VLAN_VID_MASK)
+	if (!br_vlan_valid_id(vinfo_curr->vid))
 		return -EINVAL;
 
 	if (vinfo_curr->flags & BRIDGE_VLAN_INFO_RANGE_BEGIN) {
-		/* check if we are already processing a range */
-		if (*vinfo_last)
+		if (!br_vlan_valid_range(vinfo_curr, *vinfo_last))
 			return -EINVAL;
 		*vinfo_last = vinfo_curr;
-		/* don't allow range of pvids */
-		if ((*vinfo_last)->flags & BRIDGE_VLAN_INFO_PVID)
-			return -EINVAL;
 		return 0;
 	}
 
@@ -586,10 +582,7 @@ static int br_process_vlan_info(struct net_bridge *br,
 		struct bridge_vlan_info tmp_vinfo;
 		int v, err;
 
-		if (!(vinfo_curr->flags & BRIDGE_VLAN_INFO_RANGE_END))
-			return -EINVAL;
-
-		if (vinfo_curr->vid <= (*vinfo_last)->vid)
+		if (!br_vlan_valid_range(vinfo_curr, *vinfo_last))
 			return -EINVAL;
 
 		memcpy(&tmp_vinfo, *vinfo_last,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index f540f3bdf294..dbc0089e2c1a 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -507,6 +507,37 @@ static inline bool nbp_state_should_learn(const struct net_bridge_port *p)
 	return p->state == BR_STATE_LEARNING || p->state == BR_STATE_FORWARDING;
 }
 
+static inline bool br_vlan_valid_id(u16 vid)
+{
+	return vid > 0 && vid < VLAN_VID_MASK;
+}
+
+static inline bool br_vlan_valid_range(const struct bridge_vlan_info *cur,
+				       const struct bridge_vlan_info *last)
+{
+	/* pvid flag is not allowed in ranges */
+	if (cur->flags & BRIDGE_VLAN_INFO_PVID)
+		return false;
+
+	/* check for required range flags */
+	if (!(cur->flags & (BRIDGE_VLAN_INFO_RANGE_BEGIN |
+			    BRIDGE_VLAN_INFO_RANGE_END)))
+		return false;
+
+	/* when cur is the range end, check if:
+	 *  - it has range start flag
+	 *  - range ids are invalid (end is equal to or before start)
+	 */
+	if (last) {
+		if (cur->flags & BRIDGE_VLAN_INFO_RANGE_BEGIN)
+			return false;
+		else if (cur->vid <= last->vid)
+			return false;
+	}
+
+	return true;
+}
+
 static inline int br_opt_get(const struct net_bridge *br,
 			     enum net_bridge_opts opt)
 {
-- 
2.21.0

