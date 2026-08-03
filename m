Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4978C9C
	for <bridge@lists.linux.dev>; Mon,  3 Aug 2026 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770728; cv=none; b=ZSk2Zf9BSakpT+RbXj/oOanHoK7Zr/Kq+ym4/CZPYr273/e5BZSFrW2zbc1zWFnU2StdJikyLbNdaouBUOaqByKqpwDItLkVcVwFoGf1mMWgdrkfw4T/qoZSijGGsbNUlIEcQA8BfLAfmWBGkfyOzOQheNT3X/IUSwHKlv4w33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770728; c=relaxed/simple;
	bh=OhJHb0JVLzDI82HddeXGyWsj9t/v/sHkSHf8DTKjUKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiEOCOnpkxEZ4J3fmfMALdlBw4T0ApeSqorLoHF+A1gLrHxpwlneopdpAsEf3lK1MW/afk+dTVgbSIIp36hfYFV2GRq7whnVTacqTu0vtZArNGKrWb6N2BYfxoeCR6TYbJgNWkJECdc51pJnRA+7HRL6agpnwCWUw7zZZxwErn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Wfe0MN5i; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Wfe0MN5i"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso75185e9.0
        for <bridge@lists.linux.dev>; Mon, 03 Aug 2026 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1785770724; x=1786375524; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KwUQ3Wr2m8nBhJ/UMULCTIH4+LOh16SIlVduO+rNc04=;
        b=Wfe0MN5i+yKlo1dB4CqhT/j4DAtqcyzP28rj5t15htKJN0tc1z+OzubT6GFsFlY33O
         aEXdkr398qrWavQgTMFW6gGGK4X5kpC4DiKvOKfb3MI+RRBiBKIwN4JmfwdAvZAV6In5
         TqA8U8QM2hd8+yTqHH7mqfDkz6QMyXC+FZ0dl5KjdDyqBFJGnEPaWXNHc4Qx48fI5TmW
         gdCFeN5qMtBaja68W74Qp67JkyDsqSUVLmKfjRakpzABNtP+3NGetNkL146nBAxn6gsq
         qmRzjb2tkol5AOsSUIpS7KShnRB6fra/ZkGxCKkzVK7VKZ2uH+i9dNQecnjWGVgcrfqT
         7NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785770724; x=1786375524;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KwUQ3Wr2m8nBhJ/UMULCTIH4+LOh16SIlVduO+rNc04=;
        b=awQC+4SpJVDHumjUR6WMHNukpHY871yTScom1PaZCfFfBfmKL7PacZw0Hvwpk1zrRC
         Rf1MUHZ98HN7oKFUnkf2aaZWi3SO5Hrlky7NDteEM8rgArJp0nWrATxvgFleyb2d4jp4
         +K3LAJmEhkfm9Ta3JMiiowxyn8Lbv183a612LgXaWpFtYyMuH1lWjJayO7E8D0J53bOg
         UNY9ISBGecOhqygmi8Z+6RfZtChXJRzksqXUrIgynlvjAt/Wbev/2YUd/fO2GhhUrjJj
         DSTHIZem2AVgQVVQFPyQWx7Zf423cTHgCYmK+OAy/5R410m5ibeBnFIh/0EKbwBlyg59
         qWVA==
X-Forwarded-Encrypted: i=1; AHgh+Rrmlo+svhFPCUKAivk+NGc+ZCsFKU0VMXmgJJqUBqNryjizIcPXMFi4TYANgAj61zx0H5Oloz4=@lists.linux.dev
X-Gm-Message-State: AOJu0YzNT+C1uKF9YINMqiK/332Z3QKweyzeyy8KmlD1b7ij2tbHnovo
	9qEx1GtwRqL2yH3YGJQhzqMQKrdoEru59OWztMFhGTCqF25HbGUuCN+vHZk67WPivVQ=
