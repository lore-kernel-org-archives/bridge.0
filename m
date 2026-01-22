Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1BE36C59D
	for <bridge@lists.linux.dev>; Thu, 22 Jan 2026 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094864; cv=pass; b=raLMhQxRk061K+6niSk/wKDIRRWXotdePienhy65VGvy/tlbCLy+PUNr13FKLCOL8/xRuCtU4Kuq2tF/YvWrBXOR9/H/zffsrBlZzw32dZPxg2vpg9G2BNCwYhmBjnBMH8/cTNOGTegbQrsdsubow1GeaelnSd8Y0se5IongiOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094864; c=relaxed/simple;
	bh=BzjoKlvqt1EzagDyE1uDPXUBk0JHsuSDNte2h/zwXm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzsXsGyNWAdIEoBncPxPMz2u3/dpJQt1DzT3zjLoa/7Z9QQ43uTm8WpjGCSIkKa9x2yUbz3OXX+19PxPy2Fpr6FREDjr7sySMgwy2DCOFh6dBqk/dTycJLh2K/ycabGigZ1bvd9RVQjpQio+ewc67xT8yIfiibyPzU/DcMCJwSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mnft9G2e; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mnft9G2e"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7cfd6f321b5so580269a34.2
        for <bridge@lists.linux.dev>; Thu, 22 Jan 2026 07:14:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769094860; cv=none;
        d=google.com; s=arc-20240605;
        b=ObNYUjg0MLz8XOnTtuDe3yXp3c4pTpCjFnAWNuyIRg+ugMqwi2bAboPjAgq/zoez91
         1vsulgIXoaC+6DhIVS0YThlOX5cHoM0+XPotKrgGPM5kPIyssX4+XuX3SawvzIZGMXNk
         UHUENEfpsX7geZ1NgnOeDmxLnb/qSXCUJdMopiAoePskzuz3r6pEWvnWX4V5y0gOA7+a
         FWfNSt89n72eGN7wuapuNoYK5LilmCBLN0/z8iEH6kY2IcGIN7ufaz2ray+nmXyi/81s
         0JYl51QcYGMOpcO0EI1N1DeiOx3gSpiDvZI3tn51jtjOp6BawIsPXRKYIK3HzyNrAUOV
         ofzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JBOZm8NEn1I7Enhvm7jPT5V5sGA/hVgZBX7ufyhJPsQ=;
        fh=z4EtvKD4nTOjocQTEnb11MkyvGdJwOucpYrEL0e/x9o=;
        b=f1LkV67TPvfcHoiYeV53TNHsup9b51A3sp+3s+rqWuoSOjE28nFIcq345NhkiBqgAc
         Ujr9yxAHUWaxMR6a4dyfoVad54sPTkbuD7eGFCK/FfKe60IbPj5OrBVRThY1n8FJsOLp
         shSZt39d8xGPVTwJZe/ttShnBbWG1LVrZKUTveC63VW0bbNTLo4uJDerNI0bVJDCNbVE
         BSlcFLz2iFRrEvNfAdpdFS5sBye9WQ3DTw+ntWnHcLZ3ry8wcjRQHbGRVwGFejz391vC
         GWJyi1P2oaVl+HwLuRheGOP0FlpK36OEnjV9qCudbN0uAKWBwO3kI5uA1WJZViPAAA8U
         sm9w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769094860; x=1769699660; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBOZm8NEn1I7Enhvm7jPT5V5sGA/hVgZBX7ufyhJPsQ=;
        b=Mnft9G2eAf1eCH8LB74oR24ZVXnNeW8wfr/RBE1MwgFKy64YQmFJtdK99UOgkrt4AI
         NiveJOpo3jdlk03M6zygtINk0USjqQgLX61A7ej9fKujGP0YyTRVdfjUvDuhK0QEV15k
         wteOYooFAqejzURS7c6ADxWMRkHBi0LWpFIejyzEiiVKhYufIoCKrwZVW3zR4z+KDfYZ
         PtI4gMjmZ4oZGqShufHzLIjkFfPtEVadmGeQPQirlXsSyqOLLPFu9RSyNMz7AIdBXFKK
         B7VAHuMOyTHNZ9saOZ/8DDW9QY2xEIuCajKc3C0nIUNj/sNit/UqGe/PsXG9+NiRVaB8
         OBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094860; x=1769699660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JBOZm8NEn1I7Enhvm7jPT5V5sGA/hVgZBX7ufyhJPsQ=;
        b=TozcJIPGeS1nValec7EJOQa6aJ6Ppk7w8540jFv9gjiR2PWxMk2k9JJkmTu8sOSn/b
         ShSgc+1zr3024TbS1X/kgBefAPn5wBxBQb32B+HOQoDFRdDvB+ZgR9sad6Tx9gTpj/it
         bcJKnH6gtxEzV6tsU3bS13SQGWQhLY7huwW11mKFVhaSxof3/L/ifgl43P06/RwarFWO
         wl4dpVSubdKg/2dyxnOhZVH5XSHJ7njNym7INIeZeU2iT6RtTCjdHg3m0D+P0sbjWg0L
         ytxBus5Te1MP1SGwLOqYCKsuuOGP56D5Q6xK9sKWFJgGg82r8w8io6pmDwkcH/EvzR6o
         7VIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqBLxCRhg9kMkP3F+gqJDwDw4kdKM2W81ZamGRfjxx+2F3JvbYcxYXRcl+UPg34FXzzkrWb8o=@lists.linux.dev
