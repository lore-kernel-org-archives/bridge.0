Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D4819F127
	for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068926; cv=none; b=cIj9HkoMBvzO0KYA7NBTFGhWs8+gWPNJ2CCugNdtwa4aQWots3QdJM5Ty1BJ3eaBnGvjKrFM2icyZwWAJXSjhK1lGGy2veAYSb6hdt4C9zqSh3BsaqEAGiNonSvqpQxMfTfS1QZ2FMjaMnqzkATca8O+nuUdXGjp0H6YLSLw7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068926; c=relaxed/simple;
	bh=kNP8x/IMGQOh3Wqh+fa0471RIWgjq6Z4id3flj79pJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFczNdl9DBLYgc4XBlt1OwhiCgGFpdGmVR48uwPsNrSGWdZcO6DcGdIPNBLnyZ/IU5QWCSDPf7/W5BTppIYX7dhUNhswWzOLSlI/0aR5ACOWMUrw5xIj1cbEb91ohuw47d3I/8H0RmxbkBoNa5LxrC7vb53J8Do/cejh7eJTeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6P8NpVf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6P8NpVf"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac29af3382dso528517366b.2
        for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742068923; x=1742673723; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpqiiXZms0JGOtrihsd57qCqRp7MjUMv4uKgIUJzlhQ=;
        b=F6P8NpVfg6bNT3Ny6AmR58QB8x9xoyMyW/UIxSYcWm5ZbcsrlqZ7GgzufueJi5rdbC
         MBBbtXCh9TN0rkWo+XUJW1/5K8FzxpTjnbT39iP/wCkT/Mt2tv492qX94AMau298Wj1j
         5HgZNz3VzZa6S5XmusLcO0NX6t+3ieJKq3j77fJIoc/WmENbWUN9xgj9KEEhh4xsns4G
         7ITkdjbQMjE6RhhkxHO38lvWa23WAAXAcWJjbNCorjKkyjDPU5cbDfHpJBmW1J9Kdx8H
         GVRfUbp8xCt3NXF6GYISss01qSm5P1sUL0K2jt0uivduIH9e+UtYBByROSi3jmLnxaHU
         AmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742068923; x=1742673723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpqiiXZms0JGOtrihsd57qCqRp7MjUMv4uKgIUJzlhQ=;
        b=oQymj13W+fwyvmz0Mwi4HmEgZVq85lZnfDqJ7FyS7gOXrqwZmRc/9Xz/1IC/I3L/8o
         kM/+tlzFJcBr3uUrOJ3sEqTickFcLg4XVEMoEWDIenW+xaOlrOzohP0f127lbdkhZ3tV
         ZQyVTZF4YFG+s8qrxmko/vI4dpAA4x90RxotzcHinfDwxNBSxlmUH+DYB6Hherspxcj4
         xXqWOac1kD8UvdQM2ll6GaqbFyfn8xryVxrqr7bAyk9301XfvPXcMpa/ezagX+zoFvKk
         mbhNSUFtHAHVsYsBjssvDF/jV86YqvCvZs5NqB/R5kyT8zjxyUAT8Qiiryf+Wnb5sWR5
         yndw==
X-Forwarded-Encrypted: i=1; AJvYcCWj7dfQz6feYyZFiT/zrb1IYMRmDF5+t9wfh8hTGrJVTZAFgQMrWFz8Ejp1Ma0YIy4U+rWj2xQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzWHLsOYomDqtsGWtmO6WcCDgRMjPEMd3CeVnolC0EefSI3hodb
	G1kwgMszMTzOivClL82oHSpktCXbPQZmdHYBc5G0UYrrownZez9l
X-Gm-Gg: ASbGncucc2nCU61N1iK07MtAqjvBiDMiHvQwjfHmod9anUToqeDX6FYqGNAFfHYp3fs
	H5Q0L68A1AwiuwE9523gHOPoJjHolvf5RAeAergvzSP2QtS9q/tLmD/PdBMLS2ZAuzCGK+d3TLt
	10+qR7ZQK602nz/hRXvTSwHeZ3SH+96SqdT6zwsP9gFnBGDe6xiaVPGBVnt3S7qGmjFjBoPuIxf
	JxWVp0a0Ra+qCPoyQBfP2Q8/B0XDm2TXqwnVsfQhh97nsC+kXa0pw3WdkBFGoCTtJKe+Kcf0HEI
	oN3DReBfqK1aYAdycc/gSVyVk1GiFjH5Ed6pQeZQyvKqllyIEcMQ61tv6B2UU9WmMx18uf9OBaO
	+tH12MrcbArbxXcPNgJRGB+KsKAtyls6B4aubprQopoKadzA5p3kiVMDyTwpC6jw=
X-Google-Smtp-Source: AGHT+IHCa55+wjBQiSxD140JEHodCQYGe9wVqqYoJF9zBcrAQwDR+1enIfiBTks5BKAmzlgfv6jNXQ==
X-Received: by 2002:a17:907:6ea9:b0:ac2:c26:5608 with SMTP id a640c23a62f3a-ac3301e0b40mr826573566b.8.1742068922394;
        Sat, 15 Mar 2025 13:02:02 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a489c9sm411456766b.152.2025.03.15.13.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:02:01 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v10 nf-next 1/3] netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to nft_dev_path_info()
Date: Sat, 15 Mar 2025 21:01:45 +0100
Message-ID: <20250315200147.18016-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250315200147.18016-1-ericwouds@gmail.com>
References: <20250315200147.18016-1-ericwouds@gmail.com>
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

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index acfdf523bd3b..05786d856530 100644
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

