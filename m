Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED6C3DA5CF
	for <bridge@lists.linux.dev>; Tue, 30 Jun 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849804; cv=pass; b=n2voar3ci0XITrXEWXWvY5CnhVleoO19RTkoz0eU390xla3SjGFgXYLmKQo+bMAClOKrEb8kQYg31wZDiseLsmx6iTHrUdfSxPmjlB74P74xQRG3I0VMTAZqhdHFXKw+yl9SvBRaHL3pL/stE7M8LTwidMbiynsV52/mZDHVpiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849804; c=relaxed/simple;
	bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1UmARmu0wMMu79I+jeQNkF9OOarQscmdDVXOU+d2b3xrStUKivXpd3BNaSppnBRIMfqxK6mMQ8xc04TUYLF0Ridz5+4iQreUle4kyESnuMfelF/mlBGXKoYAtfYohqyEI2VJaSXDai7NpxFpvuf3fbOsSr3h8E4W91paMk3/dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW4SfAcS; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW4SfAcS"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1276f8414bso293472066b.0
        for <bridge@lists.linux.dev>; Tue, 30 Jun 2026 13:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782849802; cv=none;
        d=google.com; s=arc-20260327;
        b=IXPh+0TC47VXQ7i+GIoAv0G5VVxo2JvQOfU04aNZtXdJ2fkt12UczFKXC18bEetoxi
         0HoX1S+2yVPQscJdP1t17F+6ZKfzhM82NHiJ0vVC+oa2xHbhhYq4PfIm/Qb96mqu+QlT
         vRh4tx+kjl8YG1JDuLTQTMqVkmYavCt86G9dmyadLXIX97AVfr4FKSFk7tbAOf5wbTY5
         cJKeWgvTM5QXLGv+WOVxKofLingoPrSGiqPnINsbyLp3DGRKELazOeoguHkAJkQbe5jK
         cqj8itbgcJcYFr8cKRxxs1y9WrXykTScqXojHEn9UYxDz1kR6u2IPY4ounv8U8KKMTnX
         WXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
        fh=KQRfaJSiD+Zm02uqOWs4KkKde1duD+82wXl77/D8R/Y=;
        b=BJqyi3SxJcv5Ixbr/jlDmm6eY1ynhN8/8SrfjpDqy5qjO0TJLdZl18TMFZ6mUsIR3N
         zKTHiXa4ZzTzIN6IP8pMZSJzlnjeEJcQxkyd9CY5oj1cr8az1mc8Hk3VaKl6UInGD7f+
         GsyELk/ztcd6rl2fKHGURC1EUURGECQldKH3upHf95VuOWzxJyoVOZOH1LFpRYtzcIFd
         9/nrbau1lZ31fHiWbqrMfWM2b8IsVZfMrYR67lZ2TCJ5fk31janjdKPhtXeMForuI+n8
         T4uXwlaM13IdRW1/6LqWDLOobmvKHDhbjpIr7w+Q9bMffYn0/nRT2wb2Ww4aUvlUNn/X
         Q+JA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782849802; x=1783454602; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
        b=GW4SfAcS1q3CXOGAuVcwV0dOgRcOrd543aagkUzSFItROGx08TSWKZes+hpOrhvlSV
         7tbmREWq79kMLoJvMmPuj5NhLkneqGozodLkJeHl+35+erZSmxstMtCVaCmf/kNSX3ZN
         o+rszQj2qkBlZqBuD96Aw0iTm0UudFiamuvUMNShlaJPYR4xviKRM1/aykoXsXY84rmD
         s//9EXb9ptRXTJwaRDyitHXpZCRRwh9YptZMELgQ9gw2J7jnP3qaph1B9rA4ZOKJ3+RQ
         uW0Gc3KHEsOO9zC5xwav+hhGUB9+reTmRNjSKVA1LVJiQetzgxuOY+bnMOSwSoKTzrCJ
         1Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849802; x=1783454602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
        b=bRLiTuk2QvUF9xFhBjg4ysziR46lrjqAoK1SHjRItXSA7xaO/BnguUNDHinGw7m+dp
         90Z7fyHgfHxgy9jcPqSVvcPxbWyhO536x3pPjttdTSo2DSxylJ2e7wBEdoYo+yeHV+8O
         faFdl6wXXAlgEILK52b8A7XA2QpZiLWRmn/00Wxgaa+kGPM8E3LrtQaY8alj6wC4XW9N
         srxkXN9LP5QM8RIVXKbDkMAnamt7FC4LaSMxaAK8dhK2lMbLxQw62HvJQ5gtPM1FTQlf
         458LW56+096l3baTEuyq8uWAOCf7UsZvTujevzpbDNXQRWwLc6Z+CVySk3BYX+GRb5G3
         Hb5A==