X-Gm-Message-State: AOJu0YzQsPr4QBxssIteVVEXh6kmzraO6bIfKO73vNdWR36kWmsm017y
	9DGfhSWel+URG7tPMXIX3/gebZCGdFFRCPvJHo7xvmwUeSYzaO9g+zw6IWeI3el85vbVTh//MlR
	tLxhERWgHmIKT097gLXPXc+g3YMjiXFw=
X-Gm-Gg: AZuq6aJM2XJhsho0q7U0afaxiOCRyw1qf4RIFeTI/TedFD9wANqNQ5S9QwCm3Ho73lS
	c+7svIcGahpEzUbaxDbfD7/eWJxtnqwLveTuo0NHptGxNws9x4lWiwtEBrFb6orpkJTUYnbs1Er
	6MVIhbLP7z44woBC/VJZZO+Py84YJd63ZunxYSf2t0vLUEsMRd8AfCYaj8PnH2VsRuvLIBaWQKe
	Ek1PZQQiN1YdOjnGIHfr6tHM/ZZ3qil5CYcecPD2c7rOp3ouZSMoXimynC94c6zUTlHkoJuTIoh
	6ruCyO8wNslZf9tYcLvK1uHjk5JYeG747eLI+XhmUEoOYvY7MGj91DZJCQ2S
X-Received: by 2002:a4a:ddd1:0:b0:662:bffd:9e35 with SMTP id
 006d021491bc7-662bffda1e2mr1583385eaf.77.1769094859811; Thu, 22 Jan 2026
 07:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260120092137.2161162-1-mmyangfl@gmail.com> <20260120092137.2161162-2-mmyangfl@gmail.com>
 <aXELnMSc4UU6DkbZ@krikkit> <CAAXyoMMAMAbEu=-wTf3MGMiZr2Uq7pqJXC+_zrtxKrsjyYi+AQ@mail.gmail.com>
 <aXIIBbCpuY_ISi-t@krikkit>
In-Reply-To: <aXIIBbCpuY_ISi-t@krikkit>
From: Yangfl <mmyangfl@gmail.com>
Date: Thu, 22 Jan 2026 23:13:43 +0800
X-Gm-Features: AZwV_Qht3cszjBZS3tSwI0aj4ueyYvMDm0wFiSnF3H1eB_3KslEbR7FUK3MfJh4
Message-ID: <CAAXyoMMJsWK8F5neewwZHtEHe0-iT1rbfPekSDXm7HJvG2bOpQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] u64_stats: Introduce u64_stats_copy()
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Carolina Jubran <cjubran@nvidia.com>, Breno Leitao <leitao@debian.org>, 
	Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 7:20=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2026-01-22, 02:22:49 +0800, Yangfl wrote:
