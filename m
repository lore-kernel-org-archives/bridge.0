Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768195;
	b=bTSL76U4U3OHbYzyea7ptHjUMuEIbQCP9Md0QpvByGkdyLQ//olOQ+/ZPeoPK1rAfq/f
	 TqG0QQBjdZ5PocaoYsIw3fDg/0p46ql7QSNeU/LLX1rW2cMX4hAS+BlQcpkNq1B+jtQzH
	 2ol0oJPFIJMamx003bOKyNruZZ+scYq0bpdxblF/6ms+yL8hjMJh+26FwbRYFjPoHG6eB
	 GveBvbcD+FeZlp9E5viBwHTSi07RRboPNAmkW7egjsCf3m1nqFfhdQKeKKaxnZ/8+m2N0
	 5tfFuSpp33wWYokTo48j7A0axR4DwFIgXzybDjLl4+xkOl5cZAJnKubYvPpZBqqxIUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768195;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=dRrmIJ8flnOPg8TSfGXbT6RnrbuAF8nRL7q/iyIRIBU=;
	b=X9f2Z98k6NILzOQY06HQq/Mznjawn2WMcCiIBRNT8xwVeQ+XV76kSW/cjc3LXnSWIScR
	 BG3ZNQaNMOYTTWp59OTukPetvRUc0OOym7MrhQ9rXGsX2dhInDaB1/cCqYO8ndcJeRYqc
	 lz6PRTcMusn7Uzmz+RgxYGiuGlaXN5+zmndd4ZB8+jUvBma/NZYEMpjRbZKCr7keeT84q
	 m4UzDgDf0L7vcMTABNFTonPIzWgprHOGK4BaHsg0gRrgHoj2IlBGdPRdgIJOvpRoEegAI
	 OagPlzvJaODXs2GgUcddQYzZjrMHcNplu+3pAjvjhM70Ppc+P0zdyEwsWCU1Rofr1Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="aAT/u2Wz";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ECF606C97E
	for <bridge@lists.linux.dev>; Fri, 23 Oct 2026 15:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74ECF606C97E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aAT/u2Wz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792768193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRrmIJ8flnOPg8TSfGXbT6RnrbuAF8nRL7q/iyIRIBU=;
	b=aAT/u2WzIiSvE6JO1HuqaPMR+CYsoBMkVluP239zEuW2znkHqnGhhCnfN/cIORYc2ITW3d
	F7Bj1GtTfF0n/4mW9RAyTYbvPSI4KkhziLPInM+ZeKN21idUT2nIQ8i1H3A9gwUON3woHa
	j9JN8dSWViQZuZYU8Qu5SBQBcoHOPZI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164--DBn7I1HPVytoPEIRebxJQ-1; Fri, 23 Oct 2026 11:09:52 -0400
X-MC-Unique: -DBn7I1HPVytoPEIRebxJQ-1
X-Mimecast-MFC-AGG-ID: -DBn7I1HPVytoPEIRebxJQ_1792768191
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a027f2e364so7200255e9.3
        for <bridge@lists.linux.dev>; Fri, 23 Oct 2026 08:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768191; x=1793372991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dRrmIJ8flnOPg8TSfGXbT6RnrbuAF8nRL7q/iyIRIBU=;
        b=LOvmgmTYrGuy8dOMEqVPMF7ijoIyNViKUEoca8cBMaNUj8IHvDFb9CIjdDNLPt4ENY
         BDLhqQX73cR+bRBAeCQq5ocXkvCqSpkGRwWz6B3yzPEVurJI87Q0ebRIqC+n5FWlA58L
         6/eY1H/63sVi1OKdKYgZY3Q3VQ3EINaqGCz7CvgmWjRHATCGqFjpYL0uPQW/jWuusHsf
         ocJ5Pqq0hEDltivPc6wgz1ijuEce9Pv2hGRYrKsFkqDkqmMmKOekyMz0i5VQorh3LZqT
         TYwtdiSNJXM62K95JYLDXQ7OCMYmeUDAxkesMkISdPM8RyvrxeLTTlzzPBYsUr4ckIae
         0tPQ==
X-Forwarded-Encrypted: i=1; AKwUvBy853kotOVBF+59fK0YSDt5B5VtE6BswUg7hZ3nUkPvzw/9pV1V/42YyUz3pBqKP4Gcg5bBViY=@lists.linux.dev
X-Gm-Message-State: AFq9FYLur3HqV5TOYHdjO+SuatrFlq6RLs/bWTrFUgQoCMYfqrqWWOst
	JsW9tQjX13IG5wzNACgywQnwEKk96m6+dK8R9X9IDauqz6X8BwpbTdq+9H4jPvtXCAaDfScEPGk
	37uKIbCGxIhLXDGNEBlHbwCqA0k3ybWgoiInVodi2SQni/S1RlnvNlHRGRQ==
