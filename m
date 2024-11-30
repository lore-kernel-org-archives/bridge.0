Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F64436E
	for <bridge@lists.linux.dev>; Sat, 30 Nov 2024 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732982697; cv=none; b=NhDQ7D1t3ciQDsX0TVnqixtUsELIFhGPSE5KdQYA7vH8EziStziHZjyJSmAILCOYUEttnYk1S+F/fjTwiJmREMCZOi7yTBUZJo8c7/TkNLJ9fUiqu2uYE1zmtorSGV8dTfKBM02nCEexw2yDsnupXDczIFTLta6tsxNkRzLvhig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732982697; c=relaxed/simple;
	bh=Ib0eMIHq4Tud5T3QYMT+FKlg8p3RZjvIuyuFfrCD4Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGL+5LF5f/1Afc2PuB+1F6Kx8dv88EXdSvBapmgt8ZNwKOZWsXiA2ZuwSD9a/TgvRa87a0dnl+gl97QlZj8RnYsyCRudsDw+dqZGmyKxivi6E4ofXGDLa5STBhenHRUqWtkfVGmxEwMOsmzzxetQyK8epPTjr6JNVIcIlr+W/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=mMhdEdHj; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="mMhdEdHj"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53df1d1b726so3262046e87.0
        for <bridge@lists.linux.dev>; Sat, 30 Nov 2024 08:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1732982694; x=1733587494; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CU8Ha8lvwzrUL3wklZxNnby9TbqM0AQPddb/sVDz+Hg=;
        b=mMhdEdHjID0sLq7ZB4foVQwZgc+61JyMn8QfYmX1GvuYFWhouvKHPl/SA8u0gnW+Iw
         JVTXPe1+oClikgyXVOSFnKWpXIG0le1WYFpPxp5SpDG6edGp5oI5F6nnTRyJ3+k4vMYF
         LhTFij5kFgGNtH8gjIvJb7In9G3gkFLy38HcTLGqg91zksPuUbgoPYCCn5G05azZTGoN
         Idyjnlr58+kj9yp6wZEG6kv+GrA1egSOSrzxkadK/cY5g5TN8jqwEWMir1jlEsWzlua+
         c7KX6efU6xvEVh1UPt3XHBMN6Hev6U/D/FPGqLVqJijt0wciCztkq55pVImcr73MzbcF
         imZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732982694; x=1733587494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CU8Ha8lvwzrUL3wklZxNnby9TbqM0AQPddb/sVDz+Hg=;
        b=Q9DV4p+l9eHaYxPPQHkLSVe9ebCpmFkBF+kX/9LpiyqwW/+UUZG0VVf6shLIUfsthe
         tQTRLx20+5tLZihQSWQSJl8tLr5320rk2cjph990IAG7A/g0vQhkHisC9IkMLopygkRN
         dI7mGhHhlqqEw+rBi1wmmO2xVEC9GCS2b9g6f1Whpxc3HanVFBSpVO8P+9G8Mo/FFLEa
         8I137K2hDbeFzoacnIpLwQlKLo+VUMk2I60fZcT+1mb7jtbwrVfzc8q+MG0FV0eNfZXd
         L9ETp7p2F8Q/LZ3oKyutCqu4IahhnmWoyNxcszDXuyynxyv6XlslipYzqk8Nbn975YvY
         fLqA==
X-Forwarded-Encrypted: i=1; AJvYcCWDCz4g66dkTF7t/9bM7OhxeBNorLb/M4AnakdztjBJQNFFJ6MuQxXJQ3/n0f/9nnW1kZakbJA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzFp2EuU0MZHw73DjrjpwuA+BrDWRoNgDK1epbd5y4LComU1Rdk
	Et4wC2l+WdGT8/fBl+tjKYccSPBFmBhlI4QLoQZndrlOaysDzt/UqpKEcPuh8nk=
X-Gm-Gg: ASbGncuBfnK2T+rkNngvXuYL/QwM8vQcIYtV/fJwH82LgTfg+gbcfoArl/rSizbHNAp
	y2O0/AkkQD621FDk9v+n+AOaFwp/MRkJEY7amneaut0PfIoy2pf5StI7QMH7wmTIl4HYKRXoPjP
	2ShaQpNFf7Ypr0LO/rpVrgjyoQ8JkZgI7XkpBYGCsXJMXzmQ52OUTbOZoHeGWf/8y9jOdckuTYX
	mYdUzyZ2dsbFHbECTxg6JbcqsC49n1/Dc8gGB8BvFstF4o=
X-Google-Smtp-Source: AGHT+IHL4oeMU03kLmQ2L0BR3qVJKTiAVIsSPE3HICpdb/3DuaV9c9TIe/hHbGxSndbZ9+FTqZL6rQ==
X-Received: by 2002:a05:6512:3990:b0:53d:eefc:2b48 with SMTP id 2adb3069b0e04-53df00dc9bamr8384254e87.33.1732982694015;
        Sat, 30 Nov 2024 08:04:54 -0800 (PST)
