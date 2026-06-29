Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE9400DF0
	for <bridge@lists.linux.dev>; Mon, 29 Jun 2026 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736418; cv=none; b=iVozK/IQM4YQYCKteI+mZFjRRo9whv520EiyY4eA0DQnCaf4nD0+afIWwQdaR8YtbEw2XYbjwg+Cbbu+ObTgqoKcFme9t8dygdcynDDM59EHYqBDHghA3CwTFEQHImj8J7FbSmSxD9qPJbsa/4f9pUnLriVGdmDv0a0GhSJ9BUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736418; c=relaxed/simple;
	bh=FLmf68CizDgbkWkilfIYmqlhpJjGjSd3CzUEP2obw5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oABiu8AbJS5ndCaRZ1d+wMFPbtedE+4CyiqKc+OdmGW2zQ4mxcqndZikmDXqmylRu4lHIigE4luNHxrGAu8PC1q/M+fw0AYd2IlyXBucYoE0FQHrLK5k7SNwFoEQxiN9AJU3YxRgwc7nRQ3vnYB/sf0caLNAQIR94IveNVTphDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/L/5wfe; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/L/5wfe"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c12614b81c9so198033466b.3
        for <bridge@lists.linux.dev>; Mon, 29 Jun 2026 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782736414; x=1783341214; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0BtFT/DLMwlAC+IMAnaYdEaIQ9JUWZrSmMLsMhq+s0=;
        b=S/L/5wfekeyhoAjFspQ1Fb/2c8KSU9CTUPC9ZOdqA7phF5ccee5U7qDYG3/8pJdgsl
         7AWRXLqa5ONf4b7UHYoMBZef1Y/6xa3/BnaRPrkl2KYM0cfqbzdAhPqGHV70+CvsxrEn
         9SYhj7M4Fz2Gr4FFSMEEMbBbItXTVMUlMfs9rqzyp3USXcgFCU1jVG7h4vAbMMT5e8as
         SeaROQ+72767RlknhqhsJLr2JfcgySpwfUfXMccBTodLoXHtz1t8V7IAw1GnZ67kjhhT
         XrHndHlUqyiFJ24aMhLaFJhwN6ynEa/Wq6xb1T5T2bbVrKL/hmFoLzT7maUb+EbJeAW4
         46Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736414; x=1783341214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B0BtFT/DLMwlAC+IMAnaYdEaIQ9JUWZrSmMLsMhq+s0=;
        b=W1NutitoVp9pmniTo5MFHkND1lpHnHyu2jSXOk6ehG0taE8wbRG1Krj6dUpStPdUoE
         oywHEm7JAGtbH6WmbmmDyfkbWIWwjtXtln2Mvn4vjo+sjj4Tks3lUsq/KKt7B7kl3EZ3
         MFRPgh57kXqu6TMWMeGGbgb8DgtnyLb/bY0HRnDdrtrXCYxo+2oMfCEwzsrxnFhpHGDX
         8n5jO0Ef9F+TWSeUW130+c6JNfBbnGRVtSat/0efHNQtTOYW36ovLgVwrctWe7FljX5E
         +CGiCp6C36O2S2/lbgTNyl8uEqTTlVBEpxCx7sfDAufA+J3EpyayuRkFenUs3uXwkndm
         SYxg==
X-Forwarded-Encrypted: i=1; AHgh+RqDMaGKKWbcgjwrBlkmHRyBDDlKWCmUpUnhYuhcPbtIsKkmG/En8YOnVGgflDRJu/CQPxHkfwM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzkn5XQ+VKWg8uQFJBsLqrCALQSlw8iXDfGeWGdsssXVgRyILiI
	Tw77DjQ+LXTkdkcqUfwI/fr1vwx4Jnp3kMQ2KNbT9v7fycrKlf10cSFK
X-Gm-Gg: AfdE7cltMKQmX2/dZrIP0rtjMiZP/TMhFTtmkoIOlVk1RwJJbB1Jy/vKNFwOuiV3MT0
	EVQYvpdNCk+YxoLwyg7Yd0IH3mdFNmEEg1bOcCUQNM/CoMvZDji8jncbCsFwTKtp9XLC8LXBHoA
	TE+D/0taIbHf90dE1+MPLTdJpdQ73mx3FmTzZbEWl9fvgTZPsitMnTHHyIpMhTHMavNWvh4P5A9
	XJcmtUvy0F1hAu931vi9eRZgKk5G+TXQigzy2hkKYaLoQcrVwo1FHZDvHCE24Q+tZyzC8MDIRi2
	gbINShT3THJnYGxbHnIxcpADoa+RryyOrGTuubFTjNwvEPH12uE+G/JplskAW+ZBItFe1hVAAap
	2Emamys572PGhTk3kpbcuN5V3grLtZqWW0OWKzU/t2yguoy17B4SlTZolR0ZF76+IcPIqQYTsgp
	vnWeI5XXs=
