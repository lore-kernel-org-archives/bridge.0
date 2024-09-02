Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B55217C22E
	for <bridge@lists.linux.dev>; Mon,  2 Sep 2024 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262508; cv=none; b=GIIVvoWv2iGU+yTfFq0Io4lxIfXKqM203KcegmWcusrgwHs60LLf7wfFyPhpG7w9zMWzOvsspnu3H6JbrleCEGbYL+RAnpK7qCk0tedsFKWvvgxciSsAUP2nJd9v+4Vh0MhqEN8MUcHgq5lhZ8j1Ijfbft1XRJJCfsO56WC1WiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262508; c=relaxed/simple;
	bh=y/phM2gtak5IpNmZ1ZyKmSpHCCT5yc5+SMu8zkK/6/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CATcsEHsiuMnlebbfRxmtCcnzI1+9V9Ua+a4pII5FDC/EX6JmxD94t3ryaYBD69an5wSc0cvOOVpEIN48r11qy/Q9aoH3EAvyIL4kRhlvOYnFsHircdmgbx1P/FEO6rp/JX2sMaUdOvqb5fswJxdBBsJmKH7GRyIPyYPeggp4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=FdIKo1fA; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="FdIKo1fA"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a8425f3d62so4357785a.3
        for <bridge@lists.linux.dev>; Mon, 02 Sep 2024 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1725262505; x=1725867305; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xwvTutx+VMx+U5m8ilJaZf9BSFWpaamYBl9FVfuHQY=;
        b=FdIKo1fAQIZleHca6oNpkMUupWnX7u4+ZBXrag50RwsNfpHG4xkefUYp0ZGaLp1gcK
         5peiiRlN3LCOoQ+qYu45jieoB7iemRQA8VvLpMTBf+UBsHhT2KUP/wDTlJasP7PjmtED
         +EjmDq34WtLiAqrYpttYRnEMk4X6n975UKMA/I6gIa+daPeC0vMyGsSc+RiLaq5yYDCT
         Z1UdXfURElHWZnNL0UCgs322vxQa07J3hHAnGRIvjztis6Q/4/38NelLJBBVlpzOELES
         uFKD2BWXNsPBHcp3CCsvYLeXvZeWAZXeojxIaJyTxRHV0MWjZiE0cSG7OHR4Sipn6MJk
         Itaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725262505; x=1725867305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xwvTutx+VMx+U5m8ilJaZf9BSFWpaamYBl9FVfuHQY=;
        b=dE86eTJSSIUOwh2BcOoueW3erZh2OMPTcUpXjDnVm/UBAYycbquRdFBNA4rNOGPiIa
         sCHydQQEWBX7EVuvzWxDjYmz/1LiGKf0s5+0vpvEm6pJ2OIgO0PGqK9YYCKUbSKGuy8t
         lMoUEqMYDjBy47hIJptEM2p2rkG93FQhZxuJKkbXK24MtQtVHOKQBDupkPJbcCfLjyqR
         esm1LRHI39fFH1IyI7MC2afI1ezzzhhOs7JRf34NwP0UaBIaXW/nhDfWhCt8mKYDb+AU
         WTA5j0JJA6hq+DRzM5ytYCwtQ4vB/wv3tZp4U2bMu3ccN+ddmSHry7vm71plXX4jMAzw
         EozA==
X-Forwarded-Encrypted: i=1; AJvYcCUUVXCzlXWzufvB9o/lS6QOmIM27A930aeIdMhqwVNoJGhzKIR7CDsWPr0e+Vej/33Y1JazaoE=@lists.linux.dev
X-Gm-Message-State: AOJu0YzYV9OA0dhtaOQbR/fBWY/CNsHoyJ/71lD/fatOolkVFk4jhuio
	TymXZA29GpiOpLDY94riqX7Ekd27osMONa1Ibof2B9sRt0s3STiy3r7TUCmGrePrr0efySWlmdy
	+ugdBHXCIPDmw7YHz1vRVGUL9eUiio9yD422SkUWZssKw1BEjw/LEGrZaa/3hgeVvse70CotWtr
	p1UNjWjZmTWDkTEaKqd/LhsA==
X-Google-Smtp-Source: AGHT+IFsXCmCKa5o+ksxosNJAkRGGSkpnJOljAKCmob6efSXTfN8qkkSolfkLbZfqv470jv4i64LAox7+Mon7bBclK8=
X-Received: by 2002:ac8:7c4f:0:b0:44e:d016:ef7 with SMTP id
 d75a77b69052e-4568cef97c9mr57086911cf.7.1725262504798; Mon, 02 Sep 2024
 00:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240830145356.102951-1-jonas.gorski@bisdn.de>
 <b0544c31-cf64-41c7-8118-a8b504a982d1@blackwall.org> <ZtRWACsOAnha75Ef@shredder.mtl.com>
 <003f02c3-33e0-4f02-8f24-82f7ed47db4c@blackwall.org>
