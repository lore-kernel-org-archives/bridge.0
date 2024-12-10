Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7423D409
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823999; cv=none; b=tKxVwDExZmQqMw8oan0O1+l2PsM/7ltM28HByDgbOABVAONazPIELk5UsSBfLwY0D8Ljc+OAvNN5O2YkIGcpan4AY/6aZT40/Xhw8IJeMtFq49bVVx2CFtfHK3qfqFkBFErS0FmF07oTBbHL8KJ+1gU3471BD/TGRdbohLF37PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823999; c=relaxed/simple;
	bh=53JGUH2pR8oX8Xp8+Xw+36LGxxviOGdtjx+fvNsDyms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIIXbNEUsRco8F1HtNYrc79yuuWgsiYunZsvDyeNkoaREthjB140UK1XAWMfD/fP6XCpLecgVCiZIb4/uv72Zuj6T/buhkOKsp7ABThbvi42waPVN/YCmn4bzXLg2A67YJGhlmMkfwvsI9gG3dt/a66sDXlz0KQvlVeE7l5mjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZc4LXMc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZc4LXMc"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so6173986a12.1
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 01:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733823995; x=1734428795; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjMfgZPTOt1wzklPxYQo1KoCry3saUouaCrKRGjXlrM=;
        b=eZc4LXMc3HL/R3pXqu4za/sy8WaWkUn3ex18oDtq+Ai1HPAD4NwqrIzXHVffDgz6gz
         M/wCa8TtrZKOO6LQb9hIJy3vkTmGJ/6rpKNUgo3n3PnntnA1HqDznaVXJQm5PKrLyjgm
         2KhDphwXaZ8OBLTwGEjUPxNJomkolkCK8SXuUZaYwErvjEhb7m73USN462us9pOc8Ekd
         HVpgnCih2V/wua1i3EenDVI1QqDxPDzOYTtHXdp45wMKJptAv5/GlN+V1sImDkA2yLIC
         YcCTS7XVHain70Urj+rA+uENmRp6xzXePYHvj7JyNaNlnvC1LisoKnnuRN87H2/HpN1l
         sklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823995; x=1734428795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjMfgZPTOt1wzklPxYQo1KoCry3saUouaCrKRGjXlrM=;
        b=A4VTKS9izwctToNCq4pUjrnpAVsRwB7cIVyIkvRfJCTANqEh2NHuFhaWObP5auT4sL
         OuDmCFn6IRh0V2d0TkyGbg/1bCrbD3yR/6488AGd+CHuLENKN+ae6kJsHf9oQ/QBWefk
         AIYJHkbhjxVTCAt3uVLIJSMbPqlQits+/KE4/TWRbIH9OPptmKOFFPEw8g0vFltEf725
         8jfI8V22OeIUFLU0zrPb4+yY7h+U/gvhtf1VN1WR+LiDrZ8IOAp2Zv07dZcCsDy6W2gJ
         Mowipl6K2JEW7z95Ia8XXZjLyfYMh5BNdQMZN95z7tJR3gYp5hG5qYbwT5vIYjiMIXS1
         KA9g==
X-Forwarded-Encrypted: i=1; AJvYcCWB7aLBYI4Y/Rt5eMHfeGEvtEIPWxuj3u9WFiRYREKJZ71Cdad8/GCCwIz3GnDiqTRIERGpWbk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxOzj/a+N2olFrBOlUiWeBduaFwdPPlGPXTv8vQUrZ8SCdiR9bs
	bmtTeSxfhkS3YAZBqqv6I6mOG6BZj5XUUfR2G9Z+yroSvJMGVz1q
X-Gm-Gg: ASbGncvQRN7OOK2tCfp6J+XaqQn5f9fBvWAqbY9/2+siUEvPpn/D/Dr/fYSUGw39bh+
	yjzovSfeSHZzLrcrPBMXbp9m6lZh7Y35DHxuIPTtySVAK75CDYMDIrNyNZPY8b8UmYjbZdiPZBB
	wc3hsH2xwItjYwlqXTSVNoO52KC2TnbGInQM0juEohMXQXb7OCvWL3AM0vhPpdGr5mayUGgbGjG
	epYtzzqaRfr/LcwpGxDuPIeNnyLcDH5Qg8i60EuguIyYKC8C+pyXEWZTXd8mUdk9lJj+DW6be8k
	Kph3/+1jo0bB1wpJzuGtXKmWIl4MB72+xk4AjdXCr9d50j+xAujDodbzK2xZWOr4LIGv8MM=
X-Google-Smtp-Source: AGHT+IFAu59kegmItDpMGH7TM0Tzld+Gwydm4Aw22u8I6s2WTgEkJzLS/k6ir2kKhoX3eegXigdJOA==
X-Received: by 2002:a05:6402:51cb:b0:5d2:7346:3ecb with SMTP id 4fb4d7f45d1cf-5d3be69d3admr15117186a12.12.1733823994692;
        Tue, 10 Dec 2024 01:46:34 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b609e56sm7313936a12.40.2024.12.10.01.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:46:33 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH RFC v3 net-next 13/13] netfilter: nft_flow_offload: Add bridgeflow to nft_flow_offload_eval()
Date: Tue, 10 Dec 2024 10:45:01 +0100
Message-ID: <20241210094501.3069-14-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210094501.3069-1-ericwouds@gmail.com>
References: <20241210094501.3069-1-ericwouds@gmail.com>
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
 net/netfilter/nft_flow_offload.c | 144 +++++++++++++++++++++++++++++--
 1 file changed, 139 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index ed0e9b499971..b17a3ef79852 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -196,6 +196,131 @@ static bool nft_flowtable_find_dev(const struct net_device *dev,
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
+
+		if (th[dir].tuple.in_vlan_ingress & BIT(i))
+			continue;
+
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
+	struct pppoe_hdr *phdr;
+	struct vlan_hdr *vhdr;
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
+		vhdr = (struct vlan_hdr *)skb_network_header(pkt->skb);
+		tuple->encap[i].id = ntohs(vhdr->h_vlan_TCI);
+		tuple->encap[i].proto = pkt->skb->protocol;
+		i++;
+		break;
+	case htons(ETH_P_PPP_SES):
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
@@ -306,6 +431,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 {
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 	struct nf_flowtable *flowtable = &priv->flowtable->data;
+	bool routing = (flowtable->type->family != NFPROTO_BRIDGE);
 	struct tcphdr _tcph, *tcph = NULL;
 	struct nf_flow_route route = {};
 	enum ip_conntrack_info ctinfo;
@@ -359,14 +485,20 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
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
@@ -419,8 +551,10 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
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
2.47.1

