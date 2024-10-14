Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE0136353
	for <bridge@lists.linux.dev>; Mon, 14 Oct 2024 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887824; cv=none; b=pEDn+TidKBgl1VXJpUt0wuMqti9HNDYhlyxBub49Ug4rp59b/zbPG9g1hPI6GArp12utU7KwMSQZYITOArxrGIuWc7C6nHbSlPiTC+8VwXSsRwViGFoLd02v5B7PgTxiT0hW8Y8n4nlkUQyudPNNVIbL3GGApb011GdfFC9JFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887824; c=relaxed/simple;
	bh=HLEWN8F2imePOAbI3obQsi4luEyITeU3XTYrIFTHsg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkQBA+7IagMBy7h08KS/746payKl4qy/HgemnUuuRMy7+JbK2050AiEYLwwcsrCCUCOXJFlKiTkpLfN/anDoWlu1Rdak7dtqQGr0q962zreTS33hQsylrwdvDad8Ia8C6XEsbQNDwoDcQz2tv8eUIRAVTfBWh6xfpa7oKacQ5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=jbIzbizZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="jbIzbizZ"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0474e70eso148364966b.0
        for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 23:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728887819; x=1729492619; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/x9sCHASM4Rf3zEKoLCrNEGmjLCGHbguwi/XAkNj6o=;
        b=jbIzbizZH0KU9fDhNJlVMFF3GfLF8D15ElvGKoOPJqhOR7N9gIJUNT3vx2Tssen/F0
         Ke7LFNVptIuHeRTbvRIL3UF+h9R4nEwz9NEl5yJ0j7CZMFZSjeUhm9N/2ftCRX/FGziE
         gFEE/2+feUh7JZBibNRXwpTeTT7vi6NX7DHQ1UJ0BI7Fhn3eeYBP/BWuyJcqp6fPE7NS
         +62e5TbYR1CGyXRnoJt5W9TKuFHtAyLYhIWt9JTinKTLI0TuDxYmTG/VcU38LR6AEDrT
         /NTiTNGC6APjLAAwH2rySthHz42cq3EFq1F0c+M4TyCTyUcvgdttjZomMyaT18hsuhZ6
         uesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728887819; x=1729492619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/x9sCHASM4Rf3zEKoLCrNEGmjLCGHbguwi/XAkNj6o=;
        b=k1Ru/O+j8IUy98U+e98YaU/axjSMBmNLCk5+vp4vYk00gSK0n0eDtMXQ/Zsv/27P62
         GB9Y05Nh6OC4X6I2FBdssj2jmU4yBojlUN6A/oDan5iXCP4Qj01Lg1nJ5xD44I6tgyng
         e/iKRo5Cs4Y6vVkq2MWkLWqoKg1t1SzSVMjw9euIF+tgcUKUSWhGz7yfugN/3yQruVjK
         TqQ+Yb1fUIHgP8wTMoQ5aO/u6OpoxoIHNBXoo1YCuBb0mesHIxuxexgreUH2Uu58oGil
         Bt5CpXluwYupCR3xd/77gTThtXMLs7PAMQgBDf6xA+BsIU91bkgwF16hiN648GgNzM0S
         Lftg==
X-Forwarded-Encrypted: i=1; AJvYcCW6umkRWdB+TpB2cFxO617wjhIPH3mY4sC9gmrTqP2vwk5IAmkU2o5/mFkvZYELPfxUs9CxoGQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwmKubm8Hn7O515cnocX20pS9imMfWHnSg7yQeq/9iz8OOmXq3R
	aL8TbRNll5/hybOsR2N8CbXvsofuSnT1ZSrTeN5UbwK1Z0TXaPZilDpDPol/1tY=
X-Google-Smtp-Source: AGHT+IHOmz4mXDYoNl9wKMY13pPq7T3XsGapXwSYgN3NOm+dxPajvUmbY2eZ6VnNrvCAhA5bOXjuSw==
X-Received: by 2002:a17:907:ea2:b0:a9a:33c:f6e1 with SMTP id a640c23a62f3a-a9a033cf8b4mr405516566b.5.1728887819334;
        Sun, 13 Oct 2024 23:36:59 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99fcb57647sm206072266b.129.2024.10.13.23.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 23:36:58 -0700 (PDT)
Message-ID: <6c0154a9-b21d-4f1d-af74-19690dad68a6@blackwall.org>
Date: Mon, 14 Oct 2024 09:36:57 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 net-next 04/12] bridge:
 br_vlan_fill_forward_path_pvid: Add port to port
To: Eric Woudstra <ericwouds@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241013185509.4430-1-ericwouds@gmail.com>
 <20241013185509.4430-5-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241013185509.4430-5-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/2024 21:55, Eric Woudstra wrote:
> Lookup vlan group from bridge port, if it is passed as argument.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/bridge/br_private.h | 1 +
>  net/bridge/br_vlan.c    | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index d4bedc87b1d8..8da7798f9368 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1581,6 +1581,7 @@ bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
>  			     const struct net_bridge_vlan *range_end);
>  
>  void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
> +				    struct net_bridge_port *p,
>  				    struct net_device_path_ctx *ctx,
>  				    struct net_device_path *path);
>  int br_vlan_fill_forward_path_mode(struct net_bridge *br,

You haven't updated the !CONFIG_BRIDGE_VLAN_FILTERING version of this helper.

> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 9c2fffb827ab..1830d7d617cd 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -1441,6 +1441,7 @@ int br_vlan_get_pvid_rcu(const struct net_device *dev, u16 *p_pvid)
>  EXPORT_SYMBOL_GPL(br_vlan_get_pvid_rcu);
>  
>  void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
> +				    struct net_bridge_port *p,
>  				    struct net_device_path_ctx *ctx,
>  				    struct net_device_path *path)
>  {
> @@ -1453,7 +1454,10 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
>  	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
>  		return;
>  
> -	vg = br_vlan_group(br);
> +	if (p)
> +		vg = nbp_vlan_group(p);
> +	else
> +		vg = br_vlan_group(br);
>  
>  	if (idx >= 0 &&
>  	    ctx->vlan[idx].proto == br->vlan_proto) {

