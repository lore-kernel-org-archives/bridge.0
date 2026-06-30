Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA15B3C553A
	for <bridge@lists.linux.dev>; Tue, 30 Jun 2026 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802687; cv=none; b=fpK4CGaMLp2tMobldQPoD8drD/dkGe87m6zWyi7HJffvIiG1dRWqFoTvXGxnyeL/Oyr27uir0318wCBRjlFt4N6kqBPEXbLTvOKjBUoF2W/tzEYXLzQp5jAx241hmHGnZq3sJo+KsRF3AKOKVYgEAezfUe7bDiS8+Zfgs/URojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802687; c=relaxed/simple;
	bh=FLmf68CizDgbkWkilfIYmqlhpJjGjSd3CzUEP2obw5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RG7knsgHThmnixe+w94Y3EwEaL7mv1ueIhLNdpkRxCU7PwI7GCHNUEQrytEKmLWdmorZmA3UYpcHQyrv6CADrEjlZhGiXh8iHRy0ER4tiF/94wRTlkQmeyQDewuztnvgBpHVh+hQfnl+xLu+GmubSJAkWRO3assTIZG6AdOBR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9uJz++v; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9uJz++v"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-46db1eb3100so458115f8f.1
        for <bridge@lists.linux.dev>; Mon, 29 Jun 2026 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782802684; x=1783407484; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0BtFT/DLMwlAC+IMAnaYdEaIQ9JUWZrSmMLsMhq+s0=;
        b=Y9uJz++vVs01CvX99oO4cIEGNfZLhwRgrcM90R3L7fdZxnqWEPy4beZTzvLCwS64TQ
         4CoJySIezJ4Mt5c8NEPepD/hb2ovHTOkwAKaviH1yGeyrSS324Xo71sCmy33QYrffcQb
         lHN5feEUj5GYXM98vWELVYmRGk2rPMgbKiSDQLyGlrkGR/2iXw1+cyXkBWuUKYOUiz2h
         kz76ovpOlJFm4I1tJ+OTTCul4aoSr3sybec4CUy/1CoLf3F+NV7vZaSyBhDQVjD1QTNI
         SoSv+0flTojZQPqap1O9PNcGOENFdTPGf/rrCO7UVJe8McwI3HDwwo/0d4Ixi817OiuY
         jMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782802684; x=1783407484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B0BtFT/DLMwlAC+IMAnaYdEaIQ9JUWZrSmMLsMhq+s0=;
        b=Mm8BH3e2LEDqjAE7DuIvJVLMuU/bZ23a9dz8UeumPlmpPtNqKDQ9BNiLllHKEaUiT7
         OFoBgkfjUf78Z7fD2h3cKo+X5df4z5rttId9fBO4thZ+4JkzNv0QIdfiAoq3QPWkWvxr
         vzJRngcVXCFd4+TLd5oIkKX4RAU0o3xX1QVu88bETnuvfODPGhziYmblH09+I7rO4H41
         lDL7uVAyfkNXSMijMWN2YtJK/5KrsAM7yt6bM1TutTccnEYu/MkTzXS9T9wbCygZaPu3
         B0NHHTYiO89oskOdP0n7NuQw+A/3oTETFh5KRxQgQix25xBugnuIE+oDFdxKdgJpZVpX
         paiw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+yIstEVwPhJGsRbLWuKb7u+dZdqaJoh5T+k7Z4KfQq4knf/OVPvYWfNccAcRqOE862M62CjI=@lists.linux.dev
X-Gm-Message-State: AOJu0YyUmGUOjzti+tBttPlmRhHsvqNlyIXN1zBH8IyJVjXQF6Mk8KcI
	t9j557wdVp2Qhq9ZoYk8Ln6Vdl6OwsQpqG5jdZH43Dfck+DeKQEykVai
X-Gm-Gg: AfdE7cltQJ+g7JhT2kLgOgqn7qx/2HwYlN3wAbSP7COAFxNa3xSXv92uK+jOT7Aqg6i
	Curkcue+k90U+Q0Bl0/qSGfDHIKNinMzEkBLoT7sMz8KD68NTOSc7HFAFcz+BlbLH/5nIgjqbYG
	qKjUgx7YGJEHCW5sBCLVc1zmMvONdKZWdD7BOHA8zzByKZUAiEChKBzaosjVLkMkpMkz2mtyrDf
	yt6IQNeZl8pspjJsl9zWTl9wqWcj+HrV1w7M6WkWZpftZMYcTZHlnb+qM5a8cScd78soxa2wcUq
	BctnMisppKW7v0CkbZM1gS/6Ib57a7mQHN0Q4ZspB/2CFNtS0d6h60UI/gS0ulLvfdd89vH50Ir
	z7aKcKOF2ExyZbB4TH100wuYOh83BiA/IH17r1lSwyQ5yNCN0aTZqDA2XvMn80sZQylo0TT4W31
	y5p6g9WBw=
X-Received: by 2002:a05:6000:8e:b0:45d:3aa3:7f76 with SMTP id ffacd0b85a97d-47552a67d8bmr2211230f8f.33.1782802684104;
        Mon, 29 Jun 2026 23:58:04 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm4570949f8f.19.2026.06.29.23.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:58:03 -0700 (PDT)
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
Date: Tue, 30 Jun 2026 08:57:35 +0200
Message-ID: <20260630065735.3341614-6-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630065735.3341614-1-pawlik.dan@gmail.com>
References: <20260630065735.3341614-1-pawlik.dan@gmail.com>
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

