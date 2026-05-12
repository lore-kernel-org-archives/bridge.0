Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409CE3C553C
	for <bridge@lists.linux.dev>; Tue, 12 May 2026 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574564; cv=none; b=Y5t6znEF6g2ZCfbcg8yyMu+6sqfemZe3MSql1IqB7Gz9Xfsy2PBcjm+otBrpGhqjz03Vddlg7f1v7NPgv6SMrNGOMoDmTjiQai37eyFdB2hoF0JyCgdnjCtSZvY5XNiAX/e0dXtp1sLcqkhi7nmebkIlGf6N4ilEgZcc0ePnPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574564; c=relaxed/simple;
	bh=XSUKlyPXQjtYXxb7m5qC2pdYB0fFCekz9mHLMvhuEPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZVL28aE4AsDt9EG+DPmsnSzLFT3332LWU9c7/8EHI/8ACA+zQSJHPMPKFzZkKyPK2oVnOwp4enbo//qdLuTrDDEifPh4Petu9XI2ICDNCSjFVpA4v4Ty0iiRyFNw6GN/TqlpsQ/R4b4Ipsoor6LB1SZ+8eHCJGnhw+t01QH9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HkLsKETg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HkLsKETg"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d7645adbdso2817400f8f.1
        for <bridge@lists.linux.dev>; Tue, 12 May 2026 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1778574560; x=1779179360; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXZa6qDwstyRO0OpnTlrlrZgvCtyoANqsIG4MYUa2C4=;
        b=HkLsKETgmLuouF3hkgbiULDQZpl02GJ4geRTYCHtTZTV5p+ySjkjkOs3NTRMy+9gDo
         tTA6TzOxRIwoRkXNLKL3kbenO18qFbticvgEvwOWQUjK1QFDu9m1rl+44WJZxxDMi/I+
         /Mvp/tXJg07PYnSC4+AZClzYNxmqu+rZT7pzkU7KmqPptUPd4jhjHdZNe5WkKVbm/qFa
         PzE3ibl5+0TUPUtrD8VJ8q3YrrS+5mhB2DkHjqeb698XAZ/YxfyVJsXkQlVi4suxIMoi
         YgM4+0pvQcSYwEQjjKUCqH6eAPEG1CvkK88T16H8VD6GLCuZauBo4zmo8YdlZkCyNm0+
         dM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574560; x=1779179360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXZa6qDwstyRO0OpnTlrlrZgvCtyoANqsIG4MYUa2C4=;
        b=fXBefjSBshUWNwo3z6e46KX+egTKPGXKdXLwocfT9vRfMSQifSx6JsX9TXWZpqKPao
         cIPo7HZPo4/hvBAcWOamcbUFrwskJDCF0DSS8HjwHePEPPkToGUM8O5C93hJUqGSzREr
         Fowsx/qjEJfTI4PInuUPSSHREPNt2T07dtp68Ad3QwIkXzN63/GUL7ucWeXdIu/w2xa/
         iJMpCfdkuXa+S/5pzUVFSdDn4zitjFCYPz3vWh5fD4uZROoV5mZ0PeL/XgPr2QkrRU9L
         ac3DG3if0LOsZPRkXxpo7ksZaOzxTit7IpBuly2d6qCRknicYGNz+jIfvvvQ2nBHBY1N
         LBug==
X-Forwarded-Encrypted: i=1; AFNElJ88Fxsv2X1FhKe2JmCMvV/bnwreC/3U8HrYSPSVOZc7H4rdoyWztV8Oid/cPUyhLPDFr+N1mJ0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzQ2Ht0O9YcWpUIrEuKjdzP0H+fc3rFz8FZdp5suLm8dPgW7Xr2
	P5y+ZVodWXq1/5zVsI6+2v7OBzKXvatUQ/U2zqq4QiVozOtMCta/boA18iZ7be44J5I=
