Return-Path: <xerofoify@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=+E0RS35K1qfhTXzmMf4araoGKCY0lxVoDg4hDmKzBak=;
	b=V3Qt103pRfHbK1nxTdtBml8GTAQp2gf8qwbtmHu4xiplkH/nmBwl51YM89rjDtlTQT
	3TSxKEvi/hfx82+SAm7MVWy3Y1V8j9q3v4L9vNXQsGWG1o1vgHFIPsBUCdTaoy5wm0/M
	kwQD96ymsuOzo4G8aiiLw1xyygoTvOStSN6pSMOLyzgJCJUzdSptNclczzDiDvRJ9J51
	AHM2p3K2BRjNmriWcwApEnorotl3e9R5sVH2ZtpcRFpyEhKKMh9BxEn2T6bLUI0FC6CR
	Do0wMrvJuiOaQ3typFdofu9XU794uBO9V6Bx/Dp9S0vuQM5luvgMvitm5nvKdsOK8qg9
	y/Ng==
From: Nicholas Krause <xerofoify@gmail.com>
Date: Fri,  1 Jan 2016 01:17:25 -0500
Message-Id: <1451629045-9017-1-git-send-email-xerofoify@gmail.com>
Subject: [Bridge] [PATCH RESEND] bridge:Fix concurrent access issue in the
	function brnf_get_logical_dev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: pablo@netfilter.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kaber@trash.net, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, davem@davemloft.net

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

