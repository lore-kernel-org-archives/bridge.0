Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397D21E094
	for <bridge@lists.linux.dev>; Tue,  4 Feb 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698607; cv=none; b=EWpv6YYKXnWE2mKyVohXeHuhyeiqYXHOm+3DahOhedMfyeP0g/Z1v+YfDNvLiSxYoypTfcqH/47QJEkHDtyy4kBdKxdmTw/lITKpMlpvEUC/+TXtbJJrKpgQnkEPGI9WwcT/kPibS69kDHk9jhHVtZ8F06yDffvyd3BhiQKcHtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698607; c=relaxed/simple;
	bh=Xf5mlATXYp8EYoXU9a3w+XGI157o2p4WZAmB5ikh7tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ke9VvoR/8DlYm4xSUNvMPTbliMFkJV77u82RpnbcVLwlgwOsoQGDs5/gMzjtynXgigYpRhprWQwkzQ9Mlt40NNJPtogrBSOFeCDryqMJHCTmw00ePxlM7ek86YAyt1BklhxfH+0Zt3Ooahqt7peOF4d/jYDMBa6x16TcNYkq88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq9XDtlc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq9XDtlc"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a4f1so1805487a12.2
        for <bridge@lists.linux.dev>; Tue, 04 Feb 2025 11:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698604; x=1739303404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNvAyhAv6GepxNEYkCskllQBVi38mrCeZ4SsbbR7WSY=;
        b=Aq9XDtlc6/LgqgtnYYL/BCHFAPMpFgmywpVtXIl0zXY9WPqpd26HIkdk7I0Q4sqvyo
         JGB5j/jg/vn+qzbNrL4Ci+1uI09oiZD2f6i7DtoQUbk27qZ2jrIfCbPNU1cvi69JcAq+
         VuGmQUDr/7Ydkj1pJzjTh+7A8k6fMWwuOnx3XbbYvchwAKUJ10FtCiOARxodpbiJZATx
         yW9YEUCShEnniNURJYDlOKo8NdhQ+p7HFCE+aeIFQ+K4fdhMpuA4KLf3Ki84fCSyiDcG
         Cok/pPe/LgTqlaZE2PEH/7vwZhdC8ioztXV5OwUV5xGJojh5Z40Nk8GDIn7dSmLBhSEx
         uL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698604; x=1739303404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNvAyhAv6GepxNEYkCskllQBVi38mrCeZ4SsbbR7WSY=;
        b=pRrWTutlSMUHUnq36jptkXd52LLrRWkdcyi4J/kr9me/iauA2KIE+zRsTmCvz9ACil
         Yu38jAeIerqqIUGl7PNvrF3zAJSNaCtj58jdfCwUP74OeefIgQ0z2zf5jwnZFw8Y2Mj0
         JcUo1KFp0fSRCrQS7qbU2A5vK6/3UJBtqGRo6y1V47DlI+7iwsxewnbRTytiECjTiyzA
         qG0XQb3WZ1piZ5fMujBoA/ppjQyCTfCupgSf5A4uEorOTQSPgKsgu6TeOW/SuSaLLRpU
         jMT6oaZw5q4eJ1OfzJ8vAZS4e/bzFgT5WG+P/Cj/b2p2KEnXBEqJ+vJAHOWzOksO/T83
         1egQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZeE5X2m5JU+lVszyWX81WQQ8YoEFnau+vfsZRdTEoGUTlMKDWNL/GXb+kadbyYtUhjzv9Hhc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5jJpSJ+GOrooJAN8T39z64on4LN00i1ZYbIgMyWAS/nEKp/B4
	Pg4Z3wlUOL7MUnx5SnbgvmO2YOFXJRCZ5SnruVhzKrJwajJFE55E
X-Gm-Gg: ASbGnct/loZKoVTclSarMbiY53S/QY9S7K8AcQMEzXra7ifmmYDFP21n9mM47ZGcovo
	Y9cntEzzwcbUIs7uheN7C1l9/B4/ypCkqIL4ItRKZoJUU3b3oZIGcrH5NRVuf/s92faHAjIkVkj
	gs3inWt0E0FSl0E5Zb/0xmnUYsesOCksF5S5ZBSu/YAgB8cvdQeeciBpUAbfL9/E1yyMz9STg1j
	B1odA+2g6ubMVLfGjyBEYuXYmHZcErlSzyKfOeSnSlIMy649LypxMgLFEnokXv9iiuFQu1382Fn
	zUoe9rDAqcAeDW0omD+vwpZuIszatBk2lqqurjG5mc2/UUSEQPXoiSL8I+aKSg0vDvz4TLaiAd4
	5gbR57r5M4zRQF091UhSKEV79F5iVBdcX
X-Google-Smtp-Source: AGHT+IF3Pc3NKrXdQnXqPQwcc/aC4MWpA9WJONMBdLCJSxY43xKupXfl7aBElhm4x8MYzyDeLkdj+A==
X-Received: by 2002:a17:907:3f20:b0:ab6:dc00:e2e8 with SMTP id a640c23a62f3a-ab6dc010668mr2925881766b.3.1738698603538;
        Tue, 04 Feb 2025 11:50:03 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5635bsm964684466b.164.2025.02.04.11.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:50:03 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH v5 net-next 10/14] netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to nft_dev_path_info()
Date: Tue,  4 Feb 2025 20:49:17 +0100
Message-ID: <20250204194921.46692-11-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204194921.46692-1-ericwouds@gmail.com>
References: <20250204194921.46692-1-ericwouds@gmail.com>
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

