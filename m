Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9138C411
	for <bridge@lists.linux.dev>; Tue,  7 Apr 2026 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544817; cv=pass; b=gecCldfrpikYS1mU7ICeJgGpRNzDy8bo3JIXajEnQc49LKezslJQpFRnFAlt4XlEz4wgPkompACRtk9qYvLL0Dxw3pxkasw2OsJDicTbXFcpL6j9BLLPIWe+q+Ri3DJizhk8l4gjPWerDza1BTSPXb68y+CZnTnlas1ZoRUoOnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544817; c=relaxed/simple;
	bh=FWpfwl5EpG+FUBdNljoQk7IzodPiLTITpijDs9wnTzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McdPivGc17fwS0Q6gMG91zrUq3WPK/fdsGb47ps7sHvoxMmsS/XwqIja4rTHYXmUiMIXMLc62S4ueDFzTOfdw4bVYRr6NgMWE6iMtWuo8dX8lmMW2E9Gui/WaeTD7jBNE9Zmcs1f5OT/qorMgu48rsEJLJTF1+1loLJW00C86L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS3I0zax; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS3I0zax"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8f97c626aaso781758166b.2
        for <bridge@lists.linux.dev>; Mon, 06 Apr 2026 23:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775544814; cv=none;
        d=google.com; s=arc-20240605;
        b=lBnRp95vk0kLeJcQDd1LjaPifeskwSAMvLS68qAWkAVs3x5py6SONiWn+9r1CLWvlH
         RRMuajobdA3iZbM6UgAxMUNBztGCqU6eea7sEF4zNP+IECuTrYYdcpohxjR0jj2NP3hU
         9pO1GfMvocqS+/nxG2AFBTfFnXeB7AqlRiokGP01r+j/vzP7JwZs4DT6KOFFirQNnhaA
         AJYl+ntP0XfK2saawTACup9RDiuggfO++yG4zODcItRdMVWyrbUuQ0mVEReYQ1ALEr2N
         oJENK7hRzNJJDKTG8Y/VZwTVTwNUVjWbkbtmkHD2aeCDUZJcnAq419rCFL/jiwux9VwM
         a+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3QGGQAplBq02BHVXyopNXftOCfxeBQ27SGZLzvlb5js=;
        fh=WwDSwZGBIbFx4YI0UlmzGNoXmVMS89R3oEfqbe+LjFs=;
        b=gcw3FZ+ICXMRDAeVPblA71oQdT3bZjIZkE62RUC4VAYiFDVIzuQmkbdJUMGCsA28w4
         CgEdXAdSKB8Z1qewJR8G2vHsiEWispOLeWM57TWK4vgu5xLAhGq5vBochga8uEypsq8q
         fUH/9ELkf98My7fns58hDkVnGFgfeTyxY6VmxCEutLMADGDoYOpyCc6AQX0xYcYdXoST
         ioGimvytjmzpHgo8KuDb91DLbSXGdUZmQ5uLH+4SNWpIV1PY/GUGGcy8SkPmsNt41xQI
         XhcJ8qehiviWJ5mJ4tZy3Nil9RiWcVFtNACYliHz6Mg1gKjEePq8itFIuCGMEIqUUivB
         S+xg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775544814; x=1776149614; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QGGQAplBq02BHVXyopNXftOCfxeBQ27SGZLzvlb5js=;
        b=bS3I0zaxMMo3g2tlkn/nTQec1QHS3NiDHx7Gw/fthWOH6LhKSOrzmKorDzlRX4VUAG
         3I1Y3UNoWvIGkPeYpKGTuD8XCv8OFJm3UqTkrm6gO7Bo/HTBjxah62Rvor0vk3Hzh664
         SPXH8BGh7ETqhG9Jlm5ZF2tRuCnS6GPQkVgfDMUSM6h9kg1z/SOmvpwC3HchigKjS9M/
         l92YebS+RzBg25Kis6dNn1xMwNLjTbzJ4MF2OdVPT2ZhteioS9mErt1DGdUeMgT8u2OL
         0IUgTZ+DNDrruXFUfm3T9z/JDVFSNiL6h9wV7/dUV+kLhAQ9oy9y6JsgwUDzp7M3Rfjb
         Gn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775544814; x=1776149614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3QGGQAplBq02BHVXyopNXftOCfxeBQ27SGZLzvlb5js=;
        b=jBqkzaSQKZr52FbofCmRzeww+ySUDMc/cfJo/pb7H64b1bckdHae2EdZG2IJYWapvI
         bGRpYvjdz1e7jwqQZetL7078+ZouuAg+9+nGsf2X5b+Mb3x6Bwn1dRvPW7RqEtGFfQmD
         4GNJuX7JEFQrxQG4b3rEYf/2HoPmMMc4RvCA0BJklQJjBZfej76+2vPSCDP0jwfyGJuw
         VWe+IahrnPYLZbbmldLemGRyNZyONFNqXicxp/XlrNwCrxOGG4AUvxf+Xt5IBfCx0Uc3
         5k17Sdzi2KZXMB1gfeUidkDEa7fhUPRsCjGwWjFOUYOyW5fdztL2htnVTRwU4AQ+t6ah
         lwgg==
