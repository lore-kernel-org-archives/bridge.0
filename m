Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=n0+dypEw/mmwj4n5umZPIEkoXA5RHLYMjIpmLep+nuo=;
	b=ZjmYF+khrnKEBPqdQVUNPGyXaF8Q8XMnKbGzr7/Ld8CbbWboUaFUyxK5bZYjva+15F
	q1tzyl/AEbkpk3okxJK/TC74X/vwIHthZynf3rRanStYhyr6PRFziW5jXdEgcPgZ1x2Y
	ujKT7CvpBkTOzpWHWp8s8bqkVo/GXQlFBPHa4=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue,  7 Feb 2017 12:46:46 +0100
Message-Id: <1486468006-8080-1-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <c341a60f-f3d1-29f6-b825-5ebd1432e5b9@cumulusnetworks.com>
References: <c341a60f-f3d1-29f6-b825-5ebd1432e5b9@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next] bridge: tunnel: fix attribute checks in
	br_parse_vlan_tunnel_info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Colin Ian King <colin.king@canonical.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

These checks should go after the attributes have been parsed otherwise
we're using tb uninitialized.

Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netlink_tunnel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index 99c68012c9d4..62eaf750bd9e 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -229,15 +229,15 @@ int br_parse_vlan_tunnel_info(struct nlattr *attr,
 
 	memset(tinfo, 0, sizeof(*tinfo));
 
-	if (!tb[IFLA_BRIDGE_VLAN_TUNNEL_ID] ||
-	    !tb[IFLA_BRIDGE_VLAN_TUNNEL_VID])
-		return -EINVAL;
-
 	err = nla_parse_nested(tb, IFLA_BRIDGE_VLAN_TUNNEL_MAX,
 			       attr, vlan_tunnel_policy);
 	if (err < 0)
 		return err;
 
+	if (!tb[IFLA_BRIDGE_VLAN_TUNNEL_ID] ||
+	    !tb[IFLA_BRIDGE_VLAN_TUNNEL_VID])
+		return -EINVAL;
+
 	tun_id = nla_get_u32(tb[IFLA_BRIDGE_VLAN_TUNNEL_ID]);
 	vid = nla_get_u16(tb[IFLA_BRIDGE_VLAN_TUNNEL_VID]);
 	if (vid >= VLAN_VID_MASK)
-- 
2.1.4

