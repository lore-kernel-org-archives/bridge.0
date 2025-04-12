Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A224A18
	for <bridge@lists.linux.dev>; Sat, 12 Apr 2025 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744465817; cv=none; b=Otrit3M2lIcu84YH1s0lRPZkCSnQDTAf6BQ+ItbPp5gaPmeelUDkL0ucDv8PHA2yd492QInh4UO8Hsf8KagFBx5CsNWxRWik6Nj3M26TiXvVt8no/bJXymoaQFISSxQzbFnvdtoSA+a42B7PmWutaTheyo//QNvGuGQxMCyXsVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744465817; c=relaxed/simple;
	bh=9HVAaKeQsXM5ZKip4Wyw4Xr3Rq1kzLUbh5jUuY5fHjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHMjg/u+Y5s6xX3gTsR2+4apdl3L9/WB1Hthax7MKLryzsNOVcKRrNgn4coQ8cDjRVYoO/tVEsSQkRLpxkMxMyhV7qgT2g+sfq1w2NRbL8pB7P8Sb4VU1vjrhWGr9V+w4B1HZti+p0s+CpW/yQvKEqrPwAzD4WSdTYAM0YCy7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/EOLXh3; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/EOLXh3"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e6df4507690so2643890276.0
        for <bridge@lists.linux.dev>; Sat, 12 Apr 2025 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744465815; x=1745070615; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HVAaKeQsXM5ZKip4Wyw4Xr3Rq1kzLUbh5jUuY5fHjg=;
        b=H/EOLXh3HrLC+KFo5JVGYx4lm1YhhdnLZK7eX+0cS7c5EeJ9ziZIOav4tivzhowdLl
         TrmVIV4FKVdEHKAH2sQehpXVpNiXjHsPeaOf7qw5dKmq2r9hr3XKsMGgkz7XiW8c7c/t
         9S1/hAwU/mlQ+kg8ru/QK64WhPpnqfoyto+rGXP0CKpVAEhBXiNYp7s197O6kYurSkbI
         cNqWiyBFfPBEzMm1Z33pr6PfLFEVJQuWWdKK2y1PbbsUGd7sDjFa4Etzx6CQBdGw2ZDt
         Y/kDR4abCxoYe3C62ViLv3eVNkJ1DGLP5lbxF3WRI39N74JulHgdAHZnm2vCstnPBm30
         jdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744465815; x=1745070615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HVAaKeQsXM5ZKip4Wyw4Xr3Rq1kzLUbh5jUuY5fHjg=;
        b=PHzjav3WXGfBlktKKQ5V56Lqd3trRYSxWs0xCH9yg2H/O/aBDRoZt/Q1oZiuN++Aqg
         WAQcR3eS58fuwxOyf+22u5fAN1Tki9jk69THK7GbesGw7Q0mNxf+BWm9PF34UnN0ifV5
         J/u4/0Blhuu0vEKBFD/BmcxePSrKQov5QZTgP2mfma3UFk4hQgw73WZcSC4RwCEsUa2t
         jRbzkZxI3n+uwhGDJJJuQMvWPesQcrkna+2uDfbaMMEygKP2o/ZZd9n/7D/mkuY3+l6L
         EU7q6W9Y76hvCsQKnU/oYgY/cX+0LlNjG8dhq9EeU31hlXUUsi5lj8SR4w3C6w4Rs0lq
         MqpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCODbBSCHRh8ZKv6b9U5cayH0GCJqBWo40DgOBZPxjEk8McomjaO/7ZqAhFxCEeGIDGaWj/SM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5fa5f3soTWth2GSJEmqx9JzaJj0hDh+szM9kTBrlNBewHfl3P
	FwiAWjDzAIzufZeZTAERfdgf6xlcf7TEE6UFK7O72LTD6RG5kbGpy/nooLqgKB3lofRgmArnhhy
	eX0JL88JTfKa8D/gkZnfxZl1TkEo=
X-Gm-Gg: ASbGncvGwIYhig3/vQe/AijcJyiIMbXM8BA1I9K+DqHmKiWCHOF8aKSU6GoqM5ly2+X
	nncUmH0UvOBvmdZk9FNvz+rdANqfe7/8Kk1YbbBtxRC3Zdl/tMm7CdCeA8wqvqnVGG0uD1wH5r7
	HZmVjG+jOi1ufDcyp0Ohhe1W/vDkBjTJ+tpZgHBsFuRKwYzaYpCT5+Zjs=
