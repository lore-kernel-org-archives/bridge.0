Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560F1311C15
	for <bridge@lists.linux.dev>; Thu, 18 Dec 2025 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054880; cv=none; b=BvQvONUI7DEVyRUGVW0fnpkUxqJU2vNAmHxm8TMaISZhZ0Cqq9mCXEowQe+Gtv0e0qPGFlMjrFoF3+rT51fqy0k/J3lBWm1mctHw4o5SPXAUmYuA7vgeqISecC6oSMfZSLKpyabaYhvDkPkWwbTRAe4GDBrMqqSpWq7X2yPN/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054880; c=relaxed/simple;
	bh=C94wtR82WZosBhwJeXMjomAJoz5qlm/EHE8TbW0CHRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsfVof+jhpd6KqDPooKeb2xfcBcNbs60mWjEbwSlW1lbmRmzCYokJtwip62lu+5Q7k2Pid7rhgk+xI/mwF15tsQexsSHSJ98U48tSIETZzK8jVClB/mcXmIs14bizSS4CaQyVgQ84U+RTOyLhlxpQtJKpE+zG7x1ymQ5fP/gCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=STHyBxue; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="STHyBxue"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso289134a12.0
        for <bridge@lists.linux.dev>; Thu, 18 Dec 2025 02:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1766054877; x=1766659677; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQsHHsPqBsIwtZa6+F15eqWTVM/7tFhJlfrDEbVJnzo=;
        b=STHyBxuejnOFh7OGdzsgcTwsOlo9SgyWpK2lfvl39TwldI5sdeuAAwzKrLb1QsbKBw
         xnS7ab635uTc90FhCAjThlRz0SzT6vC/Dy0wv+eUzFWFzsj6k041Zj/yWz991aGB/XBg
         RZS2fpgNubR0TBKr8eMZZT0Ezkd9odB6TNRG9o48I5maEChsUJEx50aZiHsZWwzj+2qb
         fjZyakTE1isRBuEi/6PGY8dpBXKRHSpYD3fpwkWZYzu5+0G3DoTxvWNvZc/w6Z7Gu0KZ
         QFP088o6I81DC/80kyuznTWnw+2b8xec+Thm6idzs7jm6oMn34bZzPtSUS67nWqBqEi4
         DO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766054877; x=1766659677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQsHHsPqBsIwtZa6+F15eqWTVM/7tFhJlfrDEbVJnzo=;
        b=v0efzEM3W4x4up7UCgsMmVvtV9QKXktu4eTjC3jKoqhL4VhAiUENI2UXUCsuylfGTF
         bKV0cc20qEYzWpS3FDafL/Qhlwjnp6wRyDQjSqsZS9k2MICR5vpDgv037iNzLDynnRYa
         P46GgvcghPTKNuFpUImKWSwccVw1rz4YZMwFw8eaeDJ2Zy0dsPqyAgt2Gh7DFcAzuHO9
         UnAHNeQJcI8F3BTZ3KSdLTG3KlIQz0angc1DWnZ2TRQRv1qFMf2/gPDrqpkobUErW3Yg
         Ktt8s1OZXQM+JXs1KzXIN/o4XS8JkN754v6YbIrDWTgKjX79Kr5Rb5t+8TMJKKzJ0kzy
         CTMg==
X-Forwarded-Encrypted: i=1; AJvYcCW6BQbAmtiAfSpBcaW0tsO6z2voZLXyQwuF+9iyEO+zICU1W/gDU6wHh7TPKccbPSteIwTdgx0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxMFv3+ujE6YTzPHC6W8eZCf67K5Psvu73Cp5vcPZhCosm8kG74
	NynMhNwnVlU/vZ2z071Fh/sOHil2PHxQW5nv54324EF7uW1tV9Kzq3lfHlxAWWlMKS4=
X-Gm-Gg: AY/fxX508tJsWWvp8sCfKUvxboZWvWDCjhiRuKG+Ja+W2I7iOw6d66LIktd+ozgYp+c
	ZpkkfogwoXKkIsQZo3wRrGdzmV3jF0aS/LpEPfBrx1KqQuWXRmeqpLAD0SJXqj+dBIKRZ9bWhad
	1ZBftasYniPrI64vD2aWtHqFVUps6Noiq63MN6SymBXezTbATJjTPi49Ypdd3ZVU0/bH0H2cXj6
	AJu/mqCODAyQoqS/c3w4fUIzhSUpHU9JJ2zQeLQ86ZzPs2C82DHHQDPhHiC3tQtxS1dqDuwnNZT
	gqNhe43mMFiJAwt9IkV2DsEauBCqknpQoePC9RiSuGYLXtYVia1ZQkyM53msOW8LG4REshRquu+
	OCwqNaS6V0hTTFdbf4DDc2/UWT0JVkNcl7Ah7m2zGCTTiKAtIExKkRlk3cR493e+WzB+nMyrEUY
	Z04b6CcZthl/S86AMvV4zDu5TbpXfpkDkdpDvumRI/+Q==
X-Google-Smtp-Source: AGHT+IGXXlccKF4Rkh7bjvtuJ+L+NN0lCcnq831RrYUEbki8gizuqPGa1mG4ZTJ8rHdDDTqFJvX2ig==
X-Received: by 2002:a05:693c:40d0:b0:2ab:ca55:89ab with SMTP id 5a478bee46e88-2ac3014dce6mr15879824eec.42.1766054877329;
        Thu, 18 Dec 2025 02:47:57 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b04e58d04asm3393552eec.2.2025.12.18.02.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 02:47:56 -0800 (PST)
Message-ID: <1688676b-9252-47b9-97b7-c9dc28d7ac8c@blackwall.org>
Date: Thu, 18 Dec 2025 12:47:51 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bridge: Describe @tunnel_hash member in
 net_bridge_vlan_group struct
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>, bridge@lists.linux.dev
Cc: Ido Schimmel <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>
References: <20251218042936.24175-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251218042936.24175-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/12/2025 06:29, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warning:
> 
> WARNING: ./net/bridge/br_private.h:267 struct member 'tunnel_hash' not described in 'net_bridge_vlan_group'
> 
> Fix it by describing @tunnel_hash member.
> 
> Fixes: efa5356b0d9753 ("bridge: per vlan dst_metadata netlink support")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> This patch is split from assorted kernel-doc fixes series [1].
> 
> Changes since v1 [2]:
> 
>    - Apply wording suggestion (Ido)
> 
> [1]: https://lore.kernel.org/netdev/20251215113903.46555-1-bagasdotme@gmail.com/
> [2]: https://lore.kernel.org/netdev/20251215113903.46555-15-bagasdotme@gmail.com/
> 
>   net/bridge/br_private.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 7280c4e9305f36..b9b2981c484149 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -247,6 +247,7 @@ struct net_bridge_vlan {
>    * struct net_bridge_vlan_group
>    *
>    * @vlan_hash: VLAN entry rhashtable
> + * @tunnel_hash: Hash table to map from tunnel key ID (e.g. VXLAN VNI) to VLAN
>    * @vlan_list: sorted VLAN entry list
>    * @num_vlans: number of total VLAN entries
>    * @pvid: PVID VLAN id
> 
> base-commit: 885bebac9909994050bbbeed0829c727e42bd1b7

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
