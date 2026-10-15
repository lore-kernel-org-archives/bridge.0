Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC551A743
	for <bridge@lists.linux.dev>; Thu, 15 Oct 2026 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068119; cv=none; b=Ro5b7jD2OpFnLPaKpcv4OCRpXZhJoJzKYWTzoypxfe+QAuS3oKy0+0MAGc8ukNPDdZHAruL3HEvFZQMVOR94vS9dHDCPZv9QyCfrV2p6C+WnTooYdx7AOD7G1YrSGn6xZHu504m9PlsQ/aaKr3/40yTvJcsC1puyBwtxuMl/dBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068119; c=relaxed/simple;
	bh=qrg0eJdV2vP7kYY8ClAjBocw4aBzi4WlBp77YFs9kk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=a4y2qxdfgKmv558pXc2ULH4JrzJwcBh5MsK7S8/Y0pg72LD7LUOx03hRBZZ3ntEZWWOcu6jyMdy8RcZCZUODWOUjXVA3afYPUa4L1ux5H35eBQ1aHXr3wcTtHAqjX6mAXrSA+YpI2kXXsvSJreTVGthF2DSiTVrC+MPJnwLmZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fci0nQXm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fci0nQXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YBIQURysnHAtYsYZBEyvPCoDT2vBfeJzj7rU3gaKycI=;
	b=Fci0nQXmFDZ4PbjUSvHjyOqyxnqs1LVVXnhAZOWzPlkx+tFbV35Zs0UGh2blIxvkAtuY5z
	rWNxZbIqquUJTLmPIEGgmQWfKSQ4CV/7poBInBqfylEVv9HBh9dtt+6sttBbZ6jAIxRPEN
	vwNtiekCC02W3z9EERm7AAe8EPwBSW0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-HLyO3Q4tPS-0diQZAvyfSA-1; Thu, 15 Oct 2026 12:41:53 +0000
X-MC-Unique: HLyO3Q4tPS-0diQZAvyfSA-1
X-Mimecast-MFC-AGG-ID: HLyO3Q4tPS-0diQZAvyfSA_1792068112
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1721559b4so54664035e9.1
        for <bridge@lists.linux.dev>; Thu, 15 Oct 2026 05:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068112; x=1792672912;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBIQURysnHAtYsYZBEyvPCoDT2vBfeJzj7rU3gaKycI=;
        b=cFFvAUO0uA1r0fZlPw7mtJoNQ/blyj4/Z63nWfCMc0yDBCr2mM8hhcFXU3AoPdJbn+
         OLAjDAjSvF8Va7q8F1x19eLFC8nnHxzix2qxa3gwSw2um1XFZUe+ldrmQ90XJFonKfnE
         i7BLwRKpznOPJ9t+apxzw6csk45OrmWPm4NgC0CTnaUvD7bDwqZh/dUboie7jUlzMWLl
         pekSNDSjKmxXCP1dFvDY5VkGBFhTLpkkZZ+UFK20hWTcPbrPTGiB/sA29T0wg6Cm96Bh
         CQ/P+wsSjQcZoAzl98c6FKkJs5GzisMP7ntlsZCXjUvQM7UpIVWgj0ioDNPPUiV7lrF2
         OTyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzj7mFvytLPLFP+a2yMkKjDjGhWlYTW8xElnVlnCfrNGwl6YM8Nz/cZqEWbRVMltSl2Jtd5KbU=@lists.linux.dev
X-Gm-Message-State: AFq9FYJZqEFUKC0Vffcne1gMQxBBCKD4cfjy37rdmiiHwYhNCg7Cp9L8
	i2zRFEX7OCh5FGcpcHpxz/Na1HvlDPVWOaxWF37fXrP3IBtuQRI16IXC8bNzqTNFeQzGJVcTNkY
	yMMQjEuYA/2pzftwRdcYGe2axPzvjGTiTt/yWsfU5qD5NAxq/QPpP7Tlrvw==
