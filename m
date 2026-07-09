Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C97379C52
	for <bridge@lists.linux.dev>; Thu,  9 Jul 2026 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610033; cv=pass; b=R9I9GhNwtHsjbT8mAHF0xpX6GctsPyp1s0QHxr3j//A1UsYqdoq2/ExiqoEBGJkm8fnl22JxprqR/GpwPnydpDJYWBk58FC91aIjY9Di/XsFp7ZUQaBRYumkHc21Mt27iQ/xFqOD4m364JtXeuo+42L+eZVsbOreXESPO1Sus4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610033; c=relaxed/simple;
	bh=lm+iwZuldvNfgm8Lzbku/fwQXnHvxwIB+0za3JCHtHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dt0vpwVjQUBijgtE/TUQoXMUE+BLSaztMDYZmWIoiDNRo1vab61YwDuXyCOVkb/8RrxfMUCDv7zd0+M7WuT2pJLOMABsLkuI7OWHcO1D+bldSu8qXZpB8SLRde4tJkW2VhEGs/cMGN6zj9hrygr3+eUGC4ynwg+Sw1BKUm1K1h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9n5Mqls; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9n5Mqls"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so3303954a12.1
        for <bridge@lists.linux.dev>; Thu, 09 Jul 2026 08:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783610030; cv=none;
        d=google.com; s=arc-20260327;
        b=lcswhx7g6gCFE2Py9LsCSnY7AA9ayF8feJkLv8bvtdYu5qcyW/42sVRjGhHRYUj8e8
         WHtwHTWqhr0iH1DN4DM7lqmdKp3ew996nOfsrBaqqQ41tXBOd+zUftJTGzr1xtzMznVV
         tzipQBZ3Q6qQU+9oCJKqc9VgK5omGbsOpyHnKDOd884Kv91Nss4PNNG2mz51wiUww8e1
         j46LFbfPlYtJG0Bb0FSuv1xEYlkywtOOWAIRz+ez6u4l/sIfaNtNzK2YA3cpHy0gNoGT
         GKQRqX7fOKfSAeIpUxSgXdW2UpcH+hdpP0sVoVMKqTlwBswPNranstx9/tOP0DivZo/e
         cKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lm+iwZuldvNfgm8Lzbku/fwQXnHvxwIB+0za3JCHtHk=;
        fh=L3Le/64AweoEFLfTi097mHUOLzhP27kgLh05tP7RUHw=;
        b=JybJ/NeB6MGTNBnfCN18fRWn3OvFpnINpX680L3DXuZXDEgs47FSkeAR7SVglwtqep
         cB07KMtFo9alDs8CMcUkXqmV/HBLi7TMBUpAz6LYXfIrHQzFZHPn8nCn4pKpGQc/41DR
         DUNhsou9pLMswrVKCC4ILAv2l65CQRWur3txJIYB72+Osd1K+OVnrb+q9m9uDcqF6+w8
         Txt3t7ucb+IwWMkiFxnvtQbZwoF4FzD/Q3kAmGP2GLsfZfBUIGMe9J4s8FXdTZ1K+3jF
         bt2DOP60R/nXkcdG7tbHEuVMpb4iLX9ZMSK50kljgnqZwH3wCZteHj85U0NVFciLE3CA
         j4YA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783610030; x=1784214830; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lm+iwZuldvNfgm8Lzbku/fwQXnHvxwIB+0za3JCHtHk=;
        b=m9n5MqlsxgITbTiIxgHGX2vWQr6ITKLcIEbn7vFFVVZXzvhl5/cbEdUtMDsfSUNF9H
         FQ54zwsBX1K6+SbX5N+QcLgfDcSxEZZF9WrPZPXzaM2jlIwmfQ7+6sTYVDc95xbbAhHq
         HfEgNrMKQGJuDrPS3pKJ28YL/GZrnkUzHZZhXByTTm6ohbfsVncsVbw3LaItQ2aZ1r9y
         SSMGnSkhm/g+fIY2Gzv6XvjPdBqm2w6vrtKPOmp60KCUBPC0p7S7NVz1O8hX/kbNvEu6
         XYCAKc+OendEAcWSq8njY4AcE3/v+J4McFsUbGt34N5bdCJdRLPgHX56kNZxAkA6PyKM
         fawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610030; x=1784214830;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lm+iwZuldvNfgm8Lzbku/fwQXnHvxwIB+0za3JCHtHk=;
        b=UACgluT2soZgoDi++psAsw/y8OA76B+ExkUfj1GpcjNiDB/LqgEgk7v+F+KkkiS09F
         1iqLKwY+5500D8qsUIi3bWJlWnY3WG6xnBSxZT+82GjJoEuQkjJC1LAspeljpz3ToepT
         XttsoeG2Kr3K6J0b2QsxMXEGAlOHXqUwLPyENjt1rBQNIoNeyi2MNH/emfA9RW9nKB3b
         w8uEU7h0zMX7Rt49xVUL45aj3GEIFUZgQ5cjFVDUsVlWIB7cR/wXcRE6RJwk+v14CQDr
         aKGQZrncKhr1cExEdviCf5GoSGKXiob9r6SpnNUr9F4Vf9YmG/hvYySTELGQu4gv87Ve
         Yqsg==
