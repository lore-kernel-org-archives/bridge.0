Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC327707
	for <bridge@lists.linux.dev>; Sat,  6 Jun 2026 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780783251; cv=pass; b=iXKmn2NWywS0DvOYk9lydgQ6vEptXTuGjGRqBa6LtQw84Rq6jT67HJZDsfCohb1x/nWYxlY+vJlkTL1UZCeDuvlMnYggVoEeAS4yZoj9MNnQJAoxwyY2FbfYp2vfcWuvvU63IbPhyEB/9wzD2v8g0IjNkIPBvp5oULJA5EiSySY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780783251; c=relaxed/simple;
	bh=JklZoVSHSSeMVT5K/IXdnIYd5bJQP32cB2VrlK1mgsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcKpI2/ZHR3uilSQ5SZZ0iXKFIE3std9e9D4niRTQ6NwHnv/t7VAV/DCzUcqZu8FzFG0TUdZv3PAcMzq50gOuxY52uILyZW9KEMPoTdlvdZULF96aT+VX7ug7VDSHDJIwkTm//ohVm00+chHC53QxYkuhlbzzRy6J3t85JD3pLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=bHhG2MCs; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="bHhG2MCs"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8588ec1b44so2202591a12.1
        for <bridge@lists.linux.dev>; Sat, 06 Jun 2026 15:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780783250; cv=none;
        d=google.com; s=arc-20240605;
        b=d+b87xZwq4RguRNZ3uEw5h+BLyuxHv/64U87s8r6C9+/0/dvbNKkv85jHJN0Zo5fCB
         xGfmKFJmrHEoAF41kL744R0Vrm3MIKW4a6tsH1vvwgfMILGUwl36wrWB6wOUKEzTjEfy
         CHDi4WVwiWl2If9TZ9Cl0GRQ97NygKO79xYL4dAAdvAVU3WY51uiTRIW1pEKcCbVBF4n
         ASFP+p7J53P3gb0qGG82hU/2L2Y82e9VQe3uCNF1B66wPnQ0gyvJn7yshHDGr9plEaJL
         7WRAPAALi0Jb5yRQ50JVfZyz6xfNE9NW4jRNWCnOdoRrinzeYiT49YuSMvLhK6R5pqfw
         kuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HBZWdID8otG8mvTK/jX8anFGJZbVGI+h8QUrOAueMus=;
        fh=OrL19lQ7I/DJF1H5rNlQrPmlVroOE437TPtfxbRxzsk=;
        b=IJmEWqy+HBKIKXTyv+C7Rucc2+XA8V/ccXIIoqXV8fjelPscDDTDpttcjsf984tI4C
         OIGeALypJWj5ZcCbzoCLNKBm/8M+M9dmFMEa8aMW7eFX9vwiDuOPgZjj6ORKgI5XSY6L
         yIwOqVSEGluNja7SjbRq9IIcu6qi0fWlPu+KYZSzdrOPTPbIjkjThkq5tcI8Nklyxc/h
         Fi2e/aSKCCAWC5CodO1XnyVKmfIbtL8d4hLqCXJq9v3ZzVAv4OUs/MVuKzRx3+dmlLkW
         PbmbKFAsVO+2y3QZQRVSBbqqzvwbvhHDCQmlB1LxPTj2JZbASyLJvcGqLY4X0kpcYTGV
         7+8w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780783250; x=1781388050; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBZWdID8otG8mvTK/jX8anFGJZbVGI+h8QUrOAueMus=;
        b=bHhG2MCshWwYNepGe7wG+fIzNhPlyTbqnCRfwbq4tS/cEukhCYZag5HZh7QGlLMzUJ
         /zglgtaFM1pZUXXdRfUryz1EkQjcGIo6huQHG4AIeAoiuz/B//ItYxf7lZjhePBXdo0d
         2wx7STUMsxGk7uvxcwMSWAeHIDGGiOWDSIAUEsK/qZB1aiU8yI0Xv9qyehuvUJ7bl9Zl
         l/8+U9wXLwuqfvW5QbIYZL1K2Z+szM/rD9I7zboSr3i1xPW+DevnXUk/ypqPLGybMVYT
         eutP5en/i2Mmty9BIfNL7u9suLtgcaKYBWKt/hwKGI/n+wK6ZYjFg2A8imz6WB4rpkr6
         aCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780783250; x=1781388050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HBZWdID8otG8mvTK/jX8anFGJZbVGI+h8QUrOAueMus=;
        b=HORAx5DMQJKI1hqZn+ZkCeC3FwbICYF8zpquWopAwLOpCA5h6w5hygandOIOHFVTw+
         0oKqtusiessR7AoCJ2ZHuv271Ci5+c4o9Pt+BYeo3GWmk/Fhhg1W1CkBYY79H8Hj0uAO
         UWMwEB3xzDXc9myT3O2Tm+zbaWQ58JQZSbAYZSksM+/hjLFLJ6HmOfSxzgZkWoC+Bz0x
         leVXLS0OJ3BJq1PgK/9lQmRMG09UpF/U8eamNxc18CbVhkSfbedd9QO7uKfzAqDds68N
         7RtZRkU18HIo27sOdXFU2CMP8hYhomu2gsCDcJyRyXUyFrxJ0cNG3kacHPS76iwuQsjL
         y5Uw==
X-Forwarded-Encrypted: i=1; AFNElJ/knilU/9reWK8GstLpMQXH422+qSI+Eyj92SXFbmLMrQBz81u7PaYMiJ6Enyp7GDYd8VaVRek=@lists.linux.dev
X-Gm-Message-State: AOJu0YwI9A6kC6BVyCuMQa2at+yRMD4rlbaCeXpiH8s1HfJF5TdHc7mF
	KSpYE08Uj2GzM6JoW3+vtjzOpba9sDONlPJn4NE64rmGzvLNPtY7xCD1sQdS+FVZCYdCXPr2Oo8
	YyXjp+G1s0759VnhORaSPbhInp9Oww75GfWOgx/Hk
