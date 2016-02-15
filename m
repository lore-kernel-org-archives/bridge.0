Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 15 Feb 2016 03:07:06 +0100
Message-Id: <1455502026-23144-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] net: fix bridge multicast packet checksum
	validation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Tom Herbert <tom@herbertland.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Steinar H . Gunderson" <sgunderson@bigfoot.com>, "David S . Miller" <davem@davemloft.net>

We need to update the skb->csum after pulling the skb, otherwise
checksum validation will fail. This fixes multicast packet loss for
bridges and splats like the following:

[...]
[   43.986968] eth0: hw csum failure
[   43.990344] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.4.0 #2
[   43.996193] Hardware name: BCM2709
[   43.999647] [<800204e0>] (unwind_backtrace) from [<8001cf14>] (show_stack+0x10/0x14)
[   44.007432] [<8001cf14>] (show_stack) from [<801ab614>] (dump_stack+0x80/0x90)
[   44.014695] [<801ab614>] (dump_stack) from [<802e4548>] (__skb_checksum_complete+0x6c/0xac)
[   44.023090] [<802e4548>] (__skb_checksum_complete) from [<803a055c>] (ipv6_mc_validate_checksum+0x104/0x178)
[   44.032959] [<803a055c>] (ipv6_mc_validate_checksum) from [<802e111c>] (skb_checksum_trimmed+0x130/0x188)
[   44.042565] [<802e111c>] (skb_checksum_trimmed) from [<803a06e8>] (ipv6_mc_check_mld+0x118/0x338)
[   44.051501] [<803a06e8>] (ipv6_mc_check_mld) from [<803b2c98>] (br_multicast_rcv+0x5dc/0xd00)
[   44.060077] [<803b2c98>] (br_multicast_rcv) from [<803aa510>] (br_handle_frame_finish+0xac/0x51c)
[...]

Fixes: 9afd85c9e455 ("net: Export IGMP/MLD message validation code")
Reported-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---

Steinar, can you check whether this fixes the bridge issues you reported on
bugzilla #99081? Not quite sure whether it is the same as yours as you
do not seem to have any such call traces.


I am not super happy with how this patch looks, but there is no "skb_push_rcsum"
available and skb_pull_rcsum() seems non-reversible as is. Alternative suggestions
always welcome.


 net/core/skbuff.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5bf88f5..6c34ef6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4076,6 +4076,11 @@ struct sk_buff *skb_checksum_trimmed(struct sk_buff *skb,
 	struct sk_buff *skb_chk;
 	unsigned int offset = skb_transport_offset(skb);
 	__sum16 ret;
+	int ip_summed;
+	int csum_valid;
+	int csum_level;
+	int csum_bad;
+	__wsum csum;
 
 	skb_chk = skb_checksum_maybe_trim(skb, transport_len);
 	if (!skb_chk)
@@ -4084,10 +4089,22 @@ struct sk_buff *skb_checksum_trimmed(struct sk_buff *skb,
 	if (!pskb_may_pull(skb_chk, offset))
 		goto err;
 
-	__skb_pull(skb_chk, offset);
+	ip_summed = skb->ip_summed;
+	csum_valid = skb->csum_valid;
+	csum_level = skb->csum_level;
+	csum_bad = skb->csum_bad;
+	csum = skb->csum;
+
+	skb_pull_rcsum(skb_chk, offset);
 	ret = skb_chkf(skb_chk);
 	__skb_push(skb_chk, offset);
 
+	skb->ip_summed = ip_summed;
+	skb->csum_valid = csum_valid;
+	skb->csum_level = csum_level;
+	skb->csum_bad = csum_bad;
+	skb->csum = csum;
+
 	if (ret)
 		goto err;
 
-- 
1.7.10.4

