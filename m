Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OEK3+d3CKz1mIylcZTyAVylsHfHcJSc3xiPKTSlMW5U=;
 b=JJyBw1Bdfdn/DXRctvYndAg0AuUSmUbCaylTOhEiNjsqQ4f8/QE2UFY4NwHHcEoUer
 PxkGvdOOeAZjIRYdL5wT/4tn7JNvJXR+mR85wrex6ZvWA0Q+luITCfvZer6p8kb4tklp
 Ol0ihmY5HpDqO4oyPFKgU4aK/H0vKrHxvdeXE=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 13 Jan 2020 17:52:27 +0200
Message-Id: <20200113155233.20771-3-nikolay@cumulusnetworks.com>
In-Reply-To: <20200113155233.20771-1-nikolay@cumulusnetworks.com>
References: <20200113155233.20771-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/8] net: bridge: netlink: add extack
	error messages when processing vlans
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

Add extack messages on vlan processing errors. We need to move the flags
missing check after the "last" check since we may have "last" set but
lack a range end flag in the next entry.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netlink.c |  6 +++---
 net/bridge/br_private.h | 38 +++++++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 14100e8653e6..40942cece51a 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -568,11 +568,11 @@ static int br_process_vlan_info(struct net_bridge *br,
 				bool *changed,
 				struct netlink_ext_ack *extack)
 {
-	if (!br_vlan_valid_id(vinfo_curr->vid))
+	if (!br_vlan_valid_id(vinfo_curr->vid, extack))
 		return -EINVAL;
 
 	if (vinfo_curr->flags & BRIDGE_VLAN_INFO_RANGE_BEGIN) {
-		if (!br_vlan_valid_range(vinfo_curr, *vinfo_last))
+		if (!br_vlan_valid_range(vinfo_curr, *vinfo_last, extack))
 			return -EINVAL;
 		*vinfo_last = vinfo_curr;
 		return 0;
@@ -582,7 +582,7 @@ static int br_process_vlan_info(struct net_bridge *br,
 		struct bridge_vlan_info tmp_vinfo;
 		int v, err;
 
-		if (!br_vlan_valid_range(vinfo_curr, *vinfo_last))
+		if (!br_vlan_valid_range(vinfo_curr, *vinfo_last, extack))
 			return -EINVAL;
 
 		memcpy(&tmp_vinfo, *vinfo_last,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index dbc0089e2c1a..a7dddc5d7790 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -507,32 +507,48 @@ static inline bool nbp_state_should_learn(const struct net_bridge_port *p)
 	return p->state == BR_STATE_LEARNING || p->state == BR_STATE_FORWARDING;
 }
 
-static inline bool br_vlan_valid_id(u16 vid)
+static inline bool br_vlan_valid_id(u16 vid, struct netlink_ext_ack *extack)
 {
-	return vid > 0 && vid < VLAN_VID_MASK;
+	bool ret = vid > 0 && vid < VLAN_VID_MASK;
+
+	if (!ret)
+		NL_SET_ERR_MSG_MOD(extack, "Vlan id is invalid");
+
+	return ret;
 }
 
 static inline bool br_vlan_valid_range(const struct bridge_vlan_info *cur,
-				       const struct bridge_vlan_info *last)
+				       const struct bridge_vlan_info *last,
+				       struct netlink_ext_ack *extack)
 {
 	/* pvid flag is not allowed in ranges */
-	if (cur->flags & BRIDGE_VLAN_INFO_PVID)
-		return false;
-
-	/* check for required range flags */
-	if (!(cur->flags & (BRIDGE_VLAN_INFO_RANGE_BEGIN |
-			    BRIDGE_VLAN_INFO_RANGE_END)))
+	if (cur->flags & BRIDGE_VLAN_INFO_PVID) {
+		NL_SET_ERR_MSG_MOD(extack, "Pvid isn't allowed in a range");
 		return false;
+	}
 
 	/* when cur is the range end, check if:
 	 *  - it has range start flag
 	 *  - range ids are invalid (end is equal to or before start)
 	 */
 	if (last) {
-		if (cur->flags & BRIDGE_VLAN_INFO_RANGE_BEGIN)
+		if (cur->flags & BRIDGE_VLAN_INFO_RANGE_BEGIN) {
+			NL_SET_ERR_MSG_MOD(extack, "Found a new vlan range start while processing one");
 			return false;
-		else if (cur->vid <= last->vid)
+		} else if (!(cur->flags & BRIDGE_VLAN_INFO_RANGE_END)) {
+			NL_SET_ERR_MSG_MOD(extack, "Vlan range end flag is missing");
 			return false;
+		} else if (cur->vid <= last->vid) {
+			NL_SET_ERR_MSG_MOD(extack, "End vlan id is less than or equal to start vlan id");
+			return false;
+		}
+	}
+
+	/* check for required range flags */
+	if (!(cur->flags & (BRIDGE_VLAN_INFO_RANGE_BEGIN |
+			    BRIDGE_VLAN_INFO_RANGE_END))) {
+		NL_SET_ERR_MSG_MOD(extack, "Both vlan range flags are missing");
+		return false;
 	}
 
 	return true;
-- 
2.21.0

