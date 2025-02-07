Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E33238D49
	for <bridge@lists.linux.dev>; Fri,  7 Feb 2025 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738940630; cv=none; b=GWDvENUJpjzpYpKvhFmzJ2gdHAPtGMPwkXLA2aGgsxUgmAEDXIRTd1oLMuWdSXmg7Sas4YBI3cI0fYhsrr0GaPk7UopApvtg2RCQxBB5TvayrB7IRfuoe/Ry/scGJRvdhOwaDO7mNNBCeUpIcMkQFGoGBQiIGBpsGwHjHaSKvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738940630; c=relaxed/simple;
	bh=Dv/Su0DUCWL65dbGc50TWvwNdQUcJSM82wl4CKW8Ybo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ena1/X332b3f28n+35Q669+8MYr9D/EqVb0F2tQRxGY9QzNzxo3BaUv5t06s5A86esVReq9JPIQKdYvI3T477eSEgZAmIty2xQIn95N7M3UD3xdIxbOMYEwiTdY5LUP8BH4PdY9n6bJXIumZyNU1n1CPxGRXD8R/n47BxosMnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/uk3gUP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/uk3gUP"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7908ecb31so9819566b.1
        for <bridge@lists.linux.dev>; Fri, 07 Feb 2025 07:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738940627; x=1739545427; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oe749KfJTlBXfu5CFXqHM08pOCrnuopnGGzvAlfhP8M=;
        b=I/uk3gUPq8lfPd8JgR+KFliSVHjJC7vY2I2S7DEiR6EBKkmGg9q3Qxr8hZE279RT/h
         hp/iuzNr4VE5bMLjYrBSPIo1b+0GnB73hdYQD5Utu8Y5eqHayxDSANoKkvrdvkE74N5/
         vSAYvODZZ27BKLHmbqhGSDWygCqnbuZ++pcHF+yDEowcgFehAEIK/6cYD0QAbeSQH0XL
         d7YJ/jY9b7dOSRS74DKJdV6JzCbRSmGpUtrFQQkNHpQFatuEWMWwhDyx+kCjBUPoITtm
         tozAnstG9kR5dgrPP16l1TvlzvrDAAva6CAarE18SSUG+oD8RAhBDi3ntl1Jw/LcFvl4
         oAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738940627; x=1739545427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oe749KfJTlBXfu5CFXqHM08pOCrnuopnGGzvAlfhP8M=;
        b=LprnIBhJyEdoe87lTQiZShOv2Qqe8aLHeBHi+xneWIERk/UaFUrbrvgUX1b4faYAIk
         Ps9QvSTUZQZVFxk5UQQ1ziHSa1C7W3tkgK/UTSvG/gHdylILRWOxAeCQfHrdQHjRNkuK
         +tbFcAhnN5qi40iHTcifTsTa7AkFYYEcXBG9pv+gEIqCugMHrnQFG3X8CgZ30uun7Ypn
         q/uIjF7CTYm64SK2j8N5NMtkqt2NaU/6D1XCHJl9CPdP/FUeFJ+WJ1awgw7p/ZNGNdnh
         8uDsUhyW8EB78ODTcSfbUnqVd8uBq58C4PRujXXEfwvAYG/wv0m1T5A+goZ/eVHu9yav
         14Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXeVnUxOLxWO3EuEfB7slF2b/Nuyy5EJQoUAmhjIT/QDc97tLb1iNrlY+hXHY8lKQ4g9XkhUmI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwIH+v69O6mXthsCPa9ZvxN3i2h3nYRL71HH0sCnO5DjKln1XhI
	WSTVsI1XGsiJ6HHP1TGCaT9JjaHa6o4hfczasKKrVvuCovnQueK4
