Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC641C72
	for <bridge@lists.linux.dev>; Fri, 21 Mar 2025 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546844; cv=none; b=rD5I/rr3PmaMsHVImluD3akXwATemeNGf7fwKOIaWsRKWe2igKJpeijfGDFf7ZjfWsYd0guQXV6CE0y+t5mRpbc/SbhpyD7x+7x7zl3bkVpgfG2KBo/f5CO7u6DmS93Wbf4CkXZScA7Qh8fXM8eyTUu+b8N5MPbKGcNED5O3vwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546844; c=relaxed/simple;
	bh=SyuNoFb2i/s9V1tVbJyyxSOL1djkJ6ircSUIO1b2fYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfxoeZKstgsWx4jjSRD+IfApeCEIU63GChi1NTd477aPR9G/m51Q+Z9cSlphV/xtMe46fIFCtECn5DroN/JpS67lm5kljOJKLghZTH3hiX075BZQg61YtIjZWYhAz1fsZcxZMWb1/SuM4fidZrPE124iUzF+rl33FZDecUwWXlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=lbh8nRM1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="lbh8nRM1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfe574976so10020895e9.1
        for <bridge@lists.linux.dev>; Fri, 21 Mar 2025 01:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1742546839; x=1743151639; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/u53XnjG5rISjfTaIEry56PJmuKkgU982r6mTPnK8U=;
        b=lbh8nRM1Or2aOOYNs9rRyrpUma7cse/NbLnsldECw8k6krB/HeNf1S3S3Iu2trkqXB
         DFbP8fZcjOp2Ed4yRqjHMJf6d//soc7tIwhuZFSRDaKs2WQ3auf5ugxqnVLDyWkcQOUo
         /kIbCysXog5Nilt25ntb/AxSFU006QGDk4GJFrKn8dU/eu+zMG4e4PONrjpxjqqJ25Dr
         krhv9GAEYgMEPMRKWmxdHhpcxhzyLwlL7OwtyATPMc6elNGkNXKZWDarCn0GSXfyvB8q
         VRY7kyLCePczHADkKgZNPpzFffZsmrSSH+YqdKYQH5kfZiJEvi5jOEfVDlEnCW7m5AcU
         E7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742546839; x=1743151639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/u53XnjG5rISjfTaIEry56PJmuKkgU982r6mTPnK8U=;
        b=rX+4wKQVRhcT/1CWwYcMecUCIYWVcMLz6lPxhLWIASCDpIXZmWLYhUgNBpdH5mudYU
         6uRbt10YFpPsJ/DPW69TcYc2POLwCPZzmPJHOj4cjfTLXWmGlI036aci1QxF8+zvuvTK
         uxcd/cXnw++eygwdlx1eWsp0UU78WDt8ALIkHDxhfllPClUwXBU9ix4fIHc3cbv0Bfvk
         1VBNhgN4rkPysE3S+m9hpCxlkLWDe5pOAKsxc/c69jgsXo0F6XHcBd4CeJ8rcyD9yb2O
         KtfEfe4yALF29LTVLe3G/1cMs12T8dr3OHxeBBZxjvQupsl7cE87hTh90mRCMPRELgE0
         YVsw==
X-Forwarded-Encrypted: i=1; AJvYcCVOsZlu3p9wI6kYR5k2ne90gQkl1LwWr9u0ucckdwpNV96rbzDZ+8Qo5et7EJfJbCmHsda3vNI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxbsb1Pk+EMPfUdSRtSP4mNqNPzYBz7DPc7sctxkMjwed/x14JN
	pdv9cL2a5tG4Az1cfrZoZX2RJtjMwxcr5yAJ+m+G1A0Siu89b5AxUkEBh9Nd9i8=
X-Gm-Gg: ASbGncvZRg/5BTLgtLvlY8c7hlxHriQuiMz8TlIYEjVR1ep+iJcMx67Mt45/rWds1F5
	8iKFOCHDGE2j3VX6WmDBtFiaFVLY739OJCkTATyXRPEjU818SsrtSsMbB+ovBX1f5vtgmwlHRL2
	rgNY6wqre0rYQuBHHTcNuSj1geURMb1ingio9TZFE3jveS7+B6L3L+DOMmpv+1ldPTQZZvy68J1
	OiDEMu9wukALl43hTqK/TALjPrml3zj6bgO176xO5NJRSn4rWB6VNfXG7IxP/0xzFmbiPysdjzD
	rpnf/2JNJCViaeE/nMXBAEwBxBfAwJhCes5bk0/YlCiNCSqdj3dJ6im3eVH9EUb7ua+88JJn9eH
	r8k8igNy0nCc=
