Return-Path: <mirq-linux@rere.qmqm.pl>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1541719024; bh=IVVBSmwrquIo56fC2fNYc4DEAHn5Hh2VoiI664DBOt8=;
	h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
	b=bG1HLOQHoNGKGWrjDuIyiPY5Nkf2ij7lMTSs4Bb13RqWvlDCZ4/E9AIdwfTKOuGk6
	WF1cZZ0bbWD3YntRhkxHRZt7StOyg7+QqxzLlvsiafe6bNht/J5l5VnwczQWyiWdyZ
	kEFrHWYllPave6I0rVN0V5VigqhlQXYDb6ZgStzq/CsjCX3WTNgWmqjYcxqTQTOAS3
	bKDktl/dfeUBAAcclbGoEo+rYcyGhItGbUWzVih5606sVv4Mxv3Re3mwE/2EPM4gzL
	de1Ysl448pqHqa2+5u/Y/G07/qAZWW8B8nbKiJwAzOWmG0NaJBwcXR+99dMnXTfgYL
	+BkbZ5BubCDPg==
Date: Fri, 09 Nov 2018 00:18:02 +0100
Message-Id: <c27737b63ec762836a000e2bb4fc95419ab0f097.1541718583.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 3/9] net/core: use __vlan_hwaccel helpers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, coreteam@netfilter.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pablo Neira Ayuso <pablo@netfilter.org>, Jiri Pirko <jiri@resnulli.us>, Steve Wise <swise@chelsio.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Sathya Perla <sathya.perla@broadcom.com>, Cong Wang <xiyou.wangcong@gmail.com>, Mirko Lindner <mlindner@marvell.com>, Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@mellanox.com>

This removes assumptions about VLAN_TAG_PRESENT bit.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 net/core/dev.c       | 8 +++++---
 net/core/skbuff.c    | 2 +-
 net/sched/act_vlan.c | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0ffcbdd55fa9..bf7e0a471186 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4889,7 +4889,7 @@ static int __netif_receive_skb_core(struct sk_buff *skb, bool pfmemalloc,
 		 * and set skb->priority like in vlan_do_receive()
 		 * For the time being, just ignore Priority Code Point
 		 */
-		skb->vlan_tci = 0;
+		__vlan_hwaccel_clear_tag(skb);
 	}
 
 	type = skb->protocol;
@@ -5386,7 +5386,9 @@ static struct list_head *gro_list_prepare(struct napi_struct *napi,
 		}
 
 		diffs = (unsigned long)p->dev ^ (unsigned long)skb->dev;
-		diffs |= p->vlan_tci ^ skb->vlan_tci;
+		diffs |= skb_vlan_tag_present(p) ^ skb_vlan_tag_present(skb);
+		if (skb_vlan_tag_present(p))
+			diffs |= p->vlan_tci ^ skb->vlan_tci;
 		diffs |= skb_metadata_dst_cmp(p, skb);
 		diffs |= skb_metadata_differs(p, skb);
 		if (maclen == ETH_HLEN)
@@ -5652,7 +5654,7 @@ static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 	__skb_pull(skb, skb_headlen(skb));
 	/* restore the reserve we had after netdev_alloc_skb_ip_align() */
 	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN - skb_headroom(skb));
-	skb->vlan_tci = 0;
+	__vlan_hwaccel_clear_tag(skb);
 	skb->dev = napi->dev;
 	skb->skb_iif = 0;
 	skb->encapsulation = 0;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b4ee5c8b928f..5bb5eb500605 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5123,7 +5123,7 @@ int skb_vlan_pop(struct sk_buff *skb)
 	int err;
 
 	if (likely(skb_vlan_tag_present(skb))) {
-		skb->vlan_tci = 0;
+		__vlan_hwaccel_clear_tag(skb);
 	} else {
 		if (unlikely(!eth_type_vlan(skb->protocol)))
 			return 0;
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index ba677d54a7af..93fdaf707313 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -63,7 +63,7 @@ static int tcf_vlan_act(struct sk_buff *skb, const struct tc_action *a,
 		/* extract existing tag (and guarantee no hw-accel tag) */
 		if (skb_vlan_tag_present(skb)) {
 			tci = skb_vlan_tag_get(skb);
-			skb->vlan_tci = 0;
+			__vlan_hwaccel_clear_tag(skb);
 		} else {
 			/* in-payload vlan tag, pop it */
 			err = __skb_vlan_pop(skb, &tci);
-- 
2.19.1

