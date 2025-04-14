Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B436C28F524
	for <bridge@lists.linux.dev>; Mon, 14 Apr 2025 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638581; cv=none; b=m/keaS/QnXvxztbcH1Y4hOmIxUrH3dttW+1S8ZwqqMW2uCMkNo6jAoeJyFa4IQfnTWmr3SJcGjRTn/aGWxtUW7JUVoO2Gg0Ey1W6EzavvRMvy31ZwWgtr3OpLEPLIHFEtJyDsnRJ9rtIf7tXl8oFy+ePBxc1VyQaTpaafEftx8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638581; c=relaxed/simple;
	bh=8+orToe/4RdZZxMkZi8d6qlyA9kIqNrN26wfR6EjFsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NieVZOTx7M/+FlIFNH7DYFoK6J0UI+Rgrsdp5f6C9Oy9JLdIJDj5itu5OaKviIktBoiv+xEPjFfkfI1KfgG2VTuodiy4PIZ5SoQl9ivi48CCCKp3W4V49j3x7KLBc2+5kcu4CLM5MRB46oB034gJQFGiCy5F92Te1jh05w/EhSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvIAmjE1; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvIAmjE1"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e6df4507690so3785363276.0
        for <bridge@lists.linux.dev>; Mon, 14 Apr 2025 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744638578; x=1745243378; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+orToe/4RdZZxMkZi8d6qlyA9kIqNrN26wfR6EjFsM=;
        b=FvIAmjE1WAXgLCPglXfuxTRq9fOsA5M5hVDz3elAHg66daLQ/fGFxC5TQ4JG2hyfPI
         JSTEEnFdeo5czmXTj3FvMqIxYBdF40j7p1tQYcJ5jqDBRtiV/svCCPUNUqx6xbV0gIBi
         F2zcUbQ2wjw0F4NzfEzBHQYKm0+J7LHhwecbw6Bky5tc/5yCXjYV1HN2vgt48Vzo1TOT
         /vEorIocvLNIkSPvlv4IvvNYBM+0aTnr9GH8vOblkc8UItcsbxMhwKo6ruxi7BVF/wBL
         s3ECP61SgmSiNsYS4Zenl/+C6DDdFQFec+HxkETMcJvd0C/MdiP6dQbnWBghcCz+umU2
         0eKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744638578; x=1745243378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+orToe/4RdZZxMkZi8d6qlyA9kIqNrN26wfR6EjFsM=;
        b=lp0Z6MnI3q1K3aeh50yF14NsvZiM05mkJmlHziyD5PxI8JKQMyfvNQzWWoO1KkhCjR
         IRdonlU5UzXX7lKZr5qXn4ZO3Cnt84a7JDPKl7qrQtj7GmUXP2rwxSiklu0VIEumjzqE
         IMUzhGsfVxrHZfSaCZeDQJ+Imii1KUeMP9LGZuWMP593dWY8RsKOEXBGW6DiKJsy9XpQ
         mflX3DGUabDgz+G5HeM4lp2g7CXK91nGmLf4cZF3pyDok05GBBW956nvmenaetX3wl4S
         EMeSGVFaiXGLgmwtT0ZK+ia54qg++UtOlPS+Y8e9DDN2o9LaHEh2FDyf+LMBvHkGlYzx
         mlgw==
X-Forwarded-Encrypted: i=1; AJvYcCXPVnGkJHHrTa4ovz6rrWArkjufRoNRzcY2C0Sc0YjQSJ2pebAoM1+brQXSvkz2r94J6V9YSIA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxpfZyMFWMQN9jWsyjc6W9Vuc2DS6w3lL6vJPwYxqMXBPBG3dfU
	cSuZMQhXZbSfBj4HO4XO/CrMrLsf5nIJcEfqt5754x5vXH6dHPsZFiuBs9Fk/CSYtvk7bwm89JS
	jED0E0NBUTSMFmbQLlYDAh+8wcAE=
