Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892DF2F12BA
	for <bridge@lists.linux.dev>; Fri, 27 Feb 2026 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178837; cv=none; b=m/Gk4J7OhcgLSc6VOCv22lcroybMbONHylLrK5P28H4y/eUax/PRcqMIQ2fsEQ3aJX49fuQETQXwuo2P2GQAgxLdGvhm4S7l7HByASC3mGcFLjau0tPdcqEdkPLXiYbzB7O4yYvo0lIlhxXikpI7V2AojB99w9Yw6tRH2xeKb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178837; c=relaxed/simple;
	bh=h9syD6WVkAmzTGwQ3i1VIb80j/B9jUPw/Vy3A2x0Fv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=es0G+AqadLqWlJDu4RIaPRIXm1sEvWs2UA3DaDNPHA281k1uPIUm1UWU/7pRAHjZ48DlKKfqGQ+WazASlzEktEhsDXCTZIPZgCPqlyOz/HkKed79QbjVsoKNJuccjtDztPBPRptYIs9NBJzyx6gUZrpAHRre5X4x5d7EDDcaxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEfLw1AM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEfLw1AM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2adae92249eso19520325ad.0
        for <bridge@lists.linux.dev>; Thu, 26 Feb 2026 23:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772178836; x=1772783636; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=evrPnhC7VvTZpi7YgqhzDnPSPz72Yoy2AMHX8h76Rd4=;
        b=KEfLw1AMf0oIa5kMVyfwLmEkW5jkR81+SJdkQ2Snq2Ms66EPACjlv9Mmk6mefYhVwr
         BVH1fO/+P/Wf4hgstxvasC4G39cKuO1AmxeDSA4glW0BsAVG7rnwlX2qJy9BBs+BjvCF
         DwxGhhxj7h/8xZbcB6o0ce1IiUmsmLj4YY7juG2ScRuduiK+lJRLTiZmhcGEO6UOnW33
         CcGv08JvGPqQWnQHeMa2YBbtOCn4WLA+ETrpToHASsn/NFzcx4zNAEMn01CdV6WBRWho
         p5cNYebCkATR/j81pjegmhVkg3Fo1RjC/LW83pxW9XeQ/uyoWd46oE7radzNwUjHSRRM
         gK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772178836; x=1772783636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evrPnhC7VvTZpi7YgqhzDnPSPz72Yoy2AMHX8h76Rd4=;
        b=wrpSyrkvS5apHjqGBlhd5xHpp9Ba0iOJqyVA06BEuFuxotj6mbXnskLTOeXpM6yzuy
         yWtMlndxsIE+8lYwFhwCYA0RoKjLTe/rrfiefF0udThPl9bHTBETd/YBjOg6WF0iaN8K
         /8QhD/Jbxzv8tVUtXxZCi2OmJC+pS2hQ5gG5JEKllCkWIcKi1TGLQcFuOKDmAl/KptA2
         pfuRzXN1zBYiO1IA5iRWkqW+DyOKvYcwKOR5O9veLme++QjGbgS/B1zpYI6QvB5bkMSG
         JDcNzZLgCKNmlAuFHiM/bi4GBrlkMxK5QRfAvWSBOQGowebdz0AwJoQU2WUEZ4mXwK+H
         juOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQfHc52JtEK+J8t/TAwlybYcHaCV4H+9isbRSzTu4/zbpwwxPfG+Hy2Hjqj40j/EN55mye6/A=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxqv37PeThwvx0zZ7lMlKyLUkbhBrrk5sUKMsYq9ps7WnYNyMih
	hzCZdnYthoUuhseAd37bJowqdZzJiZBEAFtXedbeNROVU8PC9M0IVGrLqQ1Ss4DwyBA=
X-Gm-Gg: ATEYQzyURVifss3Nw42Zeg4ma1PYrSGVFlgWlBPfTWt1/x+6MZkmrNlc1u0ZFAO05xN
	/A2CtXpSoLy953IC6ArSdpvmFNYDCeckSXk/GT1RUWx/evb6cz1q1igUR+0pYtzCxeKveyNKLyj
	utLrIBRuABBrHQWbIJ175WJto5IKmJMSbtTGZX1IRZ57dCuc+3ucGwCiKohnVa8tDFPTLy1ZV+l
	hmybNJ3ve6gs6TcoV9VzpDS8cxRGMQkr6OtJbi5qO9Ribs23F8GeLMh2GMtmZnEI2OGLdab/FPm
	m0AXPRsYEJilgwHPjLYecTjAK51e+8HLV0+BCbdul903fU+VhB4tiObNnYntkjXUuSv1Q88Wqri
	vTHTEZf4e1ES2urS57Cw1bIKG2KxLBQfT0Q8tWzsUVtm9pfo93zlHDAUsd2w08EVSQokZCnbEZy
	0hkR38L12kIAEef2K25yik0jR+TFE=
X-Received: by 2002:a17:903:1208:b0:2ab:3cba:42fa with SMTP id d9443c01a7336-2ae2e4b4c52mr19615825ad.46.1772178835895;
        Thu, 26 Feb 2026 23:53:55 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b257esm46817515ad.4.2026.02.26.23.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:53:55 -0800 (PST)
Date: Fri, 27 Feb 2026 07:53:46 +0000
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
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [RFC PATCH net-next 2/3] net: use ndo_update_offloads for
 bonding/bridge/team
Message-ID: <aaFNilMyFaD9cA2u@fedora>
References: <20260226114208.27774-1-liuhangbin@gmail.com>
 <20260226114208.27774-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226114208.27774-3-liuhangbin@gmail.com>

On Thu, Feb 26, 2026 at 11:42:07AM +0000, Hangbin Liu wrote:
> Convert bonding, bridge, and team drivers to use the new
> ndo_update_offloads callback instead of manually calling
> netdev_compute_master_upper_features() during port add/remove operations.
> 
> This change centralizes the feature computation flow:
> 
> Before:
> - netdev_compute_master_upper_features()
>   - compute offload features
>   - netdev_change_features()
>     - __netdev_update_features()
>       - update other features
> 
> After:
> - netdev_master_upper_dev_link()
>   - __netdev_upper_dev_link()
>     - netdev_change_features()
>       - __netdev_update_features()
>         - ndo_update_offloads()
>           - netdev_compute_master_upper_features()
>         - update other features
> 
> This ensures offload features are computed automatically when
> upper/lower device links change, removing the need for manual
> feature computation calls in the driver code.
> 
> The netdev_change_features() call in team_uninit() is also removed
> since it calls team_port_del() for each port, which now triggers
> feature updates automatically.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 10 +++++++---
>  drivers/net/team/team_core.c    | 11 +++++++----
>  net/bridge/br_device.c          |  6 ++++++
>  net/bridge/br_if.c              |  4 ----
>  net/core/dev.c                  |  8 ++++++--
>  5 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d05837c0713a..7043ee022980 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -8893,6 +8893,9 @@ static int __netdev_upper_dev_link(struct net_device *dev,
>  	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
>  				    priv);
>  
> +	/* re-compute all features after adding link */
> +	netdev_change_features(upper_dev);
> +
>  	return 0;

Another benefit for this change is, after calling netdev_change_features() here,
the later netdev_sync_lower_features() will disable LRO automatically.
So we don't need to call dev_disable_lro() manually in
bonding/bridge/team/VLAN. I will add this patch in next version.

Hangbin
