Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D01C07FB
	for <bridge@lists.linux.dev>; Fri,  3 Jan 2025 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735898392; cv=none; b=Z7guhvyyENKk4q9E8W2h6ybmuSSrUeXBBucCDG2zYtNjU66gq2EE8AHtYdG0B/XJPtmJktPkOPnQv4VXLSLzPuNREeP4vJWB9jVY+/EKmPQJiilQBE0zN/nptFp328O1Yj06kfhx1KnPK8jxY3XxajR7B6JhLQMJQYMUESY0LmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735898392; c=relaxed/simple;
	bh=wII6R6CkHTELP4m9fEmWPJ1g3/ccW7pwWwr3aaYh1RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHwwkuc7vDctNDGwoO/WIAFPR0MZV+FxeqrZZdBpODkeIAZD1K+Pos5kADhVv0jFHPANCvf09ROfSLGBnloCf5KXPPT1kdTqASiDXAttKTmZlGPu4pcKygiJp2XmyceMrPzEAv/Wh4pUzRp6GDhxWSflbm2wtp8j0TpP/4eIaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ZFXvlnFT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ZFXvlnFT"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1937115166b.1
        for <bridge@lists.linux.dev>; Fri, 03 Jan 2025 01:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1735898387; x=1736503187; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FF5769PjL+UoPJW3i3hqulJto6e1WeUkfttVmz9CJ9c=;
        b=ZFXvlnFTC5gbsv+DrJP4Xar5tAUpKU1sN3i5bjRVv0gTALDYRCeN0yLJGxeLCp9+sE
         05xgAL0mk/FSBWNY18LphiFOTpp4xK/Gm3LZMZ6id+uJNgMut85M/Pl7wyAVuHlEHZxa
         a1Dd3wqImjsEbGPHtRh30bd1M/6dtpBjT0uowcoB/n9HcY0eaXjLpoCVVSjNjAwcwP0R
         j9QxCdvQkwS1mLh+P8uBJio0EQD/orjwAmoyEEEcZaOWfJte6JhiiN3uV2Unxw3iwAN+
         PBvV/d0gv+7QlTtMwhKogY62n6i8s/1ak1P44Q6EjT2DsUsEu2RVltQeSU004woj5xGV
         sDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735898387; x=1736503187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FF5769PjL+UoPJW3i3hqulJto6e1WeUkfttVmz9CJ9c=;
        b=hCVDkxQ18PC+jGYVyLVE5lycR1LZXS6hTQ4C9o8wSs5bmhtsBJfO4IxW6OcQ6lFgbA
         PK23xB830+Sm7RjjaAb7efLHQK0Zd8yf7bTa9jvBlIdMDRkH5xjUz0jJw1O3S/vY1y9z
         kLgmDaZcoPA4mb68pQ8wm2RRIka1nBLMv0tonu9JW/s+N42uQg+RtEEcifnkYWxqNeNH
         TGTImyP0+97M6WKV0uSweEIORFnHUKSKQBPGXFsFc48SKNz41a3B5Fmk4ce1euIInlcC
         PcXXfh5QP0XgAYD9xnNqhmiLRzD7LVxS1WCiUoIiuWacTkywPnJna2w7P89rlhnzZjYj
         m0gQ==
X-Gm-Message-State: AOJu0YztnwcFi1PnRhg+iyYWU+IPt76qhiEAdCNrZrHD+XoO2L5TvOMg
	IkwNFhnmJhMTNfFagnAsUanzk53A33IFUrvCMIT0YVf0UMWlIJOtaleuyVYePdU=
X-Gm-Gg: ASbGncv4eyME2YAG9g8zNtDG4ZVaM58zEz5MOM3zaNIrohB/4Uco8y2U6VSbw7tDI4+
	xvpMI5jODF9NUJpVDRpyHaNmAZpC3u6FTZxzP266EgB/AygxoqwWLabewFUIuEeCwSp+tnS8XE/
	fG/t+Y5oqLAkW3AePq7sxAN0J5TZGTfuIdV04S5dG9X9WAQVqGaaCJcPC+4wMHAcsvtT2IHyz+3
	SkaSfkZ3g4HjNXedC+jj+2+uLDurPj0yddGoqSfO3u6Dn8q6ujjw/60PSHWS6mhFD3VmrzwFms/
	1TF9GidpjX71
X-Google-Smtp-Source: AGHT+IHFNrVbuHUJ42+AEeZKTZ9A8Laq0Bh/ynnBiMncFarn5T5E60lnEdA/r32vm961/qNqZfpdMw==
X-Received: by 2002:a17:907:3f8a:b0:aa6:acbb:3653 with SMTP id a640c23a62f3a-aac27027037mr4671567966b.12.1735898387309;
        Fri, 03 Jan 2025 01:59:47 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f01608fsm1864529366b.150.2025.01.03.01.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 01:59:46 -0800 (PST)
Message-ID: <e7a27b5f-a4fc-4eaa-b215-d7a1bb7fc234@blackwall.org>
Date: Fri, 3 Jan 2025 11:59:45 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: Make br_is_nd_neigh_msg() accept pointer to
 "const struct sk_buff"
To: Ted Chen <znscnchen@gmail.com>, roopa@nvidia.com
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20250103070900.70014-1-znscnchen@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250103070900.70014-1-znscnchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/25 09:09, Ted Chen wrote:
> The skb_buff struct in br_is_nd_neigh_msg() is never modified. Mark it as const.
> 
> Signed-off-by: Ted Chen <znscnchen@gmail.com>
> ---
>  net/bridge/br_arp_nd_proxy.c | 2 +-
>  net/bridge/br_private.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index c7869a286df4..115a23054a58 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -229,7 +229,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
>  #endif
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> -struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *msg)
> +struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *msg)
>  {
>  	struct nd_msg *m;
>  
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 9853cfbb9d14..3fe432babfdf 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -2290,6 +2290,6 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
>  			      u16 vid, struct net_bridge_port *p);
>  void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
>  		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
> -struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *m);
> +struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *m);
>  bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
>  #endif

Hi,
This should be targeted at net-next (subject should be PATCH net-next).
Also please try to keep commit message lines shorter, checkpatch flags
this one as over 75 characters. You should wait 24 hours before posting
v2 of the patch.

Other than that the patch is ok.

Cheers,
 Nik

