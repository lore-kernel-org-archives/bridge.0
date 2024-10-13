Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194D148FF5
	for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728845751; cv=none; b=vEiAtsRAYcYxu+1+A/6w0QOi5zsR0M6IOJE2dcG0+bTPp+bw2cPtELqLrqVLCadjAQVNwpN4lBGAmiFaQ1g/SGpcyoGA2Te6P1hJoyRY5FcBJDKRU3eeUt10cQpMauyo3VsyobdON98bwbxivCQXFagf1P7djj0c0N4ib4JbS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728845751; c=relaxed/simple;
	bh=n5GlTdCtKOmtjAaFIunijEhjxn6K4vforcxuYnG9cJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqqO7uSrgFHIHUtD0MKTgQHwKyLt7UQWJ4nqbjUvE4U3HUGpSRHSeqE2+4Dxgb6GgBNh49ztatXo49zV+/VLfQwfkqiyDUTGbDZVC9Ea22rEiETAgk1tnXaxlskPVyoJIxkFTaQV5yMS+rRH808hw1GWgxcyZJeRYplKd1RrHv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyTfdkYp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyTfdkYp"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86e9db75b9so540020466b.1
        for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 11:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728845748; x=1729450548; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXqA2N6PSdeku8lbnGk/r0H6SHXM5r8C6mfKewggPXk=;
        b=RyTfdkYp83eNkV8eqQ783aT2gDOd7SYgpRp25o1Y50Ev9vQRlLjoWR4ZaaZHCYTjTT
         CzgYsR9udOyBNZ+Lg8CtLf0OnSTco2Wqqsi9s9H5FuiDEKfYnmRquwe1XPigWY1/zLJB
         U9TAP9DGFPH04VXa05McFnWgLmpJLnNQ3jcaxHxQrON6WCrejGy2Pwhp3S0SAdv0DbBi
         6RRAjJsKFhNrWdKkRreWG1hWvOTSfWEeC/x5uNUmYN+XhKLur/wforFQserP0FZMglWH
         GjOjHX7qAFYj/nUrqgJWZBQvY3e0d5dpxyAsR3o48CsEYxbpt9Sbpn2qJ+saNL4/HPcz
         m84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728845748; x=1729450548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXqA2N6PSdeku8lbnGk/r0H6SHXM5r8C6mfKewggPXk=;
        b=vq9fVW3rDaw+QYwGMk7jWw5sSXhiNSCHPPZ8iIeaAZGJ3P/96Zo+REsL+E3T4Dj9fX
         MF+AgkvoGY2/0EweusRjawkUK2r6bkK8BsKaIbWVo5r3ei0u64VDbEF2FUXqt4ESIUAX
         UW0jB6sY7oZLpL9Hlb3a4zWlX+0WxK9vv6bTLf8QFUKE6lbnMldRAe/Qb5hHpb8Q2FEw
         6fA/jGsPgwsP3n/mijWPeJ1E58Q8p+U8LyRvM6/XumTTLxu6W6LV+xL3Bh4heUV65VNM
         OWUe+bMe1JYeNm5QULjNyQ1QRx93t0ZppqJ39MaL94tvpMh/R+Q129RvbW/QScheWfNg
         /NmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzDDC9V0tUulRlaazAnNSpETao5d3vGbdgbTcibOT43PsH6/ijatvjk9KhmyG31SXP2oVas+I=@lists.linux.dev
X-Gm-Message-State: AOJu0YyRzFxt9j/BYDSgS5zDGotcvEr7U5yI240bNJWivAM43MTMWQvE
	7s1EwIC5YgQMMWyYVsL0yKzrWsz/WAwvY1E/CSUdbFPkWwKEQWgo
X-Google-Smtp-Source: AGHT+IGDRNNl2WNHKk/RQYIt3X3ZUbDBl2cG/u3cyrPOyqik2hRlsXTDnJIYfMk+W8sAqccVFejf5w==
X-Received: by 2002:a17:906:6a0f:b0:a9a:196:fc29 with SMTP id a640c23a62f3a-a9a0196fee5mr289924666b.61.1728845748194;
        Sun, 13 Oct 2024 11:55:48 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a12d384b9sm13500866b.172.2024.10.13.11.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:55:47 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RFC v1 net-next 12/12] netfilter: nft_flow_offload: Add bridgeflow to nft_flow_offload_eval()