In-Reply-To: <003f02c3-33e0-4f02-8f24-82f7ed47db4c@blackwall.org>
From: Jonas Gorski <jonas.gorski@bisdn.de>
Date: Mon, 2 Sep 2024 09:34:48 +0200
Message-ID: <CAJpXRYReCbrh0z3fmgKqycJHZ+Z8=+KnK+YpOrhD1UsmgfiSxg@mail.gmail.com>
Subject: Re: [PATCH net] net: bridge: allow users setting EXT_LEARN for user
 FDB entries
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Petr Machata <petrm@mellanox.com>, 
	Ido Schimmel <idosch@mellanox.com>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am So., 1. Sept. 2024 um 14:25 Uhr schrieb Nikolay Aleksandrov
<razor@blackwall.org>:
>
> On 01/09/2024 14:54, Ido Schimmel wrote:
> > On Sat, Aug 31, 2024 at 11:31:50AM +0300, Nikolay Aleksandrov wrote:
> >> On 30/08/2024 17:53, Jonas Gorski wrote:
> >>> When userspace wants to take over a fdb entry by setting it as
> >>> EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
> >>> BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().
> >>>
> >>> If the bridge updates the entry later because its port changed, we cl=
ear
> >>> the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USE=
R
> >>> flag set.
> >>>
> >>> If userspace then wants to take over the entry again,
> >>> br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
> >>> setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores th=
e
> >>> update:
> >>>
> >>>    if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> >>>            /* Refresh entry */
> >>>            fdb->used =3D jiffies;
> >>>    } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> >>>            /* Take over SW learned entry */
> >>>            set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> >>>            modified =3D true;
> >>>    }
> >>>
> >>> Fix this by relaxing the condition for setting BR_FDB_ADDED_BY_EXT_LE=
ARN
> >>> by also allowing it if swdev_notify is true, which it will only be fo=
r
> >>> user initiated updates.
> >>>
> >>> Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added b=
y user as such")
> >>> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> >>> ---
> >>>  net/bridge/br_fdb.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> >>> index c77591e63841..c5d9ae13a6fb 100644
> >>> --- a/net/bridge/br_fdb.c
> >>> +++ b/net/bridge/br_fdb.c
> >>> @@ -1472,7 +1472,8 @@ int br_fdb_external_learn_add(struct net_bridge=
 *br, struct net_bridge_port *p,
> >>>             if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> >>>                     /* Refresh entry */
> >>>                     fdb->used =3D jiffies;
> >>> -           } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) =
{
> >>> +           } else if (swdev_notify ||
> >>> +                      !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) =
{
> >>>                     /* Take over SW learned entry */
> >>>                     set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> >>>                     modified =3D true;
> >>
> >> This literally means if added_by_user || !added_by_user, so you can pr=
obably
> >> rewrite that whole block to be more straight-forward with test_and_set=
_bit -
> >> if it was already set then refresh, if it wasn't modified =3D true
> >
> > Hi Nik,
> >
> > You mean like this [1]?
> > I deleted the comment about "SW learned entry" since "extern_learn" fla=
g
> > not being set does not necessarily mean the entry was learned by SW.
> >
> > [1]
> > diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> > index c77591e63841..ad7a42b505ef 100644
> > --- a/net/bridge/br_fdb.c
> > +++ b/net/bridge/br_fdb.c
> > @@ -1469,12 +1469,10 @@ int br_fdb_external_learn_add(struct net_bridge=
 *br, struct net_bridge_port *p,
> >                         modified =3D true;
> >                 }
> >
> > -               if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> > +               if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->f=
lags)) {
> >                         /* Refresh entry */
> >                         fdb->used =3D jiffies;
> > -               } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)=
) {
> > -                       /* Take over SW learned entry */
> > -                       set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)=
;
> > +               } else {
> >                         modified =3D true;
> >                 }
>
> Yeah, that's exactly what I meant. Since the added_by_user condition beco=
mes
> redundant we can just drop it.

br_fdb_external_learn_add() is called from two places; once when
userspace adds a EXT_LEARN flagged fdb entry (then swdev_nofity is
set), and once when a switchdev driver reports it has learned an entry
(then swdev_notify isn't).

AFAIU the previous condition was to prevent user fdb entries from
being taken over by hardware / switchdev events, which this would now
allow to happen. OTOH, the switchdev notifications are a statement of
fact, and the kernel really has a say into whether the hardware should
keep the entry learned, so not allowing entries to be marked as
learned by hardware would also result in a disconnect between hardware
and kernel.

My change was trying to accomodate for the former one, i.e. if the
user bit is set, only the user may mark it as EXT_LEARN, but not any
(switchdev) drivers.

I have no strong feelings about what I think is right, so if this is
the wanted direction, I can send a V2 doing that.

Best Regards,
Jonas

--=20
BISDN GmbH
K=C3=B6rnerstra=C3=9Fe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=C2=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=C3=B6psel


Commercial register:=C2=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=C2=A0DE283257294