X-Gm-Gg: AR+sD10AaZw7hnLBfClwJRa/tUXaBYHBAAV+R6NlvAoo9+ScgYekxsN08SJgF10TMLn
	G5O+ITzYbiKWTOOW4bS+aU89EKSEej6vAqR411fgBnL4UMaJIUffzn3Rc7P4IltToBI6f4YMZX0
	NGMsu/Pqh4CLHTIvS7ARPvqNTnITrsfLiv0Kntkb0x5iczD21bqpypwIU4KjOXzC/YBOR9+gRNH
	SfS8pf7bxJ6PoWK1wdrdacdmaTdP0wmGyd7v5Dj157Rpw4mYou4SieRlL3np3GP8z0am5hiMPkM
	+BwnKrAuwU61TOEe3n+fTSKX1Hccy9+wVaa6DsBXlTFiv/NAXcgT/KdjPojlaZJFDoi53E2PoHX
	Jv+V/kbw5+HSp2gL7CWslhpk5p6eIlQJVJipkZ7lspjlDv6icyF1MpGTcBfCmLQ/vqMa2Win8F3
	l7TXYK2+PA3zX2NPB003QQA9n17y3M0beVtkDIyOMGEzvhhSp482xI2Tls
X-Received: by 2002:a7b:ce08:0:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49949f89850mr351145e9.0.1785770723443;
        Mon, 03 Aug 2026 08:25:23 -0700 (PDT)
Received: from localhost ([151.251.47.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dbaesm407013465e9.12.2026.08.03.08.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:25:22 -0700 (PDT)
Date: Mon, 3 Aug 2026 18:25:21 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, ja@ssi.bg, petrm@nvidia.com,
	fw@strlen.de, kuniyu@google.com, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/5] bridge: Linearize skb once the ND
 message type is validated
Message-ID: <anCy4eCZAbz3Tv4u@penguin>
References: <20260803112505.613873-1-danieller@nvidia.com>
 <20260803112505.613873-5-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803112505.613873-5-danieller@nvidia.com>

On Mon, Aug 03, 2026 at 02:25:04PM +0300, Danielle Ratson wrote:
> br_nd_send() parses ND options from ns->opt[] and therefore needs the skb
> to be linear. Commit a01aee7cafc5 ("bridge: br_nd_send: linearize skb
> before parsing ND options") ensured that by linearizing inside
> br_nd_send() itself.
> 
> Move the linearization up into br_is_nd_neigh_msg(), right after
> ndisc_check_ns_na() has validated the message as an NS/NA. This makes a
> linear buffer a property of every recognized ND message, so that this and
> any future ND message handling operate on a linear skb and cannot
> reintroduce that class of bug by forgetting to linearize.
> 
> Since the skb is now linear by the time br_nd_send() runs, drop the
> linearization there and derive ns from the transport header set by
> ndisc_check_ns_na(), instead of recomputing it from the network header.
> 
> If linearization fails under memory pressure, br_is_nd_neigh_msg() returns
> NULL and the packet falls back to normal forwarding rather than being
> suppressed.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     	* Add a comment noting that br_is_nd_neigh_msg() also linearizes the
>     	  skb.
> 
>  net/bridge/br_arp_nd_proxy.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index 445c930ed59b..6b6de0eff38c 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -235,11 +235,17 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
>  #endif
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> +/* Validate skb as an NS/NA and linearize it for br_nd_send()'s ND
> + * option parsing; returns the nd_msg, or NULL on failure.
> + */
>  struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb)
>  {
>  	if (ndisc_check_ns_na(skb))
>  		return NULL;
>  
> +	if (skb_linearize(skb))
> +		return NULL;
> +
>  	return (struct nd_msg *)skb_transport_header(skb);
>  }
>  
> @@ -259,7 +265,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>  	bool dad;
>  	u16 pvid;
>  
> -	if (!dev || skb_linearize(request))
> +	if (!dev)
>  		return;
>  
>  	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
> @@ -276,8 +282,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>  	skb_set_mac_header(reply, 0);
>  
>  	daddr = eth_hdr(request)->h_source;
> -	ns = (struct nd_msg *)(skb_network_header(request) +
> -			       sizeof(struct ipv6hdr));
> +	ns = (struct nd_msg *)skb_transport_header(request);
>  
>  	/* Do we need option processing ? */
>  	ns_olen = request->len - (skb_network_offset(request) +
> -- 
> 2.54.0
> 

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