Date: Sun, 13 Oct 2024 20:55:08 +0200
Message-ID: <20241013185509.4430-13-ericwouds@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013185509.4430-1-ericwouds@gmail.com>
References: <20241013185509.4430-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Edit nft_flow_offload_eval() to make it possible to handle a flowtable of
the nft bridge family.

Use nft_flow_offload_bridge_init() to fill the flow tuples. It uses
nft_dev_fill_bridge_path() in each direction.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 142 +++++++++++++++++++++++++++++--
 1 file changed, 137 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 2923286d475e..bd4850691baa 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -184,6 +184,129 @@ static bool nft_flowtable_find_dev(const struct net_device *dev,
 	return found;
 }
 
+static int nft_dev_fill_bridge_path(struct flow_offload *flow,
+				    struct nft_flowtable *ft,
+				    const struct nft_pktinfo *pkt,
+				    enum ip_conntrack_dir dir,
+				    const struct net_device *src_dev,
+				    const struct net_device *dst_dev,
+				    unsigned char *src_ha,
+				    unsigned char *dst_ha)
+{
+	struct flow_offload_tuple_rhash *th = flow->tuplehash;
+	struct net_device_path_stack stack;
+	struct net_device_path_ctx ctx = {};
+	struct nft_forward_info info = {};
+	int i, j = 0;
+
+	for (i = th[dir].tuple.encap_num - 1; i >= 0 ; i--) {
+		if (info.num_encaps >= NF_FLOW_TABLE_ENCAP_MAX)
+			return -1;
+		info.encap[info.num_encaps].id = th[dir].tuple.encap[i].id;
+		info.encap[info.num_encaps].proto = th[dir].tuple.encap[i].proto;
+		info.num_encaps++;
+
+		if (th[dir].tuple.encap[i].proto == htons(ETH_P_PPP_SES))
+			continue;
+
+		if (ctx.num_vlans >= NET_DEVICE_PATH_VLAN_MAX)
+			return -1;
+		ctx.vlan[ctx.num_vlans].id = th[dir].tuple.encap[i].id;
+		ctx.vlan[ctx.num_vlans].proto = th[dir].tuple.encap[i].proto;
+		ctx.num_vlans++;
+	}
+	ctx.dev = src_dev;
+	ether_addr_copy(ctx.daddr, dst_ha);
+
+	if (dev_fill_bridge_path(&ctx, &stack) < 0)
+		return -1;
+
+	nft_dev_path_info(&stack, &info, dst_ha, &ft->data);
+
+	if (!info.indev || info.indev != dst_dev)
+		return -1;
+
+	th[!dir].tuple.iifidx = info.indev->ifindex;
+	for (i = info.num_encaps - 1; i >= 0; i--) {
+		th[!dir].tuple.encap[j].id = info.encap[i].id;
+		th[!dir].tuple.encap[j].proto = info.encap[i].proto;
+		if (info.ingress_vlans & BIT(i))
+			th[!dir].tuple.in_vlan_ingress |= BIT(j);
+		j++;
+	}
+	th[!dir].tuple.encap_num = info.num_encaps;
+
+	th[dir].tuple.mtu = dst_dev->mtu;
+	ether_addr_copy(th[dir].tuple.out.h_source, src_ha);
+	ether_addr_copy(th[dir].tuple.out.h_dest, dst_ha);
+	th[dir].tuple.out.ifidx = info.outdev->ifindex;
+	th[dir].tuple.out.hw_ifidx = info.hw_outdev->ifindex;
+	th[dir].tuple.xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
+
+	return 0;
+}
+
+static int nft_flow_offload_bridge_init(struct flow_offload *flow,
+					const struct nft_pktinfo *pkt,
+					enum ip_conntrack_dir dir,
+					struct nft_flowtable *ft)
+{
+	struct ethhdr *eth = eth_hdr(pkt->skb);
+	struct flow_offload_tuple *tuple;
+	const struct net_device *out_dev;
+	const struct net_device *in_dev;
+	int err, i = 0;
+
+	in_dev = nft_in(pkt);
+	if (!in_dev || !nft_flowtable_find_dev(in_dev, ft))
+		return -1;
+
+	out_dev = nft_out(pkt);
+	if (!out_dev || !nft_flowtable_find_dev(out_dev, ft))
+		return -1;
+
+	tuple =  &flow->tuplehash[!dir].tuple;
+
+	if (skb_vlan_tag_present(pkt->skb)) {
+		tuple->encap[i].id = skb_vlan_tag_get(pkt->skb);
+		tuple->encap[i].proto = pkt->skb->vlan_proto;
+		i++;
+	}
+	switch (pkt->skb->protocol) {
+	case htons(ETH_P_8021Q):
+		struct vlan_hdr *vhdr;
+
+		vhdr = (struct vlan_hdr *)skb_network_header(pkt->skb);
+		tuple->encap[i].id = ntohs(vhdr->h_vlan_TCI);
+		tuple->encap[i].proto = pkt->skb->protocol;
+		i++;
+		break;
+	case htons(ETH_P_PPP_SES):
+		struct pppoe_hdr *phdr;
+
+		phdr = (struct pppoe_hdr *)skb_network_header(pkt->skb);
+		tuple->encap[i].id = ntohs(phdr->sid);
+		tuple->encap[i].proto = pkt->skb->protocol;
+		i++;
+		break;
+	}
+	tuple->encap_num = i;
+
+	err = nft_dev_fill_bridge_path(flow, ft, pkt, !dir, out_dev, in_dev,
+				       eth->h_dest, eth->h_source);
+	if (err < 0)
+		return err;
+
+	memset(tuple->encap, 0, sizeof(tuple->encap));
+
+	err = nft_dev_fill_bridge_path(flow, ft, pkt, dir, in_dev, out_dev,
+				       eth->h_source, eth->h_dest);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 static void nft_dev_forward_path(struct nf_flow_route *route,
 				 const struct nf_conn *ct,
 				 enum ip_conntrack_dir dir,
@@ -294,6 +417,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 {
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 	struct nf_flowtable *flowtable = &priv->flowtable->data;
+	bool routing = (flowtable->type->family != NFPROTO_BRIDGE);
 	struct tcphdr _tcph, *tcph = NULL;
 	struct nf_flow_route route = {};
 	enum ip_conntrack_info ctinfo;
@@ -347,14 +471,20 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 		goto out;
 
 	dir = CTINFO2DIR(ctinfo);
-	if (nft_flow_route(pkt, ct, &route, dir, priv->flowtable) < 0)
-		goto err_flow_route;
+	if (routing) {
+		if (nft_flow_route(pkt, ct, &route, dir, priv->flowtable) < 0)
+			goto err_flow_route;
+	}
 
 	flow = flow_offload_alloc(ct);
 	if (!flow)
 		goto err_flow_alloc;
 
-	flow_offload_route_init(flow, &route);
+	if (routing)
+		flow_offload_route_init(flow, &route);
+	else
+		if (nft_flow_offload_bridge_init(flow, pkt, dir, priv->flowtable) < 0)
+			goto err_flow_route;
 
 	if (tcph) {
 		ct->proto.tcp.seen[0].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
@@ -407,8 +537,10 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 err_flow_add:
 	flow_offload_free(flow);
 err_flow_alloc:
-	dst_release(route.tuple[dir].dst);
-	dst_release(route.tuple[!dir].dst);
+	if (routing) {
+		dst_release(route.tuple[dir].dst);
+		dst_release(route.tuple[!dir].dst);
+	}
 err_flow_route:
 	clear_bit(IPS_OFFLOAD_BIT, &ct->status);
 out:
-- 
2.45.2

