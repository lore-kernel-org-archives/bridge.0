Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175FE199DC
	for <bridge@lists.linux.dev>; Mon,  5 Feb 2024 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133304; cv=none; b=qHfI8QDA0IvTBXsbOecqRbZQliLuSraPD7ZXv/Y0lto6eN8nwKzxYSTOeY03dN4jTpi+B7d0VFvY4NOJeqYfqsSFu9X7Gj1HMIBNJUMF2OcXjV+WPi+rSTmATq01dwUIE/J+jx67IT1DgHVsyTQN0PFv8KEbJ0xRylGV7Z+DdF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133304; c=relaxed/simple;
	bh=0BvHj8YUx8Q8Mi86gp2nO09A7PYzIxUar6bZ+pAe+tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O47NRkT3huJsZh41OSJicfy+yv7OzeRTDhddy2o0ix7u71MR+kBCwT6mxy08IPyY/GJoRYr6IIRr8/qGCSMQtEn7l0xBzvdWegpvOVVdH/BA8TBZB1yeStzIQ1RGRhLNaB7ak13WcJrJe/3Un3mxiM7x8lct6emo+5+pYxLFzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsHoCNA4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsHoCNA4"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b1d7f736bso2195620f8f.3
        for <bridge@lists.linux.dev>; Mon, 05 Feb 2024 03:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707133301; x=1707738101; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2NcjInO6CiSLYlF9JWwNu1WoSKPHx1fyhS9S8pVayk=;
        b=gsHoCNA4mMoNykMFtkeiyeN/yuIz7+2i0mihJKOjD9MJtp4ZjtKvjzoHHI8/NMOS3M
         L1dPVPRVbpdLfm8YJMIe16wsumUcqp9PKeIPCsc60T2RS18a+Rxre4UxtnyPwfkOGCLH
         ub6LJJk1YAavGL66AOI5zSFcNpt0NMsnyOEbiwD8bC5L+txsin1IIoUHa3aVnmQVDaAu
         WEyUSlWPLRWlx7SCkYfVOib6cU9D2mHqaorGu9XIPx1xfiN8WxDeg950pZV3ZqK/dfQE
         h5pvbEm/s6gxyBYoDmyP1Tm3p4Hrez5PLjlZOiUAR13WIkrt0gVcMtHXCqi9g2AzKtIP
         FXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707133301; x=1707738101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2NcjInO6CiSLYlF9JWwNu1WoSKPHx1fyhS9S8pVayk=;
        b=p9O8r4/FTDFMQHiwIr+ILObUobhpSiGewnYTSGdIe7flH5BEXWqwGg/2RCRws3Ku52
         QyLS9QR3ks1E78IoBYmWtlotqdN0H1LOh+qH25JsoUI8KvHlbRmUwR7/BikD6LaWxzoo
         UPk2O1LJYccQuuZiZQvgn/0ziG3tP6YTauOZ46bCvJBTTHFt1HUtw62jSEx37PM9M8CH
         pIkh0eyF2HGqCu5jj+l6FwGS//shVcLyWozBQr6DbXjqOqY7XWsZ/1JcYRRSeSqwvyi9
         4lPl3YwbQ2ArkI1t29Yimifp5Wntuy+ZuB7zxmFkGcj6GZFF3MpXAYKek+KLMNobN35G
         Sfhw==
X-Gm-Message-State: AOJu0YxvP9NQWJNMaRdPPQ2pcBwHapcJCQDE/dUuW9uO1MhJfL91lAwC
	6rY5OEvHSXw5hn0q25OoK+G8b74cwCcDbxd0Rh4a3LkoNro79J5752nfKiOX3wo=
