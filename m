Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56EA60264
	for <bridge@lists.linux.dev>; Tue,  2 Apr 2024 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081292; cv=none; b=aRtuYa/4Tub3NxCFkXAs1cbhR1PH6zYO5DnLQC7RGqjeDsZXgU6SPnQ10nCpUBGUPcG9Yfo+QOPq2zxjg8c84iC9Hvq7N7mFHZ2VnRSmZ0t+Mqf6WDGkvhm9Cbq3B+LvUrSMWIPgP2tIbwwmTTEulz0o1vD29TFkMwZLRSuMl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081292; c=relaxed/simple;
	bh=9p94gVK0gPzTsEH+hyC2abn3E/+pGLEBCnowQm3IsU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlroeH85QAWIJaMuQBYssP7rRHBlF+tc6oIwnVPWZVKui9lU3Uf1Tdxqqf97byNK2vxSwi2xTCnV1+MnfkKx0f8tGgu68UHG6zpjCSJLzf6sZZNP6sMePYLpYsKjvu08qFemx++im3mO8l3Du0LJP1ZFd9iRYSMZVTtTCWxxwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFVLS9Fm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFVLS9Fm"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4702457ccbso690130966b.3
        for <bridge@lists.linux.dev>; Tue, 02 Apr 2024 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712081289; x=1712686089; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHbzrvZdCFQgrHwwmngnLaKZpD+R7uorK9gu95pe8gk=;
        b=VFVLS9Fm/rBn25iKHBLNbS/7J5xEXXl3AP8AmlOTyqA6Ym5mTqmpEUZCfXiPf88jOt
         zzbifb/VcP9IAnLy+m+CywjUx/22AHjRGKjSyrxOJ9GzbZaQiFlcp/LbhnyL8C/fqt/2
         gjFZiwq0Ncv369cjzbS55sk+JyfQVKSEMvsvwm+CjJg2Hy7cEbmShOFngaLGKWQbfyL5
         KBCpCQiheg8QD1O6CGzxjqIxLPsBFzU5AuioJGh0LbXSZQPWGzFxhdrpgOC33yTHT07E
         tp7dE+EMMWsy8U3ISDeW/zexaRAu8F4zduXz79ykuTaGezLhNh0mCLZfL2WJ575Vs9xl
         Mm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712081289; x=1712686089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHbzrvZdCFQgrHwwmngnLaKZpD+R7uorK9gu95pe8gk=;
        b=Z2UYr9ywHdS816XbOTMqTm7nlCpmnjQYdk/Wr/aTwrzY1TFuy7p+zQwIlL+pgejulQ
         loBi7yg2rpgrojNMQbQH7sqn8mEXGBP/4tbf+s7Rj+HlR6lMA+B1vR1W2Md0DuL9sQXf
         f6COeUknPKmgi+wOWbifULmAs6WnbT2Xl+MVXeTNCE7OqduF4WWxF8OdhneDPjPbhu4r
         caKhqml4nQXsZI3EDuQsk5t2E+hlo5/5O1VRHjw6ou/Ez6oBDdQQMErm5qZMxYHZk1Gq
         cWmwv0GJxkFkKVU2UJr+pFeg97Q2YyIRMbRrZxsSVAAmk+4TSy69AM3EfpuOeSBzFDRG
         rO8A==
X-Forwarded-Encrypted: i=1; AJvYcCXV+G5k1TO70uM/PTIaEWXYHXMUafxCYX14An4q1vax/DHT7HFV5vj7b2+qSLYGgHHdj1kLK2XD3ynHlkA7QzEIPKSfHEvd
X-Gm-Message-State: AOJu0YxeCOd4xCayjHzbmBqAzdvO1qHKtSuXzbWKMeM5WQDgKtLTx2QM
	E7duxBaFvCHgRdpFIeDLqvRyM2aQSHJ477NUItC3udW7l1MMUzIl
