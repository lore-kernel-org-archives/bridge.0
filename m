Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90D1E9B3A
	for <bridge@lists.linux.dev>; Thu,  9 Jul 2026 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602320; cv=pass; b=PM6lQHlktQJFagARRolvyal/MdyXTbfYHthN6QtZ1B7kPNNLYnrzjrzIooRxUtVNGQy2noYMQDekpjPL4dTttAWO0mK7U2eTDoc5SudXnUPNMK3SwnAB1blS+ffHLfyo/0M2NQ8ffZE1mTVaHGPKEtxhm73feZvBIZv+9vk0D78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602320; c=relaxed/simple;
	bh=w2zFUzgmtAuk8hs2S7KZhdwkyppPnKoB5X6Mdgo9p/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvbDI8aSKyR7rehoGopsAFB3/Mgdg0XIjqh5+ixHOcd7O/3Z7qFkblWXhwKOoumjgEL4DkLxY7BXVDj2b7n/WCVTF0E4UdgsiWZ5si4/CZ0ocUoKyE/D1YAJo12m4iBRdEkqh2JV0V21Z4VumPPbAZbg1blMCjek5DsPsPI/fk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvaMf+2j; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvaMf+2j"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c029505b389so146486866b.1
        for <bridge@lists.linux.dev>; Thu, 09 Jul 2026 06:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783602317; cv=none;
        d=google.com; s=arc-20260327;
        b=DIzHdqD1SsvrIawtmWd9k7vShBGxMnHkYxuVf1yk+XQUh4f/4ScpSb4T/RVorNGJ57
         B6JQ/c6Dom+OjtOY0G/8iS3fX3zPDBjOnNU3H9SJRQ3BcCB+6ZntqbWkIdSh8/246s6c
         yUaUnmQFn+QhVCgWpYVP1ZC/Jpb6AqIGiyQivX+DMhf03daxZ42ENzrrb7tV2bIPm0G/
         JfEHQK7TUtTMMwij5aetGKpM/97GMLBugcbNP12P4ETlvrOG9JNAIz+qtZCcTPJ7pqpd
         QZsjRMVusan04Lb8Fa2Jcb5vxhGsGPQGPWBy5JZn/jBT3GxL6wonC/PPH4lBjIvsQ6Hu
         gJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w2zFUzgmtAuk8hs2S7KZhdwkyppPnKoB5X6Mdgo9p/8=;
        fh=a7Z2UbyRSN0+Gc4TgjzTG9QJXamzNo8XpyFn5O8O7Nk=;
        b=d6G4jOODDWEFMFHgt/0ZI7jBWitz2SLKxoJuJUS7DlMElbxmh3kru0E48SbU5WB4Od
         ulA6quVWT4Ci2XSpErRQ9NSx4kqqhboLSEGyTLoyVsO+bnzGzQDUxQxeFCeMLt6pCPYV
         mhEU/D+gJ5bhBrA7u0JdoX/7z85R+1ilcyDoihmPVQGVUXGp5uT5Czrs2L9rVQCieV78
         v0R5+u+dw7KnaBEohe9xFl/fU70Fn5qO9IO7GTcpmCeoJZ2EAgKREcTVZckTpjkiJKVv
         uJgiYF6jqDW+eDjWIsRpZqSEk2kaJAt08QrNy/QIaF0166qXWdAZ2h4Ja9JECXb6R3wD
         /Dag==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783602317; x=1784207117; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w2zFUzgmtAuk8hs2S7KZhdwkyppPnKoB5X6Mdgo9p/8=;
        b=lvaMf+2jeyQTc0MP9KTE9glKjDeNDbrXOO2PEcxQsDOzDlwZODiYsYWitTDavM6oCf
         brk2pZUwDaCg817EotpO9x2cN9DeV+XMoAEBMIjl/eIfql6ABDFACIk1SYzg9uQzEMn9
         3+iHZx3oqlutUtCxWNCExb4rNe2eKXTU6CqmfsbeGy3ObGyIi2zZwhdZt1OSdhUb3RR9
         t+JViYKoDd2bxB8d7w146bkVm0CUDBEiRlPFLRsylUrSzfgt7hbqICiV490nQRmj76vG
         Up6ODqbCfYXhlMNKEvl6SXh1ExrKtAAsbQhkEBGixj93ewJ6OYJVBcg+sodtkUhyo4+T
         9sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602317; x=1784207117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w2zFUzgmtAuk8hs2S7KZhdwkyppPnKoB5X6Mdgo9p/8=;
        b=ETEQivOQrE1xX9KJHFZkja0lhK3pJ1KBjYA9Meu+fbfBDjWiT6tqYopxEqWoRVRblj
         IjUgciBjzUepf17khLxLseudyTc2ILp5et6fjxK+kCm7Hsr0ATsd4LtYLjpnxuLBsMSG
         bushwR+Vvh/MY6pY0B4WGk0/bkS5nDcHDNSET9R3eAzsGxxcWBWrG/BCfdf8F7GPAuO4
         XYZSwKHtegfurEFw4qfNsqRc+KZj/n/jh5LBbF50icvNsGrxqgUt/f/25O9S3/QcIrSu
         /5ODCg81lovtcn0smkT2bvRUDsCduOyYFbk4DlgSwT/HWYwjJGdS0KCBZn9xwsKO8R03
         Swxw==
