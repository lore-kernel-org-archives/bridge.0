Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4C6191F6C
	for <bridge@lists.linux.dev>; Sun,  9 Feb 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099462; cv=none; b=Mg910v8OqwSofN8jg04Vk53nGneScf+gYc9TECiEv/RO4hREsoVdyyBN/3WyTWNW48JKp5pYLlMWH3DnVFC+HyDk8OFmlGaRFO/vA6RZxeR41mQC5Hbj/fVeMHIyziH86l0tTx4Nv8K3Qk+tHgRCSRj9MAhQ1BAEznzYDDI8w68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099462; c=relaxed/simple;
	bh=Xf5mlATXYp8EYoXU9a3w+XGI157o2p4WZAmB5ikh7tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kowjlcJp7MVvonSDdQXsc92wY7Zb3RadgsKp0OK6ARZiHUot/y0mmLA0IiTToChWeJqWRSQVQ9xHO7OGrXaGJcjWzWysjeF1brzzgP5K0/SjmoHAQIgh16Vt1NqYTLKqDS3dlpSpNbqwQPlLuskHcWesMCkdhFUhoGD+fpaUhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW7LcaEq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW7LcaEq"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso8783564a12.0
        for <bridge@lists.linux.dev>; Sun, 09 Feb 2025 03:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099459; x=1739704259; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNvAyhAv6GepxNEYkCskllQBVi38mrCeZ4SsbbR7WSY=;
        b=SW7LcaEqcfP0ibkqDvUZ9SVGe5taR981mdEkh9DlUi+SyEr2RRiSsCV1Z727MKxrg/
         HyDYQxU+qCQiF5Q8QsdE+pnighxa5UNIXWnJ/TEm/HR6qs4SELbZD8Co1dAUGXqP8WL8
         jx3AO3UbcKYxLbR5PjMUSVjZLgzYazprXK0uI47ZQl5fxTi9x22BwU3aMtx9vkmcXeK1
         iDkqald0z1AIMvEENF+jIOQnU5z9zg9CjiU4XkGOyLop1gwK24mh9wauU8DxlFMDgEtI
         KlFbjIK3WbdR9lLaPwHOFXyWB+5KXSNIQEQwPvrZ0fzLzsEzQ8Ze7NQ5EPXlgiWfqehS
         b3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099459; x=1739704259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNvAyhAv6GepxNEYkCskllQBVi38mrCeZ4SsbbR7WSY=;
        b=gbpr3qVZYPM57opDMw5vYBpQxbekSo7KE5VfHlXn79o61ShmqppLg1/9oywPbNN8vK
         9i1998RxjxU/3tGyBZVubbWgT5eXbILh6Nh3+bybbSQDl4ParpdFgfJ5lSpRYGCpZKD1
         t8uL2Sdc6yNBQgJHDPvxGsXk49iimKI9gufN2BIBjBSMoJqbMtjcYfqD7Jtvrc1CnqBh
         kWICvgSG3jbpL8wsFrBsarZrKCNn0rw4Ds89tTLtZ9sL/SPd5JRuRSyVw+OcQiH4bLM+
         bLhjXEKVhbwK1Ja1AajsVpq+1M3rRh2x+K4iCOYP7gckLeghCyPrig6bHPRw753tLoc7
         dAig==
X-Forwarded-Encrypted: i=1; AJvYcCXpfFoDkihT5bJ9U+QzBfWatg/AaibCaz2Kseo+JR1dvB38+DeYX0F2A2JXTgT9BXRI5YLfQtY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxDBgSwen3BRG6h21KXY8gZizDLUgVGC+jYU4JeV6xVogET8KAl
	5E7D3hC0h4V/iryTGahDhoyiRMxrYBsnwJpF1i6t7xICPe5logXe
X-Gm-Gg: ASbGncuGW0ydMQsncZcxA3HXGRl6oxjlsj+HHK3YQMEBAqH+OTHzuCVe497hnLTmh/G
	behMH7ZwOAHNSGy/NzQ3A1KLOl3JWYI9MqkslmkUwT02okJ6PgwW4JLVzpy5LlvtUnOKmR064K0
	qV1FUELHeGN2DsLxuLddAHYOLln0FGQiX6AeBrfzMBGphdsOcA9WzmyMs1ygfWSmoX6e5rKLR0P
	CCkfb4S3NemZeIrFIjExUTUo1yks8mk2j82Tq+rcrvVJhJKXlYK9JRIsJOiN9LjH3fimDWV9/d1
	E5OXEo8iETDRYUzU40rYtNFExcqyh7yXQqYzJybYLGPuc7j+wYB2YWl+z1OHlnh7DT0MsSl1G9D
	7g0hqFHmOda64Wgr4RcmdvG0Yx47ND7Sx
X-Google-Smtp-Source: AGHT+IFJaFbx7ete5KJozyvNC8/oWulX5RI94rWh7h2VsoTHF0Lp2lI///kU0TTT1M4WqEm7capUsA==
X-Received: by 2002:a17:907:9719:b0:ab2:f255:59f5 with SMTP id a640c23a62f3a-ab789b4a40dmr1114278166b.16.1739099459229;
        Sun, 09 Feb 2025 03:10:59 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79afc7452sm357516366b.163.2025.02.09.03.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:10:58 -0800 (PST)
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
	Kuniyuki Iwashima <kuniyu@amazon.com>,
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
Subject: [PATCH v6 net-next 10/14] netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to nft_dev_path_info()
Date: Sun,  9 Feb 2025 12:10:30 +0100
Message-ID: <20250209111034.241571-11-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209111034.241571-1-ericwouds@gmail.com>
References: <20250209111034.241571-1-ericwouds@gmail.com>
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

