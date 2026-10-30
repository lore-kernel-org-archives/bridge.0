Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348559;
	b=aUQk7R9RVr4PikcwTMXTShGWDOj4x2iNnYfZqVSiKIM4YWkR6DF6C9tvAa10G78DXrbk
	 JZm75lOh9tttIlWoqZ66Dj3Oxdxsycr10YsHJBk1yi2y9+R42LA0goyKehYNhK5YiC3Th
	 i2JVTYPQWVjn64W0g3j/mJ/pZXYXSBQsE4QDnbkuac/UwIg0CA25711rCRO335qlLbURz
	 RFbJe7iWVbuQcaoBK7nma2menfRgVBXqeK/eLbzQrtailbJszq/RxBA9VkBnawzOkd1SE
	 W0ub3tcWNtfvEnomURot8btZ0ZM2HSxyI+FV4ImOA57P+RODRdHA4SMwqJTivUcTI6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=v92GAJjZbomnBYNnJfUXzhExe9lvts+O0oV7sTd25Fc=;
	b=jhIPim7QIBQ/UYI3TFFPGOcyfIhc7zcJKXjGqMShmof/JH/BJ+xclmB041SFTTiaro32
	 JMO9EQb8p1MrGme9+Yf5/d4uEoP4nsUs1+bsofVjL+pVWI1DUH5OMal0D4GbNl9aIjS5D
	 cosCYIHp+uzOvyOk/4sqq6I2TbE+JdCZ0x1hYxiTu1NKWEncKU2f8m42ks4+Q22uxqy3Z
	 AZvSHUPPc25U9tGYlJMM+j6NcSV4CW/phS4agHQ0Z0e5o0nP8cc4qL4Mf31VhFmtpKYvb
	 IIwHytqMNeoryES+vhHJQDjnAZW8yNfZrq3tpU18ZyUxAJXrptHnTyLvn7ohcqGnwjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=WtWN1F5A;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82EC606A31D
	for <bridge@lists.linux.dev>; Fri, 30 Oct 2026 08:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E82EC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=WtWN1F5A
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so340016f8f.1
        for <bridge@lists.linux.dev>; Fri, 30 Oct 2026 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1793348557; x=1793953357; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v92GAJjZbomnBYNnJfUXzhExe9lvts+O0oV7sTd25Fc=;
        b=WtWN1F5AXUOo9dPc3H7fCurPIfcHF3OhInHQtma/OclKzBsDy++UJD4yUtUUruZHle
         XrrssNV3TKqEOYrQm6xws6NU16puGsy+sFwNkFV4+xgANjcQgb+aGHGTbRjJXLcV8ah4
         p4tvx9YkW9YrTLyCaWhMJ6OSKcDn4WYGa/W/jlevPE2zCAUjTbzSfPahYFHPds7LF+f+
         etG+dd+Qj0xf69N85yt9Etx2M03+e4lICrAbOz4LufZqt4ZLxCO9yLxSx0lEqkc3PVFR
         tS1aeA1GStukUBF8NsnBKVLqzG6gOL17YdDiuVopzv+Hc9tfsbc0eXyfI00hk3nNATA0
         b7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793348557; x=1793953357;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v92GAJjZbomnBYNnJfUXzhExe9lvts+O0oV7sTd25Fc=;
        b=2TAlqyzH3ZsYDxWEV7MFk0aMh9+rEJ/0WOTcqrYs/KjVOhtCop/X7XVmJXvok+mLaO
         PiiS8tZpumzXN+4+8uU4quPdwPLhaZOs7uv/VkQP6MQzATI/IpVOAxgBzh050R7Oi2sg
         yXJw1sF5iwPnY9Pgoa8gU0u3Gu6cx4h/b3QHFLZ5+QM0Px08ncGyIFTVtyz6zQrWTbT/
         kHj9WzYmZVvZQFdX59rI4EaINJ4GaKqXgIJAqDA9FRwIygHNgGpftUcl5D9cpM/cGP9s
         99xF0AAxGHaLloD3dbXl67Qj4VB0siHfEbLqFGxC0uYJc2o9yRF89OrLuVL7svaPo6vX
         bLCA==
X-Forwarded-Encrypted: i=1; AKwUvBzT5vZSjb/6THmevBG8seQUs4hW1xOVkiLUaYD0b2XpcXnSF6OmRYaK4u75rNFAP5v7nCex4Zg=@lists.linux.dev
X-Gm-Message-State: AFq9FYJS3JeadYKXsB8ghw2O90xOhA7FZVFSfjV2ze3ef83H0gJxuAVK
	WXKvWBqPLkSB38c704RffWEOMlWhc4xAUGqq91b2fMG52D+ZCE2KIRuY9Eimaiq5ybc=