X-Google-Smtp-Source: AGHT+IGhQs+8Km43ZQAm7iTx0+D+dW0SrD2EA5loMMOGk4HLU7CsIDSyjpplSp4mIgaJLdZXT2LfJQ==
X-Received: by 2002:a17:907:7f06:b0:a4e:8b32:c259 with SMTP id qf6-20020a1709077f0600b00a4e8b32c259mr2302664ejc.46.1712081288667;
        Tue, 02 Apr 2024 11:08:08 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id ag12-20020a1709069a8c00b00a4e222225ebsm6831592ejc.15.2024.04.02.11.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 11:08:07 -0700 (PDT)
Date: Tue, 2 Apr 2024 21:08:05 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 04/10] net: dsa: mv88e6xxx: Add all hosts mc
 addr to ATU
Message-ID: <20240402180805.yhhwj2f52sdc4dl2@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-5-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402001137.2980589-5-Joseph.Huang@garmin.com>

On Mon, Apr 01, 2024 at 08:11:03PM -0400, Joseph Huang wrote:
> Add local network all hosts multicast address (224.0.0.1) and link-local
> all nodes multicast address (ff02::1) to the ATU so that IGMP/MLD
> Queries can be forwarded even when multicast flooding is disabled on a
> port.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  drivers/net/dsa/mv88e6xxx/Kconfig | 12 ++++++++
>  drivers/net/dsa/mv88e6xxx/chip.c  | 47 +++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/Kconfig b/drivers/net/dsa/mv88e6xxx/Kconfig
> index e3181d5471df..ef7798bf50d7 100644
> --- a/drivers/net/dsa/mv88e6xxx/Kconfig
> +++ b/drivers/net/dsa/mv88e6xxx/Kconfig
> @@ -17,3 +17,15 @@ config NET_DSA_MV88E6XXX_PTP
>  	help
>  	  Say Y to enable PTP hardware timestamping on Marvell 88E6xxx switch
>  	  chips that support it.
> +
> +config NET_DSA_MV88E6XXX_ALWAYS_FLOOD_LOCAL_ALL_HOSTS_ADDRESS
> +	bool "Always flood local all hosts multicast packets"
> +	depends on NET_DSA_MV88E6XXX
> +	help
> +	  When set to Y, always flood multicast packets destined for
> +	  224.0.0.1 (Local Network All Hosts multicast address) and
> +	  ff02::1 (Link-Local All Nodes multicast address), even when
> +	  multicast flooding is disabled for a port.  This is so that
> +	  multicast snooping can continue to function even when
> +	  multicast flooding is disabled.
> +	  If in doubt, say N.

In its current form, this will never be accepted. The mainline Linux
kernel is not a purpose-built project like a bootloader (and also like
some other uses of the Linux kernel). It gets picked up by
distributions, and the same kernel image is supposed to be used on
multiple platforms. So, customizing behavior at compilation time is not
a viable option. If there is any behavior that needs to be different on
some platforms than on others for some reason (this needs a
justification in its own right), it is handled through dedicated user
space API. When others say "hide custom behavior X behind an option", a
compile-time option is not what they mean.

As for the substance of the change itself, I am far from an authority
on multicast, I think you should try to push for something else, which
should be more palatable for everybody.

Some switches I've been working with have explicit flooding controls for:
- L2 multicast
- IPv4 control multicast (224.0.0.x)
- IPv4 data multicast
- IPv6 control multicast (FF02::/16)
- IPv6 data multicast

Whereas the bridge has a single "mcast_flood" control.

It seems adequate to attempt adding more netlink attributes to control
all of the above, individually. Then you could describe your use case,
in a standard way to the kernel, as "ip link set swp0 type bridge_slave
mcast_ipv4_data_flood off mcast_ipv4_ctrl_flood on". For compatibility,
"mcast_flood" could still be interpreted as a global enable for all
multicast.

The trouble seems to be actually offloading this config to Marvell DSA,
they don't seem to have a classifier that distinguishes between kinds of
multicast traffic.

