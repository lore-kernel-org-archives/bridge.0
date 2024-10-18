Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33DF1F5EA
	for <bridge@lists.linux.dev>; Fri, 18 Oct 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729257481; cv=none; b=PNGoUZZGQnDqvESGk2rg2wHE/M8XtQ8IYIt1jqz6A/HyFIBUU23eNU3Ofr17+0gpK97fozJghU+P31rCy0Rb9H/u0f0STl/8r5Qz+BpTQBYbjJPcAPrDugJ/ChfnyI3iNyCqT4ASLxFKbv/0INTxMK1rr0F9P2pTACfA+fSylY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729257481; c=relaxed/simple;
	bh=HPXtxo5Vvpr2Etua6TwUK33NA6Be2AnfOMNRunrFSgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFuXnnF/OZes5n9X2ZBP0K/9gW7v7nlkxEiuXh2mfNqL/TdrtBnaVJb8SkmjFwOlBsM+rzv2dZwiZZKV2qjVF/XiqIUhrNCaAz5Bxv6URx+WvIn/n5gZ3TuyzheCNu+ltNI6p1xcMzYpY/+Jt4eEM4vaN15MRtzaDuSudqGHSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko3xVWhZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko3xVWhZ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315dfa3e0bso2081335e9.0
        for <bridge@lists.linux.dev>; Fri, 18 Oct 2024 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729257478; x=1729862278; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYTC1KKmj1Tx4GZAlIt/vCaAXRaBVXXUSQJlK1KgVeE=;
        b=ko3xVWhZLkBJTEvP/zbqbPG+m/JK6gHZ2CtFKI/NAakEWYrle+5M/YhFLDKCIlSxvp
         7LZp5oJbqPUsvD87uMvlc++jDXQKzSFoH44D5B1qzHE0vXAZJL88LA63Tr7boJZHvKK5
         psRm8KWSsB+W/A3RaNzo1P3gEz6xbVDEbihh5W9yVOjHXY/eYre+4o91x9iSG6uX78e0
         jazQlQXH0xjRQYjZ7X2mcpAOQ52WqUuV63D7cUU2V7i6HlY0I1PDNaoEwFEpsM0FzJFj
         p6h/b3y+3khazBMQM2a8UYKH9NNE3UCtEnrIDWTYzZ01PG3C1Uo7OAgWGZ+Mp9B3khm1
         mfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729257478; x=1729862278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYTC1KKmj1Tx4GZAlIt/vCaAXRaBVXXUSQJlK1KgVeE=;
        b=OpU9RwbK4kDOZ8bvuYPFucf2aX9Fc6JSQquYbXDe4B0Sf/TyRdqQTsDutBhYugYOB1
         MKC4kIOFcS6Gh/vWRIwa6yXwxpyDN7wfGRRJ+gwiVAb59bqr667xde1rVcLWe7M+bVRm
         KX83zsHwtlrajdHqmzSyVgEuvGjJ93LhzXiI5U99/SH9IX3A3ZZKAwvdrpDMx8BzgL47
         n6uZ5Tb5+IOQwVL21nyrRtBtYqMhrYlDPZnjFfGY4aY7sy8XA1u3IrKWxEidOFPWemS0
         R9UcrrgkUA2dicuyjdpOPq+FIlKaKTMkwnNu3uaGvmM4ajEZ/8LOj1M8ZG3PZJ8iNUj4
         LQ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbtYo3750M2TerZJfEQgrT6NRZYGNeEcj0kmWdGKCgmc/F7mpN04WoItsMhLZ2G7a2rAdSink=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4GwxlInUwOYxkkQKtCjt6E3S3h5KdHlN3S0paafw+CRSXoJRl
	jtDi1bt50TrBRhS84OcR0izx2bKcKZlBBPnJi8Lv0BN3uCLvknOw
X-Google-Smtp-Source: AGHT+IEq019Hq1TIXR/qIFJskJJDma7tgLtYd48CED4u+gZEDmakAyaK8oGFTjQd2kcXyOKjRJnT+g==
X-Received: by 2002:a05:600c:1c08:b0:42c:aeee:e603 with SMTP id 5b1f17b1804b1-4316168f7f2mr8301575e9.7.1729257477692;
        Fri, 18 Oct 2024 06:17:57 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160695d8fsm27244935e9.27.2024.10.18.06.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:17:57 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:17:54 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC v1 net-next 02/12] netfilter: bridge: Add conntrack
 double vlan and pppoe
Message-ID: <20241018131754.ikrrnsspjsu5ppfz@skbuf>
References: <20241013185509.4430-1-ericwouds@gmail.com>
 <20241013185509.4430-3-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013185509.4430-3-ericwouds@gmail.com>

On Sun, Oct 13, 2024 at 08:54:58PM +0200, Eric Woudstra wrote:
> This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
> packets that are passing a bridge.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---

Whatever you choose to do forward with these patches, please squash this
build fix here (you can drop my authorship info and commit message):

From e73315196c3143de2af2fe39e3b0e95391849d6c Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 18 Oct 2024 13:59:27 +0300
Subject: [PATCH] netfilter: bridge: fix build failures in nf_ct_bridge_pre()

clang-16 fails to build, stating:

net/bridge/netfilter/nf_conntrack_bridge.c:257:3: error: expected expression
                struct ppp_hdr {
                ^
net/bridge/netfilter/nf_conntrack_bridge.c:262:20: error: use of undeclared identifier 'ph'
                data_len = ntohs(ph->hdr.length) - 2;
                                 ^
net/bridge/netfilter/nf_conntrack_bridge.c:262:20: error: use of undeclared identifier 'ph'
net/bridge/netfilter/nf_conntrack_bridge.c:262:20: error: use of undeclared identifier 'ph'
net/bridge/netfilter/nf_conntrack_bridge.c:262:20: error: use of undeclared identifier 'ph'
net/bridge/netfilter/nf_conntrack_bridge.c:265:11: error: use of undeclared identifier 'ph'
                switch (ph->proto) {
                        ^

net/bridge/netfilter/nf_conntrack_bridge.c:278:3: error: expected expression
                struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data);
                ^
net/bridge/netfilter/nf_conntrack_bridge.c:283:17: error: use of undeclared identifier 'vhdr'
                inner_proto = vhdr->h_vlan_encapsulated_proto;
                              ^

One cannot have variable declarations placed this way in a switch/case
statement, a new scope must be opened.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index fb2f79396aa0..31e2bcd71735 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -253,7 +253,7 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 		return NF_ACCEPT;
 
 	switch (skb->protocol) {
-	case htons(ETH_P_PPP_SES):
+	case htons(ETH_P_PPP_SES): {
 		struct ppp_hdr {
 			struct pppoe_hdr hdr;
 			__be16 proto;
@@ -273,7 +273,8 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 			return NF_ACCEPT;
 		}
 		break;
-	case htons(ETH_P_8021Q):
+	}
+	case htons(ETH_P_8021Q): {
 		struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data);
 
 		data_len = 0xffffffff;
@@ -281,6 +282,7 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 		outer_proto = skb->protocol;
 		inner_proto = vhdr->h_vlan_encapsulated_proto;
 		break;
+	}
 	default:
 		data_len = 0xffffffff;
 		break;
-- 
2.43.0

