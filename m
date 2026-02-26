Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90DB288C81
	for <bridge@lists.linux.dev>; Thu, 26 Feb 2026 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110119; cv=none; b=QPy9soQSpgW+mlaqUh0bf+SdtKSj/R78blmo1My2uGcAHOdJM5H0fiSmKOXOTd4N6NwQHIv3fIQ8Xm4C4Ao186Nejx4P8LhCaVCUgNBNPOFkf4uhvNWspwsJEyqvZWGPc+Ul1hIwZvhuBHPj9zlaJlieZnUtHHVnx+1JxnHxScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110119; c=relaxed/simple;
	bh=xCXfprn4FrQzYyIjCT8vcqONZ5mA7SGSBmwwJXyM9g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntgsrEXRNHIJhUBMJPLlf2F1SPzyn0fFU4Vst1niegxgaEn1BQeaVT1G+LK9jGipbXn/PbfAHYs4NG6t8UGNO84sNTpDDZFEi6g+qEDMUZJ0GGDb7OfVwtmlUTELQH9+fOG0/PdsFFwJsoyQoJSMSfhEvBj+GEtPHr0jQAfiI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhmSDdUq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhmSDdUq"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8249fc726e9so520572b3a.2
        for <bridge@lists.linux.dev>; Thu, 26 Feb 2026 04:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772110118; x=1772714918; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SGhBIs3dYbcFk6P/XqQpMpVB1hZMUHNjX+2F9A4bd2I=;
        b=lhmSDdUqphY+7C/EvoAByeHICjU7Yda9JC6zPFl7Tu0WHE8Ib9Ul8Z5WL/3zLDA1XG
         KtzuIiPkZL7SWukohLsmj32k22ODypvuLUqd8GIToovOiCP3w07CjAwJmHkw87ZXhfE6
         aoFQnUsxt71COik176scgIHW2CeqJVl1rKgm1FI3aqtJC88aZeTP5IlHfEPBfnQssDc7
         K7UyOS218f+/QFvi1S0jKl5i5tCC6alLmnpr0Bm/F+kTvmkieCmJ9xT2M5jXHcu/wkUm
         QKm+5suBhU62UXUkwB9t+/Y5Ap0X4vmXgQsgSnUqBfSm8CJaizlsZ5Xc2deXEJmfpqdB
         jz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110118; x=1772714918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGhBIs3dYbcFk6P/XqQpMpVB1hZMUHNjX+2F9A4bd2I=;
        b=UDwLwtbY+QL4b2CtYcy78HodMvmgN5Xgjm4vO81kuqciSDssn0OUmPFI0QfGXU/gPb
         /n+ErkY5URc3g2/e8U5373PtQUjN+XIJIGygi5uRpeMs4Snh0LtKbXscS8Mg1eiJGplD
         Vkc54fvNV3nStppTaTLbg3B0RN0UFIBju/E9Thu7YaAQO7bi0WKJkunB0TFv0AiIGidt
         p/I+AW6RvV9w71FLZddPN4CBGiSl5DowUwncaAlhSeCiwlyVUEZ4k/CKm1KjYhgo9Vde
         o2VGZtv3z3ZkMcKYlU71PqY1uSAx8k+NLCc5WLj3jmdqoI6HjkEvJLhHVq83kRFhaxFn
         X8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4zGbMyXhwd3rVRGsHPSQySk2U16oyjnc8z4Ar3aKzelHhy5CfHQEirj2ggb7nimtA71Vu3Ok=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/7ABeALrGRrgTlODx2F4Bu7fbsidQsM0kGnMusgnHtZUL8it2
	MzPzTcUXHrxoC31e2i3BaKuastV27DzWOpPsJ8Co4nbsHhRZdl3/T5El
X-Gm-Gg: ATEYQzyuVwBd1qFHtFdwBVnEAG9Rl31o5qqFDly1tSKd9tfgjzcMzDE0Vf3+WPzLrk3
	dWf/bGaQmx9u4W3g/Nu7uOOLOWj1GDnPrC5MP6YicT1eXeW0iXE/tiUtHMZ5GdoLR8FziGQmO9L
	z5v3JJ8hPYvB3rOYmCTRHiIABqhoo6sO7cJI4DKxb2/Fmgun9s2Je32vqfp8zbybAqmqeJtNiav
	6cFA2j7Y21HQiCUydDqIHfhQ/6ylyg/c3OfbfU2pccyA7t5xYB2B31hXkneOJTfczPPetneCBJ/
	DqPXmKV8fteMxJecxGUjKdxktRrPCeJzsY6aRUFVspeqovAoz3RdSHeqPuIeyFUfZnHJN9ivv8A
	svmSlw02C9Owi20/MS6jhFSIuRjB1a3i9AyzAyoKO+ZUYgtCyoHFWrmFThN2vC4wozlbtetQhnx
	qo0lhPOxgjAE7y1XeT0TvVvST4B2w=
X-Received: by 2002:a05:6a21:648a:b0:358:dc7d:a2d1 with SMTP id adf61e73a8af0-395ad1ad5eamr4023452637.42.1772110118054;
        Thu, 26 Feb 2026 04:48:38 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa801954sm2040737a12.22.2026.02.26.04.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:48:37 -0800 (PST)
Date: Thu, 26 Feb 2026 12:48:27 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [RFC PATCH net-next 3/3] failover: use .ndo_update_offloads for
 failover
Message-ID: <aaBBG5iu76-u7ePb@fedora>
References: <20260226114208.27774-1-liuhangbin@gmail.com>
 <20260226114208.27774-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226114208.27774-4-liuhangbin@gmail.com>

On Thu, Feb 26, 2026 at 11:42:08AM +0000, Hangbin Liu wrote:
> diff --git a/include/net/net_failover.h b/include/net/net_failover.h
> index b12a1c469d1c..f0f038d113a0 100644
> --- a/include/net/net_failover.h
> +++ b/include/net/net_failover.h
> @@ -30,11 +30,4 @@ struct net_failover_info {
>  struct failover *net_failover_create(struct net_device *standby_dev);
>  void net_failover_destroy(struct failover *failover);
>  
> -#define FAILOVER_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> -				 NETIF_F_FRAGLIST | NETIF_F_ALL_TSO | \
> -				 NETIF_F_HIGHDMA | NETIF_F_LRO)
> -

Oh, forgot to fix this. Maybe we can use MASTER_UPPER_DEV_VLAN_FEATURES to
replace it?

drivers/net/net_failover.c: In function ‘net_failover_create’:
drivers/net/net_failover.c:687:37: error: ‘FAILOVER_VLAN_FEATURES’ undeclared (first use in this function)
  687 |         failover_dev->hw_features = FAILOVER_VLAN_FEATURES |
      |                                     ^~~~~~~~~~~~~~~~~~~~~~


Thanks
Hangbin

> -#define FAILOVER_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> -				 NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
> -
>  #endif /* _NET_FAILOVER_H */
> -- 
> 2.50.1
> 
