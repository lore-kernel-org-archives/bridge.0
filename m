Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D33876CC
	for <bridge@lists.linux.dev>; Tue,  9 Jun 2026 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989597; cv=none; b=hiIGi3RsHpeIJ6zQcOwsNv8Ja8HymAhicj4p2Y614YgI7w8nUbKwfoK/Is8x3ANAANOnKM40SDTgstTaXiHdAcuKQ1e8XxODf6a1btXxtIm58I/O9BlFXEvX0qRlkjmTB2s2+hCtCj0wtMVsIrrc3J+7LQs2U5mBE+vKiCM6kDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989597; c=relaxed/simple;
	bh=ZQsIwAc4TK4gYJhywJsUtBBFirKBKx79iCXRGMA/tu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jd2dFUQZZdJAYjQ+bZQ/SXG/NklHbiFOKfHgXQIj5i7NMFjigjWA69E9QvGFvj9WPL6YmokTxUphDyjmeg+yHe5mI8KCt/nWYPDLsa7fWk47cfwGraUHAQkpGnEphGkTLTKpGX2PIIV4evEPvp6lbOqKj/FgmUlZWTnZrfmYTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=kvwrvP24; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="kvwrvP24"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so16135315e9.1
        for <bridge@lists.linux.dev>; Tue, 09 Jun 2026 00:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780989594; x=1781594394; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q05dmcAqN63nW0f7el0pgdqxr4o+7V51VBgIj7r5oDc=;
        b=kvwrvP24rsDvEBMKNNdjGCPWfE51oDmaQa8C5Emy3Xz66B2kYFS7wCMuPPEfdIVOWF
         Mjk2YudRXoNSaTF+elOHwOjsg0jxoUyWVilqVmA5u9YNmrNrphwVyV4cnEzIKxR2keBc
         yF7KGSEryZZRmJ6h48Ty3wDyiKQhMqzJB+YXgsQgZglwxZCOw+twHqsRxz6jBgnJIkLR
         7ycsvHhpMoMvi1Gdiy+TJbCNINfCBUVIWmmkJ5nQtighpUsfqlo4DGXEm4QF35O2jzsQ
         I1nn2F7lcu4Xbif50MUdOx/MHea2T9f2FyZUtLAec+3Bs0QHS7gPMrdBFJ8pOTmVn/3s
         rqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780989594; x=1781594394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q05dmcAqN63nW0f7el0pgdqxr4o+7V51VBgIj7r5oDc=;
        b=YavakCwLFl0Y8S0findsCcDeDIsbr4ae77nCVv9GS0uCDm9PkRIoxJSSDd92l4paQJ
         XRRFIleNSHM85yFEl52zYypwwm4bIcQw/A7N1YQwMC4EGgEJ0OIaVU+JmB0+hiOvGJcY
         ADT8EJfiqI6NZV1leRyNXEcDpPFoczqJ0RN79lIY1XZJgMnhlQdx+s1vv7TNeyd5dDXA
         qh5J5YqKcbNeDpy3k6wfROX2AYWqU64a0B8lnxhXF+ymQCs96uvuBWh9CETL3UmL2u9z
         +BZ56Rkm0a2f50jf/BpQDqnc/sjpmDckpUsCMuiXcwGfiV45VoJGpjAyHDF3R9NcLek3
         IobA==
X-Forwarded-Encrypted: i=1; AFNElJ9cLEfiQo37VyoLnx+y4ThUsHrWj2Oi2jZ3B7mOozKHzygZbd2YAit24jQUSh0x3eTHLwn5H3o=@lists.linux.dev
X-Gm-Message-State: AOJu0YzN8JY5oIK2bQzqXlAXCL1KpQDl8v6OaHdd62cwazPSIMqEeCmI
	VUVDyhxAoSI+PvVjLUUJ1si71pkYnfxWVPV9hIgHDQ3DiUTL4cgilSfzDJQ2MR0aYb0=
