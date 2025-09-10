Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A719D07A
	for <bridge@lists.linux.dev>; Wed, 10 Sep 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518275; cv=none; b=j8OIkUzypVq0Y3tIj4tfwTj6WWXPrdI7H9nh7WcCLrSN4rdwxLcJiQ7ksuyixWGT9pwILT0/CBgZQ2f1HmAw1DOaV8cgBzdP3PtO9QwkUwE+lxLVv9QaRxKwR6I8T3aeDlNe1Q5ZeXTJZeM8J1v/Bu2hUaPgEsWOm/nMCFBR0EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518275; c=relaxed/simple;
	bh=jc2/UzEiHHii7qwYws85Ns4EPsygWxg33Jjz8SvEiiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOioRhqGZabZNumBQ7B5rNs5xwCkk5Ph8kr3SpduNJyfbmiP13fo/V3cansUDU9QiBYY7x/SoIiKJXjb+NFUBtyJ45jUnLHySkf6K83eRmAQgCBR85/sVeCGcxXKCIsendHlZ0tLzh1lowlSY9IN32hTaZv7yLJ0Sd1GX5KPRGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBomwwqM; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBomwwqM"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso4410628a12.1
        for <bridge@lists.linux.dev>; Wed, 10 Sep 2025 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757518273; x=1758123073; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aslT2dP/KbCqLz9yRRveBsORSsjyA/aQ8k1L0oN8zws=;
        b=SBomwwqMB9jThhF5TAOFiVIiC/hvRR88CRtL0hlOAPMJrlMBGhdF67TW9mQJgwREEF
         JtzTo3yMAPpPtC8/DKqP2R0pTvptE+dzFitj7I79GqQcV7ed70AfWwBgeDKtyWh1couO
         UpW64+dUA/h3dTAeYr2CHFNC/k6Csm4UTE2mFEMHGdWSXop6yrJIFdHtLX/NJIq3AFjl
         oha6JbNyPaLRWa1YxxsHOceFtyx8ydUhKj6Q9U/XRh6LBGjfIt9G9Irtm7TybVrw9oYN
         JroltQ8t1U7QDTJBMB0J0WRDECukrDgcgGBm0qzedlilJZgW6SE4LdUBs8Ljs7A6poYC
         4dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757518273; x=1758123073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aslT2dP/KbCqLz9yRRveBsORSsjyA/aQ8k1L0oN8zws=;
        b=tuV4dibZQZustHlrlIKCRLl4uPh3aTgIFAl+/caNjeQKlTQwwxQGl/Qn/drPfBXi6k
         w3gZS+styAhTn5oGjzEDG061JGUW+kB9BvusT7Wl4/G3KAai8jgYUFwjE2AazWM2tRQi
         ZqnJ88c5DjsTbqx2l3kbu0eDswzG2O8stpVG2msVVfPHkeqlWZNQ3X3Hfm6+R8IVRfSj
         erR2oJTw9k4TctdR+rl0ckMQKU/Cft2jg81n/kFmas959lTzedIg0ySxzl14Q0kXHWri
         yV3zdz2TYh+4KxD2xWmeG1q3tzMntpUcjOY/BjRZTHR7BlwheVjHdIdwLo+9wTwMQ38G
         +AOA==
X-Forwarded-Encrypted: i=1; AJvYcCWasGi70ATw7QzwIME5p897hWdq22WFaAvDmDVjOCyAYog/8ZnIuSh3T4IcFeDwf8iA+f7ONJM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzFBOhFP2Hrf12sZmS1y++LiAR0wzLg7rqnbNJpwlm++mWt4MaN
	NfkIIUiBnLj9kLKYspHwckrSL8lUh/pSKmK57vqlRXCePjVXyfA4Csg=
X-Gm-Gg: ASbGncv6C/J9RN4dMbJzYLCq0j2WLPDK6tXCbKZEQVZrjd55TcjPho0IY22oZYnTDe/
	nyyq6YPx0TANyX2GosQ6VhzBrRhsV5Ye5REKBrf29yVELkbG6br6B3nx9B4ZijDB9jc5Pz729sx
	Bf1KxUu0hE9E5fI0hHKaown+fIE9xd18RP3eol6c94h0Zx5jXapzE3cFoc6HyqBgnSgH7rFQCsw
	zNMnAZ8GzGW08nl/f5FvpH4wbSaElLYtitchn6MarYWA5DogkzjbqeVyxZ2NrVGD2OjYtsy8x38
	9lac2gouwMpBixJB2zr6KOe2+Mft8Z9xplBvwMd0fOpyBFtt6oJ7ujPZ7nZn4ArHCWzi/Nyr/QW
	xFN7v1qWYArCewVrRiGNZiGc5d9nnDA/EXFwjTWuY4A5iX2qXEc3QZdQ6n/PdJghm19ZX89y9BO
	o9BvwR4GDiJST1wXmHlelXw9nRhq7Yu/QK6kA2ALaiGRYwKH4a5FB2tmSO2ufxZqXm59c32tYmx
	xB2