X-Gm-Gg: AYBFou2+CIYYrMKqE9W6CK9zuIsOUaEqA8BJ3HPNyzJn8ln42Vas+sJ42jeM93463tq
	zguR46DFtvOWVP8C7zQAo0wUT7RXDlD46bAF46Erj0gnBYAzK9elL1nnfY82kxKG5vXNhPL9RRd
	I4du8jg2pHAw2tPsm/d9n06WvmNKfsUU/QvbeqPJbuVnKfjT5L6g7XeajBWVg2Uz2bUBOX6tPkN
	IFFLVcOa7gX81RRMCKY6nBzTQ1W7oIOsIE4ZrIpxh9iOoRIVHQQc4+zMuYwGSsmqHnodO7tx34N
	WdyklWg6kq8iTPoiqaEQ2MZQV7dPNXH1zM64p5MHVDSatzp8xXlBtb9WE8/X8pHVTNPUgA==
X-Received: by 2002:a05:600c:4594:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a18e4d6ac3mr375377985e9.26.1792068111881;
        Thu, 15 Oct 2026 05:41:51 -0700 (PDT)
X-Received: by 2002:a05:600c:4594:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a18e4d6ac3mr375376365e9.26.1792068109456;
        Thu, 15 Oct 2026 05:41:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd640be0sm52746555e9.1.2026.10.15.05.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:48 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev
Subject: [PATCH net-next v2 6/7] net: add ip4_parse()
Message-ID: <2645c102b2f73292d1973b82c95def24e48064e1.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1792067836.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K-nPX8qd3IYY8ddW8ZHlNEh3rZWPkiSOEEJbVt6xoi4_1792068112
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Multiple places in the net stack open-code the same minimal IPv4 header
validation: pull the fixed header, check version 4 and IHL >= 5 (where 5
is the fixed header size in 32-bit units) - and locate the transport
header at IHL * 4 past the network header.

Add a helper for doing that: it returns the validated header and
the transport header offset, or NULL if truncated or malformed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
 include/linux/ip.h                  | 24 ++++++++++++++++++++++++
 include/linux/virtio_net.h          | 28 +---------------------------
 net/bridge/br_netfilter_hooks.c     | 15 +++++----------
 net/ipv4/ip_input.c                 | 13 +++++--------
 net/ipv4/netfilter/nf_reject_ipv4.c | 13 +++++--------
 5 files changed, 40 insertions(+), 53 deletions(-)

diff --git a/include/linux/ip.h b/include/linux/ip.h
index d11c25f5030a..98012f6d0efb 100644
--- a/include/linux/ip.h
+++ b/include/linux/ip.h
@@ -56,4 +56,28 @@ static inline void iph_set_totlen(struct iphdr *iph, unsigned int len)
 {
 	iph->tot_len = len <= IP_MAX_MTU ? htons(len) : 0;
 }
+
+/*
+ * Pull and minimally validate the IPv4 header at @nhoff.
+ * Returns the header and stores the transport header offset in
+ * @thoff, or NULL if truncated or malformed.  Only the fixed header
+ * is guaranteed linear; callers that need the options or the
+ * transport header must pull further.
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
+	return iph;
+}
 #endif	/* _LINUX_IP_H */
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index aa2f8ac4657c..85ec1039f73a 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -53,32 +53,6 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	return 0;
 }
 
-/* TODO: nothing virtio specific here, move to ip.h */
-
-/*
- * Pull and minimally validate the IPv4 header at @nhoff.
- * Returns the header and stores the transport header offset in
- * @thoff, or NULL if truncated or malformed.  Only the fixed header
- * is guaranteed linear; callers that need the options or the
- * transport header must pull further.
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
-	return iph;
-}
 /* Defined in net/core/dev.c, enabled while any network namespace
  * has net.core.virtio_net_hdr_csum_check set to 0.
  */
@@ -126,7 +100,7 @@ virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
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

