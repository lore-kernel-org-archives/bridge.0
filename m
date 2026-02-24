Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3739D30AABE
	for <bridge@lists.linux.dev>; Tue, 24 Feb 2026 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915998; cv=none; b=vE9MgogfhhsYWiz5eYbWzYdFLJoUFKz5P34xBG4qWIvUU0XbcgQMZo3wx8k9OQb+IfcZpX7W2ITVZh+1b77zlGLUfOA27C6GKLE7UNS2I/10QCRDx77Yjy+r89BbjaUBuZERqOFErMYUBQUur/8sPxqCX5JrcYwSTnO2qptvekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915998; c=relaxed/simple;
	bh=s5w90tjQkJYYzbC3vOYs6oXg7h6S7OJfWNsP/+o7GlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETRtPRmGmReMGttojSWqNK7bdWg3aowG2kvBi9vWxDX45v0wptrwOBLiECXEXvHT34njrbaZcz6rL2gnHoFsOqmr/UUvn5eOmbVLm8hA/8YS0CHTtHn3PKWil9NCkOLI1p0e24uzgQw4jjm5Pd0BS4XzmEfhl0yHf98ncG6Q1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMfI0OjH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMfI0OjH"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8f97c626aaso727625166b.2
        for <bridge@lists.linux.dev>; Mon, 23 Feb 2026 22:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771915995; x=1772520795; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWLpgkJWRF7bEw/Zu91fLz8PWNtrMB/wH+bAcmEPFvw=;
        b=kMfI0OjHxRHp7tNvbYYwcD8EDGkRH3uxw8G1OM8rEYPamABuQX70e/VHjAsA+V9sZ8
         pNJqH/SwIhbZuQOFSNZlYTaqf2ayiT61n7wcU3ia/WDtG7W8237IBCtQDAIa/JqPSapY
         JwEzr4HRGs5tRLrJ6aYemMHALtStxgXKYZBYg4fAFKVKskKlBDvEa+/c9vq5PnDx1WeH
         EjwIT1hXJIdeDkHh8yXjPlCnoH2f3w3OwAguu/3jOxE5Hv+q9lBj64d8W0AM9Y1YNl3L
         ReZR9ZKRWcs/1A9OTuDUUCXNQA8IJlXcO5/J1SnpCBrfgGilTpMGF6rwMlCf7MLGtCj2
         nOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771915995; x=1772520795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWLpgkJWRF7bEw/Zu91fLz8PWNtrMB/wH+bAcmEPFvw=;
        b=kbesN8TBv7KJhTslczWifwzuSFQ60IQKgtsCqiun48ho1IYoFaQGuajS5cF4tDlFpA
         QNDwU/V3iHHUbuXZnyHnhjq4Acw+vIrZa/5VtS2Lj4/ZIb+N4rUMiASvkiH+61IPhdNM
         s9MmxaOj8lAU8KKcRZvtdaopwau2amzIIF/z3NfMiaTk0Qvqzz+NQEKfu2dodmhyfth6
         61VY1L94jX7pljUwfHIrT+iEJFRAAkkDS0v4CodrvneKt8XYKVCoEtvyalEbZqw0j60E
         aL/KxTLEuFssDp6w+RQdrjKssw4ZM2RSfftYDo9FqBCKdlWobDFNbqZ+qwVRdmwQXlK6
         tT0w==
X-Forwarded-Encrypted: i=1; AJvYcCUTaMMqGrUXFjCOgd0zzKSrm/FR/GD1M8AzTPZkzntIYafHQrIv0SlBciMhVqARarpfk4RV/5U=@lists.linux.dev
X-Gm-Message-State: AOJu0YwzdLmD0aLCysUNXEFdM219VQz5OG6IYQwX3Hmykx822DGeb2eI
	jDadt0wtI1DTuFg4J/nmeGC1yX/BBaMntmIKMS2CSRihpV043bE4TIGK
