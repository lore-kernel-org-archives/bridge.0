Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AC1F61C
	for <bridge@lists.linux.dev>; Fri,  5 Jul 2024 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720216863; cv=none; b=APafBYr7roai5qcJ1rjJnUQHfkBQ0X65GzuCYiAQqmKZhyeql/qyO0F5EvcfYCiE4Q5jTxKOJBpWfMfMhs6NLeR+69bfNNyBcdrTJUUnv8YX5nFKdSTIuSumKgJ9ZRaX/wbY18gUW+DBgActeh+lNSglZnUi2+lnxNVdBFBy5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720216863; c=relaxed/simple;
	bh=cRlLcPvgdYI+0d5Q121mKPf07KB4cpgC4kaVtDmI6ao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R/qYQCglxvlJsJUScTb3QZTa+f3elSDeUX6MG2R21vpFLHMOgTKQ/zBw41PcFTfEjOqKDONcIzEvhriPN49+8vxMkzx6drFhuWmjjRIT4gcsFnRFx9z7f9z3pjJElapN99Xcqp2o/jtuqgZLAUYP2vlaLWIfQoEr/DQ6y/CHp6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=zdcO1jVr; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="zdcO1jVr"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e9944764fso2296740e87.3
        for <bridge@lists.linux.dev>; Fri, 05 Jul 2024 15:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1720216858; x=1720821658; darn=lists.linux.dev;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wBckyEFwh/Rys/nHKmjk7v967dXh+ZDDYWaIn/2UGq0=;
        b=zdcO1jVr5ubXKsnqfO1mcsLG1ln024SKusC2wmNnYU6KQsmYLzGhI+2mW3YeQ7mFvX
         9lzknGXCL2HiQ8Hv99WN6q98UYSC8wwQPa/QkoS0myHDuQ38raQ2+3oqFO51p5n3P5S9
         tPeTtCa01XbfdsWVAZLfig0U7wUmZGsfrjcegqBahx2JAn2ICo3pvPgkxPDJGSz4ckG2
         Urlw1S3f6HP6LkVhbRmDZQLk0MDWSOTTwLFz91BQTTrMqJc5g8X8QgvOGF3iwDy0E12V
         ajdLy3hy3oOP4XDOY9atyqoqh9cZUSXZ7OP1m5yIXyty7+K+5jp+IZebnoXRsa/L+lRP
         MHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720216858; x=1720821658;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBckyEFwh/Rys/nHKmjk7v967dXh+ZDDYWaIn/2UGq0=;
        b=CdjHO9TYPdzk2uguZLL+OTU4g8kVZ1nw+gRZirUGP92yUsUdB7bH9h4/Umz5neFpPN
         lClE6R69rKOmKHUNtumo7upXRxaN/cX9ZoYI3EknZi6aqACDAy6YYBWa579J+cSC9HJZ
         p2X+StxE5nb+LvhQtlxbGXVeP3j1P1F/XSRZs0hfieQg6xlLb9G8T69dVxSt37PL+KoX
         UKFFm77GliBRgPwHD6r3rDQuQ/gftBOe/UwaKUU8sOwTwszXtG8p/+MmC47hlrQF3e7V
         kHqosOUGoNpDntK6Wv3ZY2nP27FU5l77EFAWBsA2XT73L1bumvUCZpBC34//9BmC+f2u
         Z80A==
X-Forwarded-Encrypted: i=1; AJvYcCWsuP1SXHue9rjEadnPer4KK/2ZbvOuoM09vhvHHX72GFVKZmZ0DGlczfsbh9KLZSu4Y791li5A0WBu/wcSkRW8cjWob/YQ
X-Gm-Message-State: AOJu0YzRipR0NODg1ox3KwzA+kxrcVqAZBeplwkTyy49GDLP7OO3nTv0
	atu7ZANC398XFBhWEAoNfFEFh/gHLP/obz5ZiFzX8aESmhz0T/IEa4K8u8mPn/8=
X-Google-Smtp-Source: AGHT+IEmnD1pltRm+NG29AdDzUwJcwOOmeDoXT57EhZSgEaLlRepCcFYfu+F9IeP4PfKXOWtcSR0TA==
X-Received: by 2002:a19:ca43:0:b0:52c:e1d4:8ecd with SMTP id 2adb3069b0e04-52ea061309bmr4021943e87.8.1720216858175;
        Fri, 05 Jul 2024 15:00:58 -0700 (PDT)
Received: from wkz-x13 (h-176-10-146-181.NA.cust.bahnhof.se. [176.10.146.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea6493c4esm287838e87.113.2024.07.05.15.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 15:00:57 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>, davem@davemloft.net
Cc: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>, Roopa Prabhu
 <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: mst: Check vlan state for egress decision
In-Reply-To: <20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz>
References: <20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz>
Date: Sat, 06 Jul 2024 00:00:55 +0200
Message-ID: <87plrrfqi0.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On fre, jul 05, 2024 at 15:00, Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz> wrote:
> If a port is blocking in the common instance but forwarding in an MST
> instance, traffic egressing the bridge will be dropped because the
> state of the common instance is overriding that of the MST instance.

Can't believe I missed this - thanks!

> Fix this by temporarily forcing the port state to forwarding when in
> MST mode to allow checking the vlan state via br_allowed_egress().
> This is similar to what happens in br_handle_frame_finish() when
> checking ingress traffic, which was introduced in the change below.
>
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
>  net/bridge/br_forward.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index d97064d460dc..911b37a38a32 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -22,10 +22,16 @@ static inline int should_deliver(const struct net_bridge_port *p,
>  				 const struct sk_buff *skb)
>  {
>  	struct net_bridge_vlan_group *vg;
> +	u8 state;
> +
> +	if (br_mst_is_enabled(p->br))
> +		state = BR_STATE_FORWARDING;
> +	else
> +		state = p->state;
>  
>  	vg = nbp_vlan_group_rcu(p);
>  	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&

I think it might read a bit better if we model it like the hairpin check
above. I.e. (special_mode || regular_condition)

It's not really that the state is forwarding when mst is enabled, we
simply ignore the port-global state in that case.

> -		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
> +		state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&

so something like:

    ...
    (br_mst_is_enabled(p->br) || p->state == BR_STATE_FORWARDING) &&
    br_allowed_egress(vg, skb) && nbp_switchdev_allowed_egress(p, skb) &&
    ...

>  		nbp_switchdev_allowed_egress(p, skb) &&
>  		!br_skb_isolated(p, skb);
>  }