X-Forwarded-Encrypted: i=1; AHgh+RoiwUkmEgfe5z/bhzdhPtmDspnVClykKOpJjHSMdpCaeJHyK863V3d2O1pBqWf8NqynJwLcNuo=@lists.linux.dev
X-Gm-Message-State: AOJu0YyjaKew8D5OX9EMIdF06zSJmmnuUV1vohLWIn7io0GbP1QToQPC
	8Lx0sXF97zh3GGeXRzG4jV3QSqunptg9jgkrAu+lwVV4e/GuRQNQWih1ui0pRgbzVJAhBohjvLM
	2ZptBH/MLnljOclZtWUtQspqq04Smf7g=
X-Gm-Gg: AfdE7cnCazO9jXX6ObWzQb22YnS7yJES//nXAP6j+cg2kG3buAdbmBoqK/VuVxlb+MY
	neH0hjfL7DCd1cVELwAja3FIg2RQkAjANWLnEeqhqTWmeKjFijkrVlne6PPLaof4yDc4J+s7feb
	CDk3JV2W5V2qJGoE/dcL+dmFOIuyPTs8Z/JgZfmlovpPwCCvo5wI+UJjKy0qud1aTmhPHnVaDMr
	fUw6q5QlqUCNXp9tv1rglAwjFYS57Rax1naR8XPXlzftepVWUzhWadD5uQ+x1Lxt55uxKc=
X-Received: by 2002:a17:907:720f:b0:c12:3219:ba1e with SMTP id
 a640c23a62f3a-c1297f04180mr105626766b.42.1782849801564; Tue, 30 Jun 2026
 13:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
 <20260625054005.0016.bridge-mcast@kernel.org> <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
In-Reply-To: <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
From: Ujjal Roy <royujjal@gmail.com>
Date: Wed, 1 Jul 2026 01:33:07 +0530
X-Gm-Features: AVVi8CfDECdiCgzhQlx3_wZFTGHCy6ydmcO-9SWK6-jb6Fc7WwdQO42bD5DVouM
Message-ID: <CAE2MWkkON7HuB+Szc1VhaPL8ZTYMAyfzmPM_7FkXvOPnjnF5rQ@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
To: Sasha Levin <sashal@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org, 
	Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, Kernel <netdev@vger.kernel.org>, 
	Kernel <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 8:20=E2=80=AFPM Ujjal Roy <royujjal@gmail.com> wrot=
e:
>
> On Thu, Jun 25, 2026 at 4:12=E2=80=AFPM Sasha Levin <sashal@kernel.org> w=
rote:
> >
> > > Please backport the 5-patch bridge multicast exponential field
> > > encoding series (726fa7da2d8c, 12cfb4ecc471, 95bfd196f0dc,
> > > e51560f4220a, 529dbe762de0) to the stable kernels.
> >
> > I tried, but it doesn't apply to 7.1. Could you provide a backport plea=
se?
> >
> > --
> > Thanks,
> > Sasha
>
> I will create patches on top of 7.1. But tell me what about all other
> stable releases? I have to create patches to all stables and how to
> share the patches to you? Via this email or any other process? I am a
> fresh on backporting my changes to all stables.

I have prepared the patches for stable releases mentioned in kernel.org.

And I am waiting for your response so that I can send you the patchset.
