Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F681EEF9
	for <bridge@lists.linux.dev>; Tue, 24 Sep 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185594; cv=none; b=ryZznSxUJJq0EbhdTavQRbvDVBtyOHsvz5RIBO4++9efWKsFHO5cK4VmBi6HJvAFtaE/swjl81/x2Tcin9nIoSqkxoy9zW+RHHnoYkaEI9do3NN5jNHK1IoWA2GCnY7IUuyg3dZB5q0Lf+vJX1XD6x4ivcsRLVVSSmtOABSTXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185594; c=relaxed/simple;
	bh=QVtL+3KVFqPq/oSf1Yw5Zipj+SQqfOMkPscBopyOfok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6J6TrwKOklseap0jVLw7UB96sgs9Z9p9OwF767Omet3XBewMwGnILwRQY/YDMbJk2k52l5P7D+DsnkcvCvJ+X5Za+bG/2VMT4Kfv+UYVyjZUdshOYbVLLAzlDmxunM8y1WKaI6H6UpBSJyaI6ZwPYRvxGYENCzFy1M65eqgKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ViG42jWc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ViG42jWc"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c718af3354so704428a12.0
        for <bridge@lists.linux.dev>; Tue, 24 Sep 2024 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727185591; x=1727790391; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS+n6lf0ewZ4C9NqB0m2FPDZKb3ZOgpjWOZUUqgRpHA=;
        b=ViG42jWcMjs9/Wb7PhvnAO39RcVuwINbn6KOV+KCif/+Qd86dveTdxwq8BBlxSOBSp
         6gi3xAdht9IpRYGEWS67BNF5n0qhmuTnbokMC/ZB3Qab20I3VLOJpOw7lv7UWQzYRpLO
         exUg1hEKxk6/19zTS0cWSV8uJOe75U+cdxdIgH48ub2vPOUfoWWt3w/hVd0yjsnQsFix
         RpciOhuKjlZHxzGZOGs6pGTUud4XBXzYG6OJ0RBtanKk4UihCIcj8TtNY1bPxT5ohkaH
         e0PyIsVoxR8wWuABzyG8LjIWtDw0+T69KwKh3pfq2TjApztCzTSz1yQunuaAHzekaprr
         rirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727185591; x=1727790391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS+n6lf0ewZ4C9NqB0m2FPDZKb3ZOgpjWOZUUqgRpHA=;
        b=YjqsEJSXrLbvGJyL10ekfMP8QjsmlUuYQrU6sSMfzW+BP7AECKIVC7q9sR7GVb1aUR
         ReXXmCzlTd4qTeIEt43ESGtGeWJ2HpGGbysy4sPd4peaF5w4WL1ri4sfM5ZgBdxOPS4A
         y6oRzYozwJ0ebleFwZcEsySV5ZICQiwOcZqv89DMTixEOWjckTHFoxpUeNLqmU8A7G3U
         Me7IYdgrT7es6uAgjU3q0oh+bKTt7n2iQSRq/YmdM514XcbKDxKePUQflFifHcUid3JW
         xBxpq1BTSxfS0LmtEb4RHnzQtYUitl4Dcx3VZK7Pamgw5cUnC6tqEXPkZkjHCh3j4vSX
         X57w==
X-Forwarded-Encrypted: i=1; AJvYcCXk2Pp8rtTIljsvxAq6uHEPJL/uPvEUBZCJYNpr1OKrNl2g56sZUTrZ/Jc1DuamXH253sekXAY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwUXBB23jgRG7+/vZpNBsDTHohOL3JEJ2fKw2zS6Ld/fnhVhysX
	gZqxQNpQa6zRsHaD0isb50cwgn9G1MsFDMx05oQc3x27i8pmkNAX9YOvmVLsWC8zbvS++WDOL6I
	+9sFwxQgEyryef24KnMH5BCV4M4jLlH2IxH1k
X-Google-Smtp-Source: AGHT+IFfDvU0QoxZl9U8yx2iVrPx9Ckr9pP18sGwnClBif5QuPOwDAhR+U/DPatMes1QIHSjN3FU6qPJ59E6u4F8PNU=
X-Received: by 2002:a17:906:dc8d:b0:a86:ac05:2112 with SMTP id
 a640c23a62f3a-a90d50e1eeemr1406536066b.51.1727185590419; Tue, 24 Sep 2024
 06:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <14BD7E92B23BF276+20240924090906.157995-1-yushengjin@uniontech.com>
 <20240924063258.1edfb590@fedora>
In-Reply-To: <20240924063258.1edfb590@fedora>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Sep 2024 15:46:17 +0200
Message-ID: <CANn89iLoBYjMmot=6e_WJrtEhcAzWikU2eV0eQExHPj7+ObGKA@mail.gmail.com>
Subject: Re: [PATCH v3] net/bridge: Optimizing read-write locks in ebtables.c
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: yushengjin <yushengjin@uniontech.com>, pablo@netfilter.org, kadlec@netfilter.org, 
	roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 3:33=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 24 Sep 2024 17:09:06 +0800
> yushengjin <yushengjin@uniontech.com> wrote:
>
> > When conducting WRK testing, the CPU usage rate of the testing machine =
was
> > 100%. forwarding through a bridge, if the network load is too high, it =
may
> > cause abnormal load on the ebt_do_table of the kernel ebtable module, l=
eading
> > to excessive soft interrupts and sometimes even directly causing CPU so=
ft
> > deadlocks.
> >
> > After analysis, it was found that the code of ebtables had not been opt=
imized
> > for a long time, and the read-write locks inside still existed. However=
, other
> > arp/ip/ip6 tables had already been optimized a lot, and performance bot=
tlenecks
> > in read-write locks had been discovered a long time ago.
> >
> > Ref link: https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehalam/
> >
> > So I referred to arp/ip/ip6 modification methods to optimize the read-w=
rite
> > lock in ebtables.c.
>
> What about doing RCU instead, faster and safer.

Safer ? How so ?

Stephen, we have used this stuff already in other netfilter components
since 2011

No performance issue at all.

Honestly, this old link (
https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehalam/ ) is
quite confusing,
please yushengjin do not include it next time, or we will get outdated feed=
back.

Instead, point to the real useful commit :

commit 7f5c6d4f665bb57a19a34ce1fb16cc708c04f219
    netfilter: get rid of atomic ops in fast path

This is the useful commit, because this ebtable patch simply adopts
the solution already used in iptables.

And please compile your patch, and boot it, test it before sending it again=
.
