Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2EC3DD861
	for <bridge@lists.linux.dev>; Thu,  9 Jul 2026 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600754; cv=pass; b=o0ToRoCK0//DJXwB0cN9rUFlJJSoKZ8S/rf4kH3SirGw3Y7jL8YanlrtWOFtxlTKsZZPkT04TbECx0YcAkcThERNQSiQYeWnyA75cU87wgC8aCeHkADXHxL/uThJW8PNNBxsMA9EVQo7tesFeguFGHq/SWQ+yQrFwNgtQVRvwQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600754; c=relaxed/simple;
	bh=Xl9PbSXbschCuJYzks46Urc8XGsA9GGrNgmJ8oWnohY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMIsa13tes3dUIl2LdBk4eAptjsOkhwHUvtiOm9F4+LlSdopNxWYsEAeUvPuS2ryXAgCf9oivVnlf7yamYibD6NJenFLFURzSZv74XUWm2hd95k14hsXszcRyOx0p59RiVfbjoFoos0JkvTn7Gp9lN65A3uW1IAleJ3LngGvhhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoD24x7q; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoD24x7q"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15ee037bc0so70523366b.3
        for <bridge@lists.linux.dev>; Thu, 09 Jul 2026 05:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783600751; cv=none;
        d=google.com; s=arc-20260327;
        b=qvZQQimGHd93Uankl6CwihDMob07Ll3ArqExAE0lCST6JfGbf2p8uI9e9G9hNh/HhB
         G8pfRKOluLYFXYnBGND7CeFdhLlkV7Tf02maCDRjlV0yybxAvk4QbfJobMhl1nqkfi3C
         UPIyaroAt0y39FkWoVl5fdAb4D1CUx8+HClyCnke1/gKqRd1KUq6jWOVBmr154LXQJJX
         tCWEY9clUOQOMtoGuTQ/3zfbeDKNa/yCbde+5VdxaFopqyNIGmmgZ99b+s12j+d2/AhL
         qofchOEuZ0AJGz8EgqJ21h5bH5A0UFtfndMqk/UrpVrRINgD/1AJeNRikXkjig94Cgj1
         YlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xl9PbSXbschCuJYzks46Urc8XGsA9GGrNgmJ8oWnohY=;
        fh=yLe2SKI3sIjDv0sV5gsbp9TAuKT0rxaAApDThAmcKoU=;
        b=loGznlPb0zp/5YcwhsRPIzVyQLD1CD+7dedpYt0QXR6mSdqS7A1a/TUsg8PvdSWZAK
         ol6U91WnEuz/00KwaSZyRKCggDhkvu3wys0AzoynPuaSUJdlubFJ3R4mlphJ7fzKdy3s
         FIUaxGwHexzmkry+e1ahEaotIlF595C1uhO3eq0faBQYh/BoEySqxuBXxqF/I+Wi/zj9
         pXozzCjMZ+IbtHXrGlzSlf5/PWsxIxJkgEkA+d8PnxXPM6TLjuGhuJjQJ+CeQgOvoOYH
         xcezMt/1QH4zlVgsHilIbfKaGPx8khfmwocoCZaAhz0bAm5PxFjE15PHnHCFGWaSy/PJ
         bjJg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783600751; x=1784205551; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xl9PbSXbschCuJYzks46Urc8XGsA9GGrNgmJ8oWnohY=;
        b=aoD24x7qiY4Y2j/pf3XJrhyTSOihSJfKQ3RkmMKuDB0QuBAEUvP0GTcFjreVM89Y1o
         r2LNSXwiKWKKYNTnF6+gvTL4LUJYz+6QurppAhR86M80QPe5rpEWtuwn56ismg/bMBZg
         5vEeQpbT5YOY1IEJPL4KhTKnwEmiYEQeRX5wwC76R95Hrgghn4lrz7bk8u99GROUdPN2
         Gf/jA253B8PMBsns3JvrbLaz/iBp6Lz0XhkBLfa05eCfC0p16HHhErJdjK2xzrTdUscI
         kHHH4y5UR4xOEz6mKDegUfaTW3kxLkhTEKk8XwD+9t0K8cMpP+c1iXQiBvaAzgq32sz/
         06Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600751; x=1784205551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xl9PbSXbschCuJYzks46Urc8XGsA9GGrNgmJ8oWnohY=;
        b=ckBmOSqDVVMqFwVwC41eXwFieBqGvOrL1PVCE/djRSwmCO8KByOaEAGE2fq3KT1Trk
         D81btE9Nl8O+gfuml8DshATTaiYW3PH2gSlJGmfCUXgx8Y3v117PjUftCD3bAOqKN36S
         MMgZDkrxPj7jrhYmwHzhaXp0NHckq8puLWZaWJ8YBx7Mca11aIZiVJAKpcd3aCa7/rBJ
         TcphH3ExiionHi/DxeNlh6ibAMpgxj0P2lGiTuKnoC5g6sbFDHaKjnr0WY7gNmSgv547
         /fjG2eRs2oVRS/qR4ZR/PsO6b0Et8cmLgyCPpQWWChaULdz5c16A87LHEPwEtinMSMr/
         M7ww==
