Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0BB1E22FB
	for <bridge@lists.linux.dev>; Tue, 17 Dec 2024 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432191; cv=none; b=pd+LFa18EPK5Lt9FM9VCBkUeoEiZhruPv1Gaz3//O/ih5I8wFYdXchyqPJJgsyyjfuEEXubT3x1+OpSDkcKerZxAjJ2ZcY1FP2UztKTvS0Oh9/bpZGjdbLp7nrBJF9GXDDuzGvOdb+t96hz7uu2OCrciTGOoq6Mu4mZDtM3cCvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432191; c=relaxed/simple;
	bh=y6kN0ytC+JEAm663I+e3ce52E/uTgwxjwdVw6gidIJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YW1ZoRD6TShQggTDz/PZebcKCJk+QATxOJMgVeEicnTaARo/g+Tjux5qA8GsrJzjZZTc5rZ2Tug35IyvrwXLtnMkVRBc4NJjs1frWE9EGOc4O608xX/r0u7fxvnj6ukObXcU6lUgsenJQoXjO86nE9tCKzuAp9p8wFd1PGQRUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=wUCDINS2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="wUCDINS2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso25095605e9.0
        for <bridge@lists.linux.dev>; Tue, 17 Dec 2024 02:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734432188; x=1735036988; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lPpgSVaAv355PXrM8WEJ5CO/JUa9i24YlHdFUS1Mag=;
        b=wUCDINS2JbOQW4fsG1fGxV2+/OLBcggFm97XhJcA+sSTldCDZDVxyJFYnWlOaqMbEU
         Ppn7ptz6m8Ouc+asdBj17RX4x12n1EeyVdsaoWO9/mJhTasr5VN/+FP16e921sHZdt8M
         muG+xBKo/jTKwNjq7Cbi+1LQnErR5znORFJfmPX7Qpr/MHXre4F3S1U0hqOVOLES97sh
         zHq6WjZkfaku3/IChY+JecSzEH4l8vlHYIGiE4jQIuFBPDk+aJMjhmcxDo7J9lgdCFAy
         gvc86qWA+R7MuLCCKOp/kL83ZsGyvsJ71AmbgMK7A/3lGkp0dOrh0vS2wyZluqqqtpLk
         xiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432188; x=1735036988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lPpgSVaAv355PXrM8WEJ5CO/JUa9i24YlHdFUS1Mag=;
        b=JLp5EnEiwyfQ2kRR/9v9nLr0bIBUtZUdzny08XfhtRm9+oMk+xWoPca4cIb+B/4kGi
         fF+J4TtjgXhcbv9AJa6+i5yHU1ORlp4UTAu1eZR2OaHIoqfrCVjld3AeUSToyPrIfcIF
         9iDJ5DdKSwHRw+nOwiVo9IQDofNSUCHXnHE9Q747UCUmYLt+9r3r5//F/yJDSzohqZMb
         IasFYrurf/AA+Q6+hg3XBiyxCvd+7quOB8LwexV0iv4sb1X89nDzsKJCgDPaBs/AKitf
         ZyIXMmeRFvcxFQg2ZlL4v3dJ2I0iuWUqGykCFXouJi2zt8FN674FbSOe5m5PfDt9CgVw
         huoQ==
X-Gm-Message-State: AOJu0YxwYFX3yZmdbj2ca9uO05OQwLK16h25n4BS8sGvhOCVEgXuQHDb
	KxXsfcycOtGZF9czd0fEHGUTkr3+mWv7H38/R9C7yEP0ZFAxKaabNCaoLu6IeRg=
X-Gm-Gg: ASbGncuBeaotv6WVGqiGi4cDTVF5je2F/N3lyNeRVrfK2An+4lYYt4NTmNU8QGta1/H
	VhHZ5t4WdlggurSeEPLDmbb8U/SACm5GzcZZO+dKKGHL1Gqre/O9UXRTMmJ1pEk4miUg5C5dTjd
	VVyBogTfa/N9tHwE3HojiwFdySS+hD3L4OZwNhdPtY2uKx+9SqjGsrSOBihspT50856syYX7Yb0
	sZi3Ms82ACf1N+/agFR1QYUoTlRz/5tlBG/JRfYicuwA/FRO3jIco4ru2kNqIAX7YDIe8K87k+B
	tuj1+38FONMC
X-Google-Smtp-Source: AGHT+IE+WugOposmvo/jcHeaw0Ch/ihxlIzSWqzgKieKmOo/fttsPn7O0uxSSG2XNkVbg/PrQmJctQ==
X-Received: by 2002:a05:600c:8715:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-4362aaa8b9fmr140737975e9.29.1734432188304;
        Tue, 17 Dec 2024 02:43:08 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706595sm170469495e9.33.2024.12.17.02.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 02:43:07 -0800 (PST)
Message-ID: <66adcd4a-d4ae-4dc6-a706-2761efd5084a@blackwall.org>
Date: Tue, 17 Dec 2024 12:43:05 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: bridge: constify 'struct bin_attribute'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kalle Valo <kvalo@kernel.org>,
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shahed Shaikh <shshaikh@marvell.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
 <20241216-sysfs-const-bin_attr-net-v1-1-ec460b91f274@weissschuh.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241216-sysfs-const-bin_attr-net-v1-1-ec460b91f274@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/16/24 13:30, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  net/bridge/br_sysfs_br.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index ea733542244c7e7feeffef3c993404529ba88559..c1176a5e02c43ce32cb3dc152e9aa08eb535a419 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -1002,7 +1002,7 @@ static const struct attribute_group bridge_group = {
>   * Returns the number of bytes read.
>   */
>  static ssize_t brforward_read(struct file *filp, struct kobject *kobj,
> -			      struct bin_attribute *bin_attr,
> +			      const struct bin_attribute *bin_attr,
>  			      char *buf, loff_t off, size_t count)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
> @@ -1023,10 +1023,10 @@ static ssize_t brforward_read(struct file *filp, struct kobject *kobj,
>  	return n;
>  }
>  
> -static struct bin_attribute bridge_forward = {
> +static const struct bin_attribute bridge_forward = {
>  	.attr = { .name = SYSFS_BRIDGE_FDB,
>  		  .mode = 0444, },
> -	.read = brforward_read,
> +	.read_new = brforward_read,
>  };
>  
>  /*
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