X-Google-Smtp-Source: AGHT+IFJAsN22RzEZGX9qXHrJTseEBNmURBALNvMji0DSxk8mi2vxAkq0iZRnzEUXZZujDM5omoPXg==
X-Received: by 2002:a17:90b:1fc7:b0:321:38a:229a with SMTP id 98e67ed59e1d1-32d43ef084fmr19911611a91.7.1757518272964;
        Wed, 10 Sep 2025 08:31:12 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-775f6b42023sm2592143b3a.87.2025.09.10.08.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:31:12 -0700 (PDT)
Date: Wed, 10 Sep 2025 08:31:12 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net-next 3/5] team: use common function to compute the
 features
Message-ID: <aMGZwEnJ943Rwf-Q@mini-arch>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
 <20250909081853.398190-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909081853.398190-4-liuhangbin@gmail.com>

On 09/09, Hangbin Liu wrote:
> Use the new helper netdev_compute_features_from_lowers() to compute the
> team device features. This helper performs both the feature computation
> and the netdev_change_features() call.
> 
> Note that such change replace the lower layer traversing currently done
> using team->port_list with netdev_for_each_lower_dev(). Such change is
> safe as `port_list` contains exactly the same elements as
> `team->dev->adj_list.lower` and the helper is always invoked under the
> RTNL lock.
> 
> With this change, the explicit netdev_change_features() in
> team_add_slave() can be safely removed, as team_port_add()
> already takes care of the notification via
> netdev_compute_features_from_lowers(), and same thing for team_del_slave()
> 
> This also fixes missing computations for MPLS, XFRM, and TSO/GSO partial
> features.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/team/team_core.c | 78 +++---------------------------------
>  1 file changed, 5 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 17f07eb0ee52..c5fbe392fc62 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -982,63 +982,6 @@ static void team_port_disable(struct team *team,
>  	team_lower_state_changed(port);
>  }
>  
> -#define TEAM_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
> -			    NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
> -			    NETIF_F_HIGHDMA | NETIF_F_LRO | \
> -			    NETIF_F_GSO_ENCAP_ALL)
> -
> -#define TEAM_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> -				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
> -
> -static void __team_compute_features(struct team *team)
> -{
> -	struct team_port *port;
> -	netdev_features_t vlan_features = TEAM_VLAN_FEATURES;
> -	netdev_features_t enc_features  = TEAM_ENC_FEATURES;
> -	unsigned short max_hard_header_len = ETH_HLEN;
> -	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
> -					IFF_XMIT_DST_RELEASE_PERM;
> -
> -	rcu_read_lock();
> -	if (list_empty(&team->port_list))
> -		goto done;
> -
> -	vlan_features = netdev_base_features(vlan_features);
> -	enc_features = netdev_base_features(enc_features);
> -
> -	list_for_each_entry_rcu(port, &team->port_list, list) {
> -		vlan_features = netdev_increment_features(vlan_features,
> -					port->dev->vlan_features,
> -					TEAM_VLAN_FEATURES);
> -		enc_features =
> -			netdev_increment_features(enc_features,
> -						  port->dev->hw_enc_features,
> -						  TEAM_ENC_FEATURES);
> -
> -		dst_release_flag &= port->dev->priv_flags;
> -		if (port->dev->hard_header_len > max_hard_header_len)
> -			max_hard_header_len = port->dev->hard_header_len;
> -	}
> -done:
> -	rcu_read_unlock();
> -
> -	team->dev->vlan_features = vlan_features;
> -	team->dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
> -				     NETIF_F_HW_VLAN_CTAG_TX |
> -				     NETIF_F_HW_VLAN_STAG_TX;
> -	team->dev->hard_header_len = max_hard_header_len;
> -
> -	team->dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
> -	if (dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
> -		team->dev->priv_flags |= IFF_XMIT_DST_RELEASE;
> -}
> -
> -static void team_compute_features(struct team *team)
> -{
> -	__team_compute_features(team);
> -	netdev_change_features(team->dev);
> -}
> -
>  static int team_port_enter(struct team *team, struct team_port *port)
>  {
>  	int err = 0;
> @@ -1300,7 +1243,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>  	port->index = -1;
>  	list_add_tail_rcu(&port->list, &team->port_list);
>  	team_port_enable(team, port);
> -	__team_compute_features(team);
> +	netdev_compute_features_from_lowers(team->dev);
>  	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
>  	__team_options_change_check(team);
>  
> @@ -1382,7 +1325,7 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
>  	dev_set_mtu(port_dev, port->orig.mtu);
>  	kfree_rcu(port, rcu);
>  	netdev_info(dev, "Port device %s removed\n", portname);
> -	__team_compute_features(team);
> +	netdev_compute_features_from_lowers(team->dev);
>  
>  	return 0;
>  }
> @@ -1976,27 +1919,16 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
>  
>  	err = team_port_add(team, port_dev, extack);
>  
> -	if (!err)
> -		netdev_change_features(dev);
> -
>  	return err;

do the same `return team_port_add` here as you do in team_del_slave?
