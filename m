Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627C80BEF
	for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709124; cv=none; b=Oph6dRDeU6IbWG+t+LogH0QCUH547iG5eOfMCh190rwF9LAnq7rN2rI/sf1+MzqyWj78xA8/X04uyPCGp3t+Uc3ppZqkkmzsHrzzW1CdSFEX6kPO6Vihe1HtKJhRU4iciuQBn4ETlU6z+pw1uui4a6/G/ng8k0A+uDcaaXl14Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709124; c=relaxed/simple;
	bh=0HokHZ0TRmMkYTecp/fP9y2C6p+UeMfNsTWMaSR3aes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQ2Uiv+cZVn9E82di/673wiPteAGay8m0WnJPY2DT2vkwWehe640Q017spjgjjOUpTfA8uUpeDEcfrgzD04hKByJA97YjCwOnk6v0RKpMAjkjvQcrs8gZ2KCvar5jxTlXo7ozAFWaiDYCeaGV+6aCdIwq8YfxnsHmGcsoiFUPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL/JG2s6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL/JG2s6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so15483025e9.1
        for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 05:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706709120; x=1707313920; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPtmUHcYyyquby74IEXLFQhVf4lqT8uFnAIFJQJHn3o=;
        b=JL/JG2s6DuBtGNYhloKT148M/wFVyDOIzkwkgl44Favkno9cHxF/0nzL4WqyVOikd8
         BopV1bvqMR/vvNjtsZIZB5EltBXqGemBtsvgnks/SweqqNkSM2A9xl4FJ57aRtBAxLcA
         64DVObd7BUFPO3mMhoHFSJ23i9CuwxNimo7gseK0feZ9Zwz/yurhHNBcHdzzKpcvHR0m
         YSHk21s2HJJCCznA8reUL9Y0w03qI7gVBuNYE10sSo+eNhkvWfyr7UFhLWuEiRzSlpWI
         qRNPDPWIb2S+e0shURRN5N/NgAoA9arIw8gVCqKyZ3fYHyRh/BWnlsviCWL7yVaoe4WL
         pY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706709120; x=1707313920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPtmUHcYyyquby74IEXLFQhVf4lqT8uFnAIFJQJHn3o=;
        b=G6gXqiYGiouBsHZSGLfwQ/7auyNB32wZSPtQ4WxCbnSeTXeyRltrFwqK6jkfCFh38Z
         MI0yVSaJbWkhIgt5NGvmfqLfhjRLS/Mts8vOL5iRhmjFafj7XYx/N1eZzRWONTddnhfp
         HUF8JHmNQxo2NCBchawmoA6FpHrIV+L1av1Jx7klhMpKNgKctalsFIdrQMkD9obWz8GC
         hCgHAB5ThXYRFydDVTwEkFnMtTWzJJ/+7HWaOCtOlBOh4zTu1JV+dbPQ8L7bUph3P2Dq
         fu3u+krhqOMt/cGOFhFZ3shGRilTBbfbX7gEQqYvGsO6IXVTqSN1R2HR5FUaCtgb0AAM
         VBUQ==
X-Gm-Message-State: AOJu0Yx7RQ0NuIwiRqbo+ar9Jx9rRt6tBNrXTsZF9scxYdyWhIifg1pC
	wSfeSIm0NImil2kpuzU+T75i9mEVXd1AWe5vUIv/zA25V8K6MkvW
X-Google-Smtp-Source: AGHT+IGU2n8HGY4cz1S6BH2UvGSySxcreh4eAhZs5yz6P+OEzgZoIAu09vHVOtECn1OZlbCL4w3uJA==
X-Received: by 2002:a05:6000:11cd:b0:33a:f798:bfa with SMTP id i13-20020a05600011cd00b0033af7980bfamr1244734wrx.64.1706709120330;
        Wed, 31 Jan 2024 05:52:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVmo0ogGL0wQeekvGk2oVyRJcA07MqiYZoHb6csI8VAvZCV7kIUdGyYiw1D+gCsu0b8Fk2zwb24snfv4wJamRKvdescRkI3EWLBv8GsnwzwynWut8sDC/p25ddBgEw8nFuh7gJ2ijswUydbddlDc63ZX4INnaIoWI4ZagkJREeMuF4fzMngT7DygQdyuF1MBkXVJh2rpnQ+au7yGpHHL8GpMf6Tnjz04B3IDXpkwgw+EnOmhrYGlKzVpyNxmg==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id cw7-20020a056000090700b0033afcb5b5d2sm4074389wrb.80.2024.01.31.05.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:52:00 -0800 (PST)
Date: Wed, 31 Jan 2024 15:51:57 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com,
	razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
	jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH net 2/2] net: bridge: switchdev: Skip MDB replays of
 pending events
Message-ID: <20240131135157.ddrtt4swvz5y3nbz@skbuf>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-3-tobias@waldekranz.com>
 <20240131123544.462597-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131123544.462597-3-tobias@waldekranz.com>
 <20240131123544.462597-3-tobias@waldekranz.com>

