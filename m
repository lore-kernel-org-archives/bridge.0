Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD68061A
	for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200799; cv=none; b=YFmr3ThXVZDunlrsbid27n/oq03UidlEvIr8RsfzBRv7j/FrhFP5aEOrLKuO1qoSPe5LaFfxucCl4ACAjSd7sk6yzSHoOT5c4kx90iWHQqfjhEAIyYnJkS5y+7WdzZSxwTd/5NA4zkfUQksgZm0ZM11IK6HG4pPcb4daEkqovQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200799; c=relaxed/simple;
	bh=kHvt+/F2ooSfbOrMdtoNwwajc5x4yhIjvXK1NyStQZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pp5xsylMo3yEBYpNK0bnCAMGDxh57TBRe1CXxJnF1nwcSvkA7jIRrZpyGye7CC9mnwzHFJ7GlNCBanlyoFgErcQs7ZOb41AR0Jiy3wONIdlkrw0i1GldZNYKKv8/ByeeFXNAdG+ugqVcW2HXILtAc36F+SOXL7iCBfJFTGkWXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=HEhAtR+8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="HEhAtR+8"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7431e702dso31489425ad.1
        for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 12:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200798; x=1708805598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZG+KoJy6pRblhuWX2/D05oUkUQuIMXhhucrzDvVlYlE=;
        b=v4F9M89TS5hoaGJLflv8iyiEccVl00rg76AE9KQLMPpkXK5gqkEGltCs5voqnF9ZGM
         PuSbqCAmkz/fQZUm45s/b1sueSVyC5XsVOyc0FmFqOYHH6PzZ9oaeohD4+kTY4RCXEI/
         3gUm2uTfJG3J6yxDeADQpUHJHxxQqMdZWcNGYGiPTzsIVGG7LmnNFmVx7tU5k+R9IUlO
         6rm4T8lXYSXgXJA7gO2R44bwflb6lgYnSqHdGDNBWE3nWzGWVyosHPtmRelSjxQt1et1
         JbnIdijaWusd4VzIicZbB11edywEZlH65mdurc7e1tFK7aGomrosk4Cg+Sk23Dus/gj2
         QYtA==
X-Forwarded-Encrypted: i=1; AJvYcCXbjDMr0Gmn7SITQDYhYulWuDoXdX8h3qrQZ1TrIl6vE6jefpqLJE8d7SBlohC62SsOJvqHUokCWZn122okcXCxC5Pd+ISu
X-Gm-Message-State: AOJu0Yzb32dpurJJPNPfXC1yHz/Bd11C5vej1AOKhkEvZnlvBXp2ehQn
	PcTeffgf6b1s8ImOd0VE7AVR5ymFvb8vAG5jDXWUyLN0OLrw1CfoE+yr4F4ImIRijg==
X-Google-Smtp-Source: AGHT+IHzphwhzo8tbYM+p6/gYaVgEbgNvjbGcE2SfbxeY6gbmMUbFR3d1rXGnGH3MrU8MeiaEPDx9g==
X-Received: by 2002:a17:903:8ce:b0:1db:cca9:f751 with SMTP id lk14-20020a17090308ce00b001dbcca9f751mr2001665plb.59.1708200797758;
        Sat, 17 Feb 2024 12:13:17 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001d8d90d4f67sm1790155plt.249.2024.02.17.12.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:13:17 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZG+KoJy6pRblhuWX2/D05oUkUQuIMXhhucrzDvVlYlE=;
	b=HEhAtR+8PZmNDV69ZHRPRlCpP89KCx45OhFTY4TqkLiARuvgTlpESSsVziYD1qMfVfG3tM
	B2BqoyI3dbhlfc+ZkxSsFituOt4W6Lw0KB/o1DoLWws7BxI7n7HyLB6om/Ct+FJjc36cHW
	eTjP6zmvPxTGJEJ3zvJH3qBBuvJXkrxwK3gfeUrLAPjmzQqakhz0B1TIglDV9wN2Xi9Uom
	zQzNjA456XPVCL4VfJ8DS9K6cHOD1eGlPej0oOTQ3TTbrDMIpk/KZfPTcD1cYlMRL8taZc
	cwDkRhDHV006kCAJM/O+YGQgynSjohkcyQvz+CFIo2rzJfLyzGmVeDKHUe0dRQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:29 -0300
Subject: [PATCH 07/12] net: hsr: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-7-1eb31fb689f7@marliere.net>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
In-Reply-To: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
To: Oliver Neukum <oneukum@suse.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev, 
 linux-ppp@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=kHvt+/F2ooSfbOrMdtoNwwajc5x4yhIjvXK1NyStQZI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNtDN00gPnUTOP/lDSwWQ0x7L6llPI5tF29a
 zRgR4kJL/yJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETbQAKCRDJC4p8Y4ZY
 psHPD/wMlaMU/Thwr8IQbr08FD8hI0pzxyseaJ9IXtN7SxFS/0AMKdGSATVJDztXAnhrVg/1rQi
 11sHPZttzf5hgFsRJrY8Pq8i+nIROf2FCeh4s+snINqjyRmtSVrj9HjR2mjBblbJgZwxJCfQjSp
 FfgnnxfRaUZ8hFIxWIzrYcXDQuAUckYIppLFeXdatJhflN0s0ef0p/8A47HMML3WmpMTdWbyudK
 AhVA9rYZOOTsMpzROjj5dQKUzXz2up+TIaRXq+qfxXU4q+EP2idMbxhBLSdzYC7EkFehVmbuoT2
 iCAGiDVhSPh1BVopl+hMiOHRhTjeAehqyvjW3YaUdGeU6LCSk6KgQt6nnbsIantTFz6iTlvVgyw
 rmJSabE0fQWCman7WBcHy1hkIX7d6UfBQmAJa6TWmzsnmyfzTQJuRPWUmAoZtI9L+h2zL7DYq/e
 IxYTKaIIBlRLJngFHwZJ1d9hcdGJKYTf5k3k4m+tDpkC6mfuIPdG2OAdHcujYt0lrjLnBFG9S0k
 ihRQE471z5CSx7nbgp0Neu7K4EZq0q6FfcAnKJnk/E17oFt8FXdhVkHN9wDrd1PVFCCmXXMCjSB
 TF23dBXT/Yoc+BM+0d1y4pMsjxYHchgd6c6t5qWoGEvndRQwPEqb3OTm1Sg8kIgqYqhir0BzrSl
 RXTywcnBlVLV84w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the hsr_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 net/hsr/hsr_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5ef6d437db72..c98b5b71ad7c 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -467,7 +467,7 @@ static const struct net_device_ops hsr_device_ops = {
 	.ndo_set_rx_mode = hsr_set_rx_mode,
 };
 
-static struct device_type hsr_type = {
+static const struct device_type hsr_type = {
 	.name = "hsr",
 };
 

-- 
2.43.0

