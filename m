Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=oyu4NyqM+QfxP+NlmByVdZRLn7Uggl5qhvuzGs2uaFg=;
	b=FAYe/siB9vZvUJK7GVtxZ/6P5bi9AzVBu+mxeJtMWkiAtsqM+MQkVBECx1pquIlBJN
	H+p7SyuaWRuvQThrdc8VOFYyU+Y7Pv0W6x4zP2VJuc2wPhnat55A63O3b44xCNuVjwZL
	hGQLIlq8jNsOzQjHOXHesl6GysAp9q0vg9Q5A=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 23 Mar 2018 18:27:06 +0200
Message-Id: <1521822426-18563-1-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <20180322153406.17760-1-3chas3@gmail.com>
References: <20180322153406.17760-1-3chas3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: fix direct access to bridge
	vlan_enabled and use helper
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, 3chas3@gmail.com, davem@davemloft.net

We need to use br_vlan_enabled() helper otherwise we'll break builds
without bridge vlans:
net/bridge//br_if.c: In function ‘br_mtu’:
net/bridge//br_if.c:458:8: error: ‘const struct net_bridge’ has no
member named ‘vlan_enabled’
  if (br->vlan_enabled)
        ^
net/bridge//br_if.c:462:1: warning: control reaches end of non-void
function [-Wreturn-type]
 }
 ^
scripts/Makefile.build:324: recipe for target 'net/bridge//br_if.o'
failed

Fixes: 419d14af9e07 ("bridge: Allow max MTU when multiple VLANs present")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 48dc4d2e2be3..87b2afd455c7 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -455,7 +455,7 @@ static int __br_mtu(const struct net_bridge *br, bool (compare_fn)(int, int))
 
 int br_mtu(const struct net_bridge *br)
 {
-	if (br->vlan_enabled)
+	if (br_vlan_enabled(br->dev))
 		return __br_mtu(br, max_mtu);
 	else
 		return __br_mtu(br, min_mtu);
-- 
2.1.4

