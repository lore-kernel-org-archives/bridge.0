Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A845D49C
	for <bridge@lists.linux.dev>; Wed, 14 Feb 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929165; cv=none; b=HKhvpyPeCeNk1Xou8+yI86HcVmbWnekimX0ELuByoI+xhN7KC6QHlqQOdbAsPh/fEKvztaNvzvl8ar+rdXzrnyysrHa94cboijywB5hUWEPLmsHepdmWqLs9GB6o44Jy3RhQFN7Yc5eFt/kD2bIGNwuhTEW18OeqARjpfdkeKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929165; c=relaxed/simple;
	bh=2q7cLSi0Gd2ENmAbGtzWnZ+mBZp/E6h2LXwHHZHsHkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTO+YS5vsCGtmgEzx/kvMRvElNXJgb1I7u9heb1SlybuTDhblpe8oCzAJHyfDjv0R5Q0kMxMTlWRhMsmsdYRmHf8iknY9QPBQQWG7S6QSpZH1xX3aTgvHyYF6bBB12untAYrlEyOdbGkLQUz5UzxayAQ5Xf1YDRqT4Jh3kYL5bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUgQGv2y; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUgQGv2y"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-561f8b8c058so1969448a12.0
        for <bridge@lists.linux.dev>; Wed, 14 Feb 2024 08:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707929162; x=1708533962; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxQN/1zQrCH98IYYOLyInk5Os7l9aGTXjyFr1WcC+WE=;
        b=FUgQGv2yb4CHQIlGOWu5fqFPjtV3TOR6lcLBAm0g2dUdA5avhCPEtm/stwGL8ITT8k
         P6OagEruu1ebv/G3XX5dodpCg4ZHy+kZ8tED279GchQtjPov7NGklW/0zBdJthOb1ODi
         ffStMWMG/CTjUQnTT5oogZ0Y8j9bIevE6zJ2h1wnm68hGffeIVtsAzH7gPj1GJVliCnd
         9rHR9MIO4F9ckKbp/fwBcbNrMDieWbncUv0P+GYUpAJIZCOKDFRpTSG050wuaM49u8Ky
         eHtPCttRGmF48/TwJeIVaxiRhzlz/hz2851mu/GQqj152qV2g2kSewk6PMm4oynA6Wtf
         hs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707929162; x=1708533962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxQN/1zQrCH98IYYOLyInk5Os7l9aGTXjyFr1WcC+WE=;
        b=Ca7OZQJbezS9GxpEaiIWKFczFcU7VGMYuNupjtkkyAqxLMd0l59vWNibDmFd0E8qZy
         aJMGS1DwU/GdWeSnRdV9q6ljCSBip2CfQb3bAagQy0JfOJQyciQHc6cnO95ROQsjQbF0
         a/YgyAgnAW6HyxYAPFzSe6Xz8l52KlCkpwy/j9smklm3juer4ubGO60RPjiT1mpXO7gT
         FQLxtxnHCAsqVUTWUt/+KEImP69gMPzJg6hUXKCoJyX44XucLsQzl6msqJowXSbeSq1n
         s1Fn6OVuzcTwM+UURDI/I5PGLFQ/Ue8nEdh2PVLElnOnUepuZzMH0ee9ty7E7M/YYp9x
         kRiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqQHbZO3lzSShKWirHiXky6TS2HFzFF+EJ2YOtE40N5t62yrTvycQyYjbNAwfFSgcGRGYF1f3GFGDcGRw7oiIodkxG8WvL
X-Gm-Message-State: AOJu0YxkxWSU21WX/SOcM1hWD0NihU7Rn3YgR2Njt2dnHbNomR+91VpK
	nnCbFopU+VXS8yvEiE29DFxA02m/YQE4/E/sg/n7BSxE/g4slyXs3duoHTtrYFM=
