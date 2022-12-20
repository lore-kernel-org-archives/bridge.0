Return-Path: <jgu@purestorage.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D80314011C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 043ED400EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google2022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=frWLw2ZkVObcc07j9dtQMFLxjnvLrXU3PwzZGX4Mo7w=;
 b=eduU04r8hf3vvnHc0OMdNDtR057TK+Snzk8vQVcuXrsnOT88upRHhU9h+0XUMlna8a
 gUf4xd7jISw24azRqDOgbn3C38HFfLvqW/W+MqKYRsbWzlfhFY4LCwsuWU86Ek02VpmP
 lQCTtUQ128C8+W5PdwtcECwTcDBM42bnqb0RiKyV1qCgx6e7AMbgFw1RfGTtyWU7sTmD
 ZCmhq6FggXO8KcVAt4QeON0+KXKfFCn2lVsKbntLz3MyFlb7UI1zCEMvzEagSmAV2x3o
 x6UpeRgDSrU+4hJDnqANPAkpLGMoPKl0tNYn/TKlaS7lOG+0gxMpXZDY8S+iY7ujStgZ
 fU0Q==
From: Joy Gu <jgu@purestorage.com>
Date: Mon, 19 Dec 2022 18:48:07 -0800
Message-Id: <20221220024807.36502-1-jgu@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] net: bridge: mcast: read ngrec once in igmp3/mld2
	report
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Joy Gu <jgu@purestorage.com>, netdev@vger.kernel.org, razor@blackwall.org, linux-kernel@vger.kernel.org, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, joern@purestorage.com

In br_ip4_multicast_igmp3_report() and br_ip6_multicast_mld2_report(),
"ih" or "mld2r" is a pointer into the skb header. It's dereferenced to
get "num", which is used in the for-loop condition that follows.

Compilers are free to not spend a register on "num" and dereference that
pointer every time "num" would be used, i.e. every loop iteration. Which
would be a bug if pskb_may_pull() (called by ip_mc_may_pull() or
ipv6_mc_may_pull() in the loop body) were to change pointers pointing
into the skb header, e.g. by freeing "skb->head".

We can avoid this by using READ_ONCE().

Suggested-by: Joern Engel <joern@purestorage.com>
Signed-off-by: Joy Gu <jgu@purestorage.com>
---
 net/bridge/br_multicast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 48170bd3785e..2ac4b099e00d 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2624,11 +2624,11 @@ static int br_ip4_multicast_igmp3_report(struct net_bridge_mcast *brmctx,
 	bool changed = false;
 	int err = 0;
 	u16 nsrcs;
 
 	ih = igmpv3_report_hdr(skb);
-	num = ntohs(ih->ngrec);
+	num = ntohs(READ_ONCE(ih->ngrec));
 	len = skb_transport_offset(skb) + sizeof(*ih);
 
 	for (i = 0; i < num; i++) {
 		len += sizeof(*grec);
 		if (!ip_mc_may_pull(skb, len))
@@ -2750,11 +2750,11 @@ static int br_ip6_multicast_mld2_report(struct net_bridge_mcast *brmctx,
 
 	if (!ipv6_mc_may_pull(skb, sizeof(*mld2r)))
 		return -EINVAL;
 
 	mld2r = (struct mld2_report *)icmp6_hdr(skb);
-	num = ntohs(mld2r->mld2r_ngrec);
+	num = ntohs(READ_ONCE(mld2r->mld2r_ngrec));
 	len = skb_transport_offset(skb) + sizeof(*mld2r);
 
 	for (i = 0; i < num; i++) {
 		__be16 *_nsrcs, __nsrcs;
 		u16 nsrcs;
-- 
2.39.0

