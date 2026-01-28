Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75230BF7D
	for <bridge@lists.linux.dev>; Wed, 28 Jan 2026 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616509; cv=none; b=p4tNi3bbQMW91gxhjtM+SJthurQpmD8OwH02MAPbbP1o4ODmPydCS196qIvpH5xpFzcinodMhacPIvGKHT6sfGID26ZGrc/MenMip733rjJC6XZZrjVMHyPg3uTCMnKG/b5p8rzCBOmUVnESm5nr+xEtcqXAnucBoiyV+YWJnoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616509; c=relaxed/simple;
	bh=Ck3/TVpGdm5XlyDxvF+26c/QDieIZ9lm12lyWxVd61Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Na1E6ndRxTIZL4HrRCVJb5TVb5bqZVvnTcZowWXyBEzLQ3Id59kNX1E9CanBHOFGjV2g0c+rLO2jBKdH/uQgRd/IWn58oEPhuZ3vX+svdcMpxoMafn9MlV4L3tY9uFMFq7dtFa7RvB/snluiGFblJkT0qMPuklVKokbYzvR8oh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=YICG/V51; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="YICG/V51"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso128105e9.0
        for <bridge@lists.linux.dev>; Wed, 28 Jan 2026 08:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1769616506; x=1770221306; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiKaoWtjMRDBROQANeCkUjaTheWdM6fcaXZ1pKr3nZg=;
        b=YICG/V51d0qUbzP+uHOAruljn0LF4o23D7rFGHbKhpQg2JMkOr5y5dMZcYJ/xdyB1f
         PwkQeZTaCCy5JoAmXv4lbrYRV8u+PY0JA5z7bTuCJxLkqpS0tt3JVI1+ZQ2XBPsmAkk0
         XvnNaZ0maoYQkkAFq/zsECX5cDUFsyqSZRC0cjSwHaxkIzV1lH0sn0lxzeQsX8Hhcoou
         o2YYFexKYOKQXgKqnQ1akoGdW7mVMSq3lLMoD7QvHuKsCErN2DfazmKSf1b5bYemo33l
         xjKTqkFAmypgBe1lma1pSuFWDHAVTtptedkQfVGc1+DUP6mFDP0+QOgWSc6tZHtfgeOw
         It2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616506; x=1770221306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiKaoWtjMRDBROQANeCkUjaTheWdM6fcaXZ1pKr3nZg=;
        b=V0JddJCWOr7s7onSGmxvESovi9DwXArWzzK3B5MUzCifd9d0xTB1LRioBmPy7WnPka
         QlUQuYQShvu8RYbmEYOJWAgcp77pPUlvtNxiTTHnUYAT3Dcd7w/HaD/MViWsFyKffQkH
         cyC18AMRM+NddKneVIECLNLyxUVne9ALGlEWYBKQgEtnyXNVviaXT9QdxQf0faTEUHj1
         zCv0W7rOtbLyzY6lmGaA2/ccQxFGiDumAkqAN/m+fv6+O3ZGr9Hq9BdBmsaKTxfIb3ko
         bIVkFyixnk2aiiG3nQFgd2bTnkzhowq54vnE4YCUC6IRnKZNIEsqWwfdLubnIRKYWDWo
         060w==
X-Gm-Message-State: AOJu0Yw1+dKnlFxKTv823lcDHSkCKkn0D64pWSdOuntMwkxbH/SQRvwz
	gAvzLm75WxOeAQvrL9gWYy31J1sU07KmFRkwjgHgFAMZnU769Rsnwcm4aS/CqXSR0BY=
X-Gm-Gg: AZuq6aJlop0I4+QptR2Xnn9/8FvXxrW02rXk4v/+2D1QL7dd33LPtKcawStcYp8oWbh
	Tcyc6uc2eJf7GDQ+jA+8iDKAe7rB5EIVWP5FIyzs+JbvAMIUY2XcECpe7u6X7KnFVSYf1QQcbvi
	2wxXISh81zBZ4WDeofRIzznxSc4xiu50CJ4Z/snansw2RyR8YMBjOxCGko+IgCdF3ZWmmcT4f99
	VFTFlKAXv4wLmrxEWMAinnEjEgIQqLYEmXpa5LSqyjQZXg7WPs+yLaNj08PzsVrW6TkrYyMvFBG
	MQELyfy3FaJA2EbO1ITYLy4WyMHMeZmToVeDNTrNuCIIemJ2Ejs87pHsdubwXUb96PuiIiex14k
	CG4XvrOEmzAyhnHWCjihFS2qQMnn1KrvuCoZB+8k/rokhjLZB02Xbw3v4gaW+UJ+NUeVZYN0fAH
	e931DyTLyt1wY7v6g4Ssj5bY4PE8O1urnxzrPMApfIWA==
X-Received: by 2002:a05:600c:458a:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-48069c6970fmr66761015e9.19.1769616505584;
        Wed, 28 Jan 2026 08:08:25 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c40e04sm138669265e9.13.2026.01.28.08.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 08:08:25 -0800 (PST)
Message-ID: <15f092c1-fb1d-4dc0-b04b-a389c53cd62d@blackwall.org>
Date: Wed, 28 Jan 2026 18:08:24 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: fix static key check
To: Martin Kaiser <martin@kaiser.cx>, Ido Schimmel <idosch@nvidia.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260127101925.1754425-1-martin@kaiser.cx>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260127101925.1754425-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/01/2026 12:19, Martin Kaiser wrote:
> Fix the check if netfilter's static keys are available. netfilter defines
> and exports static keys if CONFIG_JUMP_LABEL is enabled. (HAVE_JUMP_LABEL
> is never defined.)
> 
> Fixes: 971502d77faa ("bridge: netfilter: unroll NF_HOOK helper in bridge input path")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   net/bridge/br_input.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index e355a15bf5ab..1405f1061a54 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -274,7 +274,7 @@ static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
>   	int ret;
>   
>   	net = dev_net(skb->dev);
> -#ifdef HAVE_JUMP_LABEL
> +#ifdef CONFIG_JUMP_LABEL
>   	if (!static_key_false(&nf_hooks_needed[NFPROTO_BRIDGE][NF_BR_PRE_ROUTING]))
>   		goto frame_finish;
>   #endif

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

