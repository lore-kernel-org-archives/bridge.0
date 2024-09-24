Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4C1AC440
	for <bridge@lists.linux.dev>; Tue, 24 Sep 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196059; cv=none; b=iT7NWENg6peFQyQffzs87RoU7yklF8bUldbOWuZYnSdVlWCO1dlrqc83BIfLPkuJtGekBISBOBMWyNgCBtX8cj2gGORHr0wOc0ZUGQFA/p3FeaecLOtCD2O5//FQaEDWaUDLb2HT7tJlHxNuYEOT/kGMeRcD5SiCoGy3nktYbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196059; c=relaxed/simple;
	bh=3gD3nb59lyZxLhkoxFeWjQ+vTGoqQ+1LYG2lqO2CahI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QH2ObV0L0+JUqx1bY+izoiy5ccekCUSxGbBb/GxoOSG2+WbyHWCj2CeHIxMF4GiH5RTrRUl7cw3JpcjOlEt8+Hv/cNSDkyGN6m0omOcB4gwwsqE5u59tJHR0AoINV3zb+C9WLB8j2fZZp0d1rD/f7DcD3syvVN1ZxnzI3NF8RQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=L6CLmlf6; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="L6CLmlf6"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c548eb3380so26601106d6.1
        for <bridge@lists.linux.dev>; Tue, 24 Sep 2024 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1727196056; x=1727800856; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gD3nb59lyZxLhkoxFeWjQ+vTGoqQ+1LYG2lqO2CahI=;
        b=L6CLmlf6Wk1Za96G49gAjKfMJ9V5mchMUAy8l+XLzunUoOgB2AEJsjplBPrGopbF5f
         Sj6tnMgBuxJY42LEP4sLbIR776c3UCgxPpN8rJqioxlqWEyS2jaHuxTU4ARUj5+pthOR
         vYR7xnqBrE2aUC161a/FiXtxck8hYJe2exFICsVrbYUh6AsGxubm5qyFGZsVtPhSA5Jn
         yHfNsi0nDwyKAFuyrT4ySq/k1b+FVW06yZ7r1DxOn/BFluSp4CpH5ahyEMweuS87ADdL
         4c3ywqycdI24ICm3EbBOtKowimhMbUxHHjWMZ6Cd7R72hcLU2w5XOOZqQ1b7JPcuP+RB
         eFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727196056; x=1727800856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gD3nb59lyZxLhkoxFeWjQ+vTGoqQ+1LYG2lqO2CahI=;
        b=bPbssbFIXBU29zmWmacfyZxxbZpKfXkIR0ROUJCiDN4wPLib+YZJIlJwyOAxF0Hnd7
         Cwl86+VzJXV9NyhiD3vQRf3OIB2o4oqXwB2xKjW52Q2EpAcWn2Y1xldRsn2ol/1IVX1z
         Sjwnn1TyS6TuvGeLf7mBASkXk0bOl31DH9LqTJ5ZIybUTF76hWwFmalST9OGS48iSo1x
         3Uqz8hD72SkTubVjJ3xv2qDEG8YubK7MOjvDXKWhG7eQoUXuPta1sN740FTtDvk0g22P
         iujVX9qvi5BYUac7DTmEqF2JyzeQTA/yHQNMa5gBan7qIS+MfiQFNK5Fk0AAWjFjsOhx
         QuSw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9phbO4QEgmBcyHu+Pl5x1FMBT7HErsjg6qRJAw13JjHhkRx23OijECeQC1bp6pPWWJMI5fs=@lists.linux.dev
X-Gm-Message-State: AOJu0YxeQQ6VP1zrQMtspdZe5YQZL70CQiWn7QRKbGpEFxxuG0thOkwf
	/BHyxwixV/rVnndiEczAYmhuf1whPY8LMh0+pPiACcx2+SDboSb/ZX6uGxqf688=
X-Google-Smtp-Source: AGHT+IFJYP6BgUnqYcjH73JqqWOcD4NygI7jzlTvs/gJ9sdNCwq5nEPMFeOsYKZfYRmb1d8iynkHDw==
X-Received: by 2002:a05:6214:5546:b0:6c5:72c0:728b with SMTP id 6a1803df08f44-6c7bd506250mr193680686d6.24.1727196056022;
        Tue, 24 Sep 2024 09:40:56 -0700 (PDT)
Received: from fedora ([173.242.185.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4c2f51sm8013886d6.31.2024.09.24.09.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 09:40:55 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:40:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eric Dumazet <edumazet@google.com>
Cc: yushengjin <yushengjin@uniontech.com>, pablo@netfilter.org,
 kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net/bridge: Optimizing read-write locks in
 ebtables.c
Message-ID: <20240924094054.2d005c76@fedora>
In-Reply-To: <CANn89iLoBYjMmot=6e_WJrtEhcAzWikU2eV0eQExHPj7+ObGKA@mail.gmail.com>
References: <14BD7E92B23BF276+20240924090906.157995-1-yushengjin@uniontech.com>
	<20240924063258.1edfb590@fedora>
	<CANn89iLoBYjMmot=6e_WJrtEhcAzWikU2eV0eQExHPj7+ObGKA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Sep 2024 15:46:17 +0200
Eric Dumazet <edumazet@google.com> wrote:

> On Tue, Sep 24, 2024 at 3:33=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Tue, 24 Sep 2024 17:09:06 +0800
> > yushengjin <yushengjin@uniontech.com> wrote:
> > =20
> > > When conducting WRK testing, the CPU usage rate of the testing machin=
e was
> > > 100%. forwarding through a bridge, if the network load is too high, i=
t may
> > > cause abnormal load on the ebt_do_table of the kernel ebtable module,=
 leading
> > > to excessive soft interrupts and sometimes even directly causing CPU =
soft
> > > deadlocks.
> > >
> > > After analysis, it was found that the code of ebtables had not been o=
ptimized
> > > for a long time, and the read-write locks inside still existed. Howev=
er, other
> > > arp/ip/ip6 tables had already been optimized a lot, and performance b=
ottlenecks
> > > in read-write locks had been discovered a long time ago.
> > >
> > > Ref link: https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehala=
m/
> > >
> > > So I referred to arp/ip/ip6 modification methods to optimize the read=
-write
> > > lock in ebtables.c. =20
> >
> > What about doing RCU instead, faster and safer. =20
>=20
> Safer ? How so ?
>=20
> Stephen, we have used this stuff already in other netfilter components
> since 2011
>=20
> No performance issue at all.
>=20

I was thinking that lockdep and analysis tools do better job looking at RCU.
Most likely, the number of users of ebtables was small enough that nobody l=
ooked
hard at it until now.