X-Google-Smtp-Source: AGHT+IE3+PNWVFcqtxE4SQcGD7q3IvlybjIvIgFDOboMn7j+1HcsAFIUBEc0SUkUQECU9PhlRNwODw==
X-Received: by 2002:a5d:5f4b:0:b0:33a:eb5c:aa25 with SMTP id cm11-20020a5d5f4b000000b0033aeb5caa25mr4301889wrb.23.1707133301076;
        Mon, 05 Feb 2024 03:41:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWlN+MmZhTGpZ+O4h8Uvu/qEz3CfF//zsyQXfAnrYsCLKWlDHSpmWSFoMT5j1JBIPdLqrJ6/NYOtIiNO7//gH7K6sV/sWf8iQkAw4TkvYHNQpCTahYCT/3QEwn+dEDs1+erOtuHa548DRlhU4l5sBSyF+0qvfAMpiI1xVGuRqfbIqe3ZV4X4YuB9cTZo6GwNlKNntQQt8sKQ7qLN7hm9DD3bQdPkx+W0UYm0Lh3rAc3wAC/Zg7wkVeDURGzGx/qnEGO/ZGE/wzKtNKEC883jvdh
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id x5-20020adfdd85000000b0033afe6968bfsm7891052wrl.64.2024.02.05.03.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 03:41:40 -0800 (PST)
Date: Mon, 5 Feb 2024 13:41:38 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, atenart@kernel.org,
	roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
	netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH v3 net] net: bridge: switchdev: Skip MDB replays of
 pending events
Message-ID: <20240205114138.uiwioqstybmzq77b@skbuf>
References: <20240201161045.1956074-1-tobias@waldekranz.com>
 <20240201161045.1956074-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201161045.1956074-1-tobias@waldekranz.com>
 <20240201161045.1956074-1-tobias@waldekranz.com>

On Thu, Feb 01, 2024 at 05:10:45PM +0100, Tobias Waldekranz wrote:
> Before this change, generation of the list of events MDB to replay

s/events MDB/MDB events/

> would race against the IGMP/MLD snooping logic, which could concurrently

logic. This could (...)

> enqueue events to the switchdev deferred queue, leading to duplicate
> events being sent to drivers. As a consequence of this, drivers which
> reference count memberships (at least DSA), would be left with orphan
> groups in their hardware database when the bridge was destroyed.

Still missing the user impact description, aka "when would this be
noticed by, and actively bother an user?". Something that would justify
handling this via net.git rather than net-next.git.

> 
> Avoid this by grabbing the write-side lock of the MDB while generating
> the replay list, making sure that no deferred version of a replay
> event is already enqueued to the switchdev deferred queue, before
> adding it to the replay list.

The description of the solution is actually not very satisfactory to me.
I would have liked to see a more thorough analysis.

The race has 2 components, one comes from the fact that during replay,
we iterate using RCU, which does not halt concurrent updates, and the
other comes from the fact that the MDB addition procedure is non-atomic.
Elements are first added to the br->mdb_list, but are notified to
switchdev in a deferred context.

Grabbing the bridge multicast spinlock only solves the first problem: it
stops new enqueues of deferred events. We also need special handling of
the pending deferred events. The idea there is that we cannot cancel
them, since that would lead to complications for other potential
listeners on the switchdev chain. And we cannot flush them either, since
that wouldn't actually help: flushing needs sleepable context, which is
incompatible with holding br->multicast_lock, and without
br->multicast_lock held, we haven't actually solved anything, since new
deferred events can still be enqueued at any time.

So the only simple solution is to let the pending deferred events
execute (eventually), but during event replay on joining port, exclude
replaying those multicast elements which are in the bridge's multicast
list, but were not yet added through switchdev. Eventually they will be.

(side note: the handling code for excluding replays on pending event
deletion seems to not actually help, because)

Event replays on a switchdev port leaving the bridge are also
problematic, but in a different way. The deletion procedure is also
non-atomic, they are first removed from br->mdb_list then the switchdev
notification is deferred. So, the replay procedure cannot enter a
condition where it replays the deletion twice. But, there is no
switchdev_deferred_process() call when the switchdev port unoffloads an
intermediary LAG bridge port, and this can lead to the situation where
neither the replay, nor the deferred switchdev object, trickle down to a
call in the switchdev driver. So for event deletion, we need to force a
synchronous call to switchdev_deferred_process().

See how the analysis in the commit message changes the patch?

> 
> An easy way to reproduce this issue, on an mv88e6xxx system, was to

s/was/is/

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
> port (x3) is notified of the host's membership twice: once via the
> original event and once via a replay. Since only a single delete
> notification is sent, the count remains at 1 when the bridge is
> destroyed.

These 2 paragraphs, plus the mvls output, should be placed before the
"Avoid this" paragraph.

> 
> Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-joined mdb entries")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
