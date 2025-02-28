Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B123202974
	for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773783; cv=none; b=Nx/pPrH+NRWYxYC8o74UXCcYubr7Hi432HwjAOC4jpbbIdHf3jrFnetNB4AUMVPobkR+3PNhgebHJZtrjidUih9R8wY8RJ/Rr91Q4z3ltwuEvA7hLXsvuuxRRCY6KaygA/swFEB273+mpcagZfaewfSkpUabrKaa2NIQ8OBYNCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773783; c=relaxed/simple;
	bh=wMUZpUs1MP0v4aGWSuV5DzAXHNdRlbpPAoNl+5GV7TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svCixIZgh3uzJ4Ju6jocNztEjaa3TFZtqR+SDNKSH/gGYZ8TvvCSxxNNpM8pimez8utE/YJyqcZ39q4OHLOwfFuucrScbpAtciPqfVQJE6RydxEb17uy2iad87moLkyzHS0BFr2z5xaNxbrPNdetEuT1HFKpD8h+viVl9IpfVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tvk0AW55; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tvk0AW55"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab744d5e567so429668666b.1
        for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 12:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740773779; x=1741378579; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGr0DGFtdF9vUQZNuQxbjKzErqMA9pCa8F2vVWAZr6U=;
        b=Tvk0AW55LZJbnEh11Y+qkPIzHL1OAIIdjK5e3ayAmn2LgMsbZP5l5I88/TF5iiK0Vv
         hV9c9EDuQ0V4NGsBY3DBbDIcq4kTxNiaNIesj85T/9lJ3IDphithcQVDlbEemcWai5hi
         na9eAAA59w4zh8tqocRX2GUStRid6ATe/LPhHkuUkwN968tH3GxshDCYdXJE8U73KdIR
         nXiQ97eEsV36XKl465+WVZYT1PasmxFsaxPhzX9xjrrefsKktFQgC6GCWDEsiZQAdezz
         4htf1q3WV66SPpihRkim8x/lr4qqyi4HUalriVk2Z0JAGxxAZML7RkwXdsung2yXcBsR
         HD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773779; x=1741378579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGr0DGFtdF9vUQZNuQxbjKzErqMA9pCa8F2vVWAZr6U=;
        b=cyXlqZ1+UDiQQTvGqwVoxNJeKFXCkbZnZGJ5Wu1CdDgUg5poAN/zcSqJim3pVtUWVZ
         Jwvn33ic+1KK8ThorHQFJ5vxti8t+2Z+7c+mytXOitR3UhdeQYmLGj+vZXJeEfhcEOzX
         kQYl2h2/kRgphG05z0hNTaMuao/29Izh8aJR4g6ibqDUTpzoMm/BTTBFKEZKw0cly6/S
         dY8keiljKtn2lo6/0jITHKoD5H0VT//o0MhdsxKoteC6mcwX3aDQ8y+4t97Br09QY7IA
         ntCfq8/1i2n3BNIvDs4forIMiZJ1wofAy5BTHquEzkL1DqmqdjJy9b6r53rMGqI/rFGh
         UZkA==
X-Forwarded-Encrypted: i=1; AJvYcCWiyKR7V1ve4RD+Vy4lBcDQt0zlKiWnACjJ1uGrL7OTlt5pGZZWW6GFrMcKwYGDY9W5nBbqoPc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxrlf0XhR5zNcF42hMCDL3JGlh/zvnfDJD/FdA/VBRFmc+PNWcp
	glkJ+sU7RaZEirVm1D7AOC05R3/iDQqAGEmypx5rjj/xkw0vhlVo1sk0o94i
X-Gm-Gg: ASbGnctE8HP7KdYIUnZ6n/MdvxyNYdENz+gw7Twz2fNeVg6rWSda7AVSbSwL0IPMbHN
	VoHBiQ4qcxLNYIcQCOOHV4FCDQbe8TL3JMW+YIbZttWS1NHQMPpofS8FfOi6CR3Zf6bXlqClZCz
	s80aAHuR7zrNAqBO5jBg9Rc+JnMGaSl+M7FUH0xosCquHgKFGgwj9DT5oCtjNgcNYuadPixs6Uz
	G5G20iy/HIrJMV9JR0nM8/qdRYlv2gjR95kofuqFRnGFDtnWwnwRoxiUwq8J0J+3fn6CHaHN3Cc
	pZo7X23RUSkKNQ9hwJWogXBCB0q6LmdyWcDMufrep3cB4FUq2h4nH2bC4KNaFAKICCGWq9RJsrn
	wUq7vXkVjbZ7S+dRNlviOww8dWa15oBUpqoJrpum6z2g=
