Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FBC3655C9
	for <bridge@lists.linux.dev>; Thu,  9 Jul 2026 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610524; cv=pass; b=pGg5UO31FoH0p3lnxwBp/bM9KAbXMPlXiDwOESvGFrG35Bdi9x79N1UeyYwsTntm8aMy5ql3c0t+H1Tgoh45nhahsaVRFAlLz9zucZ79ZnJ5J++JCXwUyeeBavq32jNHJ2qTmAsmwC1kpFB0GSlk/tgSXmmrirtFHoHxTuoha7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610524; c=relaxed/simple;
	bh=iDolcu2mWBl3uEuQAfKWNLBAt748fEeXf9V7/Qg2coE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRninMvQW3a1bVQsKUh/dAisPh+KkcdSN235W0IKriWXvaGGE0qxHBXya8dp3+3s+6wNpIwZ561y/Uwiat5gU24KKQraMKp4fxdO+qv9Xqz7OsBpy+CBcTydscYeQdSFivmKl7/fz+5lTVzr+yN+JqK2j3OPwNv+vMJR7CF1iAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGF+try1; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGF+try1"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso1747402a12.0
        for <bridge@lists.linux.dev>; Thu, 09 Jul 2026 08:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783610521; cv=none;
        d=google.com; s=arc-20260327;
        b=TEdVjYhfDGfC2wKmbGELymSz+0wt40h6/z1+iMptePXiKBCIQUd9GjmGNdwjDTMiec
         TKjCLOVhV7nXSMTr5u+9tKbOtaufe9DTrgYb2Zg25vy34Uso/BXH6vdnEa1gzhIK8pfP
         qQs1j8ovV9lmPgfCOm3GMt061EntVYM9BD4JxtDis/20ohAbstaXBqewLkjiORriJlQ9
         BDp/52x37m622swgJhnKfmPfLVOl5RFyGlKxRXHBi46ObIaM6RzQ+1QyguOUFFPkgXbV
         /+Oowg6vz4ZYSiHpMw30GCadhVCi6thUerFZ1nO39ZwertTGyphLraY1Yf3zdO/TX44L
         J9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hl6Al4OsGwcvHqvs4fyMXGCvJt1Svt3mIHpxW1j8jYM=;
        fh=KZU7Bh/JVH60aQ2/8+lgjKFIsqbLTnmwtF+Dg7W3voo=;
        b=Hf7bExxDLU/H/ChL474D3b8URivmiXq3hRbt9bhB+MugDJUXyKkcIDQkQCO5UVY4Fv
         FsqrtrYP16KnJ6aTmXey7eXCSi1K0q+WkXuGlTuobAVkfOmwTzlSE7HYViOMPgEdJ2k+
         CCnl1QguzRE7EyTcrUrK4BuixjoM3cnWXyuXjikLVEmR6jvok4Skk+SkF9pJMvLkbsIy
         RrdUtxnvCqOAWX92qr4KV8net7y6ZecCXGgs82KRb+onmLPGscSVTDaYAskMdIK3cCjf
         kYDJVTR5RilgNU4r+RNoM8B5tS98C4g5FdGMpOa4tKZbV87Tdw1M9vskDgyXmdluM/rU
         PBYg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783610521; x=1784215321; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hl6Al4OsGwcvHqvs4fyMXGCvJt1Svt3mIHpxW1j8jYM=;
        b=MGF+try1X8vRSZXqNi2EwOXCSsVwE+Pt5rdeSBsUAMDb/m1x5vVLqeaTwHZJm+Zf6y
         7LEnollnwvraGSMYw1v6HfKyYJ2ZEB7c8LjyxHdDsdSaPmybtmKSuQ6hAEY7BQKhKd0r
         SGzAM+txMfcFLEetLscHN1hVsIW46wOcDRuVW1lzc1a/MTaMuJFriqqjTjsLCQCvFASc
         anumnw6qLVzRIghEOoy9XYMbsLUcHsDYUfyqyZJdJAKYX6Hs8UZ97B3fBUHUXrOWuOIY
         i/XrbB2Bk5jaP0Gdv88JklllARz/FPR4AcbsHiCZNDSiaDM4/ppgY+VyrdeOrRRrym0h
         QOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610521; x=1784215321;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hl6Al4OsGwcvHqvs4fyMXGCvJt1Svt3mIHpxW1j8jYM=;
        b=nmeunqEzGAREaJEs+j793mrvIDIlRW+ig5KZ/W4CJqCG77KAdkyDXCJy4dLdPa7WJV
         jOY3bcxzagkRx2FZRprJ+8Tqodzpj3OZS4n6dVV5+IQsP6pLl3Flae1porUr4qhPU79f
         MLkJQ+v+506f/H+Ry0AjK3+Ek6Cy22qMfRW/jbfb3ZfryFWzk2n2b9CpO+z4oXvGHA5S
         pSYJC/LjD3z9OPj/DQuxqt4rScgxCs3qdL5yt9mOtrS0Jp1n6DnPcu1nBZOIJH11yBzs
         aL9u9p5D+/HP15b9diG2sifCEgngc7qRoJ/wdfySmLSQw/p35WfDbaBQ+NY1fAWSFQaT
         +/eQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmItINUOnqF2RrKKy/sKjfke5Jd/Fj3PepGO8Vvm5jhEACt07JJ7tWPk0OPpgrVEkE8g46UCA=@lists.linux.dev
