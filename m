Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8488522D4CE
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122511; cv=none; b=tfsuxOLiIB/bmTBqJok663KsaKktEXrOt7oX+8I0Fo57NZJTFhUS2XHjpM+W9wkLRZI7dkSLySYIxoEj8K5fThhL8elDI52+5iq94e34GQJvH+E8Av0JzOppmtAHyvAem8FWajyd8MqjEaJ6nWE5uCirEMawn7G+lfnUiiZtCoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122511; c=relaxed/simple;
	bh=lky3FcPJjN9450c9thmKPQGaNXBjMLxRGG5xD/B9cRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGbzKTY3EJQ8sY4a2jjLWP0oY7eipNpHKU4549/bexlOMTPR7959QoKCkNuf+AhrQVWybmi2xBgLeOyx0Suyxb2ifljuOWGYuLOHrIHTtixzJd/7IOuoslZ1AJ7vrfecWKyhwhy7dn3lvlUfPoS6dKuetWD/tlbDjPG7dKPgi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzzyFVqn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzzyFVqn"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso78684a12.3
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122508; x=1744727308; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiIIzC2ENJ2s1K+DNkI8Yhy3iA1yTay52KJr2KclWBQ=;
        b=OzzyFVqnBq31vkSuucT0AAMUdLGNKPohyPAEz0jcZeoGL+oAzdHgK6eq7yexw/Z4F5
         +qBPPGUdiZ69S2aEeGd+aQz12cOywweeiqFDonsPCOFnslX+Na2/N3wdWRnmP5ViawbG
         vPc3jIfUA8jLnol95rAleHHIwWhPizJ1F2sV5whL62MNHEUSzcMEaYwPEaPAGHxBZeC0
         9v+Qh/iFesaP+XrieSCI54wcfje4yl9wZHcfkMBFn1NUjSIWVjktV9GHaOWK+mC4857Q
         dn9v6mJWTgv7SOtx4ZJXApsjQYnuHnLkaQKcfL2LIElTzwcqNgBi0aeb9PrirCw8yqli
         OHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122508; x=1744727308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiIIzC2ENJ2s1K+DNkI8Yhy3iA1yTay52KJr2KclWBQ=;
        b=Ur6HOcPsoiCV6tnypb6ppyB6WF8tj+XEL6lX1OFlExJEqBIoLYAcwQ5YswR3NPc3oR
         Gr6r6zn0jIZb11tbyOHtoNRPJAjQn61Rb6lSnZplTY12OT2O36euMSMjgQkS0yVjRG9j
         aRlGJKIA80RZ/PMJwF3/wS/E+dPKGM+Zlcj4PFipJ126usbSmKSZgENQUr69wUMOCYzL
         IORe+O5kGN70hWSbxL3Zj67/zNbov1XS65olVgbXrSTfFBgFzkg7WMFe3L9drlev6HIT
         M3DtdK27WeEJCX8yumTKJ2OgsO1YPuZ7vjD5MRe6zlZDKS1pADwIT4CuxjQWZssoG1Rr
         ylGw==
X-Forwarded-Encrypted: i=1; AJvYcCUhak6KO9gMSzlZrK0hVbf7U5NJ/ZEhUcSn7uxMTJb06+hbKw2WvqMqzqBuGrbGuNAOThq6Eag=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxjs4wUB3hFBXVG8KVqsJMy0OBFkagKqG4mPVesGquwgsjnoJn0
	jDFd2BUG9U1AXdkcXRkGxXcVX2BltN32IALnDfoF99kEkiYFIMbp
X-Gm-Gg: ASbGncsbG51GoOFydAOIPiDYB2JDYJ1oszTai7z1YmS5OlumLNumS4jiarTnFyERJ9G
	imEazkW8IUGi73omjQ13kQAzgSoRJzgUuXhYtmH09avh3WIMQ+cEQJgoi4UGvFJwoPeDzvBSsqS
	tScwNFKV9Q41H4dejvax2jjq7TYlWvBHq0zlJNOAkLvd4XQ7XIfMvHc34dBgrVa/SN0+hU54yGc
	85EnUwwSdNlhdde6v4tpClyvvqDs2es/4hM5wvrhtRrkpz7lmXUBauC/w3rvJluDszjGIKLSIX7
	wlkfGF5zwTFZoRBgYe5QDHZEHJ7nt2n7urPcbP3Sm0AnWj3RII454ASJgTTr8O0EbG5K8TS+svc
	go/yC9On4AnbWr1znd2H6tDq+kmhdYvFuk78yFKk+3QLI1clZO8N8aUwwtxMc5ZLpHuWEpYgt7A
	==