> > On Thu, Jan 22, 2026 at 1:23=E2=80=AFAM Sabrina Dubroca <sd@queasysnail=
.net> wrote:
> > >
> > > 2026-01-20, 17:21:29 +0800, David Yang wrote:
> > > > The following (anti-)pattern was observed in the code tree:
> > > >
> > > >         do {
> > > >                 start =3D u64_stats_fetch_begin(&pstats->syncp);
> > > >                 memcpy(&temp, &pstats->stats, sizeof(temp));
> > > >         } while (u64_stats_fetch_retry(&pstats->syncp, start));
> > > >
> > > > On 64bit arches, struct u64_stats_sync is empty and provides no hel=
p
> > > > against load/store tearing, especially for memcpy(), for which arch=
es may
> > > > provide their highly-optimized implements.
> > > >
> > > > In theory the affected code should convert to u64_stats_t, or use
> > > > READ_ONCE()/WRITE_ONCE() properly.
> > > >
> > > > However since there are needs to copy chunks of statistics, instead=
 of
> > > > writing loops at random places, we provide a safe memcpy() variant =
for
> > > > u64_stats.
> > > >
> > > > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > > > ---
> > > >  include/linux/u64_stats_sync.h | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >
> > > > diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_sta=
ts_sync.h
> > > > index 457879938fc1..849ff6e159c6 100644
> > > > --- a/include/linux/u64_stats_sync.h
> > > > +++ b/include/linux/u64_stats_sync.h
> > > > @@ -79,6 +79,14 @@ static inline u64 u64_stats_read(const u64_stats=
_t *p)
> > > >       return local64_read(&p->v);
> > > >  }
> > > >
> > > > +static inline void *u64_stats_copy(void *dst, const void *src, siz=
e_t len)
> > > > +{
> > > > +     BUILD_BUG_ON(len % sizeof(u64_stats_t));
> > > > +     for (size_t i =3D 0; i < len / sizeof(u64_stats_t); i++)
> > > > +             ((u64 *)dst)[i] =3D local64_read(&((local64_t *)src)[=
i]);
> > >
> > > Maybe u64_stats_read/u64_stats_t instead of local64_read/local64_t?
> > >
> >
> > I think casting to u64_stats_t is a bit overkill here since we accept
> > const void * and we are the actual implementation.
>
> It would be a bit more consistent. Just within this function you have
> 2 lines using u64_stats_t and the 3rd uses local64_t. And reusing
> types/helpers within a similar context doesn't seem overkill.
>
>
> [...]
> > > Since this new helper is always used within a
> > > u64_stats_fetch_begin/u64_stats_fetch_retry loop, maybe it would be
> > > nicer to push the retry loop into the helper as well?  Not a strong
> > > opinion. It would be a bit "simpler" for the callers, but your curren=
t
> > > proposal has the advantage of looking like memcpy(), and of also
> > > looking (for the caller) like other retry loops fetching each counter
> > > explicitly.
> > >
> >
> > The callers may want to copy other discontinuous data as well, albeit
> > no one did it then.
>
> I'm not sure why they would. I think the main point of using memcpy is
> "I don't want to copy each counter by name one by one", and possibly
> "I don't want to have to patch this code as well if we add a new
> counter". If you already have a batch copy for a bunch of counters,
> it's usually easier to add others in a contiguous block.
>

While I agree with your statement, I don't think it's a good idea to
push the retry loop into the helper. u64_stats_copy(syncp, dst, src,
len) would be a strange API, while no others accept syncp argument.
Also, it would give a false appearance to those who read the driver
code, since it does not involve fetch_begin()/fetch_retry()
explicitly.

In my opinion, it would be better to introduce a for-like macro
#define with_u64_stats_fetch(syncp), eliminating two function calls as
well as one variable declaration altogether.