Received: from localhost ([217.199.122.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f2adsm808857e87.114.2024.11.30.08.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 08:04:53 -0800 (PST)
Date: Sat, 30 Nov 2024 18:04:52 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Andy Strohman <andrew@andrewstrohman.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Roopa Prabhu <roopa@nvidia.com>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH net-next] bridge: Make the FDB consider inner tag for
 Q-in-Q
Message-ID: <Z0s3pDGGE0zXq0UE@penguin>
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130000802.2822146-1-andrew@andrewstrohman.com>

On Sat, Nov 30, 2024 at 12:07:57AM +0000, Andy Strohman wrote:
> 802.1q networks with IVL (independent VLAN learning) can
> tolerate duplicate MACs as long as the duplicates
> reside in different VLANs. Similarly, IVL networks
> allow for L2 hairpining where different VLANs are
> used for each side of the hairpin in order to not
> confuse the intermediate bridge's FDBs.
> 
> When these types of networks are inter-connected
> using 802.1ad or Q-in-Q, only the outer VLAN tag is
> considered by the 802.1ad bridge during FDB lookup.
> 
> While traffic segregation by inner and outer VID works as
> expected, the inner VLAN's independent VLAN learning can
> be defeated.
> 
> The following example describes the issue in terms of
> duplicate MACS in different VLANs. But, the same concept
> described in this example also applies L2 hairpining via
> different VLANs.
> 
>                  _______________________
>                 |  .1ad bridge          |
> 	        |_______________________|
>            PVID3|      PVID3|      PVID3|
>                 |           |           |
> TAGGED:        7|          8|          8|
>             ____|____  _____|___   _____|___
>            | .1q br 1| |.1q br 2|  |.1q br 3|
>            |_________| |________|  |________|
>          PVID7 |      PVID8 |      PVID8|
>              HOST A       HOST B      HOST C
> 
> The above diagram depicts a .1ad bridge that has "pvid 3
> untagged" configured for every member port. These member ports are
> connected to .1q bridges, named 1, 2 and 3. .1q br 1 allows VID 7 tagged
> on its port facing the .1ad bridge. .1q bridge 2 and 3 allow
> VID 8 tagged on their ports that face the .1ad bridge. Host A
> is connected to .1q br 1 via a port that is configured as "pvid 7
> untagged". Host B and C are connected to bridges via ports
> configured as "pvid 8 untagged".
> 
> Prior to this change, if host A has the same (duplicate) MAC
> address as host B, this can disrupt communication between
> host B and host C. This happens because the .1ad bridge
> will see the duplicate MAC behind two of its ports
> within the same VID (3). It's not examining the inner VLAN to
> know that the hosts are actually reside within in different
> L2 segments.
> 
> With this change, the .1ad bridge uses both the inner and outer VID
> when looking up the FDB. With this technique, host B and C are
> able to communicate without disruptions due to the duplicate MAC
> assigned to host A.
> 
> Here is an example FDB dump on a .1ad bridge that is configured like
> the above diagram:
> 
> root@OpenWrt:~# bridge fdb show dynamic
> f4:a4:54:80:93:2f dev lan3 vlan 3 inner vlan 8 master br-lan
> f4:a4:54:81:7a:90 dev lan1 vlan 3 inner vlan 7 master br-lan
> f4:a4:54:81:7a:90 dev lan2 vlan 3 inner vlan 8 master br-lan
> 
> Note how duplicate MAC f4:a4:54:81:7a:90 is behind both lan1 and
> lan2. This FDB dump shows two entries with the same MAC and
> the same 802.1ad VLAN, 3. Prior to this change, only one fdb entry
> per MAC/VID would be possible. As such, the bridge would have
> issues forwarding. After this change, these entries are understood
> to be distinct as they pertain to different inner vlans, and
> therefore separate L2 segments.
> 
> Signed-off-by: Andy Strohman <andrew@andrewstrohman.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |   4 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
>  drivers/net/ethernet/intel/igb/igb_main.c     |   4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   4 +-
>  .../ethernet/mellanox/mlxsw/spectrum_router.c |   4 +-
>  .../ethernet/mellanox/mlxsw/spectrum_span.c   |   4 +-
>  .../mellanox/mlxsw/spectrum_switchdev.c       |   2 +-
>  drivers/net/ethernet/mscc/ocelot_net.c        |   4 +-
>  .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |   8 +-
>  drivers/net/macvlan.c                         |   4 +-
>  drivers/net/vxlan/vxlan_core.c                |   6 +-
>  include/linux/if_bridge.h                     |   4 +-
>  include/linux/netdevice.h                     |   6 +-
>  include/linux/rtnetlink.h                     |   4 +-
>  include/trace/events/bridge.h                 |  20 ++--
>  include/uapi/linux/if_link.h                  |   1 +
>  include/uapi/linux/neighbour.h                |   1 +
>  net/bridge/br_arp_nd_proxy.c                  |   8 +-
>  net/bridge/br_device.c                        |  11 +-
>  net/bridge/br_fdb.c                           | 107 ++++++++++--------
>  net/bridge/br_input.c                         |  22 ++--
>  net/bridge/br_netlink.c                       |  18 ++-
>  net/bridge/br_private.h                       |  25 ++--
>  net/bridge/br_vlan.c                          |  34 +++++-
>  net/core/neighbour.c                          |   1 +
>  net/core/rtnetlink.c                          |  58 ++++++----
>  26 files changed, 227 insertions(+), 143 deletions(-)
> 

Hi,
This patch makes fdb lookups slower for everybody, ruins the nice key alignment,
increases the key memory usage and adds more complexity for a corner case, especially
having 2 different hosts with identical macs sounds weird. Fdb matching on both tags
isn't a feature I've heard of, I don't know if there are switches that support it.
Could you point to anywhere in the specs that such support is mentioned?
Also could you please give more details about the use case? Maybe we can help you solve
your problem without impacting everyone. Perhaps we can mix vlan-aware bridge and tc
to solve it. As it stands I'm against adding such matching, but I'd love to hear what
other people think.

Cheers,
 Nik