X-Google-Smtp-Source: AGHT+IECIEK0QmJOe0Z95DwXG6+lr5tNjP8GBD5Ogpg0Jfp+vB59Ktc7EyTs4eXPmXmqvPDk2cwD7A==
X-Received: by 2002:a05:6402:2351:b0:5ed:1262:c607 with SMTP id 4fb4d7f45d1cf-5f0b471a89bmr14334221a12.31.1744122507692;
        Tue, 08 Apr 2025 07:28:27 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f1549b3fd0sm2236164a12.35.2025.04.08.07.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:28:25 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v11 nf-next 6/6] netfilter: nft_flow_offload: Add bridgeflow to nft_flow_offload_eval()
Date: Tue,  8 Apr 2025 16:28:02 +0200
Message-ID: <20250408142802.96101-7-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408142802.96101-1-ericwouds@gmail.com>
References: <20250408142802.96101-1-ericwouds@gmail.com>
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
 net/netfilter/nft_flow_offload.c | 148 +++++++++++++++++++++++++++++--
 1 file changed, 143 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 889393edc629..05294955881e 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -195,6 +195,134 @@ static bool nft_flowtable_find_dev(const struct net_device *dev,
 	return found;
 }
 
+static int nft_dev_fill_bridge_path(struct flow_offload *flow,
+				    struct nft_flowtable *ft,
+				    enum ip_conntrack_dir dir,
+				    const struct net_device *src_dev,
+				    const struct net_device *dst_dev,
+				    unsigned char *src_ha,
+				    unsigned char *dst_ha)
+{
+	struct flow_offload_tuple_rhash *th = flow->tuplehash;
+	struct net_device_path_ctx ctx = {};
+	struct net_device_path_stack stack;
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
+	th[dir].tuple.out.bridge_vid = info.bridge_vid;
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
+	const struct net_device *in_dev, *out_dev;
+	struct ethhdr *eth = eth_hdr(pkt->skb);
+	struct flow_offload_tuple *tuple;
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
+
+	switch (eth_hdr(pkt->skb)->h_proto) {
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb_mac_header(pkt->skb)
+					 + sizeof(struct ethhdr));
+		tuple->encap[i].id = ntohs(vhdr->h_vlan_TCI);
+		tuple->encap[i].proto = htons(ETH_P_8021Q);
+		i++;
+		break;
+	}
+	case htons(ETH_P_PPP_SES): {
+		struct pppoe_hdr *phdr = (struct pppoe_hdr *)(skb_mac_header(pkt->skb)
+					  + sizeof(struct ethhdr));
+
+		tuple->encap[i].id = ntohs(phdr->sid);
+		tuple->encap[i].proto = htons(ETH_P_PPP_SES);
+		i++;
+		break;
+	}
+	}
+	tuple->encap_num = i;
+
+	err = nft_dev_fill_bridge_path(flow, ft, !dir, out_dev, in_dev,
+				       eth->h_dest, eth->h_source);
+	if (err < 0)
+		return err;
+
+	memset(tuple->encap, 0, sizeof(tuple->encap));
+
+	err = nft_dev_fill_bridge_path(flow, ft, dir, in_dev, out_dev,
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
@@ -315,6 +443,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 {
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 	struct nf_flowtable *flowtable = &priv->flowtable->data;
+	bool routing = flowtable->type->family != NFPROTO_BRIDGE;
 	struct tcphdr _tcph, *tcph = NULL;
 	struct nf_flow_route route = {};
 	enum ip_conntrack_info ctinfo;
@@ -368,14 +497,21 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
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
+			goto err_flow_add;
+
 	if (tcph)
 		flow_offload_ct_tcp(ct);
 
@@ -423,8 +559,10 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
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