X-Google-Smtp-Source: AGHT+IFSsO0D6FLoaTBr5CsWmwmRlLw+sSkoUxgYwd46U2pqe5KcLEx75Cg5UhavDa3o6cjGcNQ8Ug==
X-Received: by 2002:a17:907:a4c7:b0:abb:af33:d0ac with SMTP id a640c23a62f3a-abf0605eec7mr944542066b.16.1740773779092;
        Fri, 28 Feb 2025 12:16:19 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm340812666b.136.2025.02.28.12.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:16:18 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
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
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v8 net-next 02/15] netfilter: nf_flow_table_offload: Add nf_flow_encap_push() for xmit direct
Date: Fri, 28 Feb 2025 21:15:20 +0100
Message-ID: <20250228201533.23836-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228201533.23836-1-ericwouds@gmail.com>
References: <20250228201533.23836-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Loosely based on wenxu's patches:

"nf_flow_table_offload: offload the vlan/PPPoE encap in the flowtable".

Fixed double vlan and pppoe packets, almost entirely rewriting the patch.

After this patch, it is possible to transmit packets in the fastpath with
outgoing encaps, without using vlan- and/or pppoe-devices.

This makes it possible to use more different kinds of network setups.
For example, when bridge tagging is used to egress vlan tagged
packets using the forward fastpath. Another example is passing 802.1q
tagged packets through a bridge using the bridge fastpath.

This also makes the software fastpath process more similar to the
hardware offloaded fastpath process, where encaps are also pushed.

After applying this patch, always info->outdev = info->hw_outdev,
so the netfilter code can be further cleaned up by removing:
 * hw_outdev from struct nft_forward_info
 * out.hw_ifindex from struct nf_flow_route
 * out.hw_ifidx from struct flow_offload_tuple

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nf_flow_table_ip.c | 96 +++++++++++++++++++++++++++++++-
 net/netfilter/nft_flow_offload.c |  6 +-
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 8cd4cf7ae211..d0c3c459c4d2 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -306,6 +306,92 @@ static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
 	return false;
 }
 