X-Gm-Message-State: AOJu0YwaRGNSArVsyhqGWa62Aj9T6oB70KSRLRAGpKuDAh8Zh42cdZHr
	6eoddH3RlXiDWwviuVSkIN0DxlwVc0k3RLSTyv+hFsEmqogakJilYe/eRs5tOzPeB4LD17pvuew
	TxhUlq9vWz42cisfo7jo9zS//CTr9EQM=
X-Gm-Gg: AfdE7ckZhdgrF/0ve3szdxsNaZi0R1s6DunIYGA+mXPQYi0hBrkQvYuZLkt8Ay2KnKB
	u5dwlcgRbbeIcisgHEhIujS7l4W3uuqyRkMwedtAV3L/0FqseRh8/mrPeVnBk07XLUVTfzAZ9iE
	jLEybvGp53tmic9VVLov2Yew0wLPqV/BdZ9Cml0dqeUFBSP+xinqXTvECXYav9s0tWXILoLWyr1
	Plwo4DjnIoAK9sWRZJxY56SemoN9QEQ4+5ni4KsUW7MwWabKLq4St5nciaZi3AmUVyTmRk=
X-Received: by 2002:a17:907:c50e:b0:c12:6280:33c9 with SMTP id
 a640c23a62f3a-c15e780ee92mr173767266b.28.1783610520581; Thu, 09 Jul 2026
 08:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh> <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh> <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
In-Reply-To: <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 20:51:46 +0530
X-Gm-Features: AVVi8CdJgqKVLA2sAn6f7XPums4J2L125q9McUSFj0u2k_NGu-cn3IODEhE9pa8
Message-ID: <CAE2MWk=xfQ1SpkHnVL0Tsru4e=_8xi2XvESs4Lh+=g4cbFEuuA@mail.gmail.com>
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