X-Google-Smtp-Source: AGHT+IE8LFIG/Qtb3OnOZFz3Hw5O/xAyEj5D1Z1h9iIdKAXnfjsvYhvJwHWGKVW6X9GspdfeVjRY6A==
X-Received: by 2002:a05:600c:1989:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-43d50a21402mr14264985e9.21.1742546839220;
        Fri, 21 Mar 2025 01:47:19 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd28a46sm20273495e9.24.2025.03.21.01.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 01:47:18 -0700 (PDT)
Message-ID: <d9a8d030-7cac-4f5f-b422-1bae7f08c74f@blackwall.org>
Date: Fri, 21 Mar 2025 10:47:17 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 2/3] net: bridge: mcast: Notify on offload flag
 change
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <20250318224255.143683-3-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250318224255.143683-3-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 00:42, Joseph Huang wrote:
> Notify user space on offload flag(s) change.
> 
> This behavior is controlled by the new knob mdb_notify_on_flag_change:
> 
> 0 - the bridge will not notify user space about MDB flag change
> 1 - the bridge will notify user space about flag change if either
>     MDB_PG_FLAGS_OFFLOAD or MDB_PG_FLAGS_OFFLOAD_FAILED has changed
> 2 - the bridge will notify user space about flag change only if
>     MDB_PG_FLAGS_OFFLOAD_FAILED has changed
> 
> The default value is 0.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  net/bridge/br_mdb.c       | 28 +++++++++++++++++++++++-----
>  net/bridge/br_multicast.c | 25 +++++++++++++++++++++++++
>  net/bridge/br_private.h   | 15 +++++++++++++++
>  net/bridge/br_switchdev.c | 25 +++++++++++++++++++++++--
>  4 files changed, 86 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 0639691cd19b..d206b5a160f3 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -519,16 +519,17 @@ static size_t rtnl_mdb_nlmsg_size(const struct net_bridge_port_group *pg)
>  	       rtnl_mdb_nlmsg_pg_size(pg);
>  }
>  
> -void br_mdb_notify(struct net_device *dev,
> -		   struct net_bridge_mdb_entry *mp,
> -		   struct net_bridge_port_group *pg,
> -		   int type)
> +static void _br_mdb_notify(struct net_device *dev,
> +			   struct net_bridge_mdb_entry *mp,
> +			   struct net_bridge_port_group *pg,
> +			   int type, bool notify_switchdev)

please use double underscore "__"