+static int nf_flow_vlan_inner_push(struct sk_buff *skb, __be16 proto, u16 id)
+{
+	struct vlan_hdr *vhdr;
+
+	if (skb_cow_head(skb, VLAN_HLEN))
+		return -1;
+
+	__skb_push(skb, VLAN_HLEN);
+	skb_reset_network_header(skb);
+
+	vhdr = (struct vlan_hdr *)(skb->data);
+	vhdr->h_vlan_TCI = htons(id);
+	vhdr->h_vlan_encapsulated_proto = skb->protocol;
+	skb->protocol = proto;
+
+	return 0;
+}
+
+static int nf_flow_ppoe_push(struct sk_buff *skb, u16 id)
+{
+	struct ppp_hdr {
+		struct pppoe_hdr hdr;
+		__be16 proto;
+	} *ph;
+	int data_len = skb->len + 2;
+	__be16 proto;
+
+	if (skb_cow_head(skb, PPPOE_SES_HLEN))
+		return -1;
+
+	if (skb->protocol == htons(ETH_P_IP))
+		proto = htons(PPP_IP);
+	else if (skb->protocol == htons(ETH_P_IPV6))
+		proto = htons(PPP_IPV6);
+	else
+		return -1;
+
+	__skb_push(skb, PPPOE_SES_HLEN);
+	skb_reset_network_header(skb);
+
+	ph = (struct ppp_hdr *)(skb->data);
+	ph->hdr.ver  = 1;
+	ph->hdr.type = 1;
+	ph->hdr.code = 0;
+	ph->hdr.sid  = htons(id);
+	ph->hdr.length = htons(data_len);
+	ph->proto = proto;
+	skb->protocol = htons(ETH_P_PPP_SES);
+
+	return 0;
+}
+
+static int nf_flow_encap_push(struct sk_buff *skb,
+			      struct flow_offload_tuple_rhash *tuplehash,
+			      unsigned short *type)
+{
+	int i = 0, ret = 0;
+
+	if (!tuplehash->tuple.encap_num)
+		return 0;
+
+	if (tuplehash->tuple.encap[i].proto == htons(ETH_P_8021Q) ||
+	    tuplehash->tuple.encap[i].proto == htons(ETH_P_8021AD)) {
+		__vlan_hwaccel_put_tag(skb, tuplehash->tuple.encap[i].proto,
+				       tuplehash->tuple.encap[i].id);
+		i++;
+		if (i >= tuplehash->tuple.encap_num)
+			return 0;
+	}
+
+	switch (tuplehash->tuple.encap[i].proto) {
+	case htons(ETH_P_8021Q):
+		*type = ETH_P_8021Q;
+		ret = nf_flow_vlan_inner_push(skb,
+					      tuplehash->tuple.encap[i].proto,
+					      tuplehash->tuple.encap[i].id);
+		break;
+	case htons(ETH_P_PPP_SES):
+		*type = ETH_P_PPP_SES;
+		ret = nf_flow_ppoe_push(skb,
+					tuplehash->tuple.encap[i].id);
+		break;
+	}
+	return ret;
+}
+
 static void nf_flow_encap_pop(struct sk_buff *skb,
 			      struct flow_offload_tuple_rhash *tuplehash)
 {
@@ -335,6 +421,7 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
 
 static unsigned int nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
 				       const struct flow_offload_tuple_rhash *tuplehash,
+				       struct flow_offload_tuple_rhash *other_tuplehash,
 				       unsigned short type)
 {
 	struct net_device *outdev;
@@ -343,6 +430,9 @@ static unsigned int nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
 	if (!outdev)
 		return NF_DROP;
 
+	if (nf_flow_encap_push(skb, other_tuplehash, &type) < 0)
+		return NF_DROP;
+
 	skb->dev = outdev;
 	dev_hard_header(skb, skb->dev, type, tuplehash->tuple.out.h_dest,
 			tuplehash->tuple.out.h_source, skb->len);
@@ -462,7 +552,8 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 		ret = NF_STOLEN;
 		break;
 	case FLOW_OFFLOAD_XMIT_DIRECT:
-		ret = nf_flow_queue_xmit(state->net, skb, tuplehash, ETH_P_IP);
+		ret = nf_flow_queue_xmit(state->net, skb, tuplehash,
+					 &flow->tuplehash[!dir], ETH_P_IP);
 		if (ret == NF_DROP)
 			flow_offload_teardown(flow);
 		break;
@@ -757,7 +848,8 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 		ret = NF_STOLEN;
 		break;
 	case FLOW_OFFLOAD_XMIT_DIRECT:
-		ret = nf_flow_queue_xmit(state->net, skb, tuplehash, ETH_P_IPV6);
+		ret = nf_flow_queue_xmit(state->net, skb, tuplehash,
+					 &flow->tuplehash[!dir], ETH_P_IPV6);
 		if (ret == NF_DROP)
 			flow_offload_teardown(flow);
 		break;
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 46a6d280b09c..b4baee519e18 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -124,13 +124,12 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 				info->indev = NULL;
 				break;
 			}
-			if (!info->outdev)
-				info->outdev = path->dev;
 			info->encap[info->num_encaps].id = path->encap.id;
 			info->encap[info->num_encaps].proto = path->encap.proto;
 			info->num_encaps++;
 			if (path->type == DEV_PATH_PPPOE)
 				memcpy(info->h_dest, path->encap.h_dest, ETH_ALEN);
+			info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
 			break;
 		case DEV_PATH_BRIDGE:
 			if (is_zero_ether_addr(info->h_source))
@@ -158,8 +157,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 			break;
 		}
 	}
-	if (!info->outdev)
-		info->outdev = info->indev;
+	info->outdev = info->indev;
 
 	info->hw_outdev = info->indev;
 
-- 
2.47.1

