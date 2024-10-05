Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB55223
	for <bridge@lists.linux.dev>; Sat,  5 Oct 2024 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728092743; cv=none; b=LWruek+hTOAR6KdwwG9rwFG6ZEn7Nf0oYKtIDEgOj7HnlUOFlV/SUZxq5Oiz67+1egvzfC57mQX4ZxHYTOD3Fxc883dg3k/oy2ixgsVvTq1tfH3zDr3FW1J7jpMReV0l5kdRZ4fzPZ5bQye56SCRP1+VDJ+Kwd2i5r97yxZKRv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728092743; c=relaxed/simple;
	bh=fWG1fXg3ZYf7iX4DUU6mCyArA8Rxuz0fZncrjcXHktw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NEyfVIi/SvzPTX1LHccVHAc4ETe6o9KD7A1fF0tcw0Gmd7GIgLRgQJ14rYW4wtG9gFiBwmZFDQfd8z6VqxPmm+PIk7SMRW+OATw8pLtCZ4DGI1hKPfuJJ50NJOx18DuyCfpdW4JqZAOkgH3h2sgQQkwFg0Gzmpg+FriWcO4j5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvlCAoJa; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvlCAoJa"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso1719648a12.0
        for <bridge@lists.linux.dev>; Fri, 04 Oct 2024 18:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728092741; x=1728697541; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eQLjV0HPL7dlV32BWe8r/nHswhCY6g8/wd5k2qXOZT8=;
        b=SvlCAoJamtQqk/H4ReOUiolWN2J/Ap0q5CCdw+pmgafqptOWfWdG/2/Z5C8GRDMcvY
         qki6mBn+xMoFEqtv5VABSYkUjzYF6QqhHGmdccrZrqatJilahHSrt1XiMxwsVwoWGoAM
         FjGplsbH2qyyC2PM2Efd3C6rMZBBoMYzckGIJtXccFoqowIjjJY3PRjEBwO0bnK2p/tP
         ig5/3tJNrvjkmZo/l4dpGfaOrHqKqQ8ESlQyAD1LCVbIPjXs47s7df2xRSHO7S/lOjX6
         /XO7f6450RNg3OlnF97tQfcphyGD09D0z5yJkwlwGVhI/4R64fi3GRG/9BuSZ4u64CB0
         5w1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728092741; x=1728697541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQLjV0HPL7dlV32BWe8r/nHswhCY6g8/wd5k2qXOZT8=;
        b=mTxxVE9hYFXxANPZKTYxmpBISkwXgUE4MJF21XZrB/OwDVHubTo8uhUomTElrrgeBZ
         9GbYiX8cYrzvyckfhcxppizZE8kixBOrAxRLMKye0ThyRltRmY3+7utQvpEuMUozSOyf
         2J1CdbUw5CLRPcFsLR1yKyk0/KLKSbOi+yZuabIxTz/XYyMTttr9hd79BE5cGJk8ublL
         nzYbES5T4TMCAvTKKqaXJwvq3K8J7RXv3lZSblcy0LqJLeFpw8B0YFPlxnjUPlqxO2um
         P6liSgEs61D502byd7ZOF68jkj43Wh/bF0VC64SGrFaNPH7H23esiDXaLj2M1V6T3+R2
         x9bw==
X-Forwarded-Encrypted: i=1; AJvYcCULFB2CYcHj34TxKOQ3OJBq70nwvkIsU8lH1sqfwdDFMi0GROZVBVp028Ly906VvvxcajkC8BA=@lists.linux.dev
X-Gm-Message-State: AOJu0YyeOOw9ea2bU+aqnvgg7LHng71UTIfCEz0Lsp0Ahm8/nPAlv0I0
	O8Bct9vU0k2Fki6U/bKT3pE55/3JdzPFG6H78B2Rsy0vQJC4iU21
X-Google-Smtp-Source: AGHT+IGJsV3Wzf12hiFh9qTy7TwrEkm3ZPpXOQBfy7+FwWwQTYzpJDpgeJfXNnVTdHrULFkeDogufg==
X-Received: by 2002:a05:6a21:670f:b0:1d2:e90a:f847 with SMTP id adf61e73a8af0-1d6dfacac9amr7393998637.37.1728092741414;
        Fri, 04 Oct 2024 18:45:41 -0700 (PDT)
Received: from elite.lan ([2601:645:8800:2e43::abb])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71df0d695cdsm530175b3a.183.2024.10.04.18.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 18:45:40 -0700 (PDT)
From: Amedeo Baragiola <ingamedeo@gmail.com>
To: 
Cc: Amedeo Baragiola <ingamedeo@gmail.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bridge: use promisc arg instead of skb flags
Date: Fri,  4 Oct 2024 18:44:58 -0700
Message-ID: <20241005014514.1541240-1-ingamedeo@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 751de2012eaf ("netfilter: br_netfilter: skip conntrack input hook for promisc packets")
a second argument (promisc) has been added to br_pass_frame_up which
represents whether the interface is in promiscuous mode. However,
internally - in one remaining case - br_pass_frame_up checks the device
flags derived from skb instead of the argument being passed in.
This one-line changes addresses this inconsistency.

Signed-off-by: Amedeo Baragiola <ingamedeo@gmail.com>
---
 net/bridge/br_input.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index ceaa5a89b947..156c18f42fa3 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -50,8 +50,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
 	 * packet is allowed except in promisc mode when someone
 	 * may be running packet capture.
 	 */
-	if (!(brdev->flags & IFF_PROMISC) &&
-	    !br_allowed_egress(vg, skb)) {
+	if (!promisc && !br_allowed_egress(vg, skb)) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
 	}
-- 
2.46.2

