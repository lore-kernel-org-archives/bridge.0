Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127F1EB9F3
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240779; cv=none; b=IAzP0d4B6n4a9vOImtwGwlTkblc4a880GVKomuCiKI5LJD88mKKZ4RnWwZ4X25kyFFE/VVN5y6clQno19mxuxlHGja4dfMwHOac3F1CmkbBoJqhgBVOonxDGycHREmXsz/7ExsjWqKhmJE2XTf9PR89QNHTUiCIdtrcI2x+cHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240779; c=relaxed/simple;
	bh=maNLh6FFLEFZWq9gMrHdXn5flUbXY1gxWqNWlBJHOOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WA1kOZpp6tH4cghR3mYnUYmPFe4KZNTUyRXZzjslrvv0akiS3WNqUk8leFWjuB6OtC8sz7DCfjsMB4rJYI2I0Ts6MENYFpE5cNYWYXny0lzI22kkPYnNFaz4PxXrukKDMfRyz+C6kVrOA2vh5JMmjkc6iJ2+7W1tqkCumNkVtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nirttQ9N; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nirttQ9N"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so27119047a12.0
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 01:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240775; x=1736845575; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtgyJTf0nGEQy8dIgfNuKn9dKl89pMTFI5gYmniF26o=;
        b=nirttQ9NBnVIZDL3ftlisZ7naEgWFf78PJix0WnmnVUddpe1e8vhHEUF5rxJx3SoxD
         3TnFVxhSzGQW65avVUn/T9+ByQcYo8HmGa9q4wVqAMoWTPyJlvLVquSWk13ahITsMDSF
         nMeEbIHRrRo9aEYZJR82a9pAIcEjDf30J4vlb0U55KmXHWR1/E1CPaLdd3MxjEYUlLXB
         VM4nYUqySvNoD/OuWrmtdohLwEqXn/jq9hJGt4GHCPFJC1PM16OL3gUNzf2Sf6UDiAgQ
         SMk1HsfEVPlcOzDY4b69nAZJ/1KERmcXKRVBILyu/uDsYhtbQ+viQy1yf8HY2/Um3R1+
         /UZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240775; x=1736845575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtgyJTf0nGEQy8dIgfNuKn9dKl89pMTFI5gYmniF26o=;
        b=um/UdxjkEo4k9PnmE6Qca4a8ZVO2X4tGG5tEc3asB/ZVo1OdiIH+fM/ycfVJf4IEId
         IuLnx5xLx0Sq+tLaSWpcL8cE21GKpTclDrgtq4TKkm4/NW5nLL8ifK13dzquHAf9jlcA
         /RKnaXt1IV6sj0khC9KNYbtGH5DGGJpKRXyd0JAxKFKfSgTPoMyrktIiay1fOC4smV+7
         4IPGSPjZSLF7OD0C1rL2jMOvzOOklzdGofkmo1vqi7/a5pu1b/iX8tX98yk2MWZAgNwb
         eS2+8q7OsqIJIKfwlHxi8pQX4G+gfvvU8C/cjXLve4zxGF5d/ROur3qtk7qhrJ8IwBaV
         Ne4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgccvgoo300LkPNcOqTViT4qKbW/sNYG4mLp4mwzLFJ4/faFpqYbkx1bfNdHmWTbDFmK3MsHw=@lists.linux.dev
X-Gm-Message-State: AOJu0YzjLs+bf/hCnsj537bjAWV8LVeRoeprpLcWJTXVLsy6ThYNoJsV
	j7hvmdsyea0hfylL0MmlNVM8Mrdp6u13b/u0U/qGHuVORPW3FxCf
X-Gm-Gg: ASbGncvbrRWjEfHCe67YNop0KnCd/H2fNREbuqFgxTF2O+dbOyMLnWIPPq4fZcFnckO
	VXtwM/gFzhjKrACgCndF3OEnTGL71/VeLUbdRTceNdJc9Mb5pENz3Q4t3beaAAyd4rYQau7lEpA
	gGUJqqNSgIJk/j0uZafoAuEr7kQoZM+4ENrEqR2PjuOHnzYdtD/dtEA9p8jo2jAuvg+4+Up2KAa
	MUPwl1QNVHd5eBmX0RBMGZv78Ej/mdwTrNIT1lhWwVAkF3q8ww3+UdhfnHpomwmyCc928OcD/2e
	OmK4xGDLbnJMD+PCukAEdmU9NyPT5P4mZ451gzaZ9CyJxSRSpRx+qi187pbIokzDN8KwIkyxaQ=
	=
X-Google-Smtp-Source: AGHT+IHPxz9+uiCIXoSR9CoE/bJwFf3R4legPNbuUxKWFljvSeICAglSfIzYagTrY05Gf+jTQUtRFg==
X-Received: by 2002:a50:cb8c:0:b0:5d9:a61:e7c9 with SMTP id 4fb4d7f45d1cf-5d90a61e843mr14049402a12.20.1736240774460;
        Tue, 07 Jan 2025 01:06:14 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24005333a12.23.2025.01.07.01.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:14 -0800 (PST)
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
Subject: [PATCH v4 net-next 09/13] netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to nft_dev_path_info()
Date: Tue,  7 Jan 2025 10:05:26 +0100
Message-ID: <20250107090530.5035-10-ericwouds@gmail.com>
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
index cce4c5980ed5..f7c2692ff3f2 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -106,6 +106,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 		switch (path->type) {
 		case DEV_PATH_ETHERNET:
 		case DEV_PATH_DSA:
+		case DEV_PATH_MTK_WDMA:
 		case DEV_PATH_VLAN:
 		case DEV_PATH_PPPOE:
 			info->indev = path->dev;
@@ -118,6 +119,10 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
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

