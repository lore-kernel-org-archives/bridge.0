Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87A3D16E9
	for <bridge@lists.linux.dev>; Tue,  5 May 2026 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967700; cv=none; b=HLm2mHGI/TIxpmiVJ6NmTV2juK8LFSProYUDt3bIJSnmqMPoNguYqQKVwEvGofIHmFrsNL/8dnxAEhheBrQBiQj4k8X4bvGYkqAo0b7mYdXE9+lVXiepqSxJAZqZ6/XqDiSxfdsXCHIAmSZNHrYmxmru/zU2hotzYwWUvfBI+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967700; c=relaxed/simple;
	bh=1+aO1jsqt4+7D7eVQn3EaDYl7VdHvbbO7pn/PcTHylE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhtCShxMGYyl7fPQqrNvHSasShpTP0cABfV/BBLofP0I4dZm4blwg/2xDkosUSYkkbAscQGC69XUfPzYniti89Ftg8D8XbDNuAAj+ZeQptXZcxkTDo+d9byXW08H+kmN2eC1DyfUTjGgwESwjX4pA5X3SpO/EEuDb8yV8s3AFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=gijb5Ode; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="gijb5Ode"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso46828155e9.2
        for <bridge@lists.linux.dev>; Tue, 05 May 2026 00:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777967697; x=1778572497; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GZJftakxhfNgeo2AWQ3HNwbl0xuJXtG3r/LfqS/vsU=;
        b=gijb5OdepezHDOYLLbtP6l1/xGyoozsZIZ230CxVPZmBjadFIFQ+h3C+sZ/rjGzOT2
         cDKpsI1vMoXNOxMK75wKsfK7Wj4XLOiEUp034Rndxy7dxLb+/fcOMDGQJ3SJY3i9yrpa
         rMwrfTvHoqbZ19vTu+uAlPTvZujWLm5NRRcisOrvJzhNN7kDVhCvG6y+HyPb6e+I7HZo
         er5pF1pcWLCfxtpBUd91mAOjF8NsZ5Z4pcF5P8f6v9uDd3TTIxP2DVeaCGWi6MdMqMX1
         r5EPJRX5X2Pj3Tb7CECdmfefrk1wNsdWDwks/lBxtgvJBGAo3HA0FkGiTbtdCfy1SRPR
         gJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967697; x=1778572497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GZJftakxhfNgeo2AWQ3HNwbl0xuJXtG3r/LfqS/vsU=;
        b=kl785vvgMateh6f/0u16IqDaCRvgukM/d79cbB3z0gRBCyeZ5bdHGcCq3Cap2osYfA
         TVf7IjZFY7nl5ArnS2LNZfQUXGvuwIBZUisSbMw/Ml8sH/KxoqPh3k2aXEZ4BSHdEASv
         gVbdqljoSLW+h5oZKzSm/XWdAZXo+DJVASmKAHeQAvqXa1RHtTMBKoqzSl3vOdHf3aWz
         H/o21zyK6W/Jp2OTaz/ejcEX705gN5gsO98/yunu87uchbv4fi3w5HXx125bHUDtkp/F
         aMd0Dai2SmpPvWicaqy8p21NLA8hvAdd+XnYpN6t20/qHH8+HPc0MTU7gsjUcpB4BIWp
         7mYg==
X-Forwarded-Encrypted: i=1; AFNElJ88tCh4VS0h2vMKP/LafzfNW2qRfkZQ94yDSa34lnHAlx17wo2UghKCxjPWnsjcvDC8FwIKblE=@lists.linux.dev
X-Gm-Message-State: AOJu0YzPBqeRFZGPERf74Ks81jJV0Hq3iRafz+VUuUH03BYs63td8kEm
	/WCL0NGuEIZ29ddzSLnleiLs2ho47YDG7FHu02B2bERRqgqhPTZdDIwUzttamPe8HQs=
X-Gm-Gg: AeBDietFRayJoiSrKVw6sCbGRTEbApPUX+OCoCSTJfViL/2nfyVHpQm8Xuz68oeaRCF
	UuA/ky7RTl3Bb1t321RINyNYcNahVaRKxb4cIESPJgP3xTPb/7EqXFjxRf1FDeZUQm44Rpaudyi
	CgIZOAvONaAwuYwSwEHUBgRlKoHr5rDls7V3YYT/XvaDT8fRzWGqcyDrAjzTPDy2cOhJLNnN5Al
	pNt7GYXxrS0DG0guofpmryzcmmUS3o9V23K6RL5kAOE2tuz1OS5SFB4rTJ9K8s/Y281AUHIsuUB
	SfXBgKobJKVNKF+Aa8A+MDP//MZbRLupn7ieHm6vvrxK5PqjtyfczUKS5Ah3Jbc8lYwfScEIOmM
	AJTr1s0D0ymkL5CrrM996K2TkzAmw1ZvbHZOZhV9MrSSqzDJSE7pGeW/90klclLKZejkpsxYzId
	rPZXrhfEHkQNf60WgucU4iGRz1BYhSOR5RkLvtsXt4wdMAKD/jkNoIm24uY/O1OZTk
X-Received: by 2002:a05:600c:811a:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-48d18bdc477mr28515045e9.14.1777967696952;
        Tue, 05 May 2026 00:54:56 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb3427fsm544750905e9.0.2026.05.05.00.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 00:54:56 -0700 (PDT)
Message-ID: <80a0822d-7f31-4191-b434-8c84b37b4900@blackwall.org>
Date: Tue, 5 May 2026 10:54:55 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: bridge: replace simple_strtoul with
 kstrtoul
Content-Language: en-US, bg
To: Aadarsh Chandra <aadarsh.official.xz@gmail.com>, idosch@nvidia.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260505074515.636244-1-aadarsh.official.xz@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260505074515.636244-1-aadarsh.official.xz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/05/2026 10:45, Aadarsh Chandra wrote:
> The simple_strtoul() function is deprecated. It does not handle
> errors or overflows correctly. Replace it with kstrtoul() in
> brport_store() to ensure that invalid user input is caught and
> returned as an error.
> 
> v2: target net-next and simplify by reusing the ret variable as
>      suggested by Nikolay Aleksandrov.
> 

Nice that you've given us the changes, but it should be below...


> Signed-off-by: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
> ---

... here, so it's not included in the commit message.

>   net/bridge/br_sysfs_if.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 1f57c36a7fc0..cdecc7d1260c 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -318,7 +318,6 @@ static ssize_t brport_store(struct kobject *kobj,
>   	struct net_bridge_port *p = kobj_to_brport(kobj);
>   	ssize_t ret = -EINVAL;
>   	unsigned long val;
> -	char *endp;
>   
>   	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
>   		return -EPERM;
> @@ -339,8 +338,8 @@ static ssize_t brport_store(struct kobject *kobj,
>   		spin_unlock_bh(&p->br->lock);
>   		kfree(buf_copy);
>   	} else if (brport_attr->store) {
> -		val = simple_strtoul(buf, &endp, 0);
> -		if (endp == buf)
> +		ret = kstrtoul(buf, 0, &val);
> +		if (ret)
>   			goto out_unlock;
>   		spin_lock_bh(&p->br->lock);
>   		ret = brport_attr->store(p, val);

You should wait 24 hours before posting a new version.
The patch looks good to me, if there's a need for v3
please add my:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
  Nik