X-Gm-Gg: Acq92OFPU5UO7Kji2jfsnou8I1nk5Qd3SpDoOrjqD2hcJXwwyIkzGrR7RpECBAcklLe
	VjyzdPwAiixPB45VQ/YB7nenk940F/mEYtrjvpSsKrFcWm+rk/8ygczFkv23dnE5HaRk/svPrNW
	1DiWi8de2Z/ALdZHXco5Y3T9y5vKOO8RZrwkhEKOHP8vb/ZEXIdURVIDAFAfHrUoCQYrKfh5o8K
	50T2g1x8Ig5AJs64KwlD+0BAPc/BlTqCUTdcV24eaJNndtCEM5k1HqLyGNM7npgLdPuUG8Z337l
	5hk49JhKtIEC/A7AQRnRBVCAhJrEy7Brj3mLsStElkich0BRfDuRYQPqVtPHLes6sQWatW0Y7aD
	2JHsSX9ouTdG33Ypi6pygHd853Q19XnyEMeLWLnz0CsdoAt9yZfZwReTWkzgtMxDnbKa0wzYkh0
	Z4YYo/NN7l+00Ij2ogHcX3bl6iYkQ0td08Tp8Yz80G3Svq40TE5xTa+lzwgcoyoB/6
X-Received: by 2002:a05:600c:198d:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-490c25baa0bmr318874635e9.14.1780989593720;
        Tue, 09 Jun 2026 00:19:53 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm494097605e9.14.2026.06.09.00.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 00:19:53 -0700 (PDT)
Message-ID: <7fb9fef9-919c-47e5-94ab-bdfc42849104@blackwall.org>
Date: Tue, 9 Jun 2026 10:19:52 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] bridge: cfm: reject invalid CCM interval at
 configuration time
Content-Language: en-US, bg
To: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org
Cc: idosch@nvidia.com, horms@kernel.org, bridge@lists.linux.dev,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bestswngs@gmail.com
References: <20260609065116.2818837-1-xmei5@asu.edu>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260609065116.2818837-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/06/2026 09:51, Xiang Mei wrote:
> ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> the configured exp_interval converted by interval_to_us(). When
> exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> interval_to_us() returns 0, causing the worker to fire immediately in
> a tight loop that allocates skbs until OOM.
> 
> Fix this by validating exp_interval at configuration time:
> 
>   - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to the valid range
>     [BR_CFM_CCM_INTERVAL_3_3_MS, BR_CFM_CCM_INTERVAL_10_MIN] in the
>     netlink policy so userspace cannot set an invalid value.
> 
>   - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
>     not yet been configured (defaults to 0 from kzalloc).
> 
> Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interface.")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v4: remove the Suggested-by tag
> v3: Correct the fix tag and avoid use magic numbers
> v2: Move validation out of the datapath and into configuration
> 
>   net/bridge/br_cfm.c         | 6 ++++++
>   net/bridge/br_cfm_netlink.c | 4 +++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> index 118c7ea48c35..dea56fffa1c1 100644
> --- a/net/bridge/br_cfm.c
> +++ b/net/bridge/br_cfm.c
> @@ -805,6 +805,12 @@ int br_cfm_cc_ccm_tx(struct net_bridge *br, const u32 instance,
>   		goto save;
>   	}
>   
> +	if (!interval_to_us(mep->cc_config.exp_interval)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Invalid CCM interval");
> +		return -EINVAL;
> +	}
> +
>   	/* Start delayed work to transmit CCM frames. It is done with zero delay
>   	 * to send first frame immediately
>   	 */
> diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
> index 2faab44652e7..91b9922dc3f2 100644
> --- a/net/bridge/br_cfm_netlink.c
> +++ b/net/bridge/br_cfm_netlink.c
> @@ -34,7 +34,9 @@ br_cfm_cc_config_policy[IFLA_BRIDGE_CFM_CC_CONFIG_MAX + 1] = {
>   	[IFLA_BRIDGE_CFM_CC_CONFIG_UNSPEC]	 = { .type = NLA_REJECT },
>   	[IFLA_BRIDGE_CFM_CC_CONFIG_INSTANCE]	 = { .type = NLA_U32 },
>   	[IFLA_BRIDGE_CFM_CC_CONFIG_ENABLE]	 = { .type = NLA_U32 },
> -	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] = { .type = NLA_U32 },
> +	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] =
> +		NLA_POLICY_RANGE(NLA_U32, BR_CFM_CCM_INTERVAL_3_3_MS,
> +				 BR_CFM_CCM_INTERVAL_10_MIN),
>   	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_MAID]	 = {
>   	.type = NLA_BINARY, .len = CFM_MAID_LENGTH },
>   };

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

