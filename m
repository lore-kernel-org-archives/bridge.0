Return-Path: <l4stpr0gr4m@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+ZeKKxsi+JTCjIObZ4eE1fvYuLFReuH5GCzKzRZkgdE=;
 b=UCLzYMyaq7Rrmnp8ZFnPp4omrv77mq+4A6TSSxWbqeZmgcMawouGrIXO7wQEGX4ndh
 PYKaWptz3y5dYVq9LZjG7cqYZhlKesoDrBTXeVAHAlctv2iHKr1OPNQOOoqinC5hWa9x
 JV56yWZEL5kcLSl3Y9cNT872JEpREwb9UGmuHtZhNFyEXBQa4QZ4Xz/3Ms79Da8IgVcH
 e83V4rEDO67aDK3PMsP3dPDTrtC6D0B1IOk61uYp1euwsX2rXIwHoVRvewY6bDVWYW2i
 97DlNEAOs76P6GTtvaaHpyT73waBlhphm7jkMXPg/4v1swexZIXlhQ5bCnFwV6Bhuz+A
 PMPw==
From: Kangmin Park <l4stpr0gr4m@gmail.com>
Date: Mon, 23 Aug 2021 15:19:38 +0900
Message-Id: <20210823061938.28240-1-l4stpr0gr4m@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: replace
	__vlan_hwaccel_put_tag with skb_vlan_push
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

br_handle_ingress_vlan_tunnel() is called in br_handle_frame() and
goto drop when br_handle_ingress_vlan_tunnel() return non-zero.

But, br_handle_ingress_vlan_tunnel() always return 0. So, the goto
routine is currently meaningless.

However, paired function br_handle_egress_vlan_tunnel() call
skb_vlan_pop(). So, change br_handle_ingress_vlan_tunnel() to call
skb_vlan_push() instead of __vlan_hwaccel_put_tag(). And return
the return value of skb_vlan_push().

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
---
 net/bridge/br_vlan_tunnel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
index 01017448ebde..7b5a33dc9d4d 100644
--- a/net/bridge/br_vlan_tunnel.c
+++ b/net/bridge/br_vlan_tunnel.c
@@ -179,9 +179,7 @@ int br_handle_ingress_vlan_tunnel(struct sk_buff *skb,
 
 	skb_dst_drop(skb);
 
-	__vlan_hwaccel_put_tag(skb, p->br->vlan_proto, vlan->vid);
-
-	return 0;
+	return skb_vlan_push(skb, p->br->vlan_proto, vlan->vid);
 }
 
 int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
-- 
2.26.2