X-Google-Smtp-Source: AGHT+IGlVaCnBfQC6aLBOtn8bfByNyXTwCZBMS+MjyA3ylshqjYzEuowrHjxS7RvT4Ak34ee74hLRjR5mgNoo12z6Dk=
X-Received: by 2002:a05:6902:2610:b0:e64:cd91:9c6b with SMTP id
 3f1490d57ef6-e704df2291amr9533794276.2.1744465814617; Sat, 12 Apr 2025
 06:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250412122428.108029-1-jonas.gorski@gmail.com> <20250412133422.xtkd3pxoc7nwprrb@skbuf>
In-Reply-To: <20250412133422.xtkd3pxoc7nwprrb@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 12 Apr 2025 15:50:00 +0200
X-Gm-Features: ATxdqUFoNO90KQDhVHiGWcqBH9cRmiqh3zj4d_mFx7nVU1ZdayZ8Gf2QBeKdaOk
Message-ID: <CAOiHx=mYJm_mrwrDCuQ4ZEviPKLgWDqNcaSXPzaXHeGYWBJCaA@mail.gmail.com>
Subject: Re: [PATCH RFC net 0/2] net: dsa: fix handling brentry vlans with flags
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 3:34=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Sat, Apr 12, 2025 at 02:24:26PM +0200, Jonas Gorski wrote:
> > While trying to figure out the hardware behavior of a DSA supported
> > switch chip and printing various internal vlan state changes, I noticed
> > that some flows never triggered adding the cpu port to vlans, preventin=
g
> > it from receiving any of the VLANs traffic.
> >
> > E.g. the following sequence would cause the cpu port not being member o=
f
> > the vlan, despite the bridge vlan output looking correct:
> >
> > $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
> > $ ip link set lan1 master swbridge
>
> At this step, dsa_port_bridge_join() -> switchdev_bridge_port_offload()
> -> ... -> br_switchdev_port_offload() -> nbp_switchdev_sync_objs() ->
> br_switchdev_vlan_replay() -> br_switchdev_vlan_replay_group(br_vlan_grou=
p(br))
> -> br_switchdev_vlan_replay_one() should have notified DSA, with changed=
=3Dfalse.
> It should be processed by dsa_user_host_vlan_add() -> dsa_port_host_vlan_=
add().
>
> You make it sound like that doesn't happen.

Yes, because I messed up writing down what I did. That should have
been vlan_default_pvid 0 so there are no VLANs configured by default.
>
> I notice you didn't mention which "DSA supported chip" you are using.
> By any chance, does its driver set ds->configure_vlan_while_not_filtering=
 =3D false?
> That would be my prime suspect, making dsa_port_skip_vlan_configuration()=
 ignore
> the code path above, because the bridge port is not yet VLAN filtering.
> It becomes VLAN filtering only a bit later in dsa_port_bridge_join(),
> with the dsa_port_switchdev_sync_attrs() -> dsa_port_vlan_filtering(br_vl=
an_enabled(br))
> call.
>
> If that is the case, the only thing that is slightly confusing to me is
> why you haven't seen the "skipping configuration of VLAN" extack message.
> But anyway, if the theory above is true, you should instead be looking
> at adding proper VLAN support to said driver, and drop this set instead,
> because VLAN replay isn't working properly.

It's b53, and on first glance it does not set it. But as I just
noticed, I messed up the example.

So adding the lan1 vid is supposed to be the very first vlan that is config=
ured.

>
> > $ bridge vlan add dev lan1 vid 1 pvid untagged
> > $ bridge vlan add dev swbridge vid 1 pvid untagged self
> >
> > Adding more printk debugging, I traced it br_vlan_add_existing() settin=
g
> > changed to true (since the vlan "gained" the pvid untagged flags), and
> > then the dsa code ignoring the vlan notification, since it is a vlan fo=
r
> > the cpu port that is updated.
>
> Yes, this part and everything that follows should be correct.

Sorry for the mistake. I did it correctly while testing though!

Best regards,
Jonas