X-Gm-Gg: AYBFou1Bu044AHzw2j63v3V6xYEZyOPgYEuSgE4qA4lUBTBiMLRLNpWgU5uND8NPCWj
	M3oPQ8E58sHQM1aa5+Q5espZbPGaV/QItQGzOoGhBVmQeETnsqRXrZNr3v+DP7uhnixMmFoWEcq
	zh5eyRqOcaR7d7WZ3PYCBWpqa3zxr9SrWMLoy3ulY7EbkXWnYJ7IyqJIBSFeitCUJt7JjeN0Nt8
	+t2ZAJ0Wi/KweSgTFQTt/tvKKKyGvAqWrYrcEKKVXEwF0jL3DEG4TrRw8LuYh0tdARzs+HtcPiY
	pU7fG8NgqHDweWUij5wzaRtMuVnLBYcrOdISrXZSeMSctKS68HZEk0+kmEaVHuwlcV2+izf6J3y
	s8G2RWNawKPjrOqKYKmLKXyhMmW+5JjQ/YIunqJFyWJ2PZLWJh0vbBQR+jsJKhbDDSFj/hnKlZF
	4wsmoNbkvA9RLFd9SfuBm3rZwQHgAYjdiXS+ZWEwgRJhzptjMvXPQC+D1joNV3JAxdemAlw/rSc
	MQjHwfV0by51hVYaAw3TFXTXlKR+X9MYia/C/wAzr9g5tBclUUWvpDnft4z3b+bmvYUqtcjx255
	0EhVi5HdeT0iTReBP4b+nMNiO5+xuxMUCKXfyvzizs7QTwQw2ufTIYdh1XY=
X-Received: by 2002:a5d:5d09:0:b0:48e:64e2:4883 with SMTP id ffacd0b85a97d-48e6e2dbb76mr3748074f8f.8.1793348556634;
        Fri, 30 Oct 2026 01:22:36 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80306sm2116937f8f.33.2026.10.30.01.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 01:22:36 -0700 (PDT)
Message-ID: <788c84fa-12a4-4282-9afc-438d3206f21c@blackwall.org>
Date: Fri, 30 Oct 2026 10:22:35 +0200
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: mcast: release the EHT host budget for
 zero-address hosts
Content-Language: en-US, bg
To: Cheng Yongkang <teel4res@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <179328314076.648427.17991367257682028617@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <179328314076.648427.17991367257682028617@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2026 16:12, Cheng Yongkang wrote:
> __eht_del_set_entry() decrements eht_host->num_entries only when the set
> entry's host address is non-zero.  A report sent from the unspecified
> source address 0.0.0.0 (or in6addr_any for MLDv2) creates an EHT host
> with h_addr == 0, while the set entries created for its sources have
> non-zero source addresses and are counted against PG_SRC_ENT_LIMIT.
> Deleting those sources never releases the host's budget; after 32 counted
> sources the host stays at num_entries == 32 and every later counted set
> entry is refused.  The same sequence with a non-zero report source
> releases the budget normally:
> 
>    host 0.0.0.0:  IS_EXC/ALLOW1/BLOCK/ALLOW2 = 32/0/32/32
>    host 10.9.9.9: IS_EXC/ALLOW1/BLOCK/ALLOW2 = 32/0/32/0
> 
> Only set entries created for a non-zero source address are counted:
> br_multicast_create_eht_set_entry() rejects a zero source when
> allow_zero_src is false, and __eht_lookup_create_set_entry() increments
> num_entries only for those entries.  The auto-created wildcard entry for
> a zero host uses allow_zero_src == true and is not counted.  Release the
> budget based on eht_set->src_addr instead of h_addr, so counted entries
> decrement for zero-address hosts as well.  The uncounted wildcard entry
> no longer decrements the counter, which also removes the converse
> mismatch for non-zero hosts.
> 
> Fixes: baa74d39ca39 ("net: bridge: multicast: add EHT source set handling functions")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
> ---
>   net/bridge/br_multicast_eht.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast_eht.c b/net/bridge/br_multicast_eht.c
> index 18eaf9c..548ad78 100644
> --- a/net/bridge/br_multicast_eht.c
> +++ b/net/bridge/br_multicast_eht.c
> @@ -167,7 +167,14 @@ static void __eht_del_set_entry(struct net_bridge_group_eht_set_entry *set_h)
>   	RB_CLEAR_NODE(&set_h->rb_node);
>   	hlist_del_init(&set_h->host_list);
>   	memset(&zero_addr, 0, sizeof(zero_addr));
> -	if (memcmp(&set_h->h_addr, &zero_addr, sizeof(zero_addr)))
> +	/* Only set entries created for a non-zero source address are counted
> +	 * towards the host's budget, the auto-created zero source entry is
> +	 * not (see __eht_lookup_create_set_entry()).  Check the set's source
> +	 * address and not the host address: the host address can be zero as
> +	 * well (IGMPv3/MLDv2 allow an unspecified report source address), but
> +	 * its real source entries are still counted.
> +	 */
> +	if (memcmp(&set_h->eht_set->src_addr, &zero_addr, sizeof(zero_addr)))
>   		eht_host->num_entries--;
>   	hlist_add_head(&set_h->mcast_gc.gc_node, &set_h->br->mcast_gc_list);
>   	queue_work(system_long_wq, &set_h->br->mcast_gc_work);

I don't think this is a -net fix, it can target net-next when it opens up.
You can also trim the comment, it is way too verbose for something so simple.

Thanks,
  Nik

