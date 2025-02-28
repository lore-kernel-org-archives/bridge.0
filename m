Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347927E1CC
	for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773795; cv=none; b=kliupyuz5wWuGfRwLLaZ+KPJYQYDqUAWHDgu8clxOJtcqDoN8M9ZzUS3+gmhjuBU4bJf92+jHchXRlP2IiLMg099FG3fIbajaR+w5WCYQYW0/unNVAS7C5DQ5nth3sCN1PNCetnl+xumBpr3/2xKW1pZjXUJkPgpX/PQeXFHdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773795; c=relaxed/simple;
	bh=Xf5mlATXYp8EYoXU9a3w+XGI157o2p4WZAmB5ikh7tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRzRmWR/k3azNAgq+O8UjTSoXgz09p8g7xoh1stBAKqAwJp18RiuXm249LzUZGOtta0yNAb+wBUcJ4HjpZ71CUkaileN3z4HMiUW7mK59kLEXFjfjVNeRMsoV6vLoukjETYs2iJQ8tDZtPSdzR37fNhKj/ipgsHDFWOZYGm/XtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdQEJRw0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdQEJRw0"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso3768948a12.0
        for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 12:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740773792; x=1741378592; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNvAyhAv6GepxNEYkCskllQBVi38mrCeZ4SsbbR7WSY=;
        b=OdQEJRw0hUhRf5mQlBFmPXH20m1D3LXEPi59SJF7tSJpNDtnY9+2HKwxM1tUwZrYwE
         QfM9xiB+ybIy27hDD0xpgyff32aG5GLdc9DGH1lLOLKEQGNfmolMzNjtCewAWXyVNBLx
         GzygzcuLadMGrwRziXYfSiuNeUfHl0TnbzxhM0OqBsuCPhbWiDAcqGDDZfCmMFOiqkWX
         1n3j/m9kidMo62O/fS4hiltaS8fPnD6HCME40iWUvX/X2NHTk5UTD15Y/mx1q3cYVIZn
         PIOLwmYX1EEUoqXSml5AHfLdGvwcbm5nDvD1cwkWh5wrI3wdPs0aBQEgCee9MnNFsYfZ
         yyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773792; x=1741378592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNvAyhAv6GepxNEYkCskllQBVi38mrCeZ4SsbbR7WSY=;
        b=u5KH7shC42op2FQdsUAmm8Bms95gmOJAwHw1t8mD0SYHchX7tZ0wFYoCbDmL5Oy7z2
         SdiynAglggh/PUScRJnInqc4dhTNafRgl+bUiHV2psWN8XEbx1+GN12ffrDZcF6jKr6K
         aX9uBypNw1DF8izTrRli6QmqOueoAZfCq9TT5RPu0tVTCVegCZsRvYiCOoZt2E7rJ0Zs
         g2rvOz1tzAiCDCglQvyx8ZgpkLqp+e6ndSvu/QujufJy7JfABjkTacQfEy1eliIJfLsA
         fgvAHNmv7KftVnn0M4sYp0o59Ds3PUJ3bYoks1NxKlIimeGk7+jWhDuboksWdpHzeQZ9
         CJjg==
X-Forwarded-Encrypted: i=1; AJvYcCXBD8O4/zc5QgP59kY2oqhE8OzvMKKss6lpN757+GITY5xSJX6twcHrXEH7x8We2Vdndkciiys=@lists.linux.dev
X-Gm-Message-State: AOJu0YzfQJP3XTf7dj7G1fCQCVk8yJ9TbmQBwbygSuDcY9mQGp8aunzt
	pi0bl/78eJLqGL+o20H2yUWonz1jq9n50m1+LuRcXMbpMX6BtCk3
X-Gm-Gg: ASbGnctSH77Sx//x0LCi2oTFjSjWmO9oH/cHbi7kmLFNHtpI4Wv1AMWoLvMGuDa97e7
	gXzhVI9P/rAx8dC+szeSBbBvB+T1lHJngS2bVzEJvjpfwCQokyu8ZWE6rUZ0JBN2EPo24Y3CMfk
	5s3wWL/FSvDAM143WbnJOieO9/EhEIL7jRBvNk5DQVi6m0Vg9CbTGV6Jngr0Hw673WcEOExTbgN
	Uq91Zti8sU0GdBkMXeABkZS1MQFv8747i5A1H9D0rhkZf1Hsp4lwH4TnFEzqqlVmMcf4fMLFdNC
	C93S8Y23ax99WeJU1jsfLngyDsSAThO5CXMKUxfM4HvhZRL+Ynd4wfjh2p2odLlHR0oB2PMckUW
	tPblRU7okfEfLPpjzGPPw/w6pvspivhu0iTanhkpNXdY=
X-Google-Smtp-Source: AGHT+IGNTRuqBcd8nLuNsVuXSGF1sIcXELw3HlP5Nzemzcrdv1EtIzMkCBIzwqYM1NbqtT6g+Vprpw==
X-Received: by 2002:a17:907:9484:b0:abb:b136:a402 with SMTP id a640c23a62f3a-abf26424829mr486626566b.18.1740773792060;
        Fri, 28 Feb 2025 12:16:32 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm340812666b.136.2025.02.28.12.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:16:31 -0800 (PST)
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
Subject: [PATCH v8 net-next 11/15] netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to nft_dev_path_info()
Date: Fri, 28 Feb 2025 21:15:29 +0100
Message-ID: <20250228201533.23836-12-ericwouds@gmail.com>
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

In case of using mediatek wireless, in nft_dev_fill_forward_path(), the
forward path is filled, ending with mediatek wlan1.

Because DEV_PATH_MTK_WDMA is unknown inside nft_dev_path_info() it returns
with info.indev = NULL. Then nft_dev_forward_path() returns without
setting the direct transmit parameters.

This results in a neighbor transmit, and direct transmit not possible.
But we want to use it for flow between bridged interfaces.

So this patch adds DEV_PATH_MTK_WDMA to nft_dev_path_info() and makes
direct transmission possible.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 323c531c7046..b9e6d9e6df66 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -105,6 +105,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 		switch (path->type) {
 		case DEV_PATH_ETHERNET:
 		case DEV_PATH_DSA:
+		case DEV_PATH_MTK_WDMA:
 		case DEV_PATH_VLAN:
 		case DEV_PATH_PPPOE:
 			info->indev = path->dev;
@@ -117,6 +118,10 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 				i = stack->num_paths;
 				break;
 			}
+			if (path->type == DEV_PATH_MTK_WDMA) {
+				i = stack->num_paths;
+				break;
+			}
 
 			/* DEV_PATH_VLAN and DEV_PATH_PPPOE */
 			if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
-- 
2.47.1