X-Gm-Gg: Acq92OGmhZo4UoYvbfVgnAW7ki+lnKO9mGo+Lm4ezyDlmFnV56fGoBfnH/NMupX9LpE
	aY8yh1m3yC9x1lfsGs14cfkl09ecQBpNPtrLfxQraTbrxEIO1CDzX9sFipBEJoXmjb+LJIA2TRm
	T37eJRHn2mQjmf0YazksEhNnixCg51y7qsaf5bjTcje8RiQ+aRSvg9PI+psj7nIC7lsKl2Z6qfT
	W/zKOw8PQ9zT4X9hwjzqB/6joMxuMR2zuEAAJ20YrB6I3KUJ+EiZNwP8kMUkuCEf/3IfvAm6awg
	xC/1BYYMe+WNlO67bF9Qj1/YBQNCPLJ2y6+Oi3U8yW1gXgLfJjcs2Dp2+ebsrlg+utAEcDU7TfV
	g1s9wJ8BEapJAYgEBpk+U1+sz/+A68eGNRgTTccSIIKkAOdVx/p7T/ppg0RHIW5EIAPam5kOH3+
	SNMqzbFOBjNFlkBvMyIJq/UpMXEKg3yD1wMK5vWKNLKuh3SJ+sXKkG4L+Obnux4OSu
X-Received: by 2002:a05:6000:2207:b0:441:1cf9:4f06 with SMTP id ffacd0b85a97d-45b13e57a90mr2629777f8f.31.1778574560083;
        Tue, 12 May 2026 01:29:20 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm30756065f8f.14.2026.05.12.01.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 01:29:19 -0700 (PDT)
Message-ID: <1bfd86a2-e7f8-42ef-8486-4d7fa91b2199@blackwall.org>
Date: Tue, 12 May 2026 11:29:18 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: guard local finish against missing
 port
Content-Language: en-US, bg
To: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org
Cc: idosch@nvidia.com, fw@strlen.de, davem@davemloft.net,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, tonanli66@gmail.com
References: <cover.1778504155.git.tonanli66@gmail.com>
 <ad183a40c4d906f39e03590b371fdcfdffb863c6.1778504155.git.tonanli66@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ad183a40c4d906f39e03590b371fdcfdffb863c6.1778504155.git.tonanli66@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/05/2026 07:31, Ren Wei wrote:
> From: Nan Li <tonanli66@gmail.com>
> 
> The bridge local receive path may be deferred by netfilter and resumed
> later. By the time br_handle_local_finish() runs, skb->dev may still be
> valid while its bridge port association has already been removed.
> 
> br_handle_local_finish() unconditionally looks up the bridge port from
> skb->dev and dereferences it for source learning. If the port is no
> longer attached to the bridge, the lookup returns NULL and the deferred
> local receive path can no longer rely on the port state being present.
> 
> Skip the learning step when the bridge port lookup fails. In that case
> there is no port state left to learn on, so returning early preserves
> the normal behavior for existing ports while avoiding access to stale
> state.
> 
> Fixes: 8626c56c8279 ("bridge: fix potential use-after-free when hook returns QUEUE or STOLEN verdict")

I don't think that is the correct commit, it seems to me this bug
has existed for a very long time. From a quick search I think (Florian
please correct me if I'm wrong, but I think NF_QUEUE existed back then)
it was introduced in 2010 by:
  f350a0a87374 ("bridge: use rx_handler_data pointer to store net_bridge_port 
pointer")

because that commit removed the same check for a NULL port.
The patch itself is ok, it restores the check that was there before the commit
I mentioned.

> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>   net/bridge/br_input.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 2cbae0f9ae1f..5b0d7450de5f 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -247,6 +247,9 @@ static void __br_handle_local_finish(struct sk_buff *skb)
>   	struct net_bridge_port *p = br_port_get_rcu(skb->dev);
>   	u16 vid = 0;
>   
> +	if (unlikely(!p))
> +		return;
> +
>   	/* check if vlan is allowed, to avoid spoofing */
>   	if ((p->flags & BR_LEARNING) &&
>   	    nbp_state_should_learn(p) &&


