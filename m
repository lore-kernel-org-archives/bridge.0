Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE5156F5E
	for <bridge@lists.linux.dev>; Tue,  2 Sep 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830133; cv=none; b=BXNGjaPCL839MqgCG9tLiTTNModw7dn54qFH4AKFbyBHuGn+ybBQPjYG1M+Ijxi24loGWk4O+ALSWbJbofXZZz8olDSrOs698MEWAeZV5+Nc5AptRo/xPbB613+En9Qb8hnHFdz9gEg2JrGKMCmHPHEC0JdLrYeIfZ7RLNOdZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830133; c=relaxed/simple;
	bh=T/KjOOsLhvMSRHctLIe0sEbSL/AegU7tU/jzAHfFzho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcuLbJJnMMWrrodz1MLBnvlnBMv/xLj5ADX2ojKazhooCRnDPgGue01cBQaU4Mdwqc6sYIkNNOavIS5TigAAqlytQCoIqwuN5k74KBZlVDpGA94XzWubbCYhiHAedxqR6ZhWkEA3HaoerSDTtA04Hv7Zui1IOx9PAGiGgF47waQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq7Tkokp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq7Tkokp"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b471737b347so3601785a12.1
        for <bridge@lists.linux.dev>; Tue, 02 Sep 2025 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756830131; x=1757434931; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrhZ8SbifWNGRbBXiNjXeMkZVlU0hBJ919giQwu5/3M=;
        b=dq7TkokprDn9rW0/59lRhV3oYx+Ihiiq+rDAqfoELsxtF3wf/Ta++898qlCge0oHM5
         LP6QoowrDCsUPeABlYSvvRNiu1R1O0HMNowP3xlXoLqrL8hMFXdahsXSlIyx7Xw5G8eA
         HA7KV9XVaMHXr/415cIHSW764jj1hIrTuLUar4s6g8MWD/pjZJUbAWcXD3fP/WQZ+IZ9
         bBwfwwAH/ZbEbB0Kqk97IzjuYhFMGPzKX3GN2zgTFP4zoY/0/ofBWHcMT7zVGQe2CNlD
         NhhAq7HBclqfRi0qq8uSGnnC9tJX1junHsjsMDhwtE89fRxds3F4dHFr1B60TMfJBPc1
         s+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830131; x=1757434931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrhZ8SbifWNGRbBXiNjXeMkZVlU0hBJ919giQwu5/3M=;
        b=bsPFQQU29Xs+GJJeWB24SwMQdAL68+r3cLJ8zljRM9q7rqqzk9TWJxUq+kVJTa/lJr
         j48sOXOpWLcq0U8kirWnQ0LPr0dTaRg9Z7NzTO0GkoADvwPrxGnS81cUnFQTat7jdIzR
         WEVKcP7+kIog7EkDBd4FU8sZ8OC9TmcoXYC2OJXG3mvff7mfbjD3y/s2PqVdpwJAd82a
         eETqkSw7TIv9C866Z5apz4LNucxxlmJnHIjTVs/MZO8OPXmqumAP/MvlFxlkXh25fXpw
         Q6mdfMC11mEEv7XAUo8kldePNGZFhPHZonlIC5f1hupWXDZ0H3dLFhls5FT6wz9q5/Di
         IOxg==
X-Forwarded-Encrypted: i=1; AJvYcCXHoKB+p8CgVVFtz2Xd914BF67dNrlUtoHuNlDFAv0InP/0tbBJ2GxojIJm5zmbLNQqBgZKcXI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzgIDpBHq/MuNXWGiNbthSSeMlmlmnmx8ouQzgbEB+rNh/tNfSS
	sSdzvOUz6g3ZF6hLrYkzue8yMcAC0OU5ht9ALLxfsa9TmnxqUQdFAAo=
X-Gm-Gg: ASbGnctOhZc6zApmXcubKWzUrqSHI6GYrGtKhMijMuDBUK0yIQyiXlMBruAVyevvmxu
	Ot2XT/uodFraWAJr4YQDnesZzT28nu53SiS1tt8GmSmB4w2sQLpXUrdVfKFclBzFycaWFPA58Fk
	26tdWtmpeB8ssuEKIPoT2PvososGfhBpPne9TmQbK2p9JGhyuxofl6NE8uKc2vi+5jD0x57AR1m
	JCnczudyKfR5UaeaJeluT/kcBc3KTZfUr7a0eTTMiuQ9FvFIsSJjOAridhFTcrZ4OYvt7XH9dQO
	+XwYg8nFRoIBhoNNOY7rXHprpt9WXLRAEirzkuwl1jSOdGtQWIXGJvQnI+sS0n8rz0vDGCCe7B7
	PpLQ0LGMxq5M/m4pYDFyv0RIQd6XZc7TsCyUH9wqA6W1zecLI52NIyaOMJZ1urhllpwoDDhvHok
	Fzip4Sj/ZS5VoUbZLpcue/5+snRzOZICnDxs3ZZek/yaPxzXsjQPFT7+djnW3eJhDXDO1/TdHFt
	r+q
X-Google-Smtp-Source: AGHT+IHyDcasNmEHyeO6kcdp8vnamRAvkNnpljuz2J/TSAKeE8ghhhcuoQIxiBYP7sQiUc1mJNbjWQ==
X-Received: by 2002:a17:902:d4cb:b0:249:2c76:54fc with SMTP id d9443c01a7336-24944a9e7b4mr159382985ad.39.1756830130600;
        Tue, 02 Sep 2025 09:22:10 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24905da2896sm137876915ad.81.2025.09.02.09.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:22:10 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:22:09 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] team: use common function to compute the
 features
Message-ID: <aLcZsYrC7Q1sqpSv@mini-arch>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829095430.443891-4-liuhangbin@gmail.com>

On 08/29, Hangbin Liu wrote:
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
>  drivers/net/team/team_core.c | 73 ++----------------------------------
>  1 file changed, 4 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 17f07eb0ee52..018d876e140a 100644
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

[..]

> @@ -1976,9 +1919,6 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
>  
>  	err = team_port_add(team, port_dev, extack);
>  
> -	if (!err)
> -		netdev_change_features(dev);
> -
>  	return err;
>  }
>  
> @@ -1991,11 +1931,6 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
>  
>  	err = team_port_del(team, port_dev);
>  
> -	if (err)
> -		return err;
> -
> -	netdev_change_features(dev);
> -
>  	return err;
>  }

nit: change these to 'return team_port_xxx()' ? Can drop the 'err' as
well, don't think it's needed anymore?
