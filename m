Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB107395AED
	for <bridge@lists.linux.dev>; Tue,  7 Jul 2026 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415484; cv=none; b=rc0NnfTer5glmPn6gho/qu4mviyjNGbP8AOns2mrLT3dOIRgv5qO28YiUJ4sDgqmjWDC0XDKFZhmNmaLr5YrAGpIUfOuIhqpIIQLVz3GLur2mvl5EEYym6sDBKS6in9WyR8wCxQ69+qIGz+7sEyEmfmDlOpD9YnJF1Vpp7nbteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415484; c=relaxed/simple;
	bh=YBNEZ0JuBYpp39J19uIA6JD+g8DwilN2ygweuBY+Wvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oug2JtS+z+xDiZlgSJcXCyMBbpXy9qr1n76Rim0Dt2IgoME+tvjogOwvT1w03/KuvqXQBlhdFXGEqX0u0NgPHo9gBHkuhv85FnTvlO39Rjkuvu0Nas/he43PgDZ40/dAHWChBuxcajB5ut0VdukkkNgA3epuw7Ma2y3zbLf5VuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpBO3LEc; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpBO3LEc"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba3e6so6812438a12.1
        for <bridge@lists.linux.dev>; Tue, 07 Jul 2026 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415481; x=1784020281; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ab4D2p/3Z+QNLOMIvIrg+NC0XFgS2lOf5VtGliLMbQ=;
        b=TpBO3LEcB2Ml5p/z/jVOSdH50f7Y16FriLN8SZDyfYvcqlH/jdN0Evg/cQ98bnRKmj
         2kAz+sRwpgBkvnenHCp6Q/FUhAnI4/Av+lI/+wGfVSBFXIfwLehzsaKJE0dkLzNRlw/w
         0gw30cBp/9Iej5Ezjx+04z6ncc2LwXdiiTiC75qFBT7b8uSNoBFx4bsPh54roUZ56GLU
         bp+8WzeJtUmVfIf5lbtloF4dhnGdW3tpuZ0CzPQKVYW50Bzx2vsG0U0ViWmJ6CBRoY8f
         wKjrmZ9ONZFZvg/mMEYBI5eh8Mc9bXWRJz9cg2X7nRPH4j3Z+X6oAdppg7SxiKIOe7E9
         Uhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415481; x=1784020281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ab4D2p/3Z+QNLOMIvIrg+NC0XFgS2lOf5VtGliLMbQ=;
        b=le638UKlvNp0sErt9TGidDhuiUuoRzrn2ODhKiFG0sgVogUO4ccQYqWzR+qKhp5g41
         QbG52vCNSDHEJuLw3N5f9bvcgkICk/8/7Nozo/Z1HpLVDj5yZD3gNN/bwmNF2fpcigct
         tR3C7Sj9X4JoHXToNAhtnj6Eoelk/FImb+B9v+/s3gMm3tIIjS/25Qtg0VQU4/UzfYwc
         8z6PeU8yrHicaFcjYuaHYlrjBtcZV66yg1o3bf7fWg7I0mQ11xAr1F5rWMuEJ/eRAtpL
         PMfxiiVbbzffFgloBkdhu53Hj27Q6eJDvlReQvL8tgJuFH704jcZLaIoKojK23fJavn0
         1jxQ==
X-Forwarded-Encrypted: i=1; AHgh+RqBRuYi9hCGABh9Xdb+MlA/wqEOzSgwalq8bbnTWxdD+kiOOUnNC+sV3PPUthJSep672IwirCQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw81cCnqrVE3RB3aOxxpSx7sEZS1K0RaMn2jD44Fh32I+zn7+rk
	3sb4t1RsTenoj96N+xeFjG7SKVVcDH+2qjKVm4CEXKyQz9zxMquPvyHu
X-Gm-Gg: AfdE7clOxmDaX0vgMsu5+LKgDv1mZMWI91hpN0wNlUrwAvZ8aP5X4JmFfp9nRR3uZvf
	NtfNGUHG7r6z6s2iWMTQvU5xx0qO+l0VrUjEGFuMcu7nnb+Dv+98WwhcAicUi/QNsWPV9ahOTwp
	SPfGoMcJ965u/8+2UMPVH6xhTnEn3WJfIykjzfQmQhUe+K3nA0hb7RimaJo4kQIS59vH1SzbFZh
	ZlMUlpr3eYg/5OcX57Jae1q9l1bjK5qh55U57qUkORo95Jbamyx4sN4ch0qURI51aECOxagRemi
	MA3wHnJfOqUkjQy5x1luDpiF40vQF5JvariqGPAerOL2Kk4DTRtfghsijnzgs4lFhkaJ2a5GSNi
	7Fb3KFsBctIX3hAHVhXtHHrLyRtG6xjun5Qi9UH0CEERuL4Hi0tIPhFS4JZgnJs/Tnr3IcRZagL
	/9G3pqnoD+NFc/6mmchVdWy2aBpqASqeYByrfn9tRyDhFzYR18ioRRKH1iHJP276oV5nMQYXDt3
	jVaIz4ooq1SCibr7lfASgCUldkBxT0aduWtHPzzgO9M
X-Received: by 2002:a05:6402:1d55:b0:698:e595:a5c with SMTP id 4fb4d7f45d1cf-69a85651f63mr2079368a12.6.1783415481357;
        Tue, 07 Jul 2026 02:11:21 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd87d6sm5297152a12.6.2026.07.07.02.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:11:20 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v12 nf-next 5/7] netfilter: nft_flow_offload: nft_flow_offload_eval: check thoff==0
Date: Tue,  7 Jul 2026 11:10:43 +0200
Message-ID: <20260707091045.967678-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707091045.967678-1-ericwouds@gmail.com>
References: <20260707091045.967678-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of flow through bridge, when evaluating traffic with double vlan,
pppoe and pppoe-in-q. In this case thoff will be valid only when meta has
been processed. If meta was not processed in nftables, thoff is zero.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index f8c7f9f631e48..4f68fb64f1657 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -59,7 +59,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 	struct flow_offload *flow;
 	enum ip_conntrack_dir dir;
 	struct nf_conn *ct;
-	int ret;
+	int ret, thoff;
 
 	if (nft_flow_offload_skip(pkt->skb, nft_pf(pkt)))
 		goto out;
@@ -70,8 +70,11 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 
 	switch (ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.protonum) {
 	case IPPROTO_TCP:
-		tcph = skb_header_pointer(pkt->skb, nft_thoff(pkt),
-					  sizeof(_tcph), &_tcph);
+		thoff = nft_thoff(pkt);
+		if (thoff == 0)
+			goto out;
+		tcph = skb_header_pointer(pkt->skb, thoff, sizeof(_tcph),
+					  &_tcph);
 		if (unlikely(!tcph || tcph->fin || tcph->rst ||
 			     !nf_conntrack_tcp_established(ct)))
 			goto out;
-- 
2.53.0

