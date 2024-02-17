Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4777F7D3
	for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200786; cv=none; b=QtsOhTAwyVJiifVXRnXnUsiBvc1QlW0WGOUq+23c8G3uo4zZ/DjX76vpGEAEZ0HP7eymYWEa7xzVFUBdLllIzCeBnbHF9m+jCamhF8Vg99zR1slcBge/kWzEO//r5IpXgqlTIirMs/oMmBltu5RVwdbl1R3CjpVud6b0HF4lWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200786; c=relaxed/simple;
	bh=yarIivvwEL0iBD1g1oHgz89LM3QZ0OUN7cz5OAdk7mI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHUrGscF1j490MKGQlkUPaYeQmw+yKK3wj/cnU0qPCPbYq2JMAWfZFF1EcVwLIKm9WgJIWT8jEWcS1deVtf3n36W/1rCZlt/XZAf8uFKKNWKi1oRYOCIDMoLJBS6iuW3Js+CIDTdsEQbfsKy7kk8Q7lv6RZ/xcZ9/2yOrC27oK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=BVCJuvt6; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="BVCJuvt6"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so2496871a12.0
        for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 12:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200785; x=1708805585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4lnVoJ8bQxR7w4vsZ3NULyq4tTkrXiB/TSkyItFgKI=;
        b=rBh6xEGfs9PmiLv/2TFS7iBNmAfGkcRwXQvqUasHX78k34xURpGiym9Hk+mCebHq0c
         2sFGNVwuSayLF9zH8YwaJlgm/gfcii37mrMiVJo1cF0zcEMVnZautdWam52Ldk4kIaPn
         fJ8gbkyTiIIZCVYrcLiB3+AjZyqVOkop8j+uVny52JmAsL0GW369aAW6Pz+7SUWQQfxc
         K8n88JtrJQ3/dB4LjU3qNOg0ARbRC34j45cEeVqP8rBTPpKIizqneZgYY5OSCk6VLiA0
         ttMzLtbmsc3FtODylIcKvfADf0MMQEiTweOVMUrc8AiAGu/5ZpIXhy3CZSXK5Vv2/jHG
         +k/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXmvdnZI0qdQRmcg7eQ67pIKCBnUzVKSSJUXswJWZEFIpo/xdnEd3taY+ldjAqFfbto/OM1+LRK74Bh7Bjyx0yY6Uzrfct
X-Gm-Message-State: AOJu0YzvnxQ+kujYJ9SHUmo5oG91bAGOxmSJUObCXJCXwiEjtLyZOQZo
	b8Guf8DyuWRfQlQ9EISp6btNEXXotV5aC7JDSEytQPl6TgjkuIEu
X-Google-Smtp-Source: AGHT+IGkC6VGVNk5gf/yLI5f/Rzq6GQZ0RQFSd4sKubWgHq3nKwxK2vKluwYiLMMsAeYxXPxVd61gQ==
X-Received: by 2002:a05:6a20:2693:b0:19e:cd37:798c with SMTP id h19-20020a056a20269300b0019ecd37798cmr6260420pze.35.1708200784973;
        Sat, 17 Feb 2024 12:13:04 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id nd4-20020a17090b4cc400b00298d2182f1asm2224009pjb.55.2024.02.17.12.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:13:04 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4lnVoJ8bQxR7w4vsZ3NULyq4tTkrXiB/TSkyItFgKI=;
	b=BVCJuvt6vBgbxH0uFwQCn9nbLFXOoXBPbgUO4JSqLO/jTt81HjBtK1jdN135IbZqW/0RR9
	nwOYq402GyjaxAfDV6uKb8z2UnvXKhzVPpr9+V+PD7PelUyFHvtyldkbtXJNDztgb03Ty8
	5clTJ0WsGs8etCeuPYKtx3592tKIn5qMWoCxOm/hVQGP/jzgP7Q9doThvu3c+IH0rHihpY
	+5VzrOyn6bLwcSgB2RdMqDoDvARfEBlpRt3PRU1zcNH6/AYhOcQP8NHVYF+sUgfLARu1/w
	w6+G0alpXWVTVJtNxHHcZuHHdbMHoA6li8jJufC8iLzq2vSVXIKIN+RTUCXcrQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:25 -0300
Subject: [PATCH 03/12] net: bridge: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-3-1eb31fb689f7@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=yarIivvwEL0iBD1g1oHgz89LM3QZ0OUN7cz5OAdk7mI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNsLeps0ymdOOTLpFtWqQ9G0MMgWi/AyXNVh
 u8lKIx8I56JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETbAAKCRDJC4p8Y4ZY
 pvIcD/0QD0rQEfEJbu6CBq/BX5x9HIhqTgkJo61Y/K/wcXzdd+w3rK3or3FVbvPmqllbtPIXtTG
 sGirIaVmwmtK1LAXZaiMuO3026FFoz/9SlMc3ZPUTN6z0MRLzSqj01ts5CNCS16nkGQ0Cyv9CZk
 13QvAS7BQSNHipHQPDMaPH9CXzm/+wW6FAmXkjAmIZZbnqF2HlZWcOWuok51y9i36Wojc9RcVNJ
 GEoZ1lmCD4LM8Etw0y25R/xcKwHK3vL4+pYHNKUmxMipc0VPrQj1Mb9ibeAYcTQ/wW8GJImxBoF
 /DKp0JYFuSGhD7+7igL0gdirB0kWXMb0goRKJwxriSJglJusvqcJ2IOOPCgSQ6JjV0xGjWLlf0s
 ZTRPbVO0KfycjpQPOIyLkep2MNLaGI22ogSdj+8OoOyJoYQ9UMA4fYt1p1nmSZO4ICGX3J5kElU
 Oabuedb6f9fE1Sh+GDabspCCmiSQUMRytt1CTm8iH9YxyBWfiZdw0dEN6h1+sjHImDWBuh0CjTv
 F7x3zTKLnRTYYhwpfw29Q8Eo8RV8gSemQhAOCn6+I/VpcCGZqIB3IGKnITqIz+36ZbV6is0OGpa
 121AGI2Hd3rvJzAbXNJ0M73SiHzucPhrfy6DbAqxddlGdROk+5tHgNdR7skZTz98J579y4CHEgV
 nN/MjYA/fgm+GCA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the br_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 net/bridge/br_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 717e9750614c..874cec75a818 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -474,7 +474,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_fill_forward_path	 = br_fill_forward_path,
 };
 
-static struct device_type br_type = {
+static const struct device_type br_type = {
 	.name	= "bridge",
 };
 

-- 
2.43.0

