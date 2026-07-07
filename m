Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE3392C39
	for <bridge@lists.linux.dev>; Tue,  7 Jul 2026 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415487; cv=none; b=QwE6UO7DefMHCy4+OZxxUoOzheNnef9HRg2RjdivOm+mtFdptV17S/5+wZ9zqgc9oGF1rmsLyBzbaSrLBf4rGFJCh5Wea8iCqQlsfkcvZKRz9ZArDycO5ss+KBehYn4bsbIaQOlPcNRoSELa1IzlbUuTD66w2ZXIaOH2+7mYgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415487; c=relaxed/simple;
	bh=cIupgpL+oLAc4FT3upk6ZOM6xx4HQ5fC0K1GWbF5Ijk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgGon3T0qdMiYnA3dp+YITmPA61dj69R+PdN5E5lGRXiNZtOnnoc0drAejuEI/dbDJ8jCZAyk+dFCyWn+B5+ngTb6jrqgBYrFVS+C878dVYDsZwzid9RbXdbcHNO/6m197Uw+XUaX0AspDbXO+HAoiHAvcgtZpub4Wj4whPRDZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f83Z0PX0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f83Z0PX0"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so7128304a12.1
        for <bridge@lists.linux.dev>; Tue, 07 Jul 2026 02:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415484; x=1784020284; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=55T+jBPAl2TQo9pZ1aG/hh01uhhF19W9W07xYipeSiM=;
        b=f83Z0PX0cAH1BAhxlXApIO46dnHeyRPzJEqq4VY7Qkip3nO+NRiOuKk78/lrKFoa4P
         nTQUeNsURXQfK0zzWWil5fi1l0PSbkDBNbZA+aOTAfhqJoUcZjs/gOWQbMtfRZZdXGzz
         LBQnk3PuGF6F/WIQE1ufF2G3Opohb2+Roqf/Yens8U/QgTa5qWkT/vM9RYPDDxPaEN/f
         SyviDognNGYDHEFtMLXhHcGqNkry1sNSCcTf1O/7mGetW/WgeKT4kHeiaf88n/6u7ALa
         zzrM7nPMWoRWBuNmR/QaOx/amQsZ35fWcQyU0BQ/Xz6GF/kLGj7Ih+kQwMohyz+GR6D6
         tXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415484; x=1784020284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=55T+jBPAl2TQo9pZ1aG/hh01uhhF19W9W07xYipeSiM=;
        b=J5Ba9uz9TAxJknaeBwKEkoO28QtDAwKGVFgKOBd2kPbNYJY7oyPF6dVx2dBlTy6GZH
         k/KIstS3Gh2Md6jnYRD3MJLs5BGRC4870mgSip//oWMBf6HSL1WfOr0qK2lIpogCoTbK
         rGkodxDBIXNowTXj9Ismujmk3tkA6d/bKhscS+7pv4DL5Lz90Kq+YfHaI/2C73yFJ4tB
         RvwnAd3wgcJr/nhDdNTlb8GRVoVjPp0FI0QwRGxe3MPupFE660zHRvJ2Ub0Kj5CSwoKb
         t+OFxaqln1zZ9kj4AwogSkhDrU70BDrvYMZ+15m15h9JA/EqmpWudJtsHVE7bGVmL+5F
         GZIg==
X-Forwarded-Encrypted: i=1; AHgh+RpEcjLadAXxDKl3BXCsr0lKSq6YGFU1KMDhg0osNTmCLtk0r9wjn1weoAu2cz1ZhLRjg+MfimQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzYnrb216eaDzmoKnbl5ctUkcSFNPAEsqCJAmeLLxhQDFsD2pPP
	o/Qu98fLrsS4b/jsPzm0kRZoRHR5bJTn6EQph8lGz5/loNHnvu0zDVV5