X-Gm-Gg: AYBFou16V/yMQTvQYmtXXcv7q2OFYiosRc0J5ukK5jkagSUHxrOxcXteAvgeAhZ0n8M
	Tl/TB4AHi+dFa4sYudJlOMl3bm5tWb+N/4HNYAdaWwiVRG7xKtpGzFgdflxuiVKInnU6Jmw7QBY
	Fa1LlhkOUL98xxpE7hzQ1qzmxsv7BThRcR1Y684vhVaNiv8Qk+t0sfnrhsgGawOw5Vx/wW6Cweg
	iXXGK0rXfAUpl5OgtXENxzR0Mh+7sGfGKbcttOPcIEG/e9yRwtlDOed34h8S/F5Yy7Ne3zUW9nQ
	tLmP8HfEJygekxXhuH1CkZncS2q6vCZ9rVJ1CyprOUNlKRLXb8VS6UgccL4r+UIsodlgy/E=
X-Received: by 2002:a05:600c:4e43:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4a211ed613dmr41748555e9.17.1792768190613;
        Fri, 23 Oct 2026 08:09:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4e43:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4a211ed613dmr41748145e9.17.1792768190150;
        Fri, 23 Oct 2026 08:09:50 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d3f9d0dsm445729f8f.22.2026.10.23.08.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:48 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:09:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev
Subject: [PATCH net v6 6/6] net: add ip4_parse()
Message-ID: <970e2341834eadcf265fa7dd61a05ee305fdc1e4.1792687500.git.mst@redhat.com>
References: <cover.v6.git.mst@redhat.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.v6.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BEAxwPtVDFP7Ndrvrxhiwvrj1iv2fVEpUUp8WN15wTw_1792768191
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Multiple places in the net stack open-code the same minimal IPv4 header
validation: pull the fixed header, check version 4 and IHL >= 5 (where 5
is the fixed header size in 32-bit units) - and locate the transport
header at IHL * 4 past the network header.

Add a helper for doing that: it returns the validated header and
the transport header offset, or NULL if truncated or malformed.

As noted by Phil Sutter, there are more places that could use this
helper, e.g. ip_mc_check_iphdr(). They will be converted in a follow-up
patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Phil Sutter <phil@nwl.cc>
---

Notes (changelog):
    v4->v5:
        pull the options as well, so that the transport header
        offset is within the linear data (Willem de Bruijn)
    v5->v6:
        the options pull moved to the helper introduction in
        "net: resolve uncommon partial checksums at ingress"

 include/linux/ip.h                  | 38 +++++++++++++++++++++++++++++
 include/linux/virtio_net.h          | 34 +-------------------------
 net/bridge/br_netfilter_hooks.c     | 15 ++++--------
 net/ipv4/ip_input.c                 | 13 ++++------
 net/ipv4/netfilter/nf_reject_ipv4.c | 13 ++++------
 5 files changed, 54 insertions(+), 59 deletions(-)

diff --git a/include/linux/ip.h b/include/linux/ip.h
index d11c25f5030a..22604c19c460 100644
--- a/include/linux/ip.h
+++ b/include/linux/ip.h
@@ -56,4 +56,42 @@ static inline void iph_set_totlen(struct iphdr *iph, unsigned int len)
 {
 	iph->tot_len = len <= IP_MAX_MTU ? htons(len) : 0;
 }
+
+/**
+ * ip4_parse - pull and minimally validate an IPv4 header
+ * @skb: buffer to parse
+ * @nhoff: offset of the IPv4 header within the linear data
+ * @thoff: returns the transport header offset
+ *
+ * The whole header, options included, is guaranteed linear on
+ * return, so the transport header offset is within the linear
+ * data.  Callers that need to read the transport header must
+ * pull further.
+ *
+ * Return: the validated IPv4 header, or NULL if truncated or
+ * malformed.
+ */
+static inline struct iphdr *ip4_parse(struct sk_buff *skb,
+				      unsigned int nhoff,
+				      unsigned int *thoff)
+{
+	struct iphdr *iph;
+
+	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
+		return NULL;
+
+	iph = (struct iphdr *)(skb->data + nhoff);
+	if (iph->version != 4 || iph->ihl < sizeof(struct iphdr) / sizeof(u32))
+		return NULL;
+
+	*thoff = nhoff + iph->ihl * sizeof(u32);
+	/* Pull the options as well: the transport header offset
+	 * returned above must be within the linear data.  iph goes
+	 * stale across the pull.
+	 */
+	if (!pskb_may_pull(skb, *thoff))
+		return NULL;
+
+	return (struct iphdr *)(skb->data + nhoff);
+}
 #endif	/* _LINUX_IP_H */
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index a3012ebbed71..96293d3ab0da 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -53,38 +53,6 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	return 0;
 }
 
