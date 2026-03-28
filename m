Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7040DFD2
	for <bridge@lists.linux.dev>; Sat, 28 Mar 2026 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680459; cv=pass; b=BeO4dDcW7PiJqgjWRYcc0x97ksB54qD6JYuwuHII6o2kc+cywe8EqYPjacYQlejge7w5aeT2Q/8F73jWXyoUuZ9SHtKkHl+k8DfL9OUVARxY7WZ6WM2j2YYVisnT/zU2ecbs/TAfBvSjf76IwkOnxseuIyetMegCZ0MKBKqj0TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680459; c=relaxed/simple;
	bh=zryy76DaHt7oi4lNm/4tBM1hJztZ3WKVYQDK+AX6UqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDYn+Ql0MRHfW5DaYFbGTr+2Yptqd2gN81eK5TxGMFc4LNj0PsRQn2YGam7bYrFZCCDuE4pSJhcbkgyu513OeYHMYCJWMP1EgQwKdak5CecJLodAU5sNVmmCYCaodJnGTAqdy5wbVJsJTV/p8Cq7vdzkWg7MYuxYxOIaPFxekwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=E71kFWVP; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="E71kFWVP"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso1244695a12.1
        for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 23:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774680457; cv=none;
        d=google.com; s=arc-20240605;
        b=EPoxGpTkbKdhpTusHaHRyWH/A1ta9cO56SvSuqnh7Mnm2I53rutCgoupH08IjNR/mF
         1DOSvGIC92FZKkjkuFaLEFzxRjtpV8ge7kOKFs5mRhRrQleD/7hVrDbU/u067Tq/R7Qx
         nUUIbnLcJ7RxW0lZNxL3W79MHp813OqRrZF23cuyOrHGiwS4L1yExVpSoeKSMRvWXMfR
         9gYPB5m1cb7ZQf15vxd/b41atBpr+TRJhrqQvfRCh8uPo1D7yYuwJizapSUcJIc6BVlB
         SeTGLz8jPE2qFH5mL9p/TY3BipJMCVCFdlBlPEpn9QOrxq4iumb3697yQ5OnZYYPFBIS
         UHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=efA79Kc3jncizKFfyvZBGhmIZfpFT0np0LuNGDRDSDk=;
        fh=G+kneOlLPSI6I8w0Eg38Gb5WYcDxUKc0iSgH4Q51uEk=;
        b=hGbXiWN34GM0oDsexS7FjuDEda+TCQc/dMz8X2cERpKpEYNq8gL3asfmUGuoJ/tzcC
         2PaWjZ/NtOiBZca07dvfhpgS326n7BzRuy2Ju8ZkWSIyd6NUWFZfpKpN0ND1F1eVLPTQ
         /scUKmszIV8C7jDxwEyxEZsNpWNsAQnuYiHC/jG0c9HS77M20fmqRzJf4mZYH/B8eH4q
         hB17tdllk0Y6F/XseVH4v6cfl6OPr8/YIA6DBcEpndS0Ey+Z0p9Y+ujahPoRSI5UbCIe
         dVyna1TAumLvekvG1sjMIT3ufJF1Uh/a11yrJ5CoARqP+JFhre/H2bo/r3+OwllCyk9C
         lCBw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774680457; x=1775285257; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efA79Kc3jncizKFfyvZBGhmIZfpFT0np0LuNGDRDSDk=;
        b=E71kFWVPfSg9Kp4ap/g2/BcVpCAhi/ESqJpCQL09kbFFkDFViHLJilDD/EbW9K1mN1
         +Z/AR3HD5gbfapb1/dgdPO+ZlftQ1OHmCPbBDFUiNHcuWfLDmdQHGvkoODmdaV8nw8x7
         dXfYnyrK0wvhoyrZQs2hldmdwoLpmSx1Ct+5rGdkEG2bvTyAjJ1QzxJe9H/uIsMxvFl2
         Z1jwqnK+rdbAFzk09rYoWIEjStevGLtrD36QWqXidoY8OzLNbdTUl5Llzy4iBehCq0+C
         gLv4GV/n0Ul13sch/GaFHds45Pa4O2czHCMqqqn8Vu1cpS33ydI76eoQ1XhiSC7V8zSo
         Ywow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680457; x=1775285257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=efA79Kc3jncizKFfyvZBGhmIZfpFT0np0LuNGDRDSDk=;
        b=pz9QeSQAanEEINNkFoQRw+LeSFRmagErm+MJGqPtWeSLM8Fnk8XSza2G4tzTsUlC3s
         GiplBbxdxZ0RpuIVVk+Sp0QXBt8QnLbOzLuVKKrdjA1vRao3f4ppl70sEKoipOEoLXMY
         uN5bXsw6dYUTlZBS1GueZg61a8ew/c7ebV2bMdy3DXNywQEJf+sW/z/Ivu7l/68ftFnR
         LeidKe5jitCe0CS8SxkglM3+XdOlRGkPD/xe7rTSFNXEOupOETqXmEq7xswvZo32ueia
         wHYxStw2DGf/XV95LbL/GTeEaxDLiNLrUun9QYRt7u0mVnRw46FkWrJBUO5XZufQF3Cs
         kbsA==