X-Gm-Gg: AfdE7cnnAKX3wXhX+Nzb9G4M6xqe4nPqzRTnYiAAkNg8teuK3arIoZARyQFs72HkVL2
	PSn//WutK0Py/f/gF3bEhEYhgij6fMf8kXJ/z6JGugpQnqeepcSvGrNHFQ+NuVTf+nWtJrvyTSr
	lQTJVyH/hZz1/dmTbXmIXlzvlKnGQJcxm+CjnrRqFF/GQZg/f6imnDv6CjKb0UJeOEanP3ZLBmG
	DOwwDKsau8vR9/RK0Oxuf7kabBKh6AfmpHGG7ctFmQun5nR4ORl05sNaocj5KHcl73vJpswXXiV
	S8Gp8J3OJiqEx4v0aZAtfo+VlhCVuWBthqjJ1GY5q5JexQmiqg++thVLbIwd4rU3GonKA1vjFzI
	gEiDmms+hgI6gWUJvwXMHpST7YKyqXC+3qqV/aOAOr6Mcz92zOqNPKKVtZSGme4NdXB6ySV9wz0
	4ieTjzi0Ex/rSHHKPbGy/lkl6cdRVtGBrI0vq+Xs7PKE4Db1hwTcUBUD4uMZ/KE/RPIgVl5G2SZ
	stkRHQe+XDJH8KW/kmo0P9Dn7qZve+WP52mxXXJEh4h
X-Received: by 2002:aa7:d0c8:0:b0:698:18e7:9c48 with SMTP id 4fb4d7f45d1cf-69a85b96550mr1571758a12.15.1783415483553;
        Tue, 07 Jul 2026 02:11:23 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd87d6sm5297152a12.6.2026.07.07.02.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:11:23 -0700 (PDT)
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
Subject: [PATCH v12 nf-next 7/7] netfilter: nft_flow_offload: Add bridgeflow to nft_flow_offload_eval()
Date: Tue,  7 Jul 2026 11:10:45 +0200
Message-ID: <20260707091045.967678-8-ericwouds@gmail.com>
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

Edit nft_flow_offload_eval() to make it possible to handle a flowtable of
the nft bridge family.

Use nft_flow_offload_bridge_init() to fill the flow tuples. It uses
nft_dev_fill_bridge_path() in each direction.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/net/netfilter/nf_flow_table.h |   5 +
 net/netfilter/nf_flow_table_path.c    | 126 ++++++++++++++++++++++++++
 net/netfilter/nft_flow_offload.c      |  20 +++-
 3 files changed, 146 insertions(+), 5 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 5c6e3b65ae85b..a109eda5250c7 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -305,6 +305,11 @@ nf_flow_table_offload_del_cb(struct nf_flowtable *flow_table,
 void flow_offload_route_init(struct flow_offload *flow,
 			     struct nf_flow_route *route);
 
+int flow_offload_bridge_init(struct flow_offload *flow,
+			     const struct nft_pktinfo *pkt,
+			     enum ip_conntrack_dir dir,
+			     struct nft_flowtable *ft);
+
 int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow);
 void flow_offload_refresh(struct nf_flowtable *flow_table,
 			  struct flow_offload *flow, bool force);
diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 2b6ebb594a9ee..cdd6a822cb811 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/if_vlan.h>
 #include <linux/init.h>
 #include <linux/etherdevice.h>
 #include <linux/netlink.h>
@@ -365,3 +366,128 @@ int nft_flow_route(const struct nft_pktinfo *pkt, const struct nf_conn *ct,
 	return -ENOENT;
 }
 EXPORT_SYMBOL_GPL(nft_flow_route);
+
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
+	th[dir].tuple.xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
+
+	return 0;
+}
+
+int flow_offload_bridge_init(struct flow_offload *flow,
+			     const struct nft_pktinfo *pkt,
+			     enum ip_conntrack_dir dir,
+			     struct nft_flowtable *ft)
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
+	err = nft_dev_fill_bridge_path(flow, ft, dir, in_dev, out_dev,
+				       eth->h_source, eth->h_dest);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(flow_offload_bridge_init);
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 0be62841155b6..d0d63ef7cecd5 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -53,6 +53,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 {
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 	struct nf_flowtable *flowtable = &priv->flowtable->data;
+	bool routing = flowtable->type->family != NFPROTO_BRIDGE;
 	struct tcphdr _tcph, *tcph = NULL;
 	struct nf_flow_route route = {};
 	enum ip_conntrack_info ctinfo;
@@ -109,14 +110,21 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
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
+		if (flow_offload_bridge_init(flow, pkt, dir, priv->flowtable) < 0)
+			goto err_flow_add;
+
 	if (tcph)
 		flow_offload_ct_tcp(ct);
 
@@ -164,8 +172,10 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
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
2.53.0