X-Forwarded-Encrypted: i=1; AHgh+RpNOlB+peOXWVVKT9I7RXYg7NIRE+jPOXXMlR+BTLxMT/boIrSF50Y42rUIPZgFS+Pd2cVficU=@lists.linux.dev
X-Gm-Message-State: AOJu0YznvJd6wQrDTD0xyHJL2td1NTV8IhOZ01iRn0Mw9a5ySlyWCw+8
	vDWPeXY+b4rkFc2K3ey4EfGsPMBEEpKJz+qKt9AFoqTI8/u/CJF1DQ6RsOOCUDpVIQmT7MNNWxE
	gMbRKmnufrarbpwAnL3NbOemxdKzSyQc=
X-Gm-Gg: AfdE7clMLKZ/yGhJl3rZdFXxGngMdl5bem0OyT6XQYHNgFgxVm9z1tiQfgS6+FnEhqP
	5p/z4XZpooTUXMxbLA48DMc/ASP94+vsc91oI4RxGjzsJfVQXsBfIODAUovzcW82KyfG5sFhEi3
	flKCC/u5VcpWgNkc6ZOy3BkbFlvFivjJhhnie+oGYN5vMeEXgkIDGGBGpZPgBZ5E8r1VQIFQ5T0
	QCv0L4t7nNbFOoEkMAPgV6pWfc7wtwM4I23otz8q3xqBBcduvSqEMTh1cPJV6JCMxqG60C62cR4
	st33CA==
X-Received: by 2002:a17:907:268e:b0:c12:4b0f:5d12 with SMTP id
 a640c23a62f3a-c15e77d185cmr145016966b.23.1783602316748; Thu, 09 Jul 2026
 06:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com> <2026070954-activist-left-8303@gregkh>
In-Reply-To: <2026070954-activist-left-8303@gregkh>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 18:35:04 +0530
X-Gm-Features: AVVi8Cf41M_ijpHkKYz8M_XktE0qZUV9t_0z2x75RapbDuAjnTo52sPGA365USE
Message-ID: <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
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

On Thu, Jul 9, 2026 at 6:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Jul 09, 2026 at 06:12:40PM +0530, Ujjal Roy wrote:
> > On Thu, Jul 9, 2026 at 4:34=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> > > > Hi Greg,
> > > >
> > > > Please consider backporting the following bridge multicast fix seri=
es to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> > > >
> > > > 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplif=
y calculation")
> > > > 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
> > > > 95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
> > > > e51560f4220a ("ipv6: mld: encode multicast exponential fields")
> > > > 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encod=
ing tests")
> > >
> > > Why is any of this needed in older kernels?
> > >
> > > And 7.0.y is long end-of-life.
> > >
> > > And why, if this does fix issues, was it not tagged for stable to sta=
rt
> > > with?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > I already explained this in the email thread, "Please backport bridge
> > multicast exponential field encoding fix series to stable kernels".
>
> Sorry, but that's not here (remember, some of us get 1000+ emails a
> day.)
>
> Please explain why patches need to be backported when asking for them to
> be backported.
>
> thanks,
>
> greg k-h

Sorry for breaking the thread. I understand your point, I will
maintain this in the future.
How should I send the patchset that addresses the conflicts on 5.10.y
and 7.1.y? Shall I send the conflicts patchset as a series via a
different thread or how? I've never done this before, so I'm asking.

Here is the explanation for why the patches need to be backported:

History: The multicast stack currently supports decoding of IGMPv3 and
MLDv2 exponential timer field encodings, but lacks the corresponding
encoding logic when generating multicast query packets. As a result,
query intervals and response codes exceeding the linear encoding range
can be transmitted incorrectly. This can cause multicast queriers and
listeners to interpret different timing values, resulting in protocol
interoperability issues, membership timeouts, and premature multicast
group expiration.

Testing: The series adds the missing encoding support for both IGMPv3
and MLDv2 and includes selftests that validate the behavior.
I backported the series to v6.6.123.2 and verified the accompanying
selftests. The selftests fail on the unpatched kernel and pass after
applying the series, demonstrating both the bug and the effectiveness
of the fix.

Given that this is a protocol correctness issue affecting multicast
query generation, please consider backporting the complete series to
all applicable stable kernels.
