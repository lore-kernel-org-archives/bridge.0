Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2EF14F9F9
	for <bridge@lists.linux.dev>; Sun, 13 Apr 2025 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536326; cv=none; b=Qv4ErWvFB/yKSdkWq42tHhWl1b57VJp7JwqL96thzPeGlitX3OpfJ58jm5RLEq0xtTCx0ly6onsGZehOHiTAdspXqRDNZDRQnDu/1VycMIU8REAkErLq9MdsvGw1VlD9gasv3Bwc32B4dZ0aKIgT8G8v55z6+5MvQduS+pXpSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536326; c=relaxed/simple;
	bh=XW0UTv9CvXun7cSv8wxoN8fYT/wluyfThYmnYWG9Fzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If0VAW7lyx/O/uW+IValKswzsKeIlnY1Gow0JfeDoI4+nW4zJcZoX47L5mKEXRUcpU2ULL05S51kDuyXtRRD/LpR5EgWYJiMy6i/XBSIPzyhN3Hb2WFTdWfqFuiIzX7VS5PN4+idk2IjGEJrVV4fQktGO5AVcZtX8KRJS5PhAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmRhX+Pn; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmRhX+Pn"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e589c258663so3054158276.1
        for <bridge@lists.linux.dev>; Sun, 13 Apr 2025 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744536324; x=1745141124; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW0UTv9CvXun7cSv8wxoN8fYT/wluyfThYmnYWG9Fzw=;
        b=RmRhX+Pn+hx1jnQtoMCQ5m+c1UMYYG7adqinOiZNypfG5LEu5Ebn5qebCBZ9LOWGFD
         H8DZINyd7tqY/fpXzqnVPPAjXl5o5d5fpwd1Wm//ZSZN4tLJPAaL3mT93V8M4SwkcqOG
         J2soQcohc+nipQCTGk0lX1Tj3t2aDftd8jFRq33tnvgXbL39X5sbgg4sk3SRvgQ1SljR
         5+TkGIdR4KxLSZtJ0AaytlPkvDq39A1Nf+qGW5e++XxJeRlItZga3cUUjYs6NrnOn/UU
         nUlZECq5hgG4molwzvZePT/Zc9SE4hIXqJ5IDwXQNj/gBUR9OBHkwl3/xzhgdgFGA2N9
         1Tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744536324; x=1745141124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XW0UTv9CvXun7cSv8wxoN8fYT/wluyfThYmnYWG9Fzw=;
        b=RBUT23fH37j8hg/9iVS1B4n0PG9jUCsbqyThWl0zTtYuRSte4F7y6wKBvJzol//qBV
         oLYxByEvad/Nb7Ky5EHu/1QdkR+gRj/lLtrjfJQRE68srEf2qDw6fBBtYhpiPs2cbW3G
         LhqjPgG6oEoM2pu/rpJpqMmL2JDGLoU/UGpYwwPpa3vrBVSxVas4V2XkMaLrZpsLsp0B
         ycTrnwiKju7LBOGtD1WWbIiQe+ZLRpu8OeWjlUix5icdL/z/QORnxMpbU+EQP/L6j0eL
         6eKu17kX1xWqcnobtTDhBaGieGEukxvynRezzQNR6wVtNq+PApn+NEiJY6g+aq+pjNQ0
         yekQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBrsDNdkNED8/26gzv+Gs+d0ss0YzvaET3xM9jGh6dhHcAKU/2kVw0k5PrUxR1FLoMQN8iBtg=@lists.linux.dev
X-Gm-Message-State: AOJu0YyeJN78ks3m0BcQ93hb3VOa/UaJrL64+xi67/9SOCz7Xex0StWn
	/gP0a+fHq6SjuqWvinj7erDtFYsd018MuYmHHLU7uofkjMKyxozey6FV21Smka0x3UznCQd65h8
	O1uM+In1nSBKP4y8axjzkeKQRWmo=
X-Gm-Gg: ASbGnctWVWXnofPpQl4ixvQsDrkjADvFxWuDX7KJOf0KwgCTPFeT8OB4TYI2RRMKPh2
	oHjjtz3TbvLZHdq1x9nqcYNy9ieyV6oA1jBRMaZ3Q4jqbs3A2lW6x8ePAz/vKX9DckWV3Qm/352
	HHFo5msmEzRZ6sJnpFrN5y
X-Google-Smtp-Source: AGHT+IEUPr9fpjvjQQp/TLLIU5fDq/TyhcM1PNpw1aLvcN/dix4gtOImMC2y/7/MMDqAAoqeFqHr4d14FnKJbb84sRw=
X-Received: by 2002:a05:6902:218b:b0:e6d:f8d3:5ee6 with SMTP id
 3f1490d57ef6-e704dfad75bmr13813435276.41.1744536323820; Sun, 13 Apr 2025
 02:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250412122428.108029-1-jonas.gorski@gmail.com>
 <20250412133422.xtkd3pxoc7nwprrb@skbuf> <CAOiHx=mYJm_mrwrDCuQ4ZEviPKLgWDqNcaSXPzaXHeGYWBJCaA@mail.gmail.com>