On Wed, Jan 31, 2024 at 01:35:44PM +0100, Tobias Waldekranz wrote:
> Generating the list of events MDB to replay races against the IGMP/MLD
> snooping logic, which may concurrently enqueue events to the switchdev
> deferred queue, leading to duplicate events being sent to drivers.
> 
> Avoid this by grabbing the write-side lock of the MDB, and make sure
> that a deferred version of a replay event is not already enqueued to
> the switchdev deferred queue before adding it to the replay list.
> 
> An easy way to reproduce this issue, on an mv88e6xxx system, was to
> create a snooping bridge, and immediately add a port to it:
> 
>     root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && \
>     > ip link set dev x3 up master br0
>     root@infix-06-0b-00:~$ ip link del dev br0
>     root@infix-06-0b-00:~$ mvls atu
>     ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
>     DEV:0 Marvell 88E6393X
>     33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>     33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>     ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
>     root@infix-06-0b-00:~$
> 
> The two IPv6 groups remain in the hardware database because the
> port (x3) is notified of the host's membership twice: once in the
> original event and once in a replay. Since DSA tracks host addresses
> using reference counters, and only a single delete notification is
> sent, the count remains at 1 when the bridge is destroyed.
> 

It's not really my business as to how the network maintainers handle this,
but if you intend this to go to 'net', you should provide a Fixes: tag.

And to make a compelling case for a submission to 'net', you should
start off by explaining what the user-visible impact of the bug is.

> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  net/bridge/br_switchdev.c | 44 ++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index ee84e783e1df..a3481190d5e6 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -595,6 +595,8 @@ br_switchdev_mdb_replay_one(struct notifier_block *nb, struct net_device *dev,
>  }
>  
>  static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
> +				      struct net_device *dev,
> +				      unsigned long action,
>  				      enum switchdev_obj_id id,
>  				      const struct net_bridge_mdb_entry *mp,
>  				      struct net_device *orig_dev)
> @@ -608,8 +610,17 @@ static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
>  	mdb->obj.id = id;
>  	mdb->obj.orig_dev = orig_dev;
>  	br_switchdev_mdb_populate(mdb, mp);
> -	list_add_tail(&mdb->obj.list, mdb_list);
>  
> +	if (switchdev_port_obj_is_deferred(dev, action, &mdb->obj)) {
> +		/* This event is already in the deferred queue of
> +		 * events, so this replay must be elided, lest the
> +		 * driver receives duplicate events for it.
> +		 */
> +		kfree(mdb);

Would it make sense to make "mdb" a local on-stack variable, and
kmemdup() it only if it needs to be queued?

> +		return 0;
> +	}
> +
> +	list_add_tail(&mdb->obj.list, mdb_list);
>  	return 0;
>  }
>  
> @@ -677,22 +688,26 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
>  	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
>  		return 0;
>  
> -	/* We cannot walk over br->mdb_list protected just by the rtnl_mutex,
> -	 * because the write-side protection is br->multicast_lock. But we
> -	 * need to emulate the [ blocking ] calling context of a regular
> -	 * switchdev event, so since both br->multicast_lock and RCU read side
> -	 * critical sections are atomic, we have no choice but to pick the RCU
> -	 * read side lock, queue up all our events, leave the critical section
> -	 * and notify switchdev from blocking context.
> +	if (adding)
> +		action = SWITCHDEV_PORT_OBJ_ADD;
> +	else
> +		action = SWITCHDEV_PORT_OBJ_DEL;
> +
> +	/* br_switchdev_mdb_queue_one will take care to not queue a

() after function names

> +	 * replay of an event that is already pending in the switchdev
> +	 * deferred queue. In order to safely determine that, there
> +	 * must be no new deferred MDB notifications enqueued for the
> +	 * duration of the MDB scan. Therefore, grab the write-side
> +	 * lock to avoid racing with any concurrent IGMP/MLD snooping.
>  	 */
> -	rcu_read_lock();
> +	spin_lock_bh(&br->multicast_lock);
>  
>  	hlist_for_each_entry_rcu(mp, &br->mdb_list, mdb_node) {

hlist_for_each_entry()

>  		struct net_bridge_port_group __rcu * const *pp;
>  		const struct net_bridge_port_group *p;
>  
>  		if (mp->host_joined) {
> -			err = br_switchdev_mdb_queue_one(&mdb_list,
> +			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
>  							 SWITCHDEV_OBJ_ID_HOST_MDB,
>  							 mp, br_dev);
>  			if (err) {
> @@ -706,7 +721,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
>  			if (p->key.port->dev != dev)
>  				continue;
>  
> -			err = br_switchdev_mdb_queue_one(&mdb_list,
> +			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
>  							 SWITCHDEV_OBJ_ID_PORT_MDB,
>  							 mp, dev);
>  			if (err) {
> @@ -716,12 +731,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
>  		}
>  	}
>  
> -	rcu_read_unlock();
> -
> -	if (adding)
> -		action = SWITCHDEV_PORT_OBJ_ADD;
> -	else
> -		action = SWITCHDEV_PORT_OBJ_DEL;
> +	spin_unlock_bh(&br->multicast_lock);
>  
>  	list_for_each_entry(obj, &mdb_list, list) {
>  		err = br_switchdev_mdb_replay_one(nb, dev,
> -- 
> 2.34.1
> 

