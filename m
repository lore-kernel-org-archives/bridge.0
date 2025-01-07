Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56D61E1C29
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240767; cv=none; b=LEkSygiL0D4AZE//sSdIeWPEFQ7hYIB1vADCiu1zUcinzz2yGjm6vt/MAe8ZjbS/XzT2ASMDglWiDSbORDxFs/HCf2MtsAfnYBE+XGgWtdEdygj+LXQp8oLBtpBubFxp3l0YBG5ZxOz5c5BoISYaezaWiC0e6MElW4OCJeYgA4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240767; c=relaxed/simple;
	bh=Coh7dA4NZN0wC8ukUEBEVleZPuWCkMhm3t7ip8PSPUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyXfzZ5vUI1ECg3EFUkmXE4BUKDYe2ACH3DJEzCCyz8Sd7UbmFJ9E4mIgxdrOfA2j+UyecWwe7E4ifQ8jSlStxDEIikggSzYX+1E4VJWvuE337yPxM/1f4Gk4OL58Yi3xnug/raOSig8lTQe/2u+UKCEyPyio6YdaRERgSOATRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrYpklEo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrYpklEo"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d34030ebb2so10565825a12.1
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 01:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240763; x=1736845563; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Baj5jGYp4+wV8/iAbfAoST2ANmEn8FK5eb8xxUvDBwU=;
        b=ZrYpklEo+UDNpNYLvRI1c35I92OoNh43+2D0Ov+i+DDJbG2qR4gslZRwoJT09tq21r
         KuWgf3spg90GIb1NGM5wxOV40mZN497mC/5V7ztlGxfg/PqYPNPnX42spir1KUP4LEUc
         I3ukrInAZ8uiVBJ1BnS/TCcqY9ABj/+hRovkdKaWD6v7iZQuuPGXEb7HAxviYSqyb66T
         ByRlBqbqJg9DgIlwd52LnZ6ReCiF2Yx2vcLKopPjgasvXkOoMNhcOYJPCuKTqa056pqz
         kosKQJmUSdHN/8xTnVqbqKd4teXyFqAOPdpmd2C2btjQsJca2YJ60vFhMbPY9OsISZx6
         7Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240763; x=1736845563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Baj5jGYp4+wV8/iAbfAoST2ANmEn8FK5eb8xxUvDBwU=;
        b=oGZz6ww3FOR49wM3jSvVAuOxfIQ9z9uCk5CIW0AXVLyBYh4uYxMHHs6VR4W5gr6M1I
         5qs+FXB0okuTc5V14qwBk6zxlb1M+udjzNT9/cURHH9gjvucawNJ259/Z66rJWtQc2Ha
         qkU04+eeyIlSOstRkbOdXW11zwJIvURJb39hO+zPd/mbAt7alOBGS4lnFXUMMxM3Kxs4
         L4kIG1013px+eIqPb7AVD22Bi7HN68PL3Utq2GRUQMMUEe678VsCQ9TcPmDnaCtOcSUa
         GP4JgjGGv0B11gDKiHHefPT2IjI+sCAoe+ur0odpKThPCUQQ4yUURJtQesegDlTgyfvq
         Bytg==
X-Forwarded-Encrypted: i=1; AJvYcCXUrWJhC/LlLSzdsYtvF7ecz4Y5MbjwaREcoNGK4vfkyfBVgQcfdWMSdkwMuyn5ouKRbuoP+4E=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywcm1d5kIWpQYxpBgecqzck63YBNXjxxjfh+tn8Ubk4DjBwQdaK
	DuHPSHVcvnM+xHARAjtfa4ihZS9sXm6EYoX7MGwX89GzFeUI/idr
X-Gm-Gg: ASbGncsifJSPj278dqzwRYC4wI5RN1Z2pvrWjAnVqfQL5VwpHJNPUnUSXUji8LIXGg8
	pDsXSHo/ytdS4N8kprbDFNA6fxhbLuSd24EXvaJU4H2IwixRLu6x4GoUkLdB8Xf3A8H8tvYUZhg
	o202R3yHae2GHUwloO7Z3tAbO8Eqq6WZGJCw2QHyWn0OQj9o097CiWZUG2p9mXtJHqVSGB5Ns+e
	NOBVPsWbh799EhEv4tI3YogBHrLaN5qNwPekCg81PWx4viBbpIsdhWCFVR3Atw6hxpZiK80G1NJ
	Lb5pPV1PEAP1l7FFS/H1yL0kmbBt3ahJ6BleUJwpIYBDIe/+1b8/dC8Y+/F+hYVnm6LJ63qdow=
	=
X-Google-Smtp-Source: AGHT+IGihPZMtS/7pXngAOgxYVuDDIwJt5WjccXPIqnlanSAU8Lk5fvkBSWIEuChNszzwsLuG6qs6Q==
X-Received: by 2002:a05:6402:5253:b0:5d0:aa2d:6eee with SMTP id 4fb4d7f45d1cf-5d81ddf7fb6mr57942245a12.26.1736240762612;
        Tue, 07 Jan 2025 01:06:02 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24005333a12.23.2025.01.07.01.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:02 -0800 (PST)
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
Subject: [PATCH v4 net-next 01/13] netfilter: nf_flow_table_offload: Add nf_flow_encap_push() for xmit direct
Date: Tue,  7 Jan 2025 10:05:18 +0100
Message-ID: <20250107090530.5035-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107090530.5035-1-ericwouds@gmail.com>
References: <20250107090530.5035-1-ericwouds@gmail.com>
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

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nf_flow_table_ip.c | 96 +++++++++++++++++++++++++++++++-
 net/netfilter/nft_flow_offload.c |  6 +-
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 98edcaa37b38..290d8e10d85b 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -302,6 +302,92 @@ static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
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
@@ -331,6 +417,7 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
 
 static unsigned int nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
 				       const struct flow_offload_tuple_rhash *tuplehash,
+				       struct flow_offload_tuple_rhash *other_tuplehash,
 				       unsigned short type)
 {
 	struct net_device *outdev;
@@ -339,6 +426,9 @@ static unsigned int nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
 	if (!outdev)
 		return NF_DROP;
 
+	if (nf_flow_encap_push(skb, other_tuplehash, &type) < 0)
+		return NF_DROP;
+
 	skb->dev = outdev;
 	dev_hard_header(skb, skb->dev, type, tuplehash->tuple.out.h_dest,
 			tuplehash->tuple.out.h_source, skb->len);
@@ -458,7 +548,8 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 		ret = NF_STOLEN;
 		break;
 	case FLOW_OFFLOAD_XMIT_DIRECT:
-		ret = nf_flow_queue_xmit(state->net, skb, tuplehash, ETH_P_IP);
+		ret = nf_flow_queue_xmit(state->net, skb, tuplehash,
+					 &flow->tuplehash[!dir], ETH_P_IP);
 		if (ret == NF_DROP)
 			flow_offload_teardown(flow);
 		break;
@@ -753,7 +844,8 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
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
index 7b84d8d3469c..cdf1771906b8 100644
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