X-Gm-Gg: ASbGncvSMug6Mwxa7UXirL8n0kjOgWJAD1gRqqCn3K+A+ySPCjX2+Ig+oBN0XM7c6S2
	JK7pWldBxMLLVVqmku/ezowzUmQhPIxK8akEP9U9oxTuY+5Wqs8AUcprbDRjcLHx5hKFPEh4cUr
	IlHzVb9i29xI3m6VYj4TOV
X-Google-Smtp-Source: AGHT+IE7pz41ktet1N5msnDIGSIJ8EVDaFKfYflTEEXpfdGTOulYVfFTKrTv4d98YMMWSu5tauXipgFsb8VtweYkv9k=
X-Received: by 2002:a05:6902:a07:b0:e60:b135:4c07 with SMTP id
 3f1490d57ef6-e704dfda84cmr18878812276.15.1744638578458; Mon, 14 Apr 2025
 06:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250412122428.108029-3-jonas.gorski@gmail.com>
 <20250414124930.j435ccohw3lna4ig@skbuf> <20250414125248.55kdsbjfllz4jjed@skbuf>
In-Reply-To: <20250414125248.55kdsbjfllz4jjed@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 14 Apr 2025 15:49:27 +0200
X-Gm-Features: ATxdqUFhDGYeuHnd2o7xa-r3cQYxibJ0ZKR7cyDNcq-eDDRt7bhB2BFaj0CHTI4
Message-ID: <CAOiHx==VEbdn3ULHXf5FEBaNAxzyoHTqJEMYYtcQzjkj__RoLg@mail.gmail.com>
Subject: Re: [PATCH RFC net 2/2] net: dsa: propagate brentry flag changes
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 2:52=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> +Jonas, whom I've mistakenly removed from To: :-/
>
> On Mon, Apr 14, 2025 at 03:49:30PM +0300, Vladimir Oltean wrote:
> > On Sat, Apr 12, 2025 at 02:24:28PM +0200, Jonas Gorski wrote:
> > > Currently any flag changes for brentry vlans are ignored, so the
> > > configured cpu port vlan will get stuck at whatever the original flag=
s
> > > were.
> > >
> > > E.g.
> > >
> > > $ bridge vlan add dev swbridge vid 10 self pvid untagged
> > > $ bridge vlan add dev swbridge vid 10 self
> > >
> > > Would cause the vlan to get "stuck" at pvid untagged in the hardware,
> > > despite now being configured as tagged on the bridge.
> > >
> > > Fix this by passing on changed vlans to drivers, but do not increase =
the
> > > refcount for updates.
> > >
> > > Since we should never get an update for a non-existing VLAN, add a
> > > WARN_ON() in case it happens.
> > >
> > > Fixes: 134ef2388e7f ("net: dsa: add explicit support for host bridge =
VLANs")
> > > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > > ---
> >
> > I think it's important to realize that the meaning of the "flags" of
> > VLANs offloaded to the CPU port is not completely defined.
> > "egress-untagged" from the perspective of the hardware CPU port is the
> > opposite direction compared to "egress-untagged" from the perspective o=
f
> > the bridge device (one is Linux RX, the other is Linux TX).
> >
> > Additionally, we install in DSA as host VLANs also those bridge port VL=
ANs
> > which were configured by the user on foreign interfaces. It's not exact=
ly
> > clear how to reconcile the "flags" of a VLAN installed on the bridge
> > itself with the "flags" of a VLAN installed on a foreign bridge port.
> >
> > Example:
> > ip link add br0 type bridge vlan_filtering 1 vlan_default_pvid 0
> > ip link set veth0 master br0 # foreign interface, unrelated to DSA
> > ip link set swp0 master br0 # DSA interface
> > bridge vlan add dev br0 vid 1 self pvid untagged # leads to an "dsa_vla=
n_add_hw: cpu port N vid 1 untagged" trace event
> > bridge vlan add dev veth0 vid 1 # still leads to an "dsa_vlan_add_bump:=
 cpu port N vid 1 refcount 2" trace event after your change
> >
> > Depending on your expectations, you might think that host VID 1 would
> > also need to become egress-tagged in this case, although from the
> > bridge's perspective, it hasn't "changed", because it is a VLAN from a
> > different VLAN group (port veth0 vs bridge br0).
> >
> > The reverse is true as well. Because the user can toggle the "pvid" fla=
g
> > of the bridge VLAN, that will make the switchdev object be notified wit=
h
> > changed=3Dtrue. But since DSA clears BRIDGE_VLAN_INFO_PVID, the host VL=
AN,
> > as programmed to hardware, would be identical, yet we reprogram it anyw=
ay.
> >
> > Both would seem to indicate that "changed" from the bridge perspective
> > is not what matters for calling the driver, but a different "changed"
> > flag, calculated by DSA from its own perspective.
> >
> > I was a bit reluctant to add such complexity in dsa_port_do_vlan_add(),
> > considering that many drivers treat the VLANs on the CPU port as
> > always-tagged towards software (not b53 though, except for
> > b53_vlan_port_needs_forced_tagged() which is only for DSA_TAG_PROTO_NON=
E).
> > In fact, what is not entirely clear to me is what happens if they _don'=
t_
> > treat the CPU port in a special way. Because software needs to know in
> > which VLAN did the hardware begin to process a packet: if the software
> > bridge needs to continue the processing of that packet, it needs to do
> > so _in the same VLAN_. If the accelerator sends packets as VLAN-untagge=
d
> > to software, that information is lost and VLAN hopping might take place=
.
> > So I was hoping that nobody would notice that the change of flags on
> > host VLANs isn't propagated to drivers, because none of the flags shoul=
d
> > be of particular relevance in the first place.
> >
> > I would like to understand better, in terms of user-visible impact, wha=
t
> > is the problem that you see?

I was just in the progress of writing down some thoughts myself I had
while thinking about this.

So to me passing on the original flags but then no updates of these
flags feels wrong. I would expect them to be either never passed on,
or always sync it (and let the driver choose to handle or ignore
them).

Having the cpu port as egress untagged I can easily find one case
where this breaks stuff (at least with b53):

With lan1, lan2 being dsa ports of the same switch:

# bridge with lan1
$ ip link add swbridge type bridge vlan_filtering 1
$ ip link set lan1 master swbridge
$ bridge vlan add dev swbridge vid 10 self pvid untagged

# lan2 stand alone
$ ip link add lan2.10 link lan2 type vlan id 10

as then lan2.10 would never receive any packets, as the VLAN 10
packets received by the CPU ports never carry any vlan tags.

The core issue here is that b53 switches do not provide any way of
knowing the original tagged state of received packets, as the dsa
header has no field for that (bcm56* switches do, but these are a
different beast).

I guess the proper fix for b53 is probably to always have a vlan tag
on the cpu port (except for the special vlan 0 for untagged traffic on
ports with no PVID), and enable untag_vlan_aware_bridge_pvid.

To continue the stream of consciousness, it probably does not make
sense to pass on the untagged flag for the bridge/cpu port, because it
will affect all ports of the switch, regardless of them being member
of the bridge. Looking through drivers in net/drivers/dsa, I don't see
anyone checking if egress untag is applied to the cpu port, so I
wonder if not most, maybe even all (dsa) switch drivers have the same
issue and would actually need to keep the cpu port always tagged. And
looking through the tag_* handlers, only ocelot looks like it may have
the information available whether a packet was originally tagged or
not, so would also need to have untag_vlan_aware_bridge_pvid enabled.

Makes the think the cpu port always tagged should be the default
behavior. It's easy to strip a vlan tag that shouldn't be there, but
hard to add one that's missing, especially since in contrast to PVID
you can have more than one vlan as egress untagged.

Jonas
