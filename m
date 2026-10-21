Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792611322;
	b=P8+fSdzl5chgDWoTEVD3qTWTU1YcqZe5U1CP/aeSTutySQCcI/rZH+4T+Axn2ZYwKziL
	 QKkJY1oWDZ8yhFdeaU8qpgwfI0dJmmKYvjd0TG9Yi8MTyEzUHQBlrDY/uerppkxTMHQfQ
	 BltNUWR2Hn+AhzwpR06BedQGpOjixaVQTdNCkZd+lR19dYW2fjv9vbSdJBzDkGgldR3X6
	 biNH4iuJbjEPGibv3CnHHU7DuQ+Uir73HDHOpOVNB8shgLu7NUFMvFy3pn2srUruprCEq
	 EvDsh60kwZxgiPfGNzfxzUW4L3moY9/0qgUWT3X3K//9sfS8piFZ+ZfEJsCXORSEBgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4vhNYdNuVIvMrC3YXBNP/msHgi5R0+GF0fZNGQns9Cg=;
	b=2ayIQ9pvn31fpobEzryfsKC8goAO+eIK7daFxtUQ9cUflAGGI3lO9ul3zLYEe1cBthdy
	 Z5WlgurRZfB1W5AHMsam6IbpPWYq/spxlW5DN0OaTgs6Mt7/xRJgkSPmC5v5dV/U22I5X
	 Ere7t5yTUjo/uaZt+tMrtRlfkFVPUnarauO7xcccJ8Np/zXh5lBPIXoNHu8vtdfd+N/OL
	 lZl30sG4ZEGa5yJ+pF0AxfBloS0c5dCX4e6jB7A0Y31+oOOykVo/q8cDEFTkNtNuM6Zb2
	 pyhzaT38zH43lQOia1/g0dsUJy7xY4LchwLjBPXk38Dx+qb7SBXw3ICzNGQlYaLhfbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aojea.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tf4cSZGy;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D3606A31F
	for <bridge@lists.linux.dev>; Wed, 21 Oct 2026 19:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 334D3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aojea.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tf4cSZGy
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b1d818b501so1178776a12.0
        for <bridge@lists.linux.dev>; Wed, 21 Oct 2026 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792611321; x=1793216121; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vhNYdNuVIvMrC3YXBNP/msHgi5R0+GF0fZNGQns9Cg=;
        b=tf4cSZGyS4WIWUpxfa093j9aIZrKR94jzJ+9uorb0gpjY1gurftZ/D0zl8xMxo7mwH
         d7fzMFQMAtDrwaMX9AoMy6ktz1OpBDYF8TJoVJi2c/+IAJIJQaqonD47x2IbHo0cb4Rv
         p1Z2OKlUboaIS6djp7FLdpvH47GfcyfNP/6Y07SViMtdLX8REatgPH3P6CWrm1pgzi+Z
         /SC/bqowp9NQZhv6O9RWO9nw3QpieNdYqjzes+OSC//pWgULfIV210DuMigje+hCppVE
         9wM72HDnDhVUMSmMp6hqsGb3wbzet28UVr4JNb2qWOPfjUr12BoNo/kyYp7Xe5l5jA2x
         aEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792611321; x=1793216121;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4vhNYdNuVIvMrC3YXBNP/msHgi5R0+GF0fZNGQns9Cg=;
        b=s+l80acq076GPGcktu5wL+JlI0NLGpSjsLmuzMbRTPzWLzUws6BcZl3K1joJX53ZHX
         hGjraVonq2G9DLxVXCNhjHoxR+jD4abYV33oIPd2fSN/ZVfuLbI0cqi1e0CZu5iu7B0D
         yqOyjcnqtGU0Vy8u3QqvAsJLNJucZBJV+KCvo4ba9b6VGNFCAyAnvOBZsockW/AioiQA
         VlaPk0/2MOz1Poq23eBL5ZaTFZGO+ZoJep0edRAf2eyZ63IeloS4s2OhBO1AMd5qHMy1
         FiSkM5jh5EGIELLfO92ZwtMK7UDr+mWrLp1qtecmZzO8jCnCaB0KVRz6utPj80Aib1n1
         SG1A==
