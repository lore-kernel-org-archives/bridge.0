Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49041F5836
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162961; cv=none; b=DEuAqjsKEFtGpR0klGT9+pZoXVh6/nh9FA1PU8LQiKWhIpwnjXpqA/w0U1eF2533UqMEtauloiAqme9jHdJVGxVMdagy5VlYay4b9fEDvoARX1d/kj1FKgsW1TnWbpwfNFgwzIWzFr+P4/PvJUfCiHFM26M45961/pJDoPqPPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162961; c=relaxed/simple;
	bh=nefCuvZh9BBXP1HgTB2e4dXo3Ejs7pSEpE8D1o/5fHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5EnhIjNi4I4dKAMrNicmg8sUoFmO0b/TXp4YR0NJZoxT6UO00/3UyyR6Qr5/UuY32caNjY0t/1cdqzBtG0rujZycpHsGCcNzGpSTGu7WX8Wgap2QVHju5aiPYwu4CX8lhJg7b/JsGMLz7IC3M2DoN/VPWAiRSbRTbUMovSF/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Qg97gXEy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Qg97gXEy"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e4c0c12bccso11414329a12.1
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 00:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741162958; x=1741767758; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1brnVJAGUyBrrxRVaMvTP6y55O5yEMp4c+P5cyU9eYc=;
        b=Qg97gXEyluPeJo0nqogSE5iDZloRf8eVx0BEW0DCjm1fZXHnnYSauDBCy29QQtCdBD
         0j2XMZFwz51dIETB7VS2PUhIx3pJk8NKi8wbw5wz7fE/ZdMSXbuZFURCPbRHv+86Im7K
         iMO1s4idOZ7M906IbGrEaXTuAmc7BzVZj+sYnFZ/+4mFr4BjnEbzYkjZWo8Sndyq5LOv
         Gs6yDNcSdXOHiEAeJsfFwH3pQ6rtTsXbBFRsUtRrB4htFOOjqVUpYKKyLvmo2oN5VLPZ
         TOBVXopLByB2iA0yXykPSXLrwKQ+FdK0BCRbDxvHsj/+DDJlNhsuGbJ7xB6Je4L3uFm+
         NL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162958; x=1741767758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1brnVJAGUyBrrxRVaMvTP6y55O5yEMp4c+P5cyU9eYc=;
        b=Kflx6M+jfN2bDlUBbY5wVrVASFynDOn0zePQVSFeF2Fn3BhZau276ayg6SW9Q+wp19
         JZwyjAe1bQsvgZk4NjrzYDMxQDtmSQn5DtpNL/zFcmKMBostP3oQxizgpj9c9Ora7lod
         n7xG6qoGedFbTOGR2DYHpB1pcEGMhU44yfXizaGdV4U9Ke9APaUns34uH6/6coPTa0hF
         xivOVVKtQSbJdo3cjk4A+8gky8APTkvs8G/NwKTA7Yp4vEQ6jYvQ0MBdD3j5BIdMuUWD
         ufAAL52TlhQpCE/1VdfxlHhXLzZLC09LCzwmFCKSSF35phJUKQDUCZeEWDbH7ms6y0K5
         xvEg==
X-Forwarded-Encrypted: i=1; AJvYcCUarDdb3zqmR1EZftWplujMoFjEZTGNT+x3ZkL01piynMorhgsOIP3U67GRC0mC8h+p7GrkMGg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzhLO2xZtMvgiST/Pj27tJC4oanmVans6x3wVwRbW7oP3Rhe1q1
	mVk05tT0cYHfLIrxYNwwVsD01a6ilgF6qWChwYdjrKyRh6up1ZstcGNmbLgslYc=
X-Gm-Gg: ASbGncusiruO7mmmwx3vbJ7SsXeOIQzfRb86voF1CbA9ohPDcVLink6sglIsdmUpzln
	GY4CMTlhIc9jnDnCHZb6BM+HZYWjaJV5blWefATTU2lP14cKaUujQE6GukNJQkaXKnHZE/bN4xf
	d5es+hRMd/u+NA++TuwBg5J5g9HN6GqNce35QaVXvTPXBwv/2UfflLlUOw0L2Yqp4L4PH/n6AwH
	k9hSxDMD2bp6UJyLsaCU6jylnKQO+UlEMAq7mF7g9BLpyjXOl7gv6vjkIGV6rk8XY1jKUGDCLMI
	ntbM5gNI05xPiR7LKu71IuuJS/tUUM86vhOxCaKmaWjtkvQz2l7lGZVKxQpnS+pS1t5CIRcNM2J
	k
X-Google-Smtp-Source: AGHT+IHSB1wDKnA9pHV1GSviWm2eGdZkD28ziFa7v6M0Rd/G5QVSKS+XqVwTfVjxopyszVvymfpwQA==
X-Received: by 2002:a05:6402:40cf:b0:5de:dfd0:9d22 with SMTP id 4fb4d7f45d1cf-5e59f470c8dmr2220203a12.22.1741162957444;
        Wed, 05 Mar 2025 00:22:37 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6dbbbsm9395036a12.22.2025.03.05.00.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:22:36 -0800 (PST)
Message-ID: <350a057e-39ae-4e8d-a4ec-12b2f78f51cb@blackwall.org>
Date: Wed, 5 Mar 2025 10:22:35 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 11/15] netfilter: nft_flow_offload: Add
 DEV_PATH_MTK_WDMA to nft_dev_path_info()
To: Eric Woudstra <ericwouds@gmail.com>,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250228201533.23836-1-ericwouds@gmail.com>
 <20250228201533.23836-12-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-12-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> In case of using mediatek wireless, in nft_dev_fill_forward_path(), the
> forward path is filled, ending with mediatek wlan1.
> 
> Because DEV_PATH_MTK_WDMA is unknown inside nft_dev_path_info() it returns
> with info.indev = NULL. Then nft_dev_forward_path() returns without
> setting the direct transmit parameters.
> 
> This results in a neighbor transmit, and direct transmit not possible.
> But we want to use it for flow between bridged interfaces.
> 
> So this patch adds DEV_PATH_MTK_WDMA to nft_dev_path_info() and makes
> direct transmission possible.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_flow_offload.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
> index 323c531c7046..b9e6d9e6df66 100644
> --- a/net/netfilter/nft_flow_offload.c
> +++ b/net/netfilter/nft_flow_offload.c
> @@ -105,6 +105,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
>  		switch (path->type) {
>  		case DEV_PATH_ETHERNET:
>  		case DEV_PATH_DSA:
> +		case DEV_PATH_MTK_WDMA:
>  		case DEV_PATH_VLAN:
>  		case DEV_PATH_PPPOE:
>  			info->indev = path->dev;
> @@ -117,6 +118,10 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
>  				i = stack->num_paths;
>  				break;
>  			}
> +			if (path->type == DEV_PATH_MTK_WDMA) {
> +				i = stack->num_paths;
> +				break;
> +			}
>  
>  			/* DEV_PATH_VLAN and DEV_PATH_PPPOE */
>  			if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

