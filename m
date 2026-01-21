Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C1358D0F
	for <bridge@lists.linux.dev>; Wed, 21 Jan 2026 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019809; cv=pass; b=hGXvZqC6I5o6mMqhxQRe98aWMvm1O1/6ihtzMz/q+ma/PubWo4n8lff7K0ZBIbOQhL9dicyjmm0w7xiJVpv93BmqNHTdv6+Ny9XwJa6ZRmSkORV7ucTIlIWmPmcu7Ljk7zUdkiTWpk4UCZxGsEDENOmgqAyc74Jt+TWcQSdiFNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019809; c=relaxed/simple;
	bh=PdETfuP1u9AkTnIAU4OIisLef/UtQm36zVR7qzogAWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzzrHW/zLmrGyz0zLkBzvoT+AwgmQ1UJ0NHJIsKAxjloOTTOB7WRMuRZ3bg6845IZ4/nyWsfhy0HSir5HOcwBd1g4HcuwPLI46mQtcbszvcNUaBRZZdm/RizkXGAHDubXp6slM9r0rdFNxmt6c97XPujBViIGM0cxttd7SJilbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYlZsDra; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYlZsDra"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d148ddbb91so84546a34.1
        for <bridge@lists.linux.dev>; Wed, 21 Jan 2026 10:23:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769019806; cv=none;
        d=google.com; s=arc-20240605;
        b=KU/lyomd4u2n5dU5plmdbs7aS2yFM/RRlSekuzith16/Wl33J63zunjQJNk1/CYgXb
         9bqoKE1Aguixu3xEmZBI16GZjex/xOzWWlPGGMpe51ST7uNhOC+w9gUw//+ZXG4kEESP
         79egQ8cZb+162wlYYHoM62N1G+5Z905UKO5vhiW/hjlJNhuiAWw/koeRyQRHrk3fKA76
         KB5t8ldLz1bjQQZ74o+YHGNMH706O20/mDEKPL55mVeosahKACt1IVNmzPENkFzPsxfH
         ZTrM1tNq2HibhTfhEY8P72BFrc3Cy6sKSJvk4rAvlHWeSTlynYUlYmUDm3rgJikEJTXE
         +4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c1Hlj3w4l/0faf2g6KLOHGpExK3gCGGcIA2RjqkPX44=;
        fh=jSdgaQ8eTChjHO23zA4tdcXHKKy4VSU9ZkPM/IcoQcE=;
        b=M7jMxxe3pd879RXYkd5p8QhbrdaI2ei1waFgrR8WzEDtzXYFfbQahzeocHMXJXZnhW
         bvdRjqFC8+H2sdK48XCnfh9ypvP8zQVzYPKtNd+wTzABCSsbv/Iqs9GWGEfMoT1Exaeg
         pmHUvNFrjKYehKuBD01moxOOr5edh+WdYMdpOhtGQUcE/IjbIDfE8Z2rFuy21Vc4J7SG
         e80LtwBTw46LI7ImPDTUDwFGv5nmC/h0mUeBlxuljpNJa4BRhyTvHci2jBapJWRjl+Lw
         n+eor2INSdibzDqIvJvRP8KXskXe2TnLij+ixN2Ke4TdMNwfSzgGTcUZSVlutiKTlx8T
         kkRw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769019806; x=1769624606; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1Hlj3w4l/0faf2g6KLOHGpExK3gCGGcIA2RjqkPX44=;
        b=QYlZsDraPv/PoidkMpE/upLiqWjikvUR9Dgwu/5wOEa6NGAJeQRHFXYafif7AZ09RM
         s2TO0i4t/jhJw/alGWbKyPFdlURDNC+b/rMCZAhj36gjW/OdU7FMRZJQ93oECCitoqdH
         A4c5pHSWsJkrgTwSQnX8SyZa/LnvUkFeJRp2G2kgW4deTJ1vNxIfYIeKE/WNeD2ql0Wl
         7SX53mih0oADXRThnY4bxLKiK/wEiPDABaFCNDbioaGAohNS+7KE/O9oLw5t/tLIg7rJ
         HYPfGOzykPm167l6f2hCrmTkAIpz4SPF4GaMSmVj+GmVSaXyUuee/MqXbceKldaB0CmP
         MTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769019806; x=1769624606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1Hlj3w4l/0faf2g6KLOHGpExK3gCGGcIA2RjqkPX44=;
        b=baiPZJXlflK6S3bYmysEKD5v5fIjMdg4xtxTyQTRZJpiDwWxPS3Ee8ccFvvWAT0Lyb
         keWznOamDHsl+/OXDB8itkFzsnv2t2anNqmdadr8oepFnIktU5dYjCE5EKv23l8O8t7t
         UjL1R3kKSkLYgkuBxzlOijpb+CXppAvW0+0NscuG3MdncXflyOaDoM/JiAslLxWNaXaT
         bl4DnVZe8z7QMt3xsRpVMQrvPkdO3UISBi//NuuOwlwuhDONHXTXgCIh/mDV9os2PZkE
         XsdOy9LWaI3TK9GeFgsfYmph5ftAJzbqBxYKIuXF/jw0/N+FfylIITNN6kM87AdNHswT
         ZZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7SRDMgutSvHI2tUOJG/SSixdj4MlnXSVasGJwuNxSgSayXpA8x2iFdPY1rVMEjEsIn/D+ZGw=@lists.linux.dev
