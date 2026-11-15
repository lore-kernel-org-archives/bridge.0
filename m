Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704169;
	b=17UgSxtKTrYNUExprIiYvB6z9yij/Xea/KpzR/1gN2WGTBIfwOVoHZR5R1Tr2YP8rj0E
	 MP1FYPhSU+upxRGbjJ6Xj/6/ZGN70ZhJ6JQzIRLiMVRG/cxSQEkyf1P82ZYGOW56YuDN5
	 G+2VgDz6xw4UYAXrf2QNVA05ACC9dmZSmDg0jMItthXs12O9F1pvUeh92Ck3pu7L0XhZp
	 HdynCbCNv4ym2LgfVtYZfMzz/+wFGUboq86ANwwEAXgC0C3zu0jUCwqmfGBUKAoq9ZBnN
	 LaU+Xnm/j74q8JSZIPDhawd78ONAUN3sJVG3srnZ6QjOKv7eQ6hauLOLI6bEslM9bEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EXiLXVBflQGlm4cX13sHzQkGhpIOp9cmpNR58hxiL1A=;
	b=mS0aUQvnPT4zcIIBC5XsIkJFJA/6dA7nMOEWsrInRZhwDTuHtkOdB/MJgH7Dwcm/tBRw
	 /3B5tHNIqTT1JrZzxydHnjcXzAu1XAHQ4BnvkMJAikSG82uKKJet8hiEhI5qCx3A3wo8s
	 pFElLUJeRCh1OVg/V+AwjVLeXD67Cf2tlM8g13nnaNRSrF1XtlAf4zWmtHoYRGWcIZffL
	 bn1dZijw1PJWnZGymEDpMYDgyw6v5uHz+QUPNGDfco9HG22CzsW+JNquto8WadN1uteIN
	 vVdyEUA6uYnZxhTcgn6429EB6D2FgyWTeExYw17yqj64rmZ5Xk4IpKmM/nhkugEkcuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b="PMoS/JTx";
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40AB606A330
	for <bridge@lists.linux.dev>; Sun, 15 Nov 2026 00:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E40AB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=PMoS/JTx
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c50a4a2132cso283844966b.3
        for <bridge@lists.linux.dev>; Sat, 14 Nov 2026 16:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794704167; x=1795308967; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EXiLXVBflQGlm4cX13sHzQkGhpIOp9cmpNR58hxiL1A=;
        b=PMoS/JTxg/+0ZMX60+H0DzKU5R6QWtDYxA8ae3FTNcKa0iA/YnskdFu8LIC+ILPqlr
         FoE3DU+HV08p3q6Guzt9JnXqxeDus4nYj98XUuUBkmOT6vKVoRr/uvhE6PwSA5OOxQcQ
         CjXiEX8pwzcbU1jMRwKhDc6HWZvCGva1TuOySSKqxdQAm/TX5BLz691ViGDV/KQILGSF
         PaHn4MUDGC27SRXDMCE5raeveOUcZ4QQqgzw0MxwbIoNk6pOee/GPqyjHDMMeoEvmTaG
         /alBYJqiWK/PXcVnVjRMFJGb+qcQxAsdHmkiXUgJ3EySF8e7FWoTb7UMueuOmnkCge3y
         ECSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794704167; x=1795308967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EXiLXVBflQGlm4cX13sHzQkGhpIOp9cmpNR58hxiL1A=;
        b=j3EaHTeWLk0RkaiAOi0HPu5RUK0k6jiNJkfTiSNY00OIIG88BSwnfEAPktoxbLJasj
         xqRzFpB4J1YkM9PsxSIEwfsSVP+fCb/YBmKxxWxScFXtTyrpNPiBpSj8rdxlga+9bzTO
         qrVN/zXkDQpgjJRcIxm1sA+4wb8+GnWg9drVXfbc+zdH+b7At2N0jukqfiaA2o/vHv6g
         LBPrpWZZuSkBUCn/PYbpe9o5gFEn5HWMW1iMS+4WmsuxQ5XlcGIWI0+CDBhwwvWNne7z
         dhWiojiebiCiXzmX47gWfS5/Pm854bBUg9Z0li7Vgv9fWLeuCEHN8ChyjviQJy65NJ8p
         8ViQ==
X-Forwarded-Encrypted: i=1; AL+hErEvMNp2HkwavqBkB2yUBxKBtUlmbLgLoMg6i9+f8LO2IEoxtfl5+AtZjTAwWu9E6Rex0JQoj2Y=@lists.linux.dev
X-Gm-Message-State: APuU4Z8gDwHg7c3XovdcTsGZSRYRjOumCBzsj8UhnozBpCMyi7nxyGK1
	j0nm8+ZdIWrIqVz8VZjQznBb9YdwZnOQnI965jeUPVSFVScOgtwlorWrij6ttCb8Eg==
