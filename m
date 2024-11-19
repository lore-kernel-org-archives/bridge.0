Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6851C3F01
	for <bridge@lists.linux.dev>; Tue, 19 Nov 2024 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011566; cv=none; b=GTQUk2nBhoG6dZhurSIS4O97NR/pyUr9Qj1RP5Wzt7TZBwBoY1l6p+a5+IEZ2q9vJK42HlFcuC3dCVw2hwdxMsusOP6SwqE5oQ56e6H15HvUpFsOp+KqH+UCYrQvzLr/Oqe39Gx7FllR6E7nCnbVxukYkSyoUkC+bH2WVrU80Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011566; c=relaxed/simple;
	bh=poTP47yQdf4khdC+9ijtITarQAaptxBJXapnWT/Y6lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dscHgIAfBgr3ufql3gvMvVl8abUXh2EV79uk1ywJOw2ofpjL1BFE/Mlfciu/6hwDtEo1eg+RFmiFRazfRvZaScmAsin9tjG7HqfmbhS0o0vLqd20MNa05ya2ZHMr34sKVdrhyFWbKOhYIGY6Ne90FhJ+YP2l9tUR2ka7ghJJD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnLpdzXu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnLpdzXu"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso112719466b.1
        for <bridge@lists.linux.dev>; Tue, 19 Nov 2024 02:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732011563; x=1732616363; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi0AlNa47OjnLX+zdNkH8pnYspHiUC9rPn7VlkLtCao=;
        b=SnLpdzXuYuRi0YpiUswJjtL6IP7PO0hq54ASEG/FcTkaPHZ1v7lGyF+3FmogK6ifmB
         7Go4J54Re3Zntl1wdliOczJRavhWN8kSTDG6gk3VhMAJ1SytkWlkuTdG1q2/XwFZ6xcz
         v6g5ABNJtEJ7rjnmMhk+vSAFRYZTOERdt1QRDuZ/2d7EoDtnkD3olSBVdXap5dpoKmDq
         hzzemrcoZfCa2qZJkYQQj7olQnCiEnLB/hv5l8PLZL98kjLtkJuTy1IADwF72rfhslGa
         zpP0jnaRJgrOddA3eCe+2hUAE+7FLzIeeWdiZKZHWAqLsM5Oj34RdJ457rMk1u6PbuTZ
         eh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011563; x=1732616363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi0AlNa47OjnLX+zdNkH8pnYspHiUC9rPn7VlkLtCao=;
        b=v4bQEef5f+7gFh9pDhFKLoLEmE2JxH78D/NWMIeBSDpJuffmzaDF8jVK0tuESk9cDk
         5K37AtAgJGpMdBYGwol94I10PUA4IsP7bFlfgbsQtUyp6qwTv6YtwdInc3U3PP7DhOrN
         tIv2j497cwIQGT/u0tue3puXky7CU1HLMsyFaZ6DPoNOxQCH3DoUUIHeb3pwC7Q2m+ce
         XXRJHL38e0QqBlIj0s4hN4dlS00hLRRwmyi4WIBMVcSNxus8JHy/SU74mQL1AZMc17Ys
         c2t1H4iBXDDLHR/vMHEtHtMbJE33AQBAddxFq/Jc8bJAHBLtvHvkSFekiTK6IsCeWkNN
         i3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXoY9Nhk38DLlkeYcMRaMIdqm9jHgWnB9hFuORb3ee8D+FsPNaDCQW2m1If9PqKAwCDII7oLCs=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywd88lhRHCb7WHlONqaC8wCUBtAa68SBWXCHvzk3iGnS6k6qjIx
	+Z/n8viXk0dV2YeK9RmV3QfJIJ4b96M3PSFyDsSCh0Ii26HsLVWw
X-Google-Smtp-Source: AGHT+IFgtvvx9QxVfYb+i/eHHWDw6v24GqRwyxuBvltZN8tRLFnZjBJN+NHnVp7SFNVLDR7NZlEVpg==
X-Received: by 2002:a17:907:96ab:b0:a99:ec3c:15cd with SMTP id a640c23a62f3a-aa483552e2amr1511647266b.54.1732011562657;
        Tue, 19 Nov 2024 02:19:22 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e081574sm634875566b.179.2024.11.19.02.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:19:22 -0800 (PST)
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
Subject: [PATCH RFC v2 net-next 03/14] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Tue, 19 Nov 2024 11:18:55 +0100
Message-ID: <20241119101906.862680-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119101906.862680-1-ericwouds@gmail.com>
References: <20241119101906.862680-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the capability to evaluate 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets in the bridge filter chain.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_chain_filter.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 7010541fcca6..91aa3fa43d31 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -232,11 +232,27 @@ nft_do_chain_bridge(void *priv,
 		    struct sk_buff *skb,
 		    const struct nf_hook_state *state)
 {
+	struct ethhdr *ethh = eth_hdr(skb);
 	struct nft_pktinfo pkt;
+	int thoff;
 
 	nft_set_pktinfo(&pkt, skb, state);
 
-	switch (eth_hdr(skb)->h_proto) {
+	switch (ethh->h_proto) {
+	case htons(ETH_P_PPP_SES):
+		thoff = PPPOE_SES_HLEN;
+		ethh += thoff;
+		break;
+	case htons(ETH_P_8021Q):
+		thoff = VLAN_HLEN;
+		ethh += thoff;
+		break;
+	default:
+		thoff = 0;
+		break;
+	}
+
+	switch (ethh->h_proto) {
 	case htons(ETH_P_IP):
 		nft_set_pktinfo_ipv4_validate(&pkt);
 		break;
@@ -248,6 +264,8 @@ nft_do_chain_bridge(void *priv,
 		break;
 	}
 
+	pkt.thoff += thoff;
+
 	return nft_do_chain(&pkt, priv);
 }
 
-- 
2.45.2

