Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488EA4174A
	for <bridge@lists.linux.dev>; Thu, 27 Mar 2025 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115543; cv=none; b=c5twcQyIIdRgS/swTpEdbMPdERFiQaSmmghcd6gvt/v6JciFTMYJXNYC06TF/qHAqu9lk7Kfl7j1T0yrB/ST082gppbkJUAhhqGrju/fLJULTSylEhJFH/0c4gh76ZASW+3HoJtoZkrtwt6QkvOv1JtVSnPRlbyn8PFtGrJnAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115543; c=relaxed/simple;
	bh=rFD2038oSmfRL/o5UroxR35DdxxjZH24ChwRQngmNXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV9qqcxdheyI5HFdSjvAlU4yhG5xrliq5nfmz+641f24J2FK5SerAvTNjECAmg2W3MpT5zrsq+hTQ66YGt73fqN3Xyqi0lA0lIRy2oGEGpHc0eL+CtPeUADfomXOUfyYlDB+yTEwYlMWE/YKu3KMQ0RvSLSI9cOngYdj97CDHI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=lkZ4xGS5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="lkZ4xGS5"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abec8b750ebso249684266b.0
        for <bridge@lists.linux.dev>; Thu, 27 Mar 2025 15:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743115538; x=1743720338; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tj6ciWOlt5kGG5xdV8VuXH1Me4APKwNx0YShqVsUWxk=;
        b=lkZ4xGS5p5416lMHsy/FkFksg0FlKA6y3kheLr39RjNn5ATM0/OvWEltn7k0IuXVNx
         fI0gsEe1c5QFRG1FyTnxtFj7C5G5A2PyPJx5gcKlLXbm+xsQ5aKgS7vmE1nzbwPgqVHg
         m4A28VYTpGs/yrxRF41F8LCw8re75NfsVAk6oc2p5Ua05Ohb+ffYLxv/7I+v+8DJ7GLX
         0Jj1Vn+GMWB/TkFK0sYRuiRi+ION++CfY4P+4Vlml9u2YfV/CV3xWjtdl/fFzENWmTeb
         kEF7XKJ20vn6AS6QRgxHusHJgtwzz9LuvYda9Esxiwv5uUdbY3BkMMaI2SbMl7FkEQdP
         NNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743115538; x=1743720338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tj6ciWOlt5kGG5xdV8VuXH1Me4APKwNx0YShqVsUWxk=;
        b=kDEUKYWV1o2mqtg/MLsrbKi8RrPnCwZTd1kp5jU0WLn2oSplENBM/YKogX/TWlcn+o
         PHM2fodWMuAtAlyWjGcjpW5GOvXj28YuevhQRuNWS5iUA8TzPdccyA0AkYf8k53Mpj/O
         xRg86MDNJ2fXhyiEfGHdiH1DEeJfcM1zd8Es//U68SC6dHQQ8kM2ff2+z21+Q+HDkfgv
         WRw8h0lUZV0fIWmNqSzwBRrt5ZpiJb5qlxg9xq/2gd9OGkw8M6dUGieo30Hcr37EUX8Q
         6kQwfv3SIAwS+H+DhEoR/stocTNaMbat7vQEQAY9tsE2WQ3L3aQe1f5a58+PAf3sOF49
         /acg==
X-Forwarded-Encrypted: i=1; AJvYcCUVeSEV2f3cd6KMHbs9w4mA524AzAkGABfmoxFhqegbmbU6aNnfP9QQ5lhO9FsRqJxo7dDDyhU=@lists.linux.dev
X-Gm-Message-State: AOJu0YyyDnU/yRvCfgbP+GfDTqCEsSp6zWQHERpHhC8qMV+/ozLKLdQQ
	FUXul5oio5ELXcIGfmu/wsrsmdSrEr3pWZRXpLJSeY6zLuH3RF+WK8fwJxeaOcTAOCQJ4KEvSpT
	E6wiBpw==
X-Gm-Gg: ASbGncu9JB9vHVD302RDVn2S6Nprg26FGUqMc6ZWebPMs0JBABr4T6I9R/R0NkoMXAt
	1khHFcSw7g8ySaIcjUzC4v/h/39Jdrr+bjwb9Htihu2fcPF3/mv19Ta+s+7q8fzMW1XF/E1exYT
	xivBNQxD/1xT8MyFrefwcBS1agOUCoTpjKpkEHFZS+bG8qoV7vuv5npXd6zM+ITXEvh/hhYY1Gc
	tNbo30sPjm5SAHlb8ziowjeN+YaInBXu3josyGmKoaoCAQadu/zSJsGUfOdPnheSFbLs/3GUqHJ
	xO9nZv3122DOikyb8sLsOS52mfE+c38ILxUY3XerC4ooFQWNpAM=
X-Google-Smtp-Source: AGHT+IHwTbd8wqwGflE+/l8QLV4zYq2nasQtO/eu8493RQYDi8+P7mGbK4Y9sngIRgO/EYydTV0feA==
X-Received: by 2002:a17:907:7295:b0:ac3:b115:21b8 with SMTP id a640c23a62f3a-ac6fb13f5c0mr551708366b.47.1743115538218;
        Thu, 27 Mar 2025 15:45:38 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.74.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922b965sm62396566b.20.2025.03.27.15.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 15:45:37 -0700 (PDT)
Message-ID: <190cbaa8-1223-4e64-a583-daf9dfe608f5@blackwall.org>
Date: Fri, 28 Mar 2025 00:45:25 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: set skb->protocol for 802.1Q VLAN packets
To: inuc@qq.com, bridge@lists.linux.dev
Cc: netdev@vger.kernel.org, roopa@nvidia.com
References: <tencent_4B358ADB8A54F04A32CD9933114B8B383606@qq.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <tencent_4B358ADB8A54F04A32CD9933114B8B383606@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/25 20:11, inuc@qq.com wrote:
> From: Liu Jie <inuc@qq.com>
> 
> When bridging locally originated VLAN-tagged packets, we must ensure
> skb->protocol is properly set to ETH_P_8021Q. Currently, if this field
> remains unset, br_allowed_ingress() may incorrectly drop valid VLAN
> packets during the bridge transmission path.
> 
> Fix this by explicitly checking eth_hdr(skb)->h_proto for VLAN tags when
> handling locally generated packets.
> 
> Signed-off-by: Liu Jie <inuc@qq.com>
> ---
>   net/bridge/br_device.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 0ab4613aa..9094ba7e4 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -63,6 +63,9 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>   	skb_reset_mac_header(skb);
>   	skb_pull(skb, ETH_HLEN);
>   
> +	if (eth_hdr(skb)->h_proto == htons(ETH_P_8021Q))
> +		skb->protocol = htons(ETH_P_8021Q);
> +
>   	if (!br_allowed_ingress(br, br_vlan_group_rcu(br), skb, &vid,
>   				&state, &vlan))
>   		goto out;

Why do you think the protocol is incorrect? Did you see a problem with
some particular setup?