X-Forwarded-Encrypted: i=1; AHgh+RoQqPlrE+/TCDuETQp9mX0g+AP9KyzbSP2iUfWEaK9ZEVcJxA1MZKKSK7CNV6ajEcUzXNW9a08=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzu5Jw5odG4/7871S/jcvdx5Kljnihppjcttp3JV1KF0BFC3Y5H
	rwcUr80sOv8eK45Y/368MPow5y/ALT+RXMxiBslS64mvJItcWrQnILoUcpaRiDv4AcpumeTrINe
	qKf3ZGXD7qSaUeVI0SosDja3J0wkCDVo=
X-Gm-Gg: AfdE7cl5AyMI/rjUhaSWwyNcgHy3m0qCifK39vKMGCARzx/DeXGKjSmDJdwpnG4rmcF
	//8/YHBhN0eEkQuXBWBx24hTnQn0aRAF8lR5Xpr8536+8V+QALu05xtHP0tu3zk98hcPfSFhs9H
	xTL8xt4FtzTlqs2+moT2vdbOO6FDTGXFqOF8ag/ythL2GoZugt4Vl511AHynkzcgBaY5Ita8a0p
	GuXwqDA8C7Tm9KeW0Ygywevni38Y+FXC3lPxNu9Ly681XXyo+iKGRZ1YtML0z1NxJzFhuM=
X-Received: by 2002:a17:907:1b1c:b0:bed:19af:f89a with SMTP id
 a640c23a62f3a-c15cde8c84dmr329373166b.7.1783610029787; Thu, 09 Jul 2026
 08:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh> <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh>
In-Reply-To: <2026070948-lively-exchange-a458@gregkh>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 20:43:37 +0530
X-Gm-Features: AVVi8CfKbtzcJnRxXIx3ULOTra4r8qYMzKp7zTKSzETyFRYKJOujtPr221wvxYo
Message-ID: <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Stable <stable@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 7:52=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Jul 09, 2026 at 06:35:04PM +0530, Ujjal Roy wrote:
> > On Thu, Jul 9, 2026 at 6:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Thu, Jul 09, 2026 at 06:12:40PM +0530, Ujjal Roy wrote:
> > > > On Thu, Jul 9, 2026 at 4:34=E2=80=AFPM Greg KH <gregkh@linuxfoundat=
ion.org> wrote:
> > > > >
> > > > > On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> > > > > > Hi Greg,
> > > > > >
> > > > > > Please consider backporting the following bridge multicast fix =
series to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> > > > > >
> > > > > > 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and sim=
plify calculation")
> > > > > > 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi(=
)")
> > > > > > 95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields"=
)
> > > > > > e51560f4220a ("ipv6: mld: encode multicast exponential fields")
> > > > > > 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field e=
ncoding tests")
> > > > >
> > > > > Why is any of this needed in older kernels?
> > > > >
> > > > > And 7.0.y is long end-of-life.
> > > > >
> > > > > And why, if this does fix issues, was it not tagged for stable to=
 start
> > > > > with?
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > I already explained this in the email thread, "Please backport brid=
ge
> > > > multicast exponential field encoding fix series to stable kernels".
> > >
> > > Sorry, but that's not here (remember, some of us get 1000+ emails a
> > > day.)
> > >
> > > Please explain why patches need to be backported when asking for them=
 to
> > > be backported.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Sorry for breaking the thread. I understand your point, I will
> > maintain this in the future.
> > How should I send the patchset that addresses the conflicts on 5.10.y
> > and 7.1.y? Shall I send the conflicts patchset as a series via a
> > different thread or how? I've never done this before, so I'm asking.
> >
> > Here is the explanation for why the patches need to be backported:
> >
> > History: The multicast stack currently supports decoding of IGMPv3 and
> > MLDv2 exponential timer field encodings, but lacks the corresponding
> > encoding logic when generating multicast query packets. As a result,
> > query intervals and response codes exceeding the linear encoding range
> > can be transmitted incorrectly. This can cause multicast queriers and
> > listeners to interpret different timing values, resulting in protocol
> > interoperability issues, membership timeouts, and premature multicast
> > group expiration.
> >
> > Testing: The series adds the missing encoding support for both IGMPv3
> > and MLDv2 and includes selftests that validate the behavior.
> > I backported the series to v6.6.123.2 and verified the accompanying
> > selftests. The selftests fail on the unpatched kernel and pass after
> > applying the series, demonstrating both the bug and the effectiveness
> > of the fix.
> >
> > Given that this is a protocol correctness issue affecting multicast
> > query generation, please consider backporting the complete series to
> > all applicable stable kernels.
> >
>
> But this really seems like a new feature being added, it's not fixing a
> regression of something that previously worked, right?
>
> WHy can't people just update to the latest kernel release to get this if
> they need it for their environments?
>
> thanks,
>
> greg k-h

This is a corner case when people set the query timer value higher
than 128. People usually use the default value and don't change it, so
they may not encounter this issue. But I found it when I changed the
value during some extensive validation of protocol timeouts.

If one host doesn't have this fix, clients will observe premature
multicast group expiration. For example, a set-top box channel might
disconnect early.

But we can ignore this until few more people request this fix for older ker=
nels.