X-Forwarded-Encrypted: i=1; AHgh+RpeXcM9pHQBd+cTCUWI/+sCTyEnhHftvwtdHH9W9kjNLPPLdL4PAMvOcR57rEXkbFkHcg8nTdk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyabdOEOn8jCRHE+wrxqCp/h+umHc59uqPLIJ6gP5pjqF9Bv3M1
	+ebgnRB1gESNgsZHtEtBBt+mwN5He92sL67OykBwVpVzTJIbqGn1HnZAkoUwOSikrLEzHAl/kdH
	ooaHem1O9Vb3V3AL19FNkOSN1v1O/6jw=
X-Gm-Gg: AfdE7ckfmGRg3FhBJCkOxbUDqPWGmxSEHr6drOWhjgU2HpJNDGFVr2R/os4jSjQyW6s
	XKmMx3DXyl5QvqIwSkkSQFgXvHfyiQr8SQRDju34TE942azXQUYrH9ppMcPhfBIGQB+BNwhVkyy
	4wtFMpQEjRrvuaYZTrknDFfPMTwTbetT3r5bY9bZxXCXDMDQzIH+YEKLVwD6OY/ZTpd17pr3z9G
	Nv2ThzG4qkm68RG5y8JXV8KOsJw3PtgxeQl2bDTffuGCO8v1KxsOqJc89rv/p6pNQYZnbM=
X-Received: by 2002:a17:907:e153:b0:c12:6ed1:a7bc with SMTP id
 a640c23a62f3a-c15cdfe9b54mr217106766b.7.1783600750745; Thu, 09 Jul 2026
 05:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
 <20260625054005.0016.bridge-mcast@kernel.org> <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
 <CAE2MWkkON7HuB+Szc1VhaPL8ZTYMAyfzmPM_7FkXvOPnjnF5rQ@mail.gmail.com> <2026063019-crummy-mosaic-d9bb@gregkh>
In-Reply-To: <2026063019-crummy-mosaic-d9bb@gregkh>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 18:08:58 +0530
X-Gm-Features: AVVi8CeeSy9sOe-nDvJ2FgnZIaGmm16MJR8SeE21mrKCu6quf0TcNIj4Rs8oCSQ
Message-ID: <CAE2MWk=SXVZRmOnnWs0AYWLWqLipo0PTND9UCQw6noDBoJ5CdA@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
To: Greg KH <greg@kroah.com>
Cc: Sasha Levin <sashal@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org, 
	Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, Kernel <netdev@vger.kernel.org>, 
	Kernel <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 2:00=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> On Wed, Jul 01, 2026 at 01:33:07AM +0530, Ujjal Roy wrote:
> > On Thu, Jun 25, 2026 at 8:20=E2=80=AFPM Ujjal Roy <royujjal@gmail.com> =
wrote:
> > >
> > > On Thu, Jun 25, 2026 at 4:12=E2=80=AFPM Sasha Levin <sashal@kernel.or=
g> wrote:
> > > >
> > > > > Please backport the 5-patch bridge multicast exponential field
> > > > > encoding series (726fa7da2d8c, 12cfb4ecc471, 95bfd196f0dc,
> > > > > e51560f4220a, 529dbe762de0) to the stable kernels.
> > > >
> > > > I tried, but it doesn't apply to 7.1. Could you provide a backport =
please?
> > > >
> > > > --
> > > > Thanks,
> > > > Sasha
> > >
> > > I will create patches on top of 7.1. But tell me what about all other
> > > stable releases? I have to create patches to all stables and how to
> > > share the patches to you? Via this email or any other process? I am a
> > > fresh on backporting my changes to all stables.
> >
> > I have prepared the patches for stable releases mentioned in kernel.org=
.
> >
> > And I am waiting for your response so that I can send you the patchset.
>
> Please just send the patches :)

I just sent another email with the subject "Please backport bridge
multicast exponential field encoding fix series to
6.1.y/6.6.y/6.12.y/6.18.y/7.0.y", please accept that for direct
cherry-picking. Infact 5.15.y also cherry-picked cleanly, except for
the selftest commit which is not needed here, will send another email
regarding this.

I will send a separate patchset after resolving conflicts on 5.10.y and 7.1=
.y
