Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F941586EC
	for <bridge@lists.linux.dev>; Thu,  1 Feb 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804681; cv=none; b=D752FIrWOikma7pgstzGltTKSVTlYrjTOnaEPxHKcPXxrkv2bMpkc3RRYBVY0Fhe1x0q/yc2xyYllBg0nEuGlh3rqq5aC/8WY6IXO5prhicXR85P0DDpc5p368MLiLj//CcOwDqZ0gX8hIVJB1KG6cY22ShgvpIXghDI2GYxrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804681; c=relaxed/simple;
	bh=APWoK8gcAcO801xSDSZ22IQW3H8rp4/dFBB7fy4fvaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oz2QtyIH7/LHwa9l148cs/zdjfoMz8n1wxyuihd+wNupXSaaJqNYjz+Xjac7nQV4pCYAl+L8c1hqQ1mXh6DXUuP3BDgvH0F8FIsE36L4pji9nygfbvR7cu6XWWWYa20PQaV+sk3Jd2vaH/2Nr/tFVy4dV6rQADYXvE/+pf6MaXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lXqVjBz3; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lXqVjBz3"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so9617595e9.3
        for <bridge@lists.linux.dev>; Thu, 01 Feb 2024 08:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706804677; x=1707409477; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4jm2Q7ndYebk+zIyllOhWfO+o4jnVrjmyeIPJMGASzI=;
        b=lXqVjBz387G/r6Fqh2/jro7HOuryhGEuCrksNW4NtHZIJ+f2Skk+jTHdT1k93JBlaz
         WD60B+tlyf6X4YIsnUgaDLsFqLJILCCYgFrXvVH5VHsJAUcB2m+p64f+LVFY3KDa8Bn1
         a3/OEBcn0TOg8hUKlYkEUOxLwnwE8YeTbZBZznNLUVC8+OWtelxOS6oJfYQ9TxSZwprI
         MZO+R/zC+0htmAvdqWoyhXbqNsOhyrnW+SJJ/Ee4mMuaE9kZObImtmX9xhDr+2mWM8Qk
         JL8cNsBBh0mqbIbys7tpb5BAqT0GqGwRMdzY3FNsvIB4D0+kgahxASbq+6TTUk/JvvAA
         r0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804677; x=1707409477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jm2Q7ndYebk+zIyllOhWfO+o4jnVrjmyeIPJMGASzI=;
        b=tkJitMC0IRAFwKDX6N3kLNNn/AYm/1rTCvyYNNL4L1SvYZ/8wukWYZzxpRErG0GE8E
         bsj4fE2ilpj+9JXlKY0ySTgFEPiLWuHQTgNfEC0Lek99WHp1NaP+bGmG++NVGdXXZKUF
         zUt8o3RuEdMMR1C/ZHiBFNf3Y1mZmsvhbDxvmZCNZYnjA77k3u6eBHtcskKJhvxY95PW
         NwMgF+RwyqGiO4IqcdOxlXgWtRY/ditAeNCQ0jjOmVVhTjRSzs1RZn6tPA5YWXFPIut0
         POS8GrinYEB93FNlJ/5l5DDoOBsqEofOjdn1ihU0Ihq2wAKANU2sQxBGtEFlZXnhHnzn
         Cf/Q==
X-Gm-Message-State: AOJu0YyqHzV6rsuQGg//AZRbizAtQRHMMmkc/sM2PAloJCM6bLjl0NRk
	/y6x4aWTLiF0ZVav7Nob8UpIX51qqafdCheTv5Ahp4nEk2vaKxhFHB1fAXHEfF4=
X-Google-Smtp-Source: AGHT+IGYyqLR9noA49n6HjJ+husoyNmZXX5n8IQoyrc5guzxALYE4SU9FLHTynhW587YUs0qvU67fg==
X-Received: by 2002:a05:600c:4e90:b0:40f:b2aa:2da1 with SMTP id f16-20020a05600c4e9000b0040fb2aa2da1mr2386306wmq.7.1706804677148;
        Thu, 01 Feb 2024 08:24:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXxKX5y7iDyCR2DLG0Td/NcVtXoMQztJVcYWi/Sica65kxvjFUuZpdYtdZrMUQvAs74OaqvyoFAq0BqahrNTmcqn1qxF6GHmT1lTRlGAV+dhlRSoVQcV1e1fqebhB3N3yvkbg/C2QP8+3vsDhuTnJ5UhMJyotL+5SUfhTDqGgSCv9Ws9i6UFWg/QWLJfWVPjA7QDwS6h8fMAm7tFK+LrGMx538ufKpq5gv0dGE58MdtZ2u+8cIv2nlcg0zay3zpqAZnln50rd5TaImObdshmUvy1ONwxGxzqHAtdAva6q549ZzOUQ==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c155100b0040ee4f38968sm72907wmg.2.2024.02.01.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:24:36 -0800 (PST)
Date: Thu, 1 Feb 2024 17:24:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, olteanv@gmail.com,
	atenart@kernel.org, roopa@nvidia.com, razor@blackwall.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org, ivecera@redhat.com
Subject: Re: [PATCH v3 net] net: bridge: switchdev: Skip MDB replays of
 pending events
Message-ID: <ZbvFwVSQI1M_2WZo@nanopsycho>
References: <20240201161045.1956074-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201161045.1956074-1-tobias@waldekranz.com>

Thu, Feb 01, 2024 at 05:10:45PM CET, tobias@waldekranz.com wrote:
>Before this change, generation of the list of events MDB to replay
>would race against the IGMP/MLD snooping logic, which could concurrently
>enqueue events to the switchdev deferred queue, leading to duplicate
>events being sent to drivers. As a consequence of this, drivers which
>reference count memberships (at least DSA), would be left with orphan
>groups in their hardware database when the bridge was destroyed.
>
>Avoid this by grabbing the write-side lock of the MDB while generating
>the replay list, making sure that no deferred version of a replay
>event is already enqueued to the switchdev deferred queue, before
>adding it to the replay list.
>
>An easy way to reproduce this issue, on an mv88e6xxx system, was to
>create a snooping bridge, and immediately add a port to it:
>
>    root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && \
>    > ip link set dev x3 up master br0
>    root@infix-06-0b-00:~$ ip link del dev br0
>    root@infix-06-0b-00:~$ mvls atu
>    ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
>    DEV:0 Marvell 88E6393X
>    33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>    33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>    ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
>    root@infix-06-0b-00:~$
>
>The two IPv6 groups remain in the hardware database because the
>port (x3) is notified of the host's membership twice: once via the
>original event and once via a replay. Since only a single delete
>notification is sent, the count remains at 1 when the bridge is
>destroyed.
>
>Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-joined mdb entries")
>Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Could you please maintain 24 hours period between sending another patch
version?

https://www.kernel.org/doc/html/v6.7/process/maintainer-netdev.html#tl-dr
