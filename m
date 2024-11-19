Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F741CB312
	for <bridge@lists.linux.dev>; Tue, 19 Nov 2024 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011576; cv=none; b=VBRji0Smak+OfjQQb0SDaMQOCP/Ur/2PVhUhqGiMXy0+fLAUweFZMSZ72/z3RAmwTdKsmf3GOgqE2ulEFFkrPTdoHpGGt/IX5icAKcov5ZMY0hnJ9NBGugVssumAVpPp/ejtOz2x2Ax3B1HQTAdNexgvGVJ5cUGDKDxinYaaypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011576; c=relaxed/simple;
	bh=GNLJPUhMBWyFF5GnV1Oixa6YaHBEl+LkKP7TDsLQLcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5mL/NRAmZrnq4eZD6eVDlqyqGdzF11oZPWtvouzKZ5cLT7IdYLzKpPR15t70BwU+NwHk87dy2V2TQS8AFAz6wyx/yGtKlAuK1gR0vJ8hPpcefoqCxxlwWMRfMl5Tr4lrxy36pQVwo9uH5ljLplr8gVoRgtsLrB713YNWLrlshE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/oUQNpD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/oUQNpD"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a68480164so104401666b.3
        for <bridge@lists.linux.dev>; Tue, 19 Nov 2024 02:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732011573; x=1732616373; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kd7MVftOQ+4b1SqBzhiH//oS0+6ChrCs4gWAypG7zyc=;
        b=l/oUQNpDOJr/utXlrRPszbD+ccpSVY4rYpS6k+EzCBVFJ2m9N4y4z5hi7E0a3TVFP6
         loUn0vWofettXq2+a2vnZ+ZbwanXq+q5CpPimXuRJCsrcHeH//bo7c9tQM5H4eKD9pIs
         gld3ZyeaIoeME5hm2kiHNexNQkgFuOxXnK0x4/qNt/H/OqHDaJyLqIb41LLfJeHheLKn
         V6BTmKS7dvJcbIRidInufb4L54YNRLeXMxGMJjIB+MwtyxoaV1fFuwf/zLcOfBaZQ+la
         +1hu+RcQ6yMgyF8UsXy2DkgqT+1HKQqXVbWB9FbJlToIUxENMLLqcdKUZ7ZqG3dUwSRW
         tjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011573; x=1732616373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kd7MVftOQ+4b1SqBzhiH//oS0+6ChrCs4gWAypG7zyc=;
        b=m2LXnAT8boTIb5a/NZmGBnrSS9YP19CQsKhgQrepkFjY8jQNNZu6lUqrR7v0BmsCk0
         hqeCT0OOZO5O0tIyhZcKUdbuVxJ5Y212hBf6eOTg83hFFJ1B6w5onPk5oWigDi9SkvZK
         7jV5OTWjWrE6dY4DGadwTMNbpzsL9vMkzdiiLqJHu++cqa5jMb1XbyxbaHZttMaR8onB
         r4U9F+Z0r1OAT+Zrp/xCPFNb2SmZd6r2ZMPh8U5z4S+sPgU3SJvcgFHwZDUItGq0pYPO
         eySMdt7gcZ3UfmTQ2vfk7DA9o1TSxfRd/N3DpDHNTIyUsaoAc1R7M7lRqZHbGCLmk3Xw
         oLtg==
X-Forwarded-Encrypted: i=1; AJvYcCVBzU+zFC56luuezMDx2R01mSRWecynusDU6ZNYfJ3ZMQOFviryfBsE9P1t0uMjg3AAQPF6ZeU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxbzKUXUrzUKnJJ7/oiLC15lHCbQ87a2SVXq/7/qcMFTvaN2+1D
	HtetUjjZHBQB4CbPdsTbIFlnPd84MubuT/X3hlEsKHh4GRuvZ8Fy
X-Google-Smtp-Source: AGHT+IF5+KL0F1ms3SncUyr2N9wLbMEErdK4tEsHN/IWbmagzPDJ/Hm22ZABIXpU1FMVLbP7YJ4tcw==
X-Received: by 2002:a17:907:a0e:b0:a9a:4d1:c628 with SMTP id a640c23a62f3a-aa48352c0f5mr1451198666b.45.1732011572868;
        Tue, 19 Nov 2024 02:19:32 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e081574sm634875566b.179.2024.11.19.02.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:19:32 -0800 (PST)
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
Subject: [PATCH RFC v2 net-next 11/14] netfilter: nft_flow_offload: No ingress_vlan forward info for dsa user port
Date: Tue, 19 Nov 2024 11:19:03 +0100
Message-ID: <20241119101906.862680-12-ericwouds@gmail.com>
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

The bitfield info->ingress_vlans and correcponding vlan encap are used for
a switchdev user port. However, they should not be set for a dsa user port.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index f7c2692ff3f2..387e5574c31f 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -117,6 +117,11 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 				break;
 			if (path->type == DEV_PATH_DSA) {
 				i = stack->num_paths;
+				if (!info->num_encaps ||
+				    !(info->ingress_vlans & BIT(info->num_encaps - 1)))
+					break;
+				info->num_encaps--;
+				info->ingress_vlans &= ~BIT(info->num_encaps - 1);
 				break;
 			}
 			if (path->type == DEV_PATH_MTK_WDMA) {
-- 
2.45.2

