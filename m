Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7510E4
	for <bridge@lists.linux.dev>; Tue, 30 Apr 2024 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438796; cv=none; b=rZfGrZ/64+q2v7VBP9/48uM8/kQv9TZ0FdQW5pGH4tmYJHhvtJfxMlrQw675E/83jx/b56IBgm0BnB0eL0/ZztCxe5liljb0i4ibfd3v3zx6zFtxZH17NJ4Zpi1vHzdmaeZznJCIGaoS/TF061kKGRY1jjwYygNa8xFNvTHeA6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438796; c=relaxed/simple;
	bh=rZ5Fgvfjroac2GiLwSMgIhQ7CG5p1B8aQRKKwWjaFBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXwKwEJax0lPvpauxjq6TLfRzadAC0YObctwX7mdgSbAx424TNjg5y3IEbsMgfuCNDwppqd7fHtGq+cvb9IddVWiDa0UjlrV9iHgq+F6bL8URh9woPlL7vXs1RIV5nZ6VIuVSAucgucWlhcFVTugcaF34RR006YWUbONV9G+18w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaAHAIU+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaAHAIU+"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57288691c07so1614688a12.3
        for <bridge@lists.linux.dev>; Mon, 29 Apr 2024 17:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714438793; x=1715043593; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0AW/wYh4RsDtCMHIZdU80eftqWkVY8DHoSo6I6qnwxU=;
        b=EaAHAIU+sDQpIk9oK7k0JJjrr1eQo4GG9EUuFxa52Yb6RKMegc3vKOT/Hp9Ex6mATC
         kVRWggHNW7tb1+rdA0icN2g8L+ROTP9lJjog910reXIoSMVv+BU1lKDfe4Wd4ckpKjj8
         dFhab6g50niYnpHT7kIJZ30dZKze1TP/yWb8fjslJTZy6PpQVVVOpTiRr5GNwXxell3d
         JH0/BXnY5S+tDMFCoyWqky4hsm4iWQEGNA+umWZldVoxEFi0epPdsFJrDlnYshOwufrx
         j8sIMlwc5heXBzWhzYwDp7LsuZNu3l9gi6ve+dfW+OPB5JcYArryJdA/hq2WHjn4uQHR
         ILrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714438793; x=1715043593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AW/wYh4RsDtCMHIZdU80eftqWkVY8DHoSo6I6qnwxU=;
        b=NYNBl8vT9eGESxapw9SgPQSkXS2T4p/Gf4ULwRTJGKPWqB6T943qyQydl5nwtPseRR
         v8URWNKVl8fDwJbhLKDsE/vAHgjs4YbmJLaU+l1hRNwrKBYS/ZdntW5OgoEbegvCre5u
         NxsZQ8DjI08oaE6McC05IlXH9ckNGErZM6ABw1BaJ+aGAmNhrLVVQFX+WPpHlN+8lPE6
         Ss6IcpzOV6bPIuZjsOn14znwhhZnBxlhNOS+WK1fREKgNE7HHF1vcyAVEg+vvbej3S3l
         0sNh/hRGJhm3ZsTlOeFdJAGZYrnn9cXr6v7vIEdSUMt83LtvJJkUR7jcOo8MphMUGzyr
         9rrA==
X-Forwarded-Encrypted: i=1; AJvYcCXyejngRYz65zMq7pdnZnXOIUnpJM6Nn89YXvlZqO+lGzauiTFC6tzbiWWKqiaoHNmkm1iEHurgwqoSvrNTAxmAQSxD67c3
X-Gm-Message-State: AOJu0YzxGi/rgAt3Sdkp0a6BdDc5Lh+B3z2j40mlsU+JHbdcZjw1Y3v0
	TgG1k3IAwmDNSmFtxZLMgWQcSqYLki5L6g5/wYJJdP/rj9e0KnOz
X-Google-Smtp-Source: AGHT+IHdNhQ1o7yqt5336ceWzkBhi+68iQi+cVplWUMRflPGIyCHcqMyO6RMKJHvbgODYQmgqdAYrA==
X-Received: by 2002:a50:d593:0:b0:572:2264:76ec with SMTP id v19-20020a50d593000000b00572226476ecmr8068209edi.2.1714438792982;
        Mon, 29 Apr 2024 17:59:52 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d70a:9c00::b2c])
        by smtp.gmail.com with ESMTPSA id ef9-20020a05640228c900b00571bde3b0a4sm13261791edb.34.2024.04.29.17.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 17:59:52 -0700 (PDT)
Date: Tue, 30 Apr 2024 03:59:49 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 07/10] net: dsa: mv88e6xxx: Track bridge mdb
 objects
Message-ID: <20240430005949.44lcegwhmcetpddm@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-8-Joseph.Huang@garmin.com>
 <20240402122343.a7o5narxsctrkaoo@skbuf>
 <b5f79571-b4a8-4f21-8dc8-e1aa11056a5d@gmail.com>
 <20240405110745.si4gc567jt5gwpbr@skbuf>
 <c4f5c444-832c-4376-845f-7c28e88e4436@gmail.com>
 <d36e2b82-0353-4c9c-aa89-22383c3bda2b@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d36e2b82-0353-4c9c-aa89-22383c3bda2b@gmail.com>

On Mon, Apr 29, 2024 at 06:07:25PM -0400, Joseph Huang wrote:
> Something like this (some layers omitted for brevity)?
> 
>                                       +br_iterator
>                                       |  for each mdb
>                                       |    _br_switchdev_mdb_notify
> rtnl_lock                             |      without F_DEFER flag
>  |                                    |      |
>  +switchdev_port_attr_set_deferred    |      +switchdev_port_obj_notify
>    |                                  |        |
>    +dsa_port_mrouter                  |        +dsa_user_port_obj_a/d
>      |                                |          |
>      +mv88e6xxx_port_mrouter----------+          +mv88e6xxx_port_obj_a/d
>                                         |
>  +--------------------------------------+
>  |
> rtnl_unlock

At a _very_ superficial glance, I don't think you are properly
accounting for the fact that even with rtnl_lock() held, there are still
SWITCHDEV_OBJ_ID_PORT_MDB events which may be pending on the switchdev
chain. Without a switchdev_deferred_process() flush call, you won't be
getting rid of them, so when you rtnl_unlock(), they will still run.

Even worse, holding rtnl_lock() will not stop the bridge multicast layer
from modifying its br->mdb_list; only br->multicast_lock will.

So you may be better off also acquiring br->multicast_lock, and
notifying the MDB entries to the switchdev chain _with_the F_DEFER flag.

> Note that on the system I tested, each register read/write takes about 100us
> to complete. For 100's of mdb groups, this would mean that we will be
> holding rtnl lock for 10's of ms. I don't know if it's considered too long.

Not sure how this is going to be any better if the iteration over MDB
entries is done 100% in the driver, though - since its hook,
dsa_port_mrouter(), runs entirely under rtnl_lock().

Anyway, with the SWITCHDEV_F_DEFER flag, maybe the mdb object
notifications can be made to run by switchdev only a few at a time, to
give the network stack time to do other things as well.
