Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57839020C
	for <bridge@lists.linux.dev>; Tue,  5 May 2026 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777962145; cv=none; b=uOFoP7r00BYCkCMQBVUHkdH4uiavCjXz2xy8TbbiVCACB6wL8vBzRnsPcW2rkp/GFvPjY6BDc3XmkvJ4yV9VfoeOXlg7cQ/G2Q+d9lG/EV2Os8SBcFvvFuC6s/0Y/Yr3abuxrKqR293otY3g1XgynfaO8zfTX+nBPK7ubMRejQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777962145; c=relaxed/simple;
	bh=OngZ2fusFSZ6prz7j8sCWOee2sbX1jvarWy2nk69Og4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SR3R5NmCFbL/3GOmteG1D+GjnwzsTYYfcsixAgA5xbj78l+7PkdWpG/0OnZh43PNWkcFlnWVXYcUwfBqhVkA1jAnPKn6EhkS/F07mBCpdYjg+ZsANH12UOPOPtzfOKl+omRpCFChISGPP1mb3fhtLiLH/7HdcfxphZmXmP/XxXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=VeBInQ9n; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="VeBInQ9n"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so76854595e9.2
        for <bridge@lists.linux.dev>; Mon, 04 May 2026 23:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777962142; x=1778566942; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbeCRIhLk/9kzzeeJn9oXL2oBVgHxV7FJ8Zz2qL39dw=;
        b=VeBInQ9nnwlylErftXa9d6wCFo+7qS3Hj4F/Mb7PUY+CGDaAB5yIJDznKKbIn3gWCl
         4224LyBi8rVX4OYHpG3/wMy+7BEDpKpWSr5oxN6p6boGLA6eHHzbZyBb5ne1bmbkIBc3
         VOt1XR6RfShiItg0Nw133opwD/KD5PbvBzO2QEyzdiYyH6HThuz4w25IbCziNaLpGGkA
         +Vr6hDnS7ioLSyytpExO2OzjUaCozMok8juTbHAuZT02Ty5XI25VkWv7kvQnZjVKpBNg
         bLWF541x3dC31TD8TeeAihqqVxAXrM4WgNJRGp97hL3zYRbuG+XNySftm1h33uKiyVjf
         KoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777962142; x=1778566942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbeCRIhLk/9kzzeeJn9oXL2oBVgHxV7FJ8Zz2qL39dw=;
        b=fkUJaZSD5Au0mjeJSa3tp6fqX2lrmW5M2/7dyWBdeQ4AmIG1xZqaR2RDMUuugcknk4
         oDHvigOpy/LDTIUqDC6kcP8OibmRPzTKx9OjAV2fobsW2ibJdc+83DJCgoi7soOk/zgp
         5xRu4/JE0rwKSeyv+Hteqccgw+lUKKI6Nukfh4KNdjGMrO8F/KYgUmsVEoMQ53R2W5Pc
         tGR0Nx2ipublHgWuY/sQqCJ4e9ppSG8XA70M1fm9ct/qbry79JL5siyeLZKvlHRddnPj
         wZvHI+yZARrC+egvycJS09cxmVMfZzZeGwBqFLzZOIlp6knMwN1BEtGScwlMVxy2dwCO
         +cmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0LAqgYPUoYJRLHougGMaGXqKIXczi8qcVl5qPVKaTYlJzxgQxE4GyJ/EMXwZ/Oq+9HBKcUa8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzRcaUsgTmXhBz5GCQuJfXgYId6j0i8ywek/gc1jSJ4AMJZzvPe
	+HWANuXtCeAHe1/mDBxe7wv5ifGSVcIDKZ3jzs7YOlnuGuVNiwyu5VsTcH1iD15bb1g=
X-Gm-Gg: AeBDiessySA4go+pVjsrKhK5gKEIsf3epwkCHBogl5H3fIr/ptPwxV9zisdflK5uUyM
	c21uNbrgJ+gQNeV9ETQgF1YDQl3nSS0IiBcoOq9A7N+Tw/yx4IJhLWJ3al9SAeiVqV3iRi0Z6ed
	2BjOXf9ozmpKPlgIoOIfSoGyedcXdhqw3PcIKQRm9C7b543RO+MNpe682NRNjxxk9X/16DKoT8Z
	nGlERjIkxET8uTauXsWI+ZVhcgbtvMvJxCM8cHoQqKCSQ6aCJ/e/eiEP7uEX0c4WNz4Ic+LP5qu
	wufzGjzkYFdTwfOBEJdR+ExY/C1X2O2iz9BRYk9eff3hIuX9Zb54FfJ58vsoShwbUdyw3ZXzhZF
	Kf30Zr7eK8ELH5p6fdwcbTlBrOma93vf/icfdkE0DTImBThXofvyZ+XFnmu0R0ciSCS4zacLJCJ
	/fRSzNSXLib1at62gg//3JX2xDkFkrQVqfchhJJgMRNRK1Kvege4x7YjB0lBlBLc+3
X-Received: by 2002:a05:600c:444c:b0:489:1fa4:50c6 with SMTP id 5b1f17b1804b1-48a986691ebmr206195685e9.20.1777962142318;
        Mon, 04 May 2026 23:22:22 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba6f83sm314550095e9.9.2026.05.04.23.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 23:22:21 -0700 (PDT)
Message-ID: <05d26a5d-0382-4e1a-ba0c-d946509e1db4@blackwall.org>
Date: Tue, 5 May 2026 09:22:20 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: replace simple_strtoul with kstrtoul
To: Aadarsh Chandra <aadarsh.official.xz@gmail.com>, idosch@nvidia.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260504150146.457562-1-aadarsh.official.xz@gmail.com>
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260504150146.457562-1-aadarsh.official.xz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/05/2026 18:01, Aadarsh Chandra wrote:
> The simple_strtoul() function is deprecated. It does not handle
> errors or overflows correctly. Replace it with kstrtoul() in
> brport_store() to ensure that invalid user input is caught and
> returned as an error.
> 
> Signed-off-by: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
> ---
>   net/bridge/br_sysfs_if.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 

This patch should be targeted at net-next (PATCH net-next in subject).

> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 1f57c36a7fc0..3e948d781970 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -318,7 +318,7 @@ static ssize_t brport_store(struct kobject *kobj,
>   	struct net_bridge_port *p = kobj_to_brport(kobj);
>   	ssize_t ret = -EINVAL;
>   	unsigned long val;
> -	char *endp;
> +	int err;
>   
>   	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
>   		return -EPERM;
> @@ -339,9 +339,11 @@ static ssize_t brport_store(struct kobject *kobj,
>   		spin_unlock_bh(&p->br->lock);
>   		kfree(buf_copy);
>   	} else if (brport_attr->store) {
> -		val = simple_strtoul(buf, &endp, 0);
> -		if (endp == buf)
> +		err = kstrtoul(buf, 0, &val);

You can just use ret = kstrtoul() here and make this simpler, ssize_t is an
int on 32 bit archs and a long on 64 bit ones, so it can hold the return val.

> +		if (err) {
> +			ret = err;
>   			goto out_unlock;
> +		}
>   		spin_lock_bh(&p->br->lock);
>   		ret = brport_attr->store(p, val);
>   		spin_unlock_bh(&p->br->lock);

Cheers,
  Nik

