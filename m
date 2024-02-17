Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B17FBA4
	for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200790; cv=none; b=WTI7kpO1I0yZuLlEDxJ+BVv8VD+6HwM8KgOJpNX0bYyFjFza90v4E/0iWYoa9IWp/l9EEHO99JgfaoXYsgHhiBukjC5n0lgpGChEOtYr3YDO1/CR8Is1SP3RxPUcIrZ0uERmS0pzB0otdw3cFOUYDEstpUo0lCI/sKNzwOTBpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200790; c=relaxed/simple;
	bh=xzeBB090fYVJMpjGXta60hiJrVnShFCfzUaEqJyH3oA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sPWDaFRB7J4OipVQsxvWFQ0EsyrH/GE6l0m2cd23AU+5ImThSkfl+txpCq24pwx1PjAV6pchQJLgi6WnU+HNmTD6kv/v+jEYjdZmoFNaFL/21MlXsF4vgU3RZ9wJ3HUBzrcZZu+CBrjGNQrG1td/1JxznLLgTbotjHBnCtTGI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=dHqpsrS2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="dHqpsrS2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d73066880eso30528495ad.3
        for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 12:13:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200788; x=1708805588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQ226lEYIpvgIaj27cS5McvwAJ47DAULYwegieELHbM=;
        b=NDO1j/kbzSuOYf0kjz/JO4Stk1/kj8+2jMONni4FfNROlm+oiGbNt1T8zqOeSoyzb6
         3hXoJx28SwdRMoybyI4l5z6ApsyZz+gmUih57bGHAv0EkYwDelwmOO/5mmtQB9+ojk48
         gJs1l1U+IkewjthnEsst2MmAZSwFUBZYOgkzRTnhuIOGsdHU6vl0QeNvUlJnEdHKUfiW
         pKTMU8wY1+UiO30RLQAT1W25nVGkCM+s76Q9jsv+yEAA0FLqxnIxKQ5BMH1p3JdXs5pM
         Hh6ivNDdU1Cx54STTKr48FDMaq2i6qD3st//dz5WH62ROPejZPI3kUqpXdtlJmBhZOkJ
         P6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7n1ln0XGLSS8XrRSn86DG7arqhqvntfMKBIe6eDAuEMjBF181z+4LbXXowj6uEr0MdofS16vmcv6HAe7lzBT4hYB6JnX
X-Gm-Message-State: AOJu0Yw1rtGoSPMIhWk8f3+B2BTv/KpFhLJQUsyDCcuX6TxYKjbmmYZ/
	UUg5nN9aqJqXwajwHok9spe5ZWbYGE+VhLJIEPkz9E3OYL19PMEB
X-Google-Smtp-Source: AGHT+IFLhZCt1Bomhbdge0s9l8Q1F+WHBmFVAFHmGgf/RHuS+y/UixBWyt/egZ+mcioU6D9SSKlr7g==
X-Received: by 2002:a17:902:8a96:b0:1d8:d5b0:aadb with SMTP id p22-20020a1709028a9600b001d8d5b0aadbmr6707732plo.66.1708200788089;
        Sat, 17 Feb 2024 12:13:08 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id lf12-20020a170902fb4c00b001db6739d337sm1806259plb.163.2024.02.17.12.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:13:07 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQ226lEYIpvgIaj27cS5McvwAJ47DAULYwegieELHbM=;
	b=dHqpsrS2M0TRr374n753ucAGuFs0JUmJW/o10XLC7SUzjMp3Mi2LhWT0kndxVmTyj8pQfh
	3QPj7yRkt2c2ZTwU8CSZvmpWODYzL4nsNAGyGKkVyR3Z0iDylKYaGwCCqDcmA2cWv9r6fk
	A0gq+DMvWZDsp+cI8MqRIc1bM/wgZWpnvlUZIf+m+uDYRng2BXbMzKouybj4I6pIwnFlRP
	IwSJXSq9eWijJnGBUTJ6tSDkyHFt7nT1nY7Cv0ki8wtQ5QatWcP8NugVYnvLl5nvEgxSZn
	QI2rnqZwdNpXt/SAWEjqFn76IkWvIB8fxtOWGpPZg1H6n95+obqz6IJL22hZHA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:26 -0300
Subject: [PATCH 04/12] net: vxlan: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-4-1eb31fb689f7@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=960; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=xzeBB090fYVJMpjGXta60hiJrVnShFCfzUaEqJyH3oA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNsMqQd7iSTS5J2gzedoypz/uKFs5aj5gxJK
 9QV6kc63FyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETbAAKCRDJC4p8Y4ZY
 ptYID/4g5L979UugwQmNsNjt6XHDcY9Wp9n4UivzwKS0sHfJPjc4b4AJ9h7C8t0+c9RxcuYtqEc
 1DXm871SWIeaLCCb/JtpDDtBAr+0YLC8sSl9lwQXlncfD3d6SZSqyw5SON1rTqDCFhKXm+EvzFs
 aExDJdRCYDMMAxRQNis6pRBkQMBiJtJJ8ZGm0IbjG/x7YuGr8uUi5GRvR2mSrXc35Q93v/U96Bv
 EbMs/+AfM9OAA2sRQs5LB87nd7//8XI9MLbwXLU8KXKsLo9oHLoyQxjNwZ4gr1A7RzzCSlgrjTx
 hkHBCYdmGqyWBmM/0ry6Dtx//tI4xFWYCXnjBqlbf0wFhAHERr0ROew0g1f/NQXPLYsMkf9pbNv
 5AwdFU61xtK4erbLWG6+bF0M9yGqGVp2MulG3QgL6AGXQiMUehUlwHSenCgt/1VF0g80j/U4tS5
 NFkRhYFWEI1ivfBYl0SLHWCQvVa3DpUjrsJBhWMO6yUnSvp8TqgkF9NpXSP9NdNYRtceXYQyeqF
 2mNJAiRTyB0LczC/qoM8iqssntdh8c3DU1aIgAAN2ytPTtDuQScJf55t07lStqmKDGN+OmgOtuc
 3SvzelrMrzwSpPREisO1Cp+WkD6/zhN/JqNtIC/9o1C1q83ijidtmiF9rHvWrY7Kk4msMgqh5/M
 KBYJbE0lzNTZfkw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the vxlan_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 705a6fd6ab6c..386cbe4d3327 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3254,7 +3254,7 @@ static const struct net_device_ops vxlan_netdev_raw_ops = {
 };
 
 /* Info for udev, that this is a virtual tunnel endpoint */
-static struct device_type vxlan_type = {
+static const struct device_type vxlan_type = {
 	.name = "vxlan",
 };
 

-- 
2.43.0