X-Gm-Gg: AYBFou2Qzzb1SHxRuwNGzNJXRs90/pAqM8OZeQ6Ir63v38QTMxhKL7dKgnfc3e/Bifv
	WTYbeKcYIJA1JiYWW1WlukqUs2FwOlnY8sWMEDZLfOVGA1zj/UuEMMjI8Q7hTx3utG3FV2onzTC
	QollF4Ku2YtIuoJXDdK7w2SQvw2U2mHLHlN9VMwdMUo7Fa9OVu0xwBn2Mk+VNwjuGpYMC+cNXYx
	XnhbqcCTnvFLHNY+2wQO0wig9dHSqWEXxrj24h9RIET0SBM0DUTRl1wI2lMJeKvRoG+uYC+Fcf0
	dbxQV21TQEzbLBcSUYloMaNi4sD2TrrakzMH2bptrGoUFk3sIF4oTizju8Gyuy3hvSNWHnzdHF0
	g7nyNQrVYHNaujdNQVxjPJ/O4plKjd0Y5rPxNTccpDiPX9vmaSH+GcR27dH3j6WVhY8P7oVyTOj
	DqUg9/hZTdAs3aevyh0Eyu8X8zImNg4xZ0o8Z5CtSmjb2Ye52b/liw6jDjM9wNKtrCD1xuN5ive
	kAKvPsOhpLzW6XiI8jKcowAWMw8dCN36rb5sxjTE6Ck6k7/auaKs0hAUHeC4RZRf4zp+NApL/GF
	Fuck+/DA2KIlZVfqD0WP3NLqbjUAkNMry4vCm8AP7RNv97Vi75uZcQVVkYIlMLk3w1mpZEBeSOV
	xqtkCe/RiBAQSJJC533dcA0FqHQlxdxvjQO7ZRmNBES9Nb5TUzCMFUNRgytKpo2AmFqbV9cDq/p
	4RVUiXoPjNTlRL1Vi017rD236o/e8rfrAUCmFNvVxxDwjtA/gDju5JQGN20T/mnNWoY4pDJwpr2
	tEgATRN2+RZtx8UVSVBR/x0gadmvLjp2/sjuFL+PoxiNVeLdAhyac82OSZK1iihsu3C4P7rxvf8
	umrHUsewSUeHpMLdXDGBOBW0kd3Az/CGwzsaAvW1n0Gkcq5LJRQ=
X-Received: by 2002:a17:907:6d02:b0:c46:9ca9:f524 with SMTP id a640c23a62f3a-c50963b6917mr545268566b.32.1794704167251;
        Sat, 14 Nov 2026 16:56:07 -0800 (PST)
Received: from Desktop (p200300f2470a670069e45948b1a17361.dip0.t-ipconnect.de. [2003:f2:470a:6700:69e4:5948:b1a1:7361])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b921d4sm266313166b.83.2026.11.14.16.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:56:06 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH nf-next v10 1/3] net: bridge: fill a forward path only to a port that forwards
Date: Sun, 15 Nov 2026 01:55:53 +0100
Message-ID: <20261115005555.645727-2-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115005555.645727-1-julius@bairaktaris.de>
References: <20261115005555.645727-1-julius@bairaktaris.de>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_fill_forward_path() resolves the destination port from the fdb and
checks only that the vlan exists on it. A port in STP blocking, learning
or disabled state, or an MST vlan that is not forwarding on it, still
gets a path, so the flowtable transmits straight to a port the bridge
itself does not deliver to (should_deliver()).

Add br_port_forwards(), the port and vlan part of should_deliver(), and
fill a path only to a port it accepts.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
v10: new; v9 transmitted to a disabled port and in a vlan removed from
the port, which the gc then left in place

 net/bridge/br_device.c  |  2 +-
 net/bridge/br_forward.c | 19 +++++++++++++++++++
 net/bridge/br_private.h |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 0a1ce9e59a4d4..f5860e88dbe95 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -402,7 +402,7 @@ static int br_fill_forward_path(struct net_device_path_ctx *ctx,
 		return -1;
 
 	dst = br_fdb_dst_port(f);
-	if (!dst)
+	if (!dst || !br_port_forwards(dst, path->bridge.vlan_id))
 		return -1;
 
 	if (br_vlan_fill_forward_path_mode(br, dst, path))
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 54365c6104b5c..9dbe9c9495582 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -31,6 +31,25 @@ static bool should_deliver_vlan(const struct br_fwd_dst *fwd,
 	return br_allowed_egress(nbp_vlan_group_rcu(fwd->port), skb);
 }
 
+/* Called under RCU. Whether @p forwards a frame in @vid, 0 without vlan
+ * filtering, as should_deliver() decides for a frame filtered at input.
+ */
+bool br_port_forwards(const struct net_bridge_port *p, u16 vid)
+{
+	struct net_bridge_vlan *v;
+
+	if (!br_mst_is_enabled(p) && p->state != BR_STATE_FORWARDING)
+		return false;
+
+	if (!br_opt_get(p->br, BROPT_VLAN_ENABLED))
+		return !vid;
+
+	v = br_vlan_find(nbp_vlan_group_rcu(p), vid);
+
+	return v && br_vlan_should_use(v) &&
+	       br_vlan_state_allowed(br_vlan_get_state(v), false);
+}
+
 /* Don't forward packets to originating port or forwarding disabled */
 static __always_inline bool should_deliver(const struct br_fwd_dst *fwd,
 					   const struct sk_buff *skb)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 014d0b8db8c73..2c73d2549eaec 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1048,6 +1048,7 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
 void br_forward(struct net_bridge_dst dst, struct sk_buff *skb,
 		bool local_rcv, bool local_orig);
 int br_forward_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
+bool br_port_forwards(const struct net_bridge_port *p, u16 vid);
 void br_flood(struct net_bridge *br, struct net_bridge_vlan *v,
 	      struct sk_buff *skb, enum br_pkt_type pkt_type,
 	      bool local_rcv, bool local_orig);
-- 
2.53.0