X-Gm-Message-State: AOJu0YwXTuMKWCFfxnTwpFA+pwgUwN6QAPXgb+ny8n+lT+oOQ3yP7DWw
	Q4g7wO0EoaJrfdleDKhdJqsUaxBx4jcYjp+dnwWaB5rknDMbo2V91rqJgu9bJk5Ux8ct9ralCfY
	ZaTllUUwjuX5rngYiXk9Vc1z5GQZisdo=
X-Gm-Gg: AZuq6aKET37/LmxSC0SN3X9VI5FMw0FmsQEvExHxllrlJsgxuKWx+c7ZGfTUe2qi9/5
	daWYQeMIlsUlCX+UHG1TpaHSy9nBVOwttyWxfsNBz1vnTH4JxwKj2nInvsA7RlI6RnX+js1uoQU
	bdbRceAvAm/UszE33RadfMjenpW6fW86NRGAaXoRRPtXsS5/PK4VyzOsI3eINR0TGmNx5bgGCDV
	Cep0b11Ng8+rAlqHBUp/H7flQI00aLtUAei2uWqsUoQg+hHrmkCJYB/1sIV+MAI8Fq0XkhUGTwz
	5gol+BKFloUhd2BJ9ifDiSUkkP5tUlsiEpeo7QvkiE7A0YCK0D8QZnrp2tCm
X-Received: by 2002:a05:6820:174a:b0:65b:35fe:4323 with SMTP id
 006d021491bc7-662b008f427mr2444409eaf.67.1769019805582; Wed, 21 Jan 2026
 10:23:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260120092137.2161162-1-mmyangfl@gmail.com> <20260120092137.2161162-2-mmyangfl@gmail.com>
 <aXELnMSc4UU6DkbZ@krikkit>
In-Reply-To: <aXELnMSc4UU6DkbZ@krikkit>
From: Yangfl <mmyangfl@gmail.com>
Date: Thu, 22 Jan 2026 02:22:49 +0800
X-Gm-Features: AZwV_Qh2WtvpqzJ52fSNEITfJoGoQaUtqAWfgaFDL8o68nHE05e8TExvPZS0aAg
Message-ID: <CAAXyoMMAMAbEu=-wTf3MGMiZr2Uq7pqJXC+_zrtxKrsjyYi+AQ@mail.gmail.com>
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

On Thu, Jan 22, 2026 at 1:23=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2026-01-20, 17:21:29 +0800, David Yang wrote:
> > The following (anti-)pattern was observed in the code tree:
> >
> >         do {
> >                 start =3D u64_stats_fetch_begin(&pstats->syncp);
> >                 memcpy(&temp, &pstats->stats, sizeof(temp));
> >         } while (u64_stats_fetch_retry(&pstats->syncp, start));
> >
> > On 64bit arches, struct u64_stats_sync is empty and provides no help
> > against load/store tearing, especially for memcpy(), for which arches m=
ay
> > provide their highly-optimized implements.
> >
> > In theory the affected code should convert to u64_stats_t, or use
> > READ_ONCE()/WRITE_ONCE() properly.
> >
> > However since there are needs to copy chunks of statistics, instead of
> > writing loops at random places, we provide a safe memcpy() variant for
> > u64_stats.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >  include/linux/u64_stats_sync.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_s=
ync.h
> > index 457879938fc1..849ff6e159c6 100644
> > --- a/include/linux/u64_stats_sync.h
> > +++ b/include/linux/u64_stats_sync.h
> > @@ -79,6 +79,14 @@ static inline u64 u64_stats_read(const u64_stats_t *=
p)
> >       return local64_read(&p->v);
> >  }
> >
> > +static inline void *u64_stats_copy(void *dst, const void *src, size_t =
len)
> > +{
> > +     BUILD_BUG_ON(len % sizeof(u64_stats_t));
> > +     for (size_t i =3D 0; i < len / sizeof(u64_stats_t); i++)
> > +             ((u64 *)dst)[i] =3D local64_read(&((local64_t *)src)[i]);
>
> Maybe u64_stats_read/u64_stats_t instead of local64_read/local64_t?
>

I think casting to u64_stats_t is a bit overkill here since we accept
const void * and we are the actual implementation.

Again, they should convert to u64_stats_t, and this solution already
implies that u64_stats_t is binary compatible with u64. I've already
sent several patches related to that, but that's another issue.

> > +     return dst;
> > +}
>
> Since this new helper is always used within a
> u64_stats_fetch_begin/u64_stats_fetch_retry loop, maybe it would be
> nicer to push the retry loop into the helper as well?  Not a strong
> opinion. It would be a bit "simpler" for the callers, but your current
> proposal has the advantage of looking like memcpy(), and of also
> looking (for the caller) like other retry loops fetching each counter
> explicitly.
>

The callers may want to copy other discontinuous data as well, albeit
no one did it then.

         do {
                 start =3D u64_stats_fetch_begin(&pstats->syncp);
                 memcpy(...);
                 u64_stats_read(...);
         } while (u64_stats_fetch_retry(&pstats->syncp, start));

It would be redundant to provide two variants of the function.
Moreover, callers can (and already) invent their own reader/writer
helpers, for example

         #define SLIC_GET_STATS_COUNTER(newst, st, counter) \
         { \
                  unsigned int start; \
                  do { \
                          start =3D u64_stats_fetch_begin(&(st)->syncp); \
                          newst =3D u64_stats_read(&(st)->counter); \
                  } while (u64_stats_fetch_retry(&(st)->syncp, start)); \
         }

> Either way, I think extending the "Usage" section of the big comment
> at the top of the file with this new helper would be nice.
>

I think callers should avoid memcpy() eventually, and they almost
certainly copied more data than what they need. However, I took a look
at some instances, and it would be non trivial to modify those
drivers.

> --
> Sabrina
