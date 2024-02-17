Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358A8120C
	for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200806; cv=none; b=uKiyzvnC4FPPqK6QDZqu6lheNhwKK0Yf1uclmFxZ5Tw8cgYMCxQaEKzhX4TYWsRV1mnMp/F4aC9ptVEMXVWf6ulGxfuGU37+pgQPawecbCKM+4C97ON2kBXn8ml/fFs2dp6h/2wAmX33nv/YYopZ4vnqS36O4Qvnw35w8M0H77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200806; c=relaxed/simple;
	bh=y6BYSrCEA+qZPTeLeEv74HdrbzQ4CCbt7n0reUwhfoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dh5nnbTntGTo3c/2tv+Hj4BIRzcWMko0wb/OKatAPhCr25MDlScRFxXu+MAbeUaJnwLoy7G4uie9QjJhl8EtL3FHb0NLNZnw7t0uB59AR4uihVDBvOxdZn8uLQD0pFiUmtwM/N59D8RcVsHLrMtn61TizyYQ3+BD8225i/PmhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=mmLItJ/2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="mmLItJ/2"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e104196e6eso3254698b3a.0
        for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 12:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200804; x=1708805604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XmWynX/cFY/zYOq/2eCC7fEshtrUVqvaNfQwMNQ7SfY=;
        b=t58OQBzIGjflphQzozkR1x9nhwskmAp2ZO/zhHkibQIX7TX+jDoinSDkdMTVjwD2Qw
         KVLzT/BOZBK+ySmF8tPvHlF20sy8fJGF5tHhr4JiIIKQbmQYmHuyBCWv+8DJ5eIMpnO9
         PQ1gITDBwk79xLMTaW0/f8h2+7RLgiXcc38TY1G5K45VpM47qUDsxoERuDeqx+jMtVOB
         lXHJfPvP/Y4Ll/MEHYjle11VILJABHZ48crAQ6D/d5NhUJnSdR29iofdHKUs2Yrxka4h
         cavb8BLh3oO5IC9ods9Uds8Kt3q7gxldhRQa5nxY15bPggBFJjOq9aq9qBgKcOSpguIE
         /5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWhdDiwKzM24HCdk0aCb+cXmawdkRMvKOJwNakvw/hUonfDSArs6WTAiedgAt5ahA6GLkNsKMX1JXBOvu+oFXwyeww+UTYA
X-Gm-Message-State: AOJu0Yy3ZSdhSqhCFEr44hZmPvgcyzxzRPRcpHeC7w+2d8gISa6IyCsw
	Xv5Ldl3dYGZ8d0+xmgPzbGyOb6tkNLX+xYhEk+VTcHe1BYlDmlxy
X-Google-Smtp-Source: AGHT+IGXInpkUwpO67eEfAZG6SMtlHXxrmmO6ZqL1R6Tv99t29Os7Hx2UnFHEXYlf5KDA9RavDqXyQ==
X-Received: by 2002:a05:6a20:2d0f:b0:19e:9d92:492e with SMTP id g15-20020a056a202d0f00b0019e9d92492emr11119962pzl.44.1708200804103;
        Sat, 17 Feb 2024 12:13:24 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id fh14-20020a056a00390e00b006e08c103dddsm1999319pfb.192.2024.02.17.12.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:13:23 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XmWynX/cFY/zYOq/2eCC7fEshtrUVqvaNfQwMNQ7SfY=;
	b=mmLItJ/2x1YIEiW8tOghxhkXrDk0/58hvlSpnv7t72c3p1Qjr0lwTfr3tBnpPX29WNkMCG
	TCGdzm3/QEMD9og4rc7VY6itAm0m+qbsCy/EytMaV0wD8VZICY8mL9ofq9vHqjbqpJamMw
	emrryPMrxmYrz37Te0OuQbVZ1xcHkk87JvibWr/i+erc92CrLkSb1DBHlfhoJVoV9dg7+t
	P5cmdlPdMFB/Ne3PelnGsX/vnXewjknUzaKkV/KVBLc66QA5ZAUgkWGeWaKO+4osaLK20y
	L5UhBx84gxR/OUwUT4ixAQpN0Qa9FuFvUjHspFtulAAvAd3oQBnehPF3zobBsQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:31 -0300
Subject: [PATCH 09/12] net: vlan: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-9-1eb31fb689f7@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=y6BYSrCEA+qZPTeLeEv74HdrbzQ4CCbt7n0reUwhfoY=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNtfkuOOhHL7kJiC+Ppke+4cIU9PVk1Ov4nG
 MXL0y/nXcaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETbQAKCRDJC4p8Y4ZY
 pgv+D/94g+Fv2KX/++lAfaa5txLoX+0t+RdSw4BU2/ZLzxwCGk6D1dqvyxAxeQNpvnsSMVvu/Xb
 aIgLGT+kw9AH1PPNAzjVhxvQ+4dRD0jGaE1S55vQYlvuYD/EoNfbUBfPRO7502bYtuei+ZtpnN3
 Y77RsNGBDlT0di184JU7nMC0wNSM9vY/b+T9I+1+Trmo+OeWFAkAhLn5A3mYt8xSZAnSHiAdLIU
 awjwNwWo59k6W/01zNDwnsV7wJkyxy7S7q+Qxc/EOb5IIvcHBsOMmLLIaSAfzqayQxLwSdWrsnS
 BFvJfFIELdcWsjvgk14W3Aon59uGIGph8EKU+fMRWCzEMFfTPjHJONBfaLg0XvgqGAR6K80HSwH
 UP6IjZ+GKKwksYq3z5819HNKR0jiF2UPqN8QMC3fZ9sTt/FV3zKJMDmTwvu3K124Js8dk6DRG0K
 NB9aHAC9I/HGjkbvgJOmc8O30Q6NM21KE3FZ4Sa2Yql9v5ZVnkVSLaLh94vgAVyJKaO30+vxIoj
 ZwB2h4Onx0QmWr2/LbquNc0SqdkHVHuJ1pj78wCYbSjM1oOLs19o6lTf9yFHIs4yMuVQhjU/mqp
 n9LGhrfGQy9v6jWy4K174vgXeQZ+Ys0ot/5+40MtWJlKLxwi1quuhhtel1aTUYgeJFDgF1g1pnI
 ofJclDNx7CiDU6g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the vlan_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 net/8021q/vlan_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 790b54a7cbe3..df5552518251 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -537,7 +537,7 @@ static const struct header_ops vlan_passthru_header_ops = {
 	.parse_protocol = vlan_parse_protocol,
 };
 
-static struct device_type vlan_type = {
+static const struct device_type vlan_type = {
 	.name	= "vlan",
 };
 

-- 
2.43.0