In-Reply-To: <CAOiHx=mYJm_mrwrDCuQ4ZEviPKLgWDqNcaSXPzaXHeGYWBJCaA@mail.gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sun, 13 Apr 2025 11:25:12 +0200
X-Gm-Features: ATxdqUGr1sHPIJAJqS4j0fS7KvaiCs3iVse3NbRGaHjOGUrakBsCO4TJU4Jf4Wc
Message-ID: <CAOiHx=mchprjNi8qQKsYzf18rE0NZxt-SjBRs9xnJEppcXUe7Q@mail.gmail.com>
Subject: Re: [PATCH RFC net 0/2] net: dsa: fix handling brentry vlans with flags
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 3:50=E2=80=AFPM Jonas Gorski <jonas.gorski@gmail.co=
m> wrote:
>
> On Sat, Apr 12, 2025 at 3:34=E2=80=AFPM Vladimir Oltean <olteanv@gmail.co=
m> wrote:
> >
> > On Sat, Apr 12, 2025 at 02:24:26PM +0200, Jonas Gorski wrote:
> > > While trying to figure out the hardware behavior of a DSA supported
> > > switch chip and printing various internal vlan state changes, I notic=
ed
> > > that some flows never triggered adding the cpu port to vlans, prevent=
ing
> > > it from receiving any of the VLANs traffic.
> > >
> > > E.g. the following sequence would cause the cpu port not being member=
 of
> > > the vlan, despite the bridge vlan output looking correct:
> > >
> > > $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid=
 1
> > > $ ip link set lan1 master swbridge
> >
> > At this step, dsa_port_bridge_join() -> switchdev_bridge_port_offload()
> > -> ... -> br_switchdev_port_offload() -> nbp_switchdev_sync_objs() ->
> > br_switchdev_vlan_replay() -> br_switchdev_vlan_replay_group(br_vlan_gr=
oup(br))
> > -> br_switchdev_vlan_replay_one() should have notified DSA, with change=
d=3Dfalse.
> > It should be processed by dsa_user_host_vlan_add() -> dsa_port_host_vla=
n_add().
> >
> > You make it sound like that doesn't happen.
>
> Yes, because I messed up writing down what I did. That should have
> been vlan_default_pvid 0 so there are no VLANs configured by default.
> >
> > I notice you didn't mention which "DSA supported chip" you are using.
> > By any chance, does its driver set ds->configure_vlan_while_not_filteri=
ng =3D false?
> > That would be my prime suspect, making dsa_port_skip_vlan_configuration=
() ignore
> > the code path above, because the bridge port is not yet VLAN filtering.
> > It becomes VLAN filtering only a bit later in dsa_port_bridge_join(),
> > with the dsa_port_switchdev_sync_attrs() -> dsa_port_vlan_filtering(br_=
vlan_enabled(br))
> > call.
> >
> > If that is the case, the only thing that is slightly confusing to me is
> > why you haven't seen the "skipping configuration of VLAN" extack messag=
e.
> > But anyway, if the theory above is true, you should instead be looking
> > at adding proper VLAN support to said driver, and drop this set instead=
,
> > because VLAN replay isn't working properly.
>
> It's b53, and on first glance it does not set it. But as I just
> noticed, I messed up the example.

So I had the chance to properly check and b53 does not unset it, so it
should be true.

> So adding the lan1 vid is supposed to be the very first vlan that is conf=
igured.
>
> >
> > > $ bridge vlan add dev lan1 vid 1 pvid untagged
> > > $ bridge vlan add dev swbridge vid 1 pvid untagged self
> > >
> > > Adding more printk debugging, I traced it br_vlan_add_existing() sett=
ing
> > > changed to true (since the vlan "gained" the pvid untagged flags), an=
d
> > > then the dsa code ignoring the vlan notification, since it is a vlan =
for
> > > the cpu port that is updated.
> >
> > Yes, this part and everything that follows should be correct.

So as an addendum that I probably should have included in the cover
letter and commit message:

Starting with no vlans configured on the bridge:

$ bridge vlan add dev lan1 vid 1 pvid untagged
$ bridge vlan add dev swbridge vid 1 pvid untagged self

does not work, but

$ bridge vlan add dev lan1 vid 1 pvid untagged
$ bridge vlan add dev swbridge vid 1 self

does properly trigger a configuration of the vlan on the cpu port.

And the difference is that in the former, would_change =3D>
vlan->changed is true (due to "pvid untagged"), and in the latter it
is not.

Best regards,
Jonas
