Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E57381AD6
	for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200812; cv=none; b=CZKDNg8/3EVGCnCGKFz2WT+gWizRYso0CsYeKIywccwpEImS8HZbwk/i+U9mCMchy8iu8cTQ/scVAxIdlryFRjnEZED6+SKAqVH40sZzLFOypGttea88P7tZJ/7x1eOISYD5sbCTTtLrSTHjDA/B9x44Q5C1z5gUQma2ZLa3xdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200812; c=relaxed/simple;
	bh=jckpWHmanpSHMnPw7HQu4VFxOjRCXzlNGUWz/0ZTJeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CqdOGHEKLjrt46aYJux59g8B+in4CYVL3JV1dCmoXSok+/KdfBxOUNCTZGqJjbwcTkzRVWahg2rSQL8NIH4ZTlpgRV0LgWt+0OF114AZSp89go4E+tvBsv0EN55ZbWLpP7EnQfBQeRA9/Bq/v9ol96ETEfTrztqjgSM6Vo3AOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=AEPsU/lk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="AEPsU/lk"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2997c5fe6abso95067a91.1
        for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 12:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200810; x=1708805610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrOIV6/f3vZV0RT8ynNTPeBVRF+ik/O4GVtwFdY3Oyg=;
        b=YU6zglBr+NKMTgvdl8H2gIEbsSVtRcf1hVLqK6LxkYC2vWmsKtgvDJdaoE0mOWJCwf
         aUZJwil0Ym5oRXDoi2DV/0WzZCQRKAbZG36VlWIXD/lQChDsK6WnYuN2Dd12Q+8HKbaR
         OEZVzAVUGR6r7lgxkbwET7AxHovTAhfm5xFtfq9NqFCvMZ5mljHVgSdDGhK2UJZegHN8
         9NFj8hG7HLebPs16MWiV79o4Sp8FUHxL/UqW95R51cCzh/MxKONc3e9If+zDh1QGM9pM
         y1ZilPzAe1YbJcLcmbKgn6kf3Te3aTnX9fRJCiLv/wDc54/Eohk9lAuynh395tHWZsYn
         S67g==
X-Forwarded-Encrypted: i=1; AJvYcCXeKm2nN9D8Uvunv1R6YMxmLymZfxEyrnza1WgIAxig9EihAyJrGB4IrdgoqTaUzrBIQ/O/z786XUAMssCQGMkqrW8Ec2Aa
X-Gm-Message-State: AOJu0YyiKCZz18WFhlHLXOPBtjIABqMr+a1LHeIrteJxUWcdbc8x6bGW
	WRGVa1Bvcm4xpHdL1cXGlkZ1IE501nNF38k5ZW4UeXMfGL+0mvrp
X-Google-Smtp-Source: AGHT+IHNI4aTrKzu/exZ5IH5/eCHtxL8hDAZoK8faGROygZc23MMA8HJ0xHAJA5VeRP382zhxD892g==
X-Received: by 2002:a17:902:d504:b0:1db:cf64:732b with SMTP id b4-20020a170902d50400b001dbcf64732bmr2255775plg.21.1708200810472;
        Sat, 17 Feb 2024 12:13:30 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903304a00b001d7222d8caasm1819993pla.50.2024.02.17.12.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:13:30 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrOIV6/f3vZV0RT8ynNTPeBVRF+ik/O4GVtwFdY3Oyg=;
	b=AEPsU/lktqn3QfPkZuEQm1XN26hyVbHsQy2EgjvgwjwYINSHoYjBxSs6VAbGYuAse+jkho
	nC/6oIOwksA5vNNR63Px7gPiyBOVN39R364ExTjAUoDLHzy45hKqh3MUdoo5YUYI/ZMWU/
	sIrsG7p2/vGA7i7HCh+At+PqUbwnZAmYg1NNaT9X2NRcONmDkaGHFcY8RLKEmXcnXRdqFZ
	/iG78rVfrlgohqqZV9JOIMyQpxjfdsWjZHt1rp3gBssaGKtOmJpksnkSVyOdav8gnRno09
	tacQqRgf0/ntW8i7N3ZSPdQ5uF1eJ84LMXvvY9SWQcAMlbhc2EjGLefH/yocAw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:33 -0300
Subject: [PATCH 11/12] net: wwan: core: constify the struct device_type
 usage
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-11-1eb31fb689f7@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=jckpWHmanpSHMnPw7HQu4VFxOjRCXzlNGUWz/0ZTJeo=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNth7ayQciNaopWilyJn+5++vrrozSI/AGf2
 LmjjU+2+ReJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETbQAKCRDJC4p8Y4ZY
 pvQUD/9eIcYw88bFShKSfY20/NUwqHxGY+WcJStJhCBjIXXQwTk3eCT9KVJ0xwG0N3tF5kYz3Xl
 QSlbOE6MLsb4fXgUTkADqWhPK3nWR8JdoQbMGRet3W37oK1kNkucG7iNPHPD6HLX2gq/kmNIj9y
 /1hMOur7RKkt28HNKThkE9bDYtpg1AlNEVKn1C3rzCGd9la+DadlzsMhytSdrWaj2UPApUFW0ZU
 V8h5vmyy2+48oX7xlL47839rTZ0hEbnjSPPXBElgDdgtatCmS7M8JVl0NWQyHJEEfXqinfFSJuu
 hwUq1OJ3CAUK0OXPZmVJ0O0HGJ3zaM0hANsIbv5WBfsulXuyDX+aVRbzj7F/2yDcubeo0UDIZ/f
 T4wvopAoGYBXU/dbWKtH71h5xB9/7qVbQNIT4MxnSWQ2F6bP+yKVgNjwOdZLIZTh66ugT8g55jb
 Y6CJzOtZn1i3ywzG1NS9DLb7xH/OuDRHum8iakV5jChkg5GTVnb8Rbhb34X6K0MwV5IPIZ7ty6K
 nnBcmmn9DAOYphgAGwlHAtisVEDWyL+E1zDdGHMzYgMbPaUlh4HXKkJmKN3XP6r0Pwlxc16Ahqh
 4k+gDQ+xNrnjKCCTwFHSA6w5Nt5k6VrsQNusqQVDLsuKYYf16rPeHyA72lJiKCyrySAc7asdE6y
 HVX6bd5XxFV5mXQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the wwan_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/wwan/wwan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 2ed20b20e7fc..b0030f3ed0f0 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -920,7 +920,7 @@ static int wwan_rtnl_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static struct device_type wwan_type = { .name = "wwan" };
+static const struct device_type wwan_type = { .name = "wwan" };
 
 static struct net_device *wwan_rtnl_alloc(struct nlattr *tb[],
 					  const char *ifname,

-- 
2.43.0