X-Forwarded-Encrypted: i=1; AKwUvBy2RYsZCZujG3RJVAZ+L79Ip9SezeGxI4+XK1waRJZJVlVFjsy9A+MxIQsprTjajXkbJAYb9GI=@lists.linux.dev
X-Gm-Message-State: AFq9FYKlbqk5egWfieCTB1v7tj+ng0gf76Kz15HB4WxHyGjiVsndJMNp
	qSTlJ5V7mUKCUoSBRfqfa6XGaxQeZtNPOs9VmPYa0h7IZcHr6+zDgRffCPC6D9UsKYZMKUzyfQL
	UXw==
X-Received: from edcpp11.prod.google.com ([2002:a05:6402:c0cb:b0:6ae:14cc:13c4])
 (user=aojea job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:e07:b0:6b1:c5c3:9624
 with SMTP id 4fb4d7f45d1cf-6b408eb45cemr2264098a12.22.1792611320449; Wed, 21
 Oct 2026 12:35:20 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:35:09 +0000
In-Reply-To: <20261021193512.2302587-1-aojea@google.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261021193512.2302587-1-aojea@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021193512.2302587-2-aojea@google.com>
Subject: [PATCH nf-next 1/4] netfilter: br_netfilter: flush nfqueue entries
 when the hooks are removed
From: Antonio Ojea <aojea@google.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev, Antonio Ojea <aojea@google.com>, 
	"Sashiko (nipa)" <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

br_netfilter registers hooks at the bridge hook points and at ip and ip6
prerouting. It also calls NF_HOOK() itself with its own functions as
okfn: br_nf_forward() and br_nf_forward_arp() run the ip, ip6 and arp
forward hooks with br_nf_forward_finish(), br_nf_post_routing() runs the
ip and ip6 postrouting hooks with br_nf_dev_queue_xmit(). A packet
queued to userspace from one of these hook points keeps that okfn in its
nf_queue_entry and nf_reinject() calls it when the verdict arrives.

Until commit 72ac1c0937df ("netfilter: nf_queue: limit the hook drop
flush to the unregistered hook point") unregistering any hook flushed
every queued packet of the network namespace, so brnf_exit_net()
dropped these entries as a side effect of removing br_nf_ops. The flush
now only covers the hook points of the removed hooks, and the entries
queued from forward and postrouting stay in the queue after
rmmod br_netfilter. The next verdict for one of them jumps into freed
module text:

  BUG: unable to handle page fault for address: ffffffffc0802250
  #PF: supervisor instruction fetch in kernel mode
  #PF: error_code(0x0010) - not-present page
  RIP: 0010:0xffffffffc0802250
  Call Trace:
   nfqnl_reinject+0x221/0x3d0
   nfqnl_recv_verdict+0x851/0xaa0
   nfnetlink_rcv_msg+0x199/0x300
   netlink_rcv_skb+0x59/0x100
   netlink_unicast+0x28c/0x3c0
   netlink_sendmsg+0x1f2/0x420
  Modules linked in: [last unloaded: br_netfilter]

Flush every queued packet of the namespace when br_netfilter leaves it.
Move the hook removal to a pre_exit callback and do the flush in the
exit callback: the pernet core runs a grace period between the two, so
no hook of this module is still running when the flush happens and no
entry with an okfn in this module can be queued after it. The same
split is what nf_tables_pre_exit_net() uses for base chain hooks.

nf_queue_nf_hook_drop() was declared in nf_internals.h, which is
private to net/netfilter; move the declaration to nf_queue.h so that
br_netfilter can call it, and include that header in the two files that
used the private declaration.

Reproduced in virtme-ng with br_netfilter built as a module: two network
namespaces connected through a bridge with bridge-nf-call-iptables=1, an
ip forward chain that sends udp dport 12345 to queue 1, and the nf_queue
selftest helper holding the verdicts (-H). With 10 packets queued, rmmod
br_netfilter returns and /proc/net/netfilter/nfnetlink_queue still shows
the 10 entries; the first verdict panics the kernel as shown above. With
this patch rmmod drops the 10 entries and the verdict fails with
-ENOENT. nft_queue.sh passes.

The code and this commit message were written with an LLM coding
assistant from the review linked below. The author reviewed the result
and validated it with the reproducer and the selftest.

Fixes: 72ac1c0937df ("netfilter: nf_queue: limit the hook drop flush to the unregistered hook point")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netfilter-devel/179237288267.3135.9555179349652175002@kernel.org/
Suggested-by: Florian Westphal <fw@strlen.de>
Assisted-by: LLM
Signed-off-by: Antonio Ojea <aojea@google.com>
---
 include/net/netfilter/nf_queue.h  |  5 +++++
 net/bridge/br_netfilter_hooks.c   | 21 ++++++++++++++++++---
 net/netfilter/nf_conntrack_core.c |  1 +
 net/netfilter/nf_internals.h      |  3 ---
 net/netfilter/nft_ct.c            |  1 +
 5 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index 86021c55ba3c..9e1388179097 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -42,6 +42,11 @@ struct nf_queue_handler {
 void nf_register_queue_handler(const struct nf_queue_handler *qh);
 void nf_unregister_queue_handler(void);
 
+/* Drop the packets of @net queued from the hook point of @ops, or every
+ * queued packet of @net when @ops is NULL.
+ */
+void nf_queue_nf_hook_drop(struct net *net, const struct nf_hook_ops *ops);
+
 bool nf_queue_entry_get_refs(struct nf_queue_entry *entry);
 void nf_queue_entry_free(struct nf_queue_entry *entry);
 
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index e15355ff215a..d3fc89c3317c 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -37,6 +37,7 @@
 #include <net/dst_metadata.h>
 #include <net/route.h>
 #include <net/netfilter/br_netfilter.h>
+#include <net/netfilter/nf_queue.h>
 #include <net/netns/generic.h>
 #include <net/inet_dscp.h>
 
@@ -1296,14 +1297,27 @@ static int __net_init brnf_init_net(struct net *net)
 	return br_netfilter_sysctl_init_net(net);
 }
 
+static void __net_exit brnf_pre_exit_net(struct net *net)
+{
+	struct brnf_net *brnet = net_generic(net, brnf_net_id);
+
+	if (brnet->enabled)
+		nf_unregister_net_hooks(net, br_nf_ops, ARRAY_SIZE(br_nf_ops));
+}
+
 static void __net_exit brnf_exit_net(struct net *net)
 {
-	struct brnf_net *brnet;
+	struct brnf_net *brnet = net_generic(net, brnf_net_id);
 
-	brnet = net_generic(net, brnf_net_id);
 	if (brnet->enabled) {
-		nf_unregister_net_hooks(net, br_nf_ops, ARRAY_SIZE(br_nf_ops));
 		brnet->enabled = false;
+		/* A grace period has passed since brnf_pre_exit_net() removed
+		 * the hooks, so none of them is still running.  Drop what they
+		 * queued from the ip, ip6 and arp forward and postrouting hook
+		 * points: those entries carry an okfn in this module and the
+		 * hook removal did not flush them.
+		 */
+		nf_queue_nf_hook_drop(net, NULL);
 	}
 
 	br_netfilter_sysctl_exit_net(net, brnet);
@@ -1311,6 +1325,7 @@ static void __net_exit brnf_exit_net(struct net *net)
 
 static struct pernet_operations brnf_net_ops __read_mostly = {
 	.init = brnf_init_net,
+	.pre_exit = brnf_pre_exit_net,
 	.exit = brnf_exit_net,
 	.id   = &brnf_net_id,
 	.size = sizeof(struct brnf_net),
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 931b76aacd93..42a7cbdbd7d5 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -49,6 +49,7 @@
 #include <net/netfilter/nf_conntrack_synproxy.h>
 #include <net/netfilter/nf_nat.h>
 #include <net/netfilter/nf_nat_helper.h>
+#include <net/netfilter/nf_queue.h>
 #include <net/netns/hash.h>
 #include <net/ip.h>
 
diff --git a/net/netfilter/nf_internals.h b/net/netfilter/nf_internals.h
index ce5aff2cae71..06a795bbbb99 100644
--- a/net/netfilter/nf_internals.h
+++ b/net/netfilter/nf_internals.h
@@ -23,9 +23,6 @@
 #define CTA_FILTER_F_ALL			(CTA_FILTER_F_MAX-1)
 #define CTA_FILTER_FLAG(ctattr) CTA_FILTER_F_ ## ctattr
 
-/* nf_queue.c */
-void nf_queue_nf_hook_drop(struct net *net, const struct nf_hook_ops *ops);
-
 /* nf_log.c */
 int __init netfilter_log_init(void);
 
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 5a8db5592036..7464805651ae 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -23,6 +23,7 @@
 #include <net/netfilter/nf_conntrack_l4proto.h>
 #include <net/netfilter/nf_conntrack_expect.h>
 #include <net/netfilter/nf_conntrack_seqadj.h>
+#include <net/netfilter/nf_queue.h>
 #include "nf_internals.h"
 
 struct nft_ct_helper_obj  {
-- 
2.56.0.218.g1ec904b173-goog