X-Gm-Gg: AZuq6aI2wUTnfFbQiE/m7bMMCXt3s5lfP7P2Ex0g1KBFlgpUzNSHIXjCqVixgUotASm
	x/HSGRc2Y3LlxB25Z52PHcvh0tzE1IOvJHiBqTLdA9IDW3BxonZcDbvaVjKDmes96yeqcEjsfqq
	0UNFkDfIFqmgFNqoZ36KSiJrC53yx5E93cE5qCfChegHfRKK2anumBhV+2xaBj+aQWxgogRBnrS
	veMa8DBqpMwTPCp2qv39ROND5aM1CJ7nicNzatGVSoowU0FVwfauThvdIIaMkZkYjkFLzk8ooBj
	6dnnqAfJExrn0ivTyGP5Z3AVGFjvPOYSWKqqGaNPtzLRZVPH2s4cgzWaz9MOCAv1wM4QzbYB9LR
	2Ovl6i2lI3WiqmAoLPwHV42iIrCKjCuiedDxqNwCIgFQBIvj+YoF2qc7zG+WBVQZXJ0Kxr3bDFT
	gXoHRwJiL7mlcmIOe9xB3psEb1h1WnQPQYUwLLLtQCesyQC5gYCRu3+vIuSxYPCm8ShTQREF/o5
	j0Hx7XYtQzuC7t9QQ11fGe59uqPL4N2jvCHELSsPK8nzE9xQtLAyS0=
X-Received: by 2002:a17:906:4455:b0:b8f:8ff5:45d with SMTP id a640c23a62f3a-b9081c19dd5mr506369666b.53.1771915994218;
        Mon, 23 Feb 2026 22:53:14 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eaba13866sm3096698a12.18.2026.02.23.22.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:53:13 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v19 nf-next 1/5] net: pppoe: avoid zero-length arrays in struct pppoe_hdr
Date: Tue, 24 Feb 2026 07:53:02 +0100
Message-ID: <20260224065307.120768-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224065307.120768-1-ericwouds@gmail.com>
References: <20260224065307.120768-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub Kicinski suggested following patch:

W=1 C=1 GCC build gives us:

net/bridge/netfilter/nf_conntrack_bridge.c: note: in included file (through
../include/linux/if_pppox.h, ../include/uapi/linux/netfilter_bridge.h,
../include/linux/netfilter_bridge.h): include/uapi/linux/if_pppox.h:
153:29: warning: array of flexible structures

It doesn't like that hdr has a zero-length array which overlaps proto.
The kernel code doesn't currently need those arrays.

PPPoE connection is functional after applying this patch.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/ppp/pppoe.c       | 2 +-
 include/uapi/linux/if_pppox.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 4275b393a454..7900cc3212a5 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -885,7 +885,7 @@ static int pppoe_sendmsg(struct socket *sock, struct msghdr *m,
 	skb->protocol = cpu_to_be16(ETH_P_PPP_SES);
 
 	ph = skb_put(skb, total_len + sizeof(struct pppoe_hdr));
-	start = (char *)&ph->tag[0];
+	start = (char *)ph + sizeof(*ph);
 
 	error = memcpy_from_msg(start, m, total_len);
 	if (error < 0) {
diff --git a/include/uapi/linux/if_pppox.h b/include/uapi/linux/if_pppox.h
index 9abd80dcc46f..29b804aa7474 100644
--- a/include/uapi/linux/if_pppox.h
+++ b/include/uapi/linux/if_pppox.h
@@ -122,7 +122,9 @@ struct sockaddr_pppol2tpv3in6 {
 struct pppoe_tag {
 	__be16 tag_type;
 	__be16 tag_len;
+#ifndef __KERNEL__
 	char tag_data[];
+#endif
 } __attribute__ ((packed));
 
 /* Tag identifiers */
@@ -150,7 +152,9 @@ struct pppoe_hdr {
 	__u8 code;
 	__be16 sid;
 	__be16 length;
+#ifndef __KERNEL__
 	struct pppoe_tag tag[];
+#endif
 } __packed;
 
 /* Length of entire PPPoE + PPP header */
-- 
2.53.0

