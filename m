Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792611323;
	b=yCeXc+qhkzuklxfp78c01/KGWGfDhs7B8N8TKiIx+ymKwjoscEySYFDRZaRbiJ9Nurtp
	 f/cU342mqilvuMzsCp1Le6720vAPLBQk+edjr+UdVTT5PthhiT9bWV74eERSHibbB7slY
	 8EmKydjd2F1e7vm825m3Oph1AKckVuWo0wKEyFKD9E+5F72DwyjVO15AtUij47BsLMtqT
	 NL/G7SSOcxFt8ECTM4Xm+fPOLbtANuwJcbU3b7ygnJnp/i9GW8dREnud1o1JADpgtZ4HQ
	 JRIS8IhbdTIp3uICivSU66nrV0wjH9bpgxY9RTPVNEeYu8RFMrIYLc6oS6eWCHG5n6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nMtqh2Mj2WCDd5yf3abSsLXT8L797mR+77AQX/XH9K0=;
	b=DBNRoNynWAdpMsUiaN0wMAqO60/r+DAf6O5CQ9XL8Ti/X0GQ2169tLVlxYtkDJsT0YAe
	 LrZghkS33bVyo8KevpmHOY/pAO8QM8v7vjvbl6re27eJ8mibdVjAaujxSKlZjAwRyejtm
	 FJV46qj77cDpuobEKzrxPTf8FItEGQNMKrRQ89C5egntZxh7ynVF3KK69LBIa3ePC/Qs9
	 fQtJ8FRdnwE1gJN+E43oDxvM2aqkd/dO9LRrbBOFGf+tsYePqtXOPCCztQAjJB6QwcHQf
	 CacYLimJReTcSf5HXfCVetfexrheXzmn9ZOvqzYwzBy98ru11PGcH/KICoyn1oAmkLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aojea.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=alpHig5j;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550CB606A31D
	for <bridge@lists.linux.dev>; Wed, 21 Oct 2026 19:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 550CB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aojea.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=alpHig5j
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c438ca31778so82463666b.2
        for <bridge@lists.linux.dev>; Wed, 21 Oct 2026 12:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792611322; x=1793216122; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMtqh2Mj2WCDd5yf3abSsLXT8L797mR+77AQX/XH9K0=;
        b=alpHig5jx6YfkvRiZqvy52XVeFPGIvJxR2yOxEn78P4Uvib28BGQAuatpspcNeoMWN
         NK5iOlMgbweZMCWlBiM0+PGo+Bh7+tQYGLC7aS2ElLfMpIBlnNDG5eAya4l+puCekHMj
         02uEAJtv/xwKrhUkka3ECL6w5rHivwZuaMSSntIRQzMFqlsZgVGTbvZ4WfLiRFCFsrR1
         Yn7qIIycbwIuk0lIC6M+Lcm8TW78TAkGFrIN0wmwaLDOYSk2P4qL2AL6JyM/A6drrY65
         J4G2qvIeEDGly/7JBmubAwgnp0N1bJpylCNYU5pq5Zlvb88AltgJog62Lt9Wcgz9k7VH
         q0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792611322; x=1793216122;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nMtqh2Mj2WCDd5yf3abSsLXT8L797mR+77AQX/XH9K0=;
        b=hlVtEyP8DQ3hfoe0VBI8WntZL0aqYssOD4AF/i1/Vg9zFithVNnT4mv8SESfAy0k4h
         7Njg0SMnYouV2KHRiUXfIWlrBFSIOzv9UIr5C4j6d/YNOLnobjt+PY9DqKnAQ84Cnmjo
         gyD6SQbxVrU+M7rhqDQi2Y2K797pFKFuIqK6GnNqGNxT0I4tFzAFjy8pvF/dUyG/1vTZ
         AevLbdNK7E+H42cdR72aj3LYdakSwdzITp0EaWvdHrLAji/b9LEzMfZldAhhVNLuDSA+
         raAuhTyU+olpNBdcEDdYCcnIFXl3LNvQhPo5voI19RlZZPAGzSewF21hdPhR2yIcdPo+
         Iw6w==
X-Forwarded-Encrypted: i=1; AKwUvBw+IRRKoZRHssQBkxg297dFu6JqzUfQsbikO4bcUTRXZIBJI85kWFPJVpLzIHWn87C5GlU5QhI=@lists.linux.dev
X-Gm-Message-State: AFq9FYLmwpLhAVODXD+IJBtwZH24S8ujHpMQaUwhgqpaJF27O9L7Ce0z
	cAqgb8kLKaABEJplQVFRHKCW9nlaa9Y8ZMxlkXgV6T+hFtrkqnEp8HJ14xhv5xRXeaqYKdjRMYF
	B6A==
X-Received: from ejczw8-n1.prod.google.com ([2002:a17:907:e008:10b0:c3d:9dd0:9ff2])
 (user=aojea job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:9f90:b0:c46:7645:86c
 with SMTP id a640c23a62f3a-c4679b9cba3mr266657666b.47.1792611321449; Wed, 21
 Oct 2026 12:35:21 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:35:10 +0000
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
Message-ID: <20261021193512.2302587-3-aojea@google.com>
Subject: [PATCH nf-next 2/4] netfilter: conntrack: flush nfqueue entries
 before waiting for the conntrack count
From: Antonio Ojea <aojea@google.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev, Antonio Ojea <aojea@google.com>, 
	"Sashiko (nipa)" <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

A packet queued to userspace keeps its conntrack reference in
skb->_nfct until the verdict arrives. The conntrack hooks sit at
prerouting, local in, local out and postrouting; a packet queued from
the forward hook point is covered by none of them.

Until commit 72ac1c0937df ("netfilter: nf_queue: limit the hook drop
flush to the unregistered hook point") unregistering the conntrack hooks
flushed every queued packet of the network namespace and released those
references. The flush now only covers the hook points of the removed
hooks. Packets queued from forward keep their nf_conn alive, and
nf_conntrack_cleanup_net_list() loops on cnet->count, with
pernet_ops_rwsem held for write, until userspace sends a verdict or
closes the queue.

Flush every queued packet of the namespaces being cleaned up in
nf_conntrack_cleanup_net_list(), after the synchronize_rcu_expedited()
that waits for the packets still inside the hooks, so that a packet a
hook was processing while the hooks were removed is dropped as well.

Reproduced in virtme-ng with nf_conntrack built as a module and loaded
with enable_hooks=1: two network namespaces routed through the host
namespace, an ip forward chain that sends udp dport 12345 to queue 1,
and the nf_queue selftest helper holding the verdicts (-H). With 10
packets queued and 10 conntrack entries, rmmod nf_conntrack blocks until
the verdicts are sent, 15 s later in the test. With this patch rmmod
returns at once, the 10 entries are dropped and the verdict fails with
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
 net/netfilter/nf_conntrack_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 42a7cbdbd7d5..3ccee38beb1f 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2490,6 +2490,12 @@ void nf_conntrack_cleanup_net_list(struct list_head *net_exit_list)
 	 *  delete...
 	 */
 	synchronize_rcu_expedited();
+
+	/* Packets queued to userspace hold nf_conn references; the hook
+	 * removal only flushed the hook points conntrack was registered at.
+	 */
+	list_for_each_entry(net, net_exit_list, exit_list)
+		nf_queue_nf_hook_drop(net, NULL);
 i_see_dead_people:
 	busy = 0;
 	list_for_each_entry(net, net_exit_list, exit_list) {
-- 
2.56.0.218.g1ec904b173-goog

