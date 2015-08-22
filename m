Return-Path: <xerofoify@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=+E0RS35K1qfhTXzmMf4araoGKCY0lxVoDg4hDmKzBak=;
	b=YZM3CXDkgbHUrwJ/rMHQMZA84sUDdCWefFe4bRodCgNdx6mYneTDWrPNcg8RthZeyb
	jBpBeOEu8RpCplC/aRY9tWwmNyUjw8KdPLxMT5oDsZxZahV6OUVYYh6bDBRKDyPMt71I
	c8ZDejUkGzstKC18rM9ZMe4smFKWn5XOdP0o2FEJ7PXZK66LAOGd0DuXTnsp5r+9+3zJ
	lJn8IDAtivBJ1WxlEoun2Z/2+45E4yEL1/HB7B5ZwaYl79lZH7WAWYWTCTWvaqCX7HSe
	A0SBmyVG+fyOZZbb1b/+aeNjUw8CQlcM/hehKob/3vxqbpUdW6orymI6cliDK6U5riSn
	hjDA==
From: Nicholas Krause <xerofoify@gmail.com>
Date: Sat, 22 Aug 2015 00:47:26 -0400
Message-Id: <1440218846-760-1-git-send-email-xerofoify@gmail.com>
Subject: [Bridge] [PATCH] bridge:Fix concurrent access issue in the function
	brnf_get_logical_dev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: pablo@netfilter.org
Cc: kadlec@blackhole.kfki.h, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, kaber@trash.net

This fixes a concurrent access issue in the function brnf_get_logical_dev
by properly locking with the function rcu_read_lock before calling the
function vlan_find_dev_deep_rcu and unlocking after this function call
as all callers of this function are required to do this in order to
improve issues with concurrent access by other threads executing
on this data structures simultaneously.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bridge/br_netfilter_hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index c8b9bcf..73c84a8 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -428,9 +428,10 @@ static struct net_device *brnf_get_logical_dev(struct sk_buff *skb, const struct
 	if (brnf_pass_vlan_indev == 0 || !skb_vlan_tag_present(skb))
 		return br;
 
+	rcu_read_lock();
 	vlan = __vlan_find_dev_deep_rcu(br, skb->vlan_proto,
 				    skb_vlan_tag_get(skb) & VLAN_VID_MASK);
-
+	rcu_read_unlock();
 	return vlan ? vlan : br;
 }
 
-- 
2.1.4