On Thu, Jul 9, 2026 at 8:43=E2=80=AFPM Ujjal Roy <royujjal@gmail.com> wrote=
:
>
> On Thu, Jul 9, 2026 at 7:52=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
> >
> > On Thu, Jul 09, 2026 at 06:35:04PM +0530, Ujjal Roy wrote:
> > > On Thu, Jul 9, 2026 at 6:23=E2=80=AFPM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > > >
> > > > On Thu, Jul 09, 2026 at 06:12:40PM +0530, Ujjal Roy wrote:
> > > > > On Thu, Jul 9, 2026 at 4:34=E2=80=AFPM Greg KH <gregkh@linuxfound=
ation.org> wrote:
> > > > > >
> > > > > > On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > Please consider backporting the following bridge multicast fi=
x series to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> > > > > > >
> > > > > > > 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and s=
implify calculation")
> > > > > > > 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qq=
i()")
> > > > > > > 95bfd196f0dc ("ipv4: igmp: encode multicast exponential field=
s")
> > > > > > > e51560f4220a ("ipv6: mld: encode multicast exponential fields=
")
> > > > > > > 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field=
 encoding tests")
> > > > > >
> > > > > > Why is any of this needed in older kernels?
> > > > > >
> > > > > > And 7.0.y is long end-of-life.
> > > > > >
> > > > > > And why, if this does fix issues, was it not tagged for stable =
to start
> > > > > > with?
> > > > > >
> > > > > > thanks,
> > > > > >
> > > > > > greg k-h
> > > > >
> > > > > I already explained this in the email thread, "Please backport br=
idge
> > > > > multicast exponential field encoding fix series to stable kernels=
".
> > > >
> > > > Sorry, but that's not here (remember, some of us get 1000+ emails a
> > > > day.)
> > > >
> > > > Please explain why patches need to be backported when asking for th=
em to
> > > > be backported.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > Sorry for breaking the thread. I understand your point, I will
> > > maintain this in the future.
> > > How should I send the patchset that addresses the conflicts on 5.10.y
> > > and 7.1.y? Shall I send the conflicts patchset as a series via a
> > > different thread or how? I've never done this before, so I'm asking.
> > >
> > > Here is the explanation for why the patches need to be backported:
> > >
> > > History: The multicast stack currently supports decoding of IGMPv3 an=
d
> > > MLDv2 exponential timer field encodings, but lacks the corresponding
> > > encoding logic when generating multicast query packets. As a result,
> > > query intervals and response codes exceeding the linear encoding rang=
e
> > > can be transmitted incorrectly. This can cause multicast queriers and
> > > listeners to interpret different timing values, resulting in protocol
> > > interoperability issues, membership timeouts, and premature multicast
> > > group expiration.
> > >
> > > Testing: The series adds the missing encoding support for both IGMPv3
> > > and MLDv2 and includes selftests that validate the behavior.
> > > I backported the series to v6.6.123.2 and verified the accompanying
> > > selftests. The selftests fail on the unpatched kernel and pass after
> > > applying the series, demonstrating both the bug and the effectiveness
> > > of the fix.
> > >
> > > Given that this is a protocol correctness issue affecting multicast
> > > query generation, please consider backporting the complete series to
> > > all applicable stable kernels.
> > >
> >
> > But this really seems like a new feature being added, it's not fixing a
> > regression of something that previously worked, right?
> >
> > WHy can't people just update to the latest kernel release to get this i=
f
> > they need it for their environments?
> >
> > thanks,
> >
> > greg k-h
>
> This is a corner case when people set the query timer value higher
> than 128. People usually use the default value and don't change it, so
> they may not encounter this issue. But I found it when I changed the
> value during some extensive validation of protocol timeouts.
>
> If one host doesn't have this fix, clients will observe premature
> multicast group expiration. For example, a set-top box channel might
> disconnect early.
>
> But we can ignore this until few more people request this fix for older k=
ernels.

Last two patches actually fix the timeout issue. Below one fixes QQIC
encoding BUG for IPv4.

95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
@@ -780,11 +780,9 @@ static struct sk_buff
*br_ip4_multicast_alloc_query(struct net_bridge *br,
        case 3:
                ihv3 =3D igmpv3_query_hdr(skb);
                ihv3->type =3D IGMP_HOST_MEMBERSHIP_QUERY;
-               ihv3->code =3D (group ? br->multicast_last_member_interval =
:
-                                     br->multicast_query_response_interval=
) /
-                            (HZ / IGMP_TIMER_SCALE);
+               ihv3->code =3D igmpv3_mrc(mrt / (HZ / IGMP_TIMER_SCALE));
                ihv3->group =3D group;
-               ihv3->qqic =3D br->multicast_query_interval / HZ;
+               ihv3->qqic =3D igmpv3_qqic(br->multicast_query_interval
/ HZ);  // This was not encoding earlier