X-Gm-Gg: ASbGncumSlA74Uhk9bHlxJrds3y/3AHp75d52gxcZ5LH5zq0H7Ey38mkr0qG+2tVgUI
	NjpdDpis9zWBM8VbRZXYYgjOjMDlsrkHwX4CameLuH8icBpIpBVQK95SwQRHk38xiEyShyyGodw
	JKqDu1p8OZM2KZRKEb7Podi+6UFlH/x89mQRgzazsDBTUpn2XXMA/3yUCDNM7nP7mDprKASi3qL
	NO7bOVwGlJ5DIH2OAZOhPKwvFXAJOHyJYp1U1sTdSb2wY2n7boD4YuQI63+AhCe59UnQRH47heD
	Eiw=
X-Google-Smtp-Source: AGHT+IHsKZDrEgjFzsjOHb6AegH/WyuF+q13HWJO6Xd2xBaxIXrpB2eiffrWM2ZlqpgeNqo0xDb4cA==
X-Received: by 2002:a17:907:360d:b0:ab6:ed8a:1593 with SMTP id a640c23a62f3a-ab789b6045amr110408366b.7.1738940625225;
        Fri, 07 Feb 2025 07:03:45 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e6192sm278238266b.121.2025.02.07.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 07:03:44 -0800 (PST)
Date: Fri, 7 Feb 2025 17:03:40 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 net-next 12/14] bridge: No DEV_PATH_BR_VLAN_UNTAG_HW
 for dsa foreign
Message-ID: <20250207150340.sxhsva7qz7bb7qjd@skbuf>
References: <20250204194921.46692-1-ericwouds@gmail.com>
 <20250204194921.46692-13-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204194921.46692-13-ericwouds@gmail.com>

On Tue, Feb 04, 2025 at 08:49:19PM +0100, Eric Woudstra wrote:
> In network setup as below:
> 
>              fastpath bypass
>  .----------------------------------------.
> /                                          \
> |                        IP - forwarding    |
> |                       /                \  v
> |                      /                  wan ...
> |                     /
> |                     |
> |                     |
> |                   brlan.1
> |                     |
> |    +-------------------------------+
> |    |           vlan 1              |
> |    |                               |
> |    |     brlan (vlan-filtering)    |
> |    |               +---------------+
> |    |               |  DSA-SWITCH   |
> |    |    vlan 1     |               |
> |    |      to       |               |
> |    |   untagged    1     vlan 1    |
> |    +---------------+---------------+
> .         /                   \
>  ----->wlan1                 lan0
>        .                       .
>        .                       ^
>        ^                     vlan 1 tagged packets
>      untagged packets
> 
> br_vlan_fill_forward_path_mode() sets DEV_PATH_BR_VLAN_UNTAG_HW when
> filling in from brlan.1 towards wlan1. But it should be set to
> DEV_PATH_BR_VLAN_UNTAG in this case. Using BR_VLFLAG_ADDED_BY_SWITCHDEV
> is not correct. The dsa switchdev adds it as a foreign port.
> 
> The same problem for all foreignly added dsa vlans on the bridge.
> 
> First add the vlan, trying only native devices.
> If this fails, we know this may be a vlan from a foreign device.
> 
> Use BR_VLFLAG_TAGGING_BY_SWITCHDEV to make sure DEV_PATH_BR_VLAN_UNTAG_HW
> is set only when there if no foreign device involved.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---

Shouldn't mlxsw_sp_switchdev_vxlan_vlans_add() also respect the
SWITCHDEV_F_NO_FOREIGN flag? My (maybe incorrect) understanding of
bridging topologies with vxlan and mlxsw is that they are neighbor
bridge ports, and mlxsw doesn't (seem to) call
switchdev_bridge_port_offload() for the vxlan bridge port. This
technically makes vxlan a foreign bridge port to mlxsw, so it should
skip reacting on VLAN switchdev objects when that flag is set, just
for uniform behavior across the board.

(your patch repeats the notifier without the SWITCHDEV_F_NO_FOREIGN
flag anyway, so it only matters for flowtable offload).