X-Google-Smtp-Source: AGHT+IFnTjS9mtXyhY8TtcRIoPIE0u5cL8S0F7na2Q1yrKH4or2igg07i+Y27IJ/PEHjgcoK/wmKig==
X-Received: by 2002:aa7:d418:0:b0:563:85aa:c769 with SMTP id z24-20020aa7d418000000b0056385aac769mr1590877edq.20.1707929162077;
        Wed, 14 Feb 2024 08:46:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1qlMKYaJKp14wDb4UKwsfNyNPOTyFwImnmc8r2N/uYl5FpDDsRKpokud/1Tv8CnBl3Xl29hGOElLIAeu6aGkHU+lfeqZfLVWsOJeQ9w2RJaigPIrhQ5OxzkJ3UAaT/OhgF+8AHiJChqCq1s1Yb4Z0uOFoRCeiB6IlGRyhJllU67vOiI4Qejd6JI4lEF4+D9f1vJ77hfEmaeX3JKIVI2vo2s0YaQdokgxUFuIC7YqDqS0h9vTwu7l2LfyqOwr3nNu+aPLf7BugnwFGaddiBL3T
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id dh12-20020a0564021d2c00b005638c060464sm384553edb.25.2024.02.14.08.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:46:01 -0800 (PST)
Date: Wed, 14 Feb 2024 18:45:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, atenart@kernel.org,
	roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
	netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH v4 net 1/2] net: bridge: switchdev: Skip MDB replays of
 deferred events on offload
Message-ID: <20240214164559.njyaoscx2e22esep@skbuf>
References: <20240212191844.1055186-1-tobias@waldekranz.com>
 <20240212191844.1055186-1-tobias@waldekranz.com>
 <20240212191844.1055186-2-tobias@waldekranz.com>
 <20240212191844.1055186-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212191844.1055186-2-tobias@waldekranz.com>
 <20240212191844.1055186-2-tobias@waldekranz.com>

On Mon, Feb 12, 2024 at 08:18:43PM +0100, Tobias Waldekranz wrote:
> Before this change, generation of the list of MDB events to replay
> would race against the creation of new group memberships, either from
> the IGMP/MLD snooping logic or from user configuration.
> 
> While new memberships are immediately visible to walkers of
> br->mdb_list, the notification of their existence to switchdev event
> subscribers is deferred until a later point in time. So if a replay
> list was generated during a time that overlapped with such a window,
> it would also contain a replay of the not-yet-delivered event.
> 
> The driver would thus receive two copies of what the bridge internally
> considered to be one single event. On destruction of the bridge, only
> a single membership deletion event was therefore sent. As a
> consequence of this, drivers which reference count memberships (at
> least DSA), would be left with orphan groups in their hardware
> database when the bridge was destroyed.
> 
> This is only an issue when replaying additions. While deletion events
> may still be pending on the deferred queue, they will already have
> been removed from br->mdb_list, so no duplicates can be generated in
> that scenario.
> 
> To a user this meant that old group memberships, from a bridge in
> which a port was previously attached, could be reanimated (in
> hardware) when the port joined a new bridge, without the new bridge's
> knowledge.
> 
> For example, on an mv88e6xxx system, create a snooping bridge and
> immediately add a port to it:
> 
>     root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && \
>     > ip link set dev x3 up master br0
> 
> And then destroy the bridge:
> 
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
> port (x3) is notified of the host's membership twice: once via the
> original event and once via a replay. Since only a single delete
> notification is sent, the count remains at 1 when the bridge is
> destroyed.
> 
> Then add the same port (or another port belonging to the same hardware
> domain) to a new bridge, this time with snooping disabled:
> 
>     root@infix-06-0b-00:~$ ip link add dev br1 up type bridge mcast_snooping 0 && \
>     > ip link set dev x3 up master br1
> 
> All multicast, including the two IPv6 groups from br0, should now be
> flooded, according to the policy of br1. But instead the old
> memberships are still active in the hardware database, causing the
> switch to only forward traffic to those groups towards the CPU (port
> 0).
> 
> Eliminate the race in two steps:
> 
> 1. Grab the write-side lock of the MDB while generating the replay
>    list.
> 
> This prevents new memberships from showing up while we are generating
> the replay list. But it leaves the scenario in which a deferred event
> was already generated, but not delivered, before we grabbed the
> lock. Therefore:
> 
> 2. Make sure that no deferred version of a replay event is already
>    enqueued to the switchdev deferred queue, before adding it to the
>    replay list, when replaying additions.
> 
> Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-joined mdb entries")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Excellent from my side, thank you!

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

> @@ -307,6 +336,50 @@ int switchdev_port_obj_del(struct net_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
>  
> +/**
> + *	switchdev_port_obj_act_is_deferred - Is object action pending?
> + *
> + *	@dev: port device
> + *	@nt: type of action; add or delete
> + *	@obj: object to test
> + *
> + *	Returns true if a deferred item is exists, which is equivalent
> + *	to the action @nt of an object @obj.

nitpick: replace "is exists" with something else like "is pending" or
"exists".

Also "action of an object" or "on an object"?

> + *
> + *	rtnl_lock must be held.
> + */