X-Forwarded-Encrypted: i=1; AJvYcCX3ZJ/fQ8CiYT+MePGwFR3wfsSmu1ePIYdKa/uxoHKxMWzFLZ/A0/35+fJxu/XD4cQ45TgApy0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzjvhNsLxUm9y0ABz0WNpKMjY56aRCfq4b5uF2kP39NTWmJI99Z
	dg5PpiKpheoWtnFJfl4AGfcif72vYFkeU4AnO1t5kHJaM6h12CfOvOZ/+16xowUwJ0XKNxtN5ko
	wQe64HahGahFb/Pj5g5OS/sBFhwcRnnk=
X-Gm-Gg: AeBDievIiNHGs3FqmNq8eQXSdIzN0lbciNa4JwktiDprr/XxpVyiRQ4zjHBeOXbwGrG
	HMmi58/5dmb4bkqXPwOOow3tocxxk0zpZYR4pqiUWnpj5VptHk45xIKJnxHCFtDZ6lT6HyineZu
	INWwrAt7ii5sszOhDwPt/o3AVVCBQ6Mw0xgwjHvGA+xmpVIAEqEiKh/fO5lQkyfmstGloPl2DVd
	3An+sL6B3YjQL/Fy4/obdPsA2O49PHSQ9wkI3M2G5r48N5Wyu+rGOlhz+7MzS3BBfB30G0n3tcT
	RhpLTX6xpZo/J2oOCA==
X-Received: by 2002:a17:906:f581:b0:b9b:1b9e:1e99 with SMTP id
 a640c23a62f3a-b9c679580b6mr816033466b.34.1775544813579; Mon, 06 Apr 2026
 23:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260403150050.1235-1-royujjal@gmail.com> <20260403150050.1235-6-royujjal@gmail.com>
 <20260406182504.52a03794@kernel.org>
In-Reply-To: <20260406182504.52a03794@kernel.org>
From: Ujjal Roy <royujjal@gmail.com>
Date: Tue, 7 Apr 2026 12:23:20 +0530
X-Gm-Features: AQROBzDobic8jv_imKaJPmW4xt1c4Ipd4HaOp8P0tUSTUyRBdcWdqg-PViFb7qc
Message-ID: <CAE2MWknnJHgdxrC8mVPsCxe91WfA4aS6JZEGvhG4u3Mmq0D3EA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] selftests: net: bridge: add tests for MRC
 and QQIC validation
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 6:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri,  3 Apr 2026 15:00:50 +0000 Ujjal Roy wrote:
> > --- a/tools/testing/selftests/net/forwarding/.gitignore
> > +++ b/tools/testing/selftests/net/forwarding/.gitignore
> > @@ -1,3 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  forwarding.config
> >  ipmr
> > +mc_encode
> > +mc_decode
>
> please keep this file sorted

I will keep all the codes under a single file and keep them sorted.

>
> > diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/te=
sting/selftests/net/forwarding/Makefile
> > index bbaf4d937dd8..a26da846632d 100644
> > --- a/tools/testing/selftests/net/forwarding/Makefile
> > +++ b/tools/testing/selftests/net/forwarding/Makefile
> > @@ -1,5 +1,15 @@
> >  # SPDX-License-Identifier: GPL-2.0+ OR MIT
> >
> > +top_srcdir =3D ../../../../..
> > +
> > +CFLAGS +=3D -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/includ=
e $(KHDR_INCLUDES)
> > +CFLAGS +=3D -I$(top_srcdir)/tools/include
>
> Could you please keep the format more aligned with the ksft
> net/Makefile? Also is the -I$(top_srcdir)/tools/include
> still necessary? KHDR_INCLUDES don't include $src/usr/include ??
>
> > +TEST_GEN_FILES :=3D \
> > +     mc_encode \
> > +     mc_decode \
> > +# end of TEST_GEN_FILES
>
> Also needs to be sorted
> --
> pw-bot: cr

I need bitops.h for fls() API, so I can see KHDR_INCLUDES is not
needed but tools/include is needed. I don't see lib.mk is including
the tools/include.

@Nikolay Aleksandrov  Please review the updated test cases in this patch.
