Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WwnW+GWJajN/nHK/Uu8SXGjaStKjr4BPobqUYTEyxn4=;
 b=hHDIhLqQj6tIa4w4qVJf800brqAuVR7rfr+AG9ipbfVi11s4nScM+Xibp+zDBVAzii
 hkuPeCjHsZ76AvynBapL8kF5odlTh+GOYV3RmrFzMiVTp6OGizUh7XLkDgJg/0+30Waw
 shC1D7SpfqudW6TBOtRVs8KoP1WtmJUbp8UCIgYkiWKAFxkd/8KzKcfIA1kdVCmbaxVs
 od1nxE3C5Ntg/CsaSs82plPxuYsT5V8PiAYsREpXB1FsLaqU6BX9nH4MGvalMe26FGCe
 wgHOj8zgTjecbISRYIBn+sMHQ7/pDvJ3yC4gDGkylHK1BduQ1Xal4OIF2lJrml648DzN
 JH2w==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 16 Aug 2021 17:57:04 +0300
Message-Id: <20210816145707.671901-2-razor@blackwall.org>
In-Reply-To: <20210816145707.671901-1-razor@blackwall.org>
References: <20210816145707.671901-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/4] net: bridge: vlan: enable mcast
	snooping for existing master vlans
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

We always create a vlan with enabled mcast snooping, so when the user
turns on per-vlan mcast contexts they'll get consistent behaviour with
the current situation, but one place wasn't updated when a bridge/master
vlan which already exists (created due to port vlans) is being added as
real bridge vlan (BRIDGE_VLAN_INFO_BRENTRY). We need to enable mcast
snooping for that vlan when that happens.

Fixes: 7b54aaaf53cb ("net: bridge: multicast: add vlan state initialization and control")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_vlan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index cbc922681a76..e25e288e7a85 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -694,6 +694,7 @@ static int br_vlan_add_existing(struct net_bridge *br,
 		vlan->flags |= BRIDGE_VLAN_INFO_BRENTRY;
 		vg->num_vlans++;
 		*changed = true;
+		br_multicast_toggle_one_vlan(vlan, true);
 	}
 
 	if (__vlan_add_flags(vlan, flags))
-- 
2.31.1

