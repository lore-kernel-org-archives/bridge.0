Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222A3D5647
	for <bridge@lists.linux.dev>; Mon, 20 Jul 2026 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539573; cv=none; b=t4bkwfoSc9bEIdTzN/0WRwmkG6b+5+OjR7fcRHpld/Qzna7DFddWh3wgURyhDVpb2IhbnMo5qhqHgCc91bWRK3GAz20RxxfcmW2aOCaw7ZeZUBu6c+6WEoAYQiuimkp/jqH90a7SFYNvnceOSn3PMmkhqOAHcYFJSVpdr+DawOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539573; c=relaxed/simple;
	bh=1er2AwOtW+Q5pN+4saTyA7iFWqAVhtkHRfcGy0PqazQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMpbnAJoCNQLVWQB6lOS4qWxeelhsusB7RGtSDDADq00ijbwmMozRzoYm2h4inz0D0SkIzGl+LAeNtmItk7BclJ1ar4WJ1HA/t16zZrP6e+ewAWJ3vudchwpeNfvbToQjKgSUkoL8Zyb9O+RCppgVVa5ZAkP5AnBQNwwR0U+MCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=aeG+RXQ6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="aeG+RXQ6"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954afac04bso24116995e9.0
        for <bridge@lists.linux.dev>; Mon, 20 Jul 2026 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784539567; x=1785144367; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f4Q/SpXFodA4HEULFpbuDXr3Dy9TdKlUl0euy6i0Tv0=;
        b=aeG+RXQ6sgzeXdRRti5wX4Rw1vn3Uuljo8OlQHXdQ9iaPdMsIN3sTnqwoSJqROrIeM
         sv+QCj3dgidRBsMEc4nLw5ZiDokC8/bTgrpVc3tzJ3FbvMa4ru531oKu3ARIayPnlUk+
         VzDSshTKrtti5rMa9rNfEC52ViGVfhfDn4kOgLn6hW79cX7NC33kNADAVcPxLybKKSlT
         CUUXcvPiSjgSHDhcJAxlTzxYvNh08qFpPsQYCGjs8i6GDudOV2BLjR46S63Y73G/rse4
         miDOQtIQwZt1MQpPc5p/LdkFCSutBKVjevq4LoznL8eu22SaQHOWZ12RuAiVhmpN5tYi
         +Bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539567; x=1785144367;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f4Q/SpXFodA4HEULFpbuDXr3Dy9TdKlUl0euy6i0Tv0=;
        b=T69yFZ47JMuGHVXh+MpEWOY4Hkc/+Hd6w0TtxiTa8r/8duDhTMhUi+3+ys++U+xBtU
         Mw/kw3pd5sEXOGzkCCQrk0JckqfZ4dXewwHzJ1pGFVcTasHoPFrpHIZANnI5hO9TrFZe
         mLha4vEDm/GRQbEjtyQvTUO+iDnSuIvYBwKCE1jtxVNI52TL5jz8SC6NJOwxiZJFh3mv
         45rf31yUl5ufAX+aqO8aRxPOPWu6FHuzgv6GUIjV8N+6QEjyRBKvqsZuCUQnIIO/4rVw
         hjEyw79O9UatB6pxRkXr3ZoDrTV1MnKgvfOHWcm81QEFbOZYj2UgibcPt/P89uy/6Nrd
         OvYw==
X-Forwarded-Encrypted: i=1; AHgh+RqW3DlIyseV3V14ihvztYsUPV+EX05JCRFS5sF8wFJF2w8B5uA8D+fbdHrnajKpPTTE7JaksI4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxbVr/R4LpddSE/d4IrjrSmBDWsISR2G80r23QjUtTqq0n0GHol
	b8j+G24b31npn5GKI1PzgbkzCJ2HJxAui/vHMJ3itzJYC7imwMpazR3q3EoGOMn3v3E=
X-Gm-Gg: AfdE7cnog/X1Cd55JXOrv7IAKnLUXI2mN6hJIWYpAw8ola+BLgGPABclWHwugysSzV0
	hzB7cBEIPRnsXiCBcvAe+9c1HB8CtxzLz8P/w0Sshfa6JqnGdLRxIEZgfzoI7hpyk8TjpoKx8a+
	tEUrb940/3sdJ1Fqa8/+GKThJw7rjdens8DvykR8HdS0OWcBUF8T+bCGyHCt5Mh/9Zmm5BzJ2yg
	QSHVVD0GlodNvfT+JgKDpfJb+n4Wn3l3nhBviOCPTajsiyHyLHCwUTc7GSd+s5hgm5L7Y7DG89Z
	dPH47ORDJOYT3LvqHf9+v+b/2BqE9tzqymXYES/Es63oUjGkMr+eA0RfiL3+jQdsHYUi9gPCwHb
	wNHUIPhgve6Rq7WdpgCUlhWOy0gzn49JOZR2E3D40nPimwWN2sB9M31011Q4DyYksfRBrRysOlT
	Dh0YGRrOuqRVevgy2YbLfSHB84PhH83ujM1Ppjj+Tk83A=
X-Received: by 2002:a05:600c:4687:b0:495:4df2:7412 with SMTP id 5b1f17b1804b1-4954df27450mr119179575e9.32.1784539567008;
        Mon, 20 Jul 2026 02:26:07 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2e83ddsm256560825e9.10.2026.07.20.02.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 02:26:06 -0700 (PDT)
Message-ID: <27d8e26e-3498-4741-949a-742d057bbcde@blackwall.org>
Date: Mon, 20 Jul 2026 12:26:05 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] bridge: Linearize skb once the ND message
 type is validated
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ja@ssi.bg, petrm@nvidia.com, fw@strlen.de, kuniyu@google.com,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1784463131.git.danieller@nvidia.com>
 <c431f129eb438c12ef1e48d91039e09489a8f862.1784463131.git.danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c431f129eb438c12ef1e48d91039e09489a8f862.1784463131.git.danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 16:34, Danielle Ratson wrote:
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
>   net/bridge/br_arp_nd_proxy.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index 445c930ed59b..46779d9fad61 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -240,6 +240,9 @@ struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb)
>   	if (ndisc_check_ns_na(skb))
>   		return NULL;
>   
> +	if (skb_linearize(skb))
> +		return NULL;
> +
>   	return (struct nd_msg *)skb_transport_header(skb);
>   }

This one is a bit weird - I wouldn't expect the check and validation to also
linearize the skb. I'd rename this helper to show that it also linearizes the skb.
Other than that the patch looks good.

>   
> @@ -259,7 +262,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>   	bool dad;
>   	u16 pvid;
>   
> -	if (!dev || skb_linearize(request))
> +	if (!dev)
>   		return;
>   
>   	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
> @@ -276,8 +279,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>   	skb_set_mac_header(reply, 0);
>   
>   	daddr = eth_hdr(request)->h_source;
> -	ns = (struct nd_msg *)(skb_network_header(request) +
> -			       sizeof(struct ipv6hdr));
> +	ns = (struct nd_msg *)skb_transport_header(request);
>   
>   	/* Do we need option processing ? */
>   	ns_olen = request->len - (skb_network_offset(request) +