How many link-local IPv4 and IPv6 addresses are there in actual use?
Would it be feasible to actually add ATU addresses for all of them, like
you did for 224.0.0.1 and ff02::1, and say that the port destinations of
_those_ are the mcast_ipv4_ctrl_flood ports?

> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 9ed1821184ec..fddcb596c421 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -2488,6 +2488,41 @@ static int mv88e6xxx_broadcast_setup(struct mv88e6xxx_chip *chip, u16 vid)
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_NET_DSA_MV88E6XXX_ALWAYS_FLOOD_LOCAL_ALL_HOSTS_ADDRESS)
> +static int mv88e6xxx_port_add_multicast(struct mv88e6xxx_chip *chip, int port,
> +					u16 vid)
> +{
> +	u8 state = MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC;
> +	const char multicast[][ETH_ALEN] = {
> +		{ 0x01, 0x00, 0x5e, 0x00, 0x00, 0x01 },
> +		{ 0x33, 0x33, 0x00, 0x00, 0x00, 0x01 }
> +	};
> +	int i, err;
> +
> +	for (i = 0; i < ARRAY_SIZE(multicast); i++) {
> +		err = mv88e6xxx_port_db_load_purge(chip, port, multicast[i], vid, state);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mv88e6xxx_multicast_setup(struct mv88e6xxx_chip *chip, u16 vid)
> +{
> +	int port;
> +	int err;
> +
> +	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
> +		err = mv88e6xxx_port_add_multicast(chip, port, vid);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>  struct mv88e6xxx_port_broadcast_sync_ctx {
>  	int port;
>  	bool flood;
> @@ -2572,6 +2607,12 @@ static int mv88e6xxx_port_vlan_join(struct mv88e6xxx_chip *chip, int port,
>  		err = mv88e6xxx_broadcast_setup(chip, vlan.vid);
>  		if (err)
>  			return err;
> +
> +#if IS_ENABLED(CONFIG_NET_DSA_MV88E6XXX_ALWAYS_FLOOD_LOCAL_ALL_HOSTS_ADDRESS)
> +		err = mv88e6xxx_multicast_setup(chip, vlan.vid);
> +		if (err)
> +			return err;
> +#endif
>  	} else if (vlan.member[port] != member) {
>  		vlan.member[port] = member;
>  
> @@ -3930,6 +3971,12 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
>  	if (err)
>  		goto unlock;
>  
> +#if IS_ENABLED(CONFIG_NET_DSA_MV88E6XXX_ALWAYS_FLOOD_LOCAL_ALL_HOSTS_ADDRESS)
> +	err = mv88e6xxx_multicast_setup(chip, 0);

This is the danger of developing on an old kernel and then just blindly
forward-porting. It will compile and smile and look pretty, but it won't
work. You need to request your board provider to do something and give
you access to mainline code.

In newer kernels, VID 0 is MV88E6XXX_VID_STANDALONE, aka a completely
separate address database compared to what the bridge is in charge of.
So, applied to the mainline kernel as of today, your change does nothing
useful, because when under a VLAN-unaware bridge, packets now get
classified to MV88E6XXX_VID_BRIDGED (4095).

For that matter, the port database (MV88E6XXX_VID_STANDALONE) should be
controlled through dev_mc_add(), and "ip maddr" shows you the link-local
multicast addresses offloaded to the device's RX filter.

mv88e6xxx today does not pass the requirements for dsa_switch_supports_mc_filtering(),
so dev_mc_add() does not actually program anything into hardware, but if
it did, it would have been the port database (VID 0), and this is what
makes your change wrong. You can read more about address databases in
Documentation/networking/dsa/dsa.rst.

> +	if (err)
> +		goto unlock;
> +#endif
> +
>  	err = mv88e6xxx_pot_setup(chip);
>  	if (err)
>  		goto unlock;
> -- 
> 2.17.1
> 