X-Received: by 2002:a17:906:f58a:b0:c12:34ec:ad25 with SMTP id a640c23a62f3a-c1234ecbf2bmr445790166b.65.1782736414123;
        Mon, 29 Jun 2026 05:33:34 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05c22sm773866566b.39.2026.06.29.05.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:33:32 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	idosch@nvidia.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bridge@lists.linux.dev,
	coreteam@netfilter.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	rchen14b@gmail.com,
	lorenzo@kernel.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH 5/5] netfilter: nf_flow_table_path: add VLAN passthrough support
Date: Mon, 29 Jun 2026 14:32:53 +0200
Message-ID: <20260629123253.1912621-6-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629123253.1912621-1-pawlik.dan@gmail.com>
References: <20260629123253.1912621-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Chen <rchen14b@gmail.com>

VLAN passthrough packets can be offloaded when bridge-nf-filter-vlan-tagged
is enabled. When a packet has a VLAN tag and the bridge does not have VLAN
filtering enabled (passthrough mode), record the VLAN encap info so the
hardware flow offload entry includes the correct VLAN tag.

Without this change, VLAN-tagged bridged traffic cannot be offloaded by PPE
because the VLAN encap information is missing from the flow entry.

Enable with: echo 1 > /proc/sys/net/bridge/bridge-nf-filter-vlan-tagged

Based on a MediaTek SDK patch by Chak-Kei Lam <chak-kei.lam@mediatek.com>.
Signed-off-by: Ryan Chen <rchen14b@gmail.com>
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
 net/netfilter/nf_flow_table_path.c | 32 ++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 580aa1db3cb4..d15c425c88c4 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -17,6 +17,7 @@
 #include <net/netfilter/nf_flow_table.h>
 #include <linux/if_bridge.h>
 #include <linux/if_ether.h>
+#include <linux/if_vlan.h>
 #include <net/route.h>
 #include <net/ip6_route.h>
 
@@ -136,6 +137,29 @@ struct nft_forward_info {
 	enum flow_offload_xmit_type xmit_type;
 };
 
+static void nft_fill_vlan_passthrough_info(const struct nft_pktinfo *pkt,
+					   struct nft_forward_info *info)
+{
+	if (!skb_vlan_tag_present(pkt->skb))
+		return;
+
+	rcu_read_lock();
+	/* when bridge VLAN filtering is enabled, the bridge handles the tag */
+	if (netif_is_bridge_port(pkt->skb->dev) &&
+	    !br_vlan_is_enabled_rcu(pkt->skb->dev)) {
+		if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
+			info->indev = NULL;
+		} else {
+			info->encap[info->num_encaps].id =
+				skb_vlan_tag_get_id(pkt->skb);
+			info->encap[info->num_encaps].proto =
+				pkt->skb->vlan_proto;
+			info->num_encaps++;
+		}
+	}
+	rcu_read_unlock();
+}
+
 static int nft_dev_path_info(const struct net_device_path_stack *stack,
 			     struct nft_forward_info *info,
 			     unsigned char *ha, struct nf_flowtable *flowtable)
@@ -326,8 +350,12 @@ static int nft_dev_forward_path(const struct nft_pktinfo *pkt,
 		nft_br_vlan_dev_fill_forward_path(pkt, &ctx);
 	}
 
-	if (nft_dev_fill_forward_path(&ctx, route, dst, ct, dir, ha, &stack) < 0 ||
-	    nft_dev_path_info(&stack, &info, ha, &ft->data) < 0)
+	if (nft_dev_fill_forward_path(&ctx, route, dst, ct, dir, ha, &stack) < 0)
+		return -ENOENT;
+
+	nft_fill_vlan_passthrough_info(pkt, &info);
+
+	if (nft_dev_path_info(&stack, &info, ha, &ft->data) < 0)
 		return -ENOENT;
 
 	if (!nft_flowtable_find_dev(info.indev, ft))
-- 
2.54.0

