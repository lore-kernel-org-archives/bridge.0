Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CCE2367B3
	for <bridge@lists.linux.dev>; Wed,  2 Jul 2025 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445712; cv=none; b=fbSrD19sBDBBgNbESMwNxTcURt0Wp1hlD8IcB7d4qEejh/jrscRUpIjU3AcEe3X//H7BJ89B9hn9EuUtwStOTvNdWjUTfwQ34foZQN4aeP1EQEghNrmdOIekvsekCVrToBcHWxtrV1Bm/m3Du1KqLTBdwB3a0tSs0OP4oX4rbLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445712; c=relaxed/simple;
	bh=yiZwDP3lXQ5zigCNoF6oAAAWr7zjLZWfVbmf4bcC2SA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BnrHXRhkP/DcHzsTdAfBqp+f6+mLYbZFkceS+xw0WhJuHCHC90c5RhIwqQMIOdA/lZLOVX7FesQdKq2ckLKO0+XLufTYh9UecwKdP2ruVIso5Z3hyVsuqPx7Ic4qvJGnsviLQ0Xnr2p2FMiWF2wR0gwezbFdVa3Htpg1KsOVX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=iDkJox8o; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="iDkJox8o"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae361e8ec32so921971966b.3
        for <bridge@lists.linux.dev>; Wed, 02 Jul 2025 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1751445708; x=1752050508; darn=lists.linux.dev;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+g1v0m8aDNnOEfwu4uRQC0dDUg9Qe01yaAwfMhR5CgU=;
        b=iDkJox8oCgpYA6ynRUqyNDGEisJr+hD5G/0tvAb0Y0fXpRf1DOwZZ68FdCvAhvyfto
         aiPn8zvbLZ7AMc8N1bYCdtYElytWg/AArjCijJi36pqyTw8UTufj+6Ll9PaIQtlFyIw5
         070mH0cDL5bA1AUzJ6p7sZYcKWTFzX3Ijb2qTHCof5Y5DqNmP1OqIcNFlqFMI3eo02GA
         LIXn9Lz78Phsls9jjoFMoRvU1n/dusXMUtTAUj6r/5b7dw4h7M6fnsmQtlHS3gTvLkkj
         V1HR5eGKFSQ0LCbLklqTyq8QptgwXj2brIkywPh9WI0YCNiv/24bmg12SJuDIJ1zCi0D
         YZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751445708; x=1752050508;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+g1v0m8aDNnOEfwu4uRQC0dDUg9Qe01yaAwfMhR5CgU=;
        b=bNSQilMbSLUDc+1EfRSisD3GH57YttWWk11msTfdevqyGFAgUu08eVJVrmeY3DEiQA
         lGdTDupNdCfWIwsJy8e+BokZclPhUCPuQ34PHxcX9gzlMfnjRop7nbBZPd8PeQdV5y3r
         NgKrudcbd85NicQ4PG5loPJd2o1OEP3t3eqmIqacvJiB2Zg5WzjWTKOOnUXBa/zN9JRD
         dig6AYzq89S8G1/Q9Wz4kYpa10cI7fWqGQ+X40rVC5h/m9LkraDX0h1PeqB5liWrsm6k
         4+5+sQvNVpwObm6sGMxipXkR+iMZbQ/TAe5LeQ+wkCs8LZOb4OM2U4GYSJ2JxmDrbvgF
         M/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUND6evGZS1YFapiJsoOyYwy+vDPFxjDMJyFBOOqkrFml+gts9lUr+xmTz9OMjXaJ1l6rATD74=@lists.linux.dev
X-Gm-Message-State: AOJu0YzTpu2i14aRjiSUcv2/OzzggarDNt5GXkkrMfDycxca+DKipoFT
	J3HAW65gpFBqK7DDJOfmpoWHWsdlUzy5AWAuMF5Xr4t+3TrGAuAsZbkREci6hVdux40=
X-Gm-Gg: ASbGncvJqEQLGW444rVPIa4vNSLniivmxktiuv46WhWdgu2RiokPWT9E7xZz7JvSnot
	Xv9JN80bQplZCYFe+8WH5uH/QLb9yWUsyYJrpdJQXk9GoQFTZn0oWvqhgVSB47GeTHqaQW3kvYI
	ohVI4pibWcX/WRS32yYr2PLZfKDRStKERZS5V+DCtotatYUTvROAUVRF92anW5HfrCg6iWNv4gD
	02UAPhVnN0W1q0oZzouJLzslD5TnD+yEx5XXk0dPbKGKIm9N1s1Mpdi7Kt1dIvBtm/GqRFtVNEH
	AmlYgnyt36zUN/G4g3ZdYTdOVwt6+qt5fRA6nsdptP8UmMH44u8ewSD6mAEYdUgQ1vPuKXUjKL1
	10yfd+uec7WrwlPOl
X-Google-Smtp-Source: AGHT+IEAT04i+G6dTY7KDU/s2zt7X2lFu59Vom3aNPj/WoKa/U2EndBYJk+f2l1y2tj0gHmlMwt+vg==
X-Received: by 2002:a17:907:944e:b0:ad8:9b5d:2c1e with SMTP id a640c23a62f3a-ae3c2c8b851mr204395766b.29.1751445708272;
        Wed, 02 Jul 2025 01:41:48 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353659678sm1041760966b.38.2025.07.02.01.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:41:47 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <Joseph.Huang@garmin.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: Do not offload IGMP/MLD messages
In-Reply-To: <20250701193639.836027-1-Joseph.Huang@garmin.com>
References: <20250701193639.836027-1-Joseph.Huang@garmin.com>
Date: Wed, 02 Jul 2025 10:41:45 +0200
Message-ID: <87a55nyofq.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On tis, jul 01, 2025 at 15:36, Joseph Huang <Joseph.Huang@garmin.com> wrote:
> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
> being unintentionally flooded to Hosts. Instead, let the bridge decide
> where to send these IGMP/MLD messages.

Hi Joseph,

Do I understand the situation correctly that this is the case where the
local host is sending out reports in response to a remote querier?

       mcast-listener-process (IP_ADD_MEMBERSHIP)
          \
          br0
         /   \
      swp1   swp2
        |     |
  QUERIER     SOME-OTHER-HOST

So in the above setup, br0 will want to br_forward() reports for
mcast-listener-process's group(s) via swp1 to QUERIER; but since the
source hwdom is 0, the report is eligible for tx offloading, and is
flooded by hardware to both swp1 and swp2, reaching SOME-OTHER-HOST as
well?

> Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  net/bridge/br_switchdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 95d7355a0407..757c34bf5931 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -18,7 +18,8 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
>  		return false;
>  
>  	return (p->flags & BR_TX_FWD_OFFLOAD) &&
> -	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
> +	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom) &&
> +	       !br_multicast_igmp_type(skb);
>  }
>  
>  bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb)
> -- 
> 2.49.0