X-Forwarded-Encrypted: i=1; AJvYcCVBYcFEpxzBfUtUy+ePiVfSlZgoDZMylECVO1Mrt9jvhvDUQO3rqyyJLPS4g4E60Ylud/SDc/k=@lists.linux.dev
X-Gm-Message-State: AOJu0YyRalRgax6WwQZ84FyRFmyw1//bjc788rh/NLNK6ku4h27i6a/U
	gMlLWmyniWxd8ISlQJWgITH+2ArMfXOhGZtkU+nn9dtOZTQ2wsFdKLokq9Yb+3P+xYwJCY1lsIp
	HQdsk3D5jyFxDKUqFaaAVRKXVOih83doQBoe+y+Jv
X-Gm-Gg: ATEYQzzr+97RqbBbO0q5aLXhd6UCzUC4pHl0bxyo4aAIGL1hzcanVK8sORl2W94gupI
	7WvjP0XGrnf2Kp2/xRtbHPcWdr56RxjIPSOK5nxkX2YsNPBxufAnq1t7xr59zUdxf9vTP02rzj4
	DOt2R6zmATkQUltRmMtjK5p18q4gedzdZ9yfzU67+peaHBnCHCHUbXvE48HADD+518q79DyGCDz
	inGLnN92Ao80bDz16fzQvtq4Wpp/UKSSMOpApK8O8s0fP11PrCDz8wiPLa3sz8bOV8qxGd5ULA6
	T4AhsaCw
X-Received: by 2002:a17:903:1a0c:b0:2b0:7224:a4f3 with SMTP id
 d9443c01a7336-2b0cdd40b60mr52610835ad.48.1774680456961; Fri, 27 Mar 2026
 23:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328063000.1845376-1-xmei5@asu.edu> <edad225a-79cc-42de-a771-b1ea6d430ef7@blackwall.org>
In-Reply-To: <edad225a-79cc-42de-a771-b1ea6d430ef7@blackwall.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Fri, 27 Mar 2026 23:47:26 -0700
X-Gm-Features: AQROBzAbJpV1CkxbRr5-qliISa1tOnspYTMXZ0FCgpdfmusuPjcBODzQ14y4YhQ
Message-ID: <CAPpSM+R5pM_X2_dbWvvpUn-MvZtqiLEXbmotnEQf+5DvPjxumw@mail.gmail.com>
Subject: Re: [PATCH net v2] bridge: mrp: reject zero test interval to avoid
 OOM panic
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, horms@kernel.org, 
	kuba@kernel.org, idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick review.

On Fri, Mar 27, 2026 at 11:44=E2=80=AFPM Nikolay Aleksandrov
<razor@blackwall.org> wrote:
>
> On 28/03/2026 08:30, Xiang Mei wrote:
> > br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> > interval value from netlink without validation. When interval is 0,
> > usecs_to_jiffies(0) yields 0, causing the delayed work
> > (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> > itself with zero delay. This creates a tight loop on system_percpu_wq
> > that allocates and transmits MRP test frames at maximum rate, exhaustin=
g
> > all system memory and causing a kernel panic via OOM deadlock.
> >
> > The same zero-interval issue applies to br_mrp_start_in_test_parse()
> > for interconnect test frames.
> >
> > Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
> > IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
> > IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
> > netlink attribute parsing layer before the value ever reaches the
> > workqueue scheduling code. This is consistent with how other bridge
> > subsystems (br_fdb, br_mst) enforce range constraints on netlink
> > attributes.
> >
> > Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
> > Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for con=
figuring MRP interconnect")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >   net/bridge/br_mrp_netlink.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> > index ce6f63c77cc0..86f0e75d6e34 100644
> > --- a/net/bridge/br_mrp_netlink.c
> > +++ b/net/bridge/br_mrp_netlink.c
> > @@ -196,7 +196,7 @@ static const struct nla_policy
> >   br_mrp_start_test_policy[IFLA_BRIDGE_MRP_START_TEST_MAX + 1] =3D {
> >       [IFLA_BRIDGE_MRP_START_TEST_UNSPEC]     =3D { .type =3D NLA_REJEC=
T },
> >       [IFLA_BRIDGE_MRP_START_TEST_RING_ID]    =3D { .type =3D NLA_U32 }=
,
> > -     [IFLA_BRIDGE_MRP_START_TEST_INTERVAL]   =3D { .type =3D NLA_U32 }=
,
> > +     [IFLA_BRIDGE_MRP_START_TEST_INTERVAL]   =3D NLA_POLICY_MIN(NLA_U3=
2, 1),
> >       [IFLA_BRIDGE_MRP_START_TEST_MAX_MISS]   =3D { .type =3D NLA_U32 }=
,
> >       [IFLA_BRIDGE_MRP_START_TEST_PERIOD]     =3D { .type =3D NLA_U32 }=
,
> >       [IFLA_BRIDGE_MRP_START_TEST_MONITOR]    =3D { .type =3D NLA_U32 }=
,
> > @@ -316,7 +316,7 @@ static const struct nla_policy
> >   br_mrp_start_in_test_policy[IFLA_BRIDGE_MRP_START_IN_TEST_MAX + 1] =
=3D {
> >       [IFLA_BRIDGE_MRP_START_IN_TEST_UNSPEC]  =3D { .type =3D NLA_REJEC=
T },
> >       [IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]   =3D { .type =3D NLA_U32 }=
,
> > -     [IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]        =3D { .type =3D N=
LA_U32 },
> > +     [IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]        =3D NLA_POLICY_MI=
N(NLA_U32, 1),
> >       [IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS]        =3D { .type =3D N=
LA_U32 },
> >       [IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD]  =3D { .type =3D NLA_U32 }=
,
> >   };
>
> Alright, let's limit them :-)
>
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
>