-/* TODO: nothing virtio specific here, move to ip.h */
-
-/*
- * Pull and minimally validate the IPv4 header at @nhoff.
- * Returns the header and stores the transport header offset in
- * @thoff, or NULL if truncated or malformed.  The whole header,
- * options included, is guaranteed linear on return.
- */
-static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
-						  unsigned int nhoff,
-						  unsigned int *thoff)
-{
-	struct iphdr *iph;
-
-	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
-		return NULL;
-
-	iph = (struct iphdr *)(skb->data + nhoff);
-	if (iph->version != 4 ||
-	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
-		return NULL;
-
-	*thoff = nhoff + iph->ihl * sizeof(u32);
-	/* Pull the options as well: the transport header offset
-	 * returned above must be within the linear data.  iph goes
-	 * stale across the pull.
-	 */
-	if (!pskb_may_pull(skb, *thoff))
-		return NULL;
-
-	return (struct iphdr *)(skb->data + nhoff);
-}
 /* Defined in net/core/dev.c, enabled while any network namespace
  * has net.core.virtio_net_hdr_validate set to 0.
  */
@@ -170,7 +138,7 @@ virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
 		    unsigned int *thoff, int *ip_proto)
 {
 	if (proto == htons(ETH_P_IP)) {
-		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
+		const struct iphdr *iph = ip4_parse(skb, nhoff, thoff);
 
 		if (!iph || ip_is_fragment(iph))
 			return false;
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0a394e5f4391..e89da0e41542 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -206,18 +206,13 @@ static inline void nf_bridge_pull_encap_header_rcsum(struct sk_buff *skb)
 static int br_validate_ipv4(struct net *net, struct sk_buff *skb)
 {
 	const struct iphdr *iph;
-	u32 len;
+	u32 len, thoff;
 
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+	iph = ip4_parse(skb, 0, &thoff);
+	if (!iph)
 		goto inhdr_error;
 
-	iph = ip_hdr(skb);
-
-	/* Basic sanity checks */
-	if (iph->ihl < 5 || iph->version != 4)
-		goto inhdr_error;
-
-	if (!pskb_may_pull(skb, iph->ihl*4))
+	if (!pskb_may_pull(skb, thoff))
 		goto inhdr_error;
 
 	iph = ip_hdr(skb);
@@ -228,7 +223,7 @@ static int br_validate_ipv4(struct net *net, struct sk_buff *skb)
 	if (skb->len < len) {
 		__IP_INC_STATS(net, IPSTATS_MIB_INTRUNCATEDPKTS);
 		goto drop;
-	} else if (len < (iph->ihl*4))
+	} else if (len < thoff)
 		goto inhdr_error;
 
 	if (pskb_trim_rcsum(skb, len)) {
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 9860178752b8..5adf01763e85 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -500,7 +500,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 {
 	const struct iphdr *iph;
 	int drop_reason;
-	u32 len;
+	u32 len, thoff;
 
 	/* When the interface is in promisc. mode, drop all the crap
 	 * that it receives, do not try to analyse it.
@@ -520,10 +520,6 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 	}
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-		goto inhdr_error;
-
-	iph = ip_hdr(skb);
 
 	/*
 	 *	RFC1122: 3.2.1.2 MUST silently discard any IP frame that fails the checksum.
@@ -536,7 +532,8 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 	 *	4.	Doesn't have a bogus length
 	 */
 
-	if (iph->ihl < 5 || iph->version != 4)
+	iph = ip4_parse(skb, 0, &thoff);
+	if (!iph)
 		goto inhdr_error;
 
 	BUILD_BUG_ON(IPSTATS_MIB_ECT1PKTS != IPSTATS_MIB_NOECTPKTS + INET_ECN_ECT_1);
@@ -546,7 +543,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 		       IPSTATS_MIB_NOECTPKTS + (iph->tos & INET_ECN_MASK),
 		       max_t(unsigned short, 1, skb_shinfo(skb)->gso_segs));
 
-	if (!pskb_may_pull(skb, iph->ihl*4))
+	if (!pskb_may_pull(skb, thoff))
 		goto inhdr_error;
 
 	iph = ip_hdr(skb);
@@ -559,7 +556,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 		drop_reason = SKB_DROP_REASON_PKT_TOO_SMALL;
 		__IP_INC_STATS(net, IPSTATS_MIB_INTRUNCATEDPKTS);
 		goto drop;
-	} else if (len < (iph->ihl*4))
+	} else if (len < thoff)
 		goto inhdr_error;
 
 	/* Our transport medium may have padded the buffer out. Now we know it
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 59ec465a9df9..42d639854ddf 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -25,22 +25,19 @@ nf_reject_ip_tcphdr_get(struct sk_buff *oldskb,
 static int nf_reject_iphdr_validate(struct sk_buff *skb)
 {
 	struct iphdr *iph;
-	u32 len;
+	u32 len, thoff;
 
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-		return 0;
-
-	iph = ip_hdr(skb);
-	if (iph->ihl < 5 || iph->version != 4)
+	iph = ip4_parse(skb, 0, &thoff);
+	if (!iph)
 		return 0;
 
 	len = ntohs(iph->tot_len);
 	if (skb->len < len)
 		return 0;
-	else if (len < (iph->ihl*4))
+	else if (len < thoff)
 		return 0;
 
-	if (!pskb_may_pull(skb, iph->ihl*4))
+	if (!pskb_may_pull(skb, thoff))
 		return 0;
 
 	return 1;
-- 
MST