>  {
>  	struct net *net = dev_net(dev);
>  	struct sk_buff *skb;
>  	int err = -ENOBUFS;
>  
> -	br_switchdev_mdb_notify(dev, mp, pg, type);
> +	if (notify_switchdev)
> +		br_switchdev_mdb_notify(dev, mp, pg, type);
>  
>  	skb = nlmsg_new(rtnl_mdb_nlmsg_size(pg), GFP_ATOMIC);
>  	if (!skb)
> @@ -546,6 +547,23 @@ void br_mdb_notify(struct net_device *dev,
>  	rtnl_set_sk_err(net, RTNLGRP_MDB, err);
>  }
>  
> +void br_mdb_notify(struct net_device *dev,
> +		   struct net_bridge_mdb_entry *mp,
> +		   struct net_bridge_port_group *pg,
> +		   int type)
> +{
> +	_br_mdb_notify(dev, mp, pg, type, true);
> +}
> +
> +#ifdef CONFIG_NET_SWITCHDEV
> +void br_mdb_flag_change_notify(struct net_device *dev,
> +			       struct net_bridge_mdb_entry *mp,
> +			       struct net_bridge_port_group *pg)
> +{
> +	_br_mdb_notify(dev, mp, pg, RTM_NEWMDB, false);
> +}
> +#endif
> +
>  static int nlmsg_populate_rtr_fill(struct sk_buff *skb,
>  				   struct net_device *dev,
>  				   int ifindex, u16 vid, u32 pid,
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index b2ae0d2434d2..8d583caecd40 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4051,6 +4051,10 @@ void br_multicast_ctx_init(struct net_bridge *br,
>  	brmctx->ip6_querier.port_ifidx = 0;
>  	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
>  #endif
> +#ifdef CONFIG_NET_SWITCHDEV
> +	brmctx->multicast_mdb_notify_on_flag_change =
> +		MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE;
> +#endif
>  
>  	timer_setup(&brmctx->ip4_mc_router_timer,
>  		    br_ip4_multicast_local_router_expired, 0);
> @@ -4708,6 +4712,27 @@ int br_multicast_set_mld_version(struct net_bridge_mcast *brmctx,
>  }
>  #endif
>  
> +#ifdef CONFIG_NET_SWITCHDEV
> +int br_multicast_set_mdb_notify_on_flag_change(struct net_bridge_mcast *brmctx,
> +					       u8 val)
> +{
> +	switch (val) {
> +	case MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE:
> +	case MDB_NOTIFY_ON_FLAG_CHANGE_BOTH:
> +	case MDB_NOTIFY_ON_FLAG_CHANGE_FAIL_ONLY:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Please use NLA_POLICY_MAX() instead.

> +
> +	spin_lock_bh(&brmctx->br->multicast_lock);
> +	brmctx->multicast_mdb_notify_on_flag_change = val;
> +	spin_unlock_bh(&brmctx->br->multicast_lock);
> +
> +	return 0;
> +}
> +#endif
> +
>  void br_multicast_set_query_intvl(struct net_bridge_mcast *brmctx,
>  				  unsigned long val)
>  {
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index cd6b4e91e7d6..8e8de5d54ae3 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -132,6 +132,10 @@ struct net_bridge_mcast_port {
>  #endif /* CONFIG_BRIDGE_IGMP_SNOOPING */
>  };
>  
> +#define MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE	0
> +#define MDB_NOTIFY_ON_FLAG_CHANGE_BOTH		1
> +#define MDB_NOTIFY_ON_FLAG_CHANGE_FAIL_ONLY	2

This should be an enum and it is also uAPI, you should move it to 
include/uapi/linux/if_bridge.h

> +
>  /* net_bridge_mcast must be always defined due to forwarding stubs */
>  struct net_bridge_mcast {
>  #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
> @@ -146,6 +150,9 @@ struct net_bridge_mcast {
>  	u8				multicast_router;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	u8				multicast_mld_version;
> +#endif
> +#ifdef CONFIG_NET_SWITCHDEV
> +	u8				multicast_mdb_notify_on_flag_change;
>  #endif
>  	unsigned long			multicast_last_member_interval;
>  	unsigned long			multicast_membership_interval;
> @@ -988,6 +995,10 @@ int br_multicast_set_igmp_version(struct net_bridge_mcast *brmctx,
>  int br_multicast_set_mld_version(struct net_bridge_mcast *brmctx,
>  				 unsigned long val);
>  #endif
> +#ifdef CONFIG_NET_SWITCHDEV
> +int br_multicast_set_mdb_notify_on_flag_change(struct net_bridge_mcast *brmctx,
> +					       u8 val);
> +#endif
>  struct net_bridge_mdb_entry *
>  br_mdb_ip_get(struct net_bridge *br, struct br_ip *dst);
>  struct net_bridge_mdb_entry *
> @@ -1004,6 +1015,10 @@ int br_mdb_hash_init(struct net_bridge *br);
>  void br_mdb_hash_fini(struct net_bridge *br);
>  void br_mdb_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
>  		   struct net_bridge_port_group *pg, int type);
> +#ifdef CONFIG_NET_SWITCHDEV
> +void br_mdb_flag_change_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
> +			       struct net_bridge_port_group *pg);
> +#endif
>  void br_rtr_notify(struct net_device *dev, struct net_bridge_mcast_port *pmctx,
>  		   int type);
>  void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 68dccc2ff7b1..5b09cfcdf3f3 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -504,20 +504,41 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>  	struct net_bridge_mdb_entry *mp;
>  	struct net_bridge_port *port = data->port;
>  	struct net_bridge *br = port->br;
> +	bool offload_changed = false;
> +	bool failed_changed = false;
> +	u8 notify;
>  
>  	spin_lock_bh(&br->multicast_lock);
>  	mp = br_mdb_ip_get(br, &data->ip);
>  	if (!mp)
>  		goto out;
> +
> +	notify = br->multicast_ctx.multicast_mdb_notify_on_flag_change;

let's not waste cycles if there was an error and notify == 0, please keep the original
code path and avoid walking over the group ports.

> +
>  	for (pp = &mp->ports; (p = mlock_dereference(*pp, br)) != NULL;
>  	     pp = &p->next) {
>  		if (p->key.port != port)
>  			continue;
>  
> -		if (err)
> +		if (err) {
> +			if (!(p->flags & MDB_PG_FLAGS_OFFLOAD_FAILED))
> +				failed_changed = true;
>  			p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
> -		else
> +		} else {
> +			if (!(p->flags & MDB_PG_FLAGS_OFFLOAD))
> +				offload_changed = true;
>  			p->flags |= MDB_PG_FLAGS_OFFLOAD;
> +		}
> +
> +		if (notify == MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE ||
> +		    (!offload_changed && !failed_changed))
> +			continue;
> +
> +		if (notify == MDB_NOTIFY_ON_FLAG_CHANGE_FAIL_ONLY &&
> +		    !failed_changed)
> +			continue;
> +
> +		br_mdb_flag_change_notify(br->dev, mp, p);

This looks like a mess.. First you need to manage these flags properly as I wrote in my
other reply, they must be mutually exclusive and you can do this in a helper. Also
please read the old flags in the beginning, then check what flags changed, make a mask
what flags are for notifications (again can come from a helper, it can be generated when
the option changes so you don't compute it every time) and decide what to do if any of
those flags changed.
Note you have to keep proper flags state regardless of the notify option.

>  	}
>  out:
>  	spin_unlock_bh(&br->multicast_lock);