X-Gm-Gg: Acq92OHEieYce6vHPglbIhgD0tre9cjimzTNaT7HreAPEg7QNv/S/A4QJI8H5HEH8A8
	5b92FW8Iaqm0wSGyNYcXlyx8iuRFYwAWdqq68EUJjtHUBvhRg7KYmPPO+V09qpCAu2B5LYGRSsP
	k3VJnHsNs96WVcaflJxC324/cXnIL2Tq36SdGaP4R5y9KuzBCGJL0zIkFalM5hndK1L3T28/Wv/
	yV/lvu3ewhycZIpEQWI3MhAH9Wt71mRuEiHyxG7PWLMDRqlp3ynH39oUTc7GCw8zcJENMZACAhS
	LYgV/wsvut1w3itxkGI/YqDI51rL2n3sDA1FICJ0RSO6bNVxZA==
X-Received: by 2002:aa7:88cb:0:b0:842:68d3:e29d with SMTP id
 d2e1a72fcca58-842b0e7d233mr9029036b3a.36.1780783249552; Sat, 06 Jun 2026
 15:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260405000324.548623-1-xmei5@asu.edu> <20260407070716.GA752875@shredder>
In-Reply-To: <20260407070716.GA752875@shredder>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 6 Jun 2026 15:00:38 -0700
X-Gm-Features: AVVi8Cf7lOaRxhyC9Nd1mAHqEQjUOB9sRQGvd0iUnAgNqhuZ5cGPZR2gKctHC9s
Message-ID: <CAPpSM+Tuf5tLGabgjXg3=1sFOAg3ioFPMGeSeoufCPhrLH6tfw@mail.gmail.com>
Subject: Re: [PATCH net v2] bridge: cfm: reject invalid CCM interval at
 configuration time
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, bridge@lists.linux.dev, 
	razor@blackwall.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback, and sorry for the delayed v3. It was sent.

Best,
Xiang

On Tue, Apr 7, 2026 at 12:07=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Sat, Apr 04, 2026 at 05:03:24PM -0700, Xiang Mei wrote:
> > ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> > the configured exp_interval converted by interval_to_us(). When
> > exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> > interval_to_us() returns 0, causing the worker to fire immediately in
> > a tight loop that allocates skbs until OOM.
> >
> > Fix this by validating exp_interval at configuration time:
> >
> >  - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to [1, 7] in the
> >    netlink policy so userspace cannot set an invalid value.
> >
> >  - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
> >    not yet been configured (defaults to 0 from kzalloc).
> >
> > Fixes: a806ad8ee2aa ("bridge: cfm: Kernel space implementation of CFM. =
CCM frame TX added.")
>
> Nit: Doesn't matter in practice, but let's blame commit 2be665c3940d
> ("bridge: cfm: Netlink SET configuration Interface.") instead as I don't
> think this bug could be triggered before exposing the netlink API.
>
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v2: Move validation out of the datapath and into configuration
> >
> >  net/bridge/br_cfm.c         | 6 ++++++
> >  net/bridge/br_cfm_netlink.c | 2 +-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> > index 118c7ea48c35..dea56fffa1c1 100644
> > --- a/net/bridge/br_cfm.c
> > +++ b/net/bridge/br_cfm.c
> > @@ -805,6 +805,12 @@ int br_cfm_cc_ccm_tx(struct net_bridge *br, const =
u32 instance,
> >               goto save;
> >       }
> >
> > +     if (!interval_to_us(mep->cc_config.exp_interval)) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Invalid CCM interval");
> > +             return -EINVAL;
> > +     }
> > +
> >       /* Start delayed work to transmit CCM frames. It is done with zer=
o delay
> >        * to send first frame immediately
> >        */
> > diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
> > index 2faab44652e7..1bb33c8f587b 100644
> > --- a/net/bridge/br_cfm_netlink.c
> > +++ b/net/bridge/br_cfm_netlink.c
> > @@ -34,7 +34,7 @@ br_cfm_cc_config_policy[IFLA_BRIDGE_CFM_CC_CONFIG_MAX=
 + 1] =3D {
> >       [IFLA_BRIDGE_CFM_CC_CONFIG_UNSPEC]       =3D { .type =3D NLA_REJE=
CT },
> >       [IFLA_BRIDGE_CFM_CC_CONFIG_INSTANCE]     =3D { .type =3D NLA_U32 =
},
> >       [IFLA_BRIDGE_CFM_CC_CONFIG_ENABLE]       =3D { .type =3D NLA_U32 =
},
> > -     [IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] =3D { .type =3D NLA_U32 =
},
> > +     [IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] =3D NLA_POLICY_RANGE(NLA=
_U32, 1, 7),
>
> Use BR_CFM_CCM_INTERVAL_3_3_MS and BR_CFM_CCM_INTERVAL_10_MIN instead of
> the magic numbers?
>
> The Sashiko review points out that blocking BR_CFM_CCM_INTERVAL_NONE
> might break user space, but it seems weird to allow passing a value that
> is interpreted the same as an invalid one. Worst case, if someone
> complains, we can revert and go back to v1.
>
> >       [IFLA_BRIDGE_CFM_CC_CONFIG_EXP_MAID]     =3D {
> >       .type =3D NLA_BINARY, .len =3D CFM_MAID_LENGTH },
> >  };
> > --
> > 2.43.0
> >
