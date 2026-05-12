Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63638E5DF
	for <bridge@lists.linux.dev>; Tue, 12 May 2026 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576271; cv=pass; b=VD6L0cEcUS1EAZvvuesCYVaLPMEUVfPlvV0kFrzzTcFxtRomyHHZJXlWecBEa7f52bV4Of68YH6ULtEu0LBUVi5zTI9X+qDW9BLNkOPmRjYKTYVXLnkQ8ZhMMQI1mREwa79j6TuhvZqA9DkhsYx1QTLJ3aXPp7EqHrIO058O3DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576271; c=relaxed/simple;
	bh=fHCwkUcAZqA/suQImg18ULhJSx0PMGzQUjdBOUI1Yfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elMvxFyeV+I0oTyQ/JEOmQ0L4WmCW9CdhxpYJktFrTVomiLtxc/GHecwosBrEcTLmckweV4OWG0KBXDC14g/PgYib7e9570+QwekRBDGknLEOHO3b+BqGKM4Y0Yzfq9eixmRnOGzRaJOAAi6bcs4XSQYq3MM+39TH/K6f/gfCbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScC2lyi+; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScC2lyi+"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8ed4dd182efso342135185a.3
        for <bridge@lists.linux.dev>; Tue, 12 May 2026 01:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778576264; cv=none;
        d=google.com; s=arc-20240605;
        b=JZjM8tqlYSxVE5FnGOso73yXWbK42x+9d31RNICW+UfXBdHRY3pwnIJcLdzQAmPldC
         OQbC4kWITXsiKXtkkUbhggvuygB7qQ3uqBrid2CdyPQFulJmU966UJfN3WzW89ybzZyt
         99QANfRnQZVzcF/3UUL0aq92YFhWVgm2wwA2zUPudbHUa1jmr68Rcvo/xm6bbsgKHNsa
         KS8wkHFM12wYkZvlwbJM+ZIwDBdgNKS/iiD6BhJA87XOYxJMjih7l36kLPfDC0l0ix8P
         J4ZKqWzoH6T8K5by4R5BrzW+8dIAroPPMzv9DppaqHbrTS+f/vZNkk7iUpI+TwFIdJa1
         KGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=55ODQSegitzmMbbfgjBwlX6/XYm1XcpZ4+xgA+8OEP8=;
        fh=oq8uLPYooQ9jisw4Oa8gWiA2YowQokqME9LgQpDCiYc=;
        b=MVYsaqDBHpgHZeC0BoeywLHvBhy8Dr35HHHa0Imu3lLqr03rIRTwKntPX/ETLTigCt
         n/Z4qLPK4Cie6kmKo4DA94My9j1DH7b+HwuO4V54xmi9sht8uGX+h0dNWd6yLmgUIwq5
         pFHTOH8ZmQhhcHIJjrqRTBd6LSO07f6nFUDwauZluneFlNO/ljcC+pYQh35yMkz++xUK
         WNfdUoRCEAN+pclpRm05SIYYHYJfc3X2jYMncskoUrN0OmioLTvs1a94C/Ry3wDKkYsm
         lfitLLyGPR7gl77djq/1nqtmFprELDK6w1STWwU6SL1hCrcHMMfN/dmxsvd54I/+DTSA
         yCEQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778576264; x=1779181064; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55ODQSegitzmMbbfgjBwlX6/XYm1XcpZ4+xgA+8OEP8=;
        b=ScC2lyi+LcZB/H/jtf2qrIHDBy5MGWznPXDjiKlG5r/jDyhWSB4YwF63GZdaJnZwC/
         DY51TBzq4U0luO9DN/tdWexZ81DCDx96gMK3/6jjI9fEZ9xEnMnFVERiLnoOBRvwKOVN
         VYCwxKV+UJIR1PuuxPl8i8XVFF4d9x+8iy4lXNVBjtaULlEnPpM0iRnp0GYA8YgfZymE
         uewd/IZoDg1M9CtGH7M59jLebx+rq2BsiL437Yla5Nmedc7vVaFD61LBBNqGF5SLuj6e
         1jo/wY+LMu6nB3Ayece3vFFd5bKtSDRu66KWBrpts5SUieIwsZU83ZSaj9ts6grNx7Td
         pfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576264; x=1779181064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55ODQSegitzmMbbfgjBwlX6/XYm1XcpZ4+xgA+8OEP8=;
        b=tOczC08wPzjOujPDGagbezU6PxUt+p4lg4d7iCh9MmGMMEUpWXYOAEBYMy6mCreLDb
         7RyvuYGrHqVB+DvXPI4QA/K0skwOWD+LVViZ05pY6/HsIpMCs6H6IKrQCdBiLaMhlk6e
         Sse5mnCLfS5JO9EL18bColF09c2d9c+ctpIpSSZYwfhYi1MG8LXapVCMtzGHIzUfmx3t
         M9BiibwFzvAAwzSaheObKW4QFZ6K2QhIgbSrZQtTmCnd9Qs0Cm2OLiIPdrBHdX5rlivk
         TPUKYuDLSB8tJuhxL4AONqbz+hCMe5iduuFtMCr598lI+1UEh5DBaBjXnjQ2uIhLK7SO
         6cAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8n5wvKMv4kgyLzW3K41uMOMw6aeO2EhZjNjm3oxmB5bHW5oLuiT0DEvMKLNb61ipMSgUCtm9I=@lists.linux.dev
X-Gm-Message-State: AOJu0YzA6/PC7GN7OIt+62xprzWLpFp38CXVqqa4GAl0crIFWh984ZIV
	X7ceI1ZnlG8QJf3knuXhx8Tbbs7EOKaixFxC//2LTpjs1oQ5PHXrchbOeMZfytdEfWheNAEdITy
	uzpc7Vlfj9Z8izOoJkOr/jBqV8fj7SCU=
X-Gm-Gg: Acq92OF8Yr9wdYzyakuoZci9l/QO8d3irsejDymFbhD2voBfZc23wrQHOVezwK1Kk2z
	61zkhf7ARfF/etDZy9OjXXQvbF7Z91VkWtcQbRjbEToWDGolREYAREq670r7EbQ544ER5gIGqzA
	4aEiU1IrU/HfoVt1/1aukGEtTUUm91Sajsx+ZO8xW9MWPgIbpXwBEIlpWd+8JR7IcC8KfercyML
	fDVs+8uqbm3APSKDbs9E67CtUlH3WXE1PtuuMBEDGkdCBDBWlJfOZ4RlepfHEApPBUrWsM/oXZU
	8ULRsSUC/RO6aXMEuQ==
X-Received: by 2002:a05:620a:4555:b0:8ea:addd:894c with SMTP id
 af79cd13be357-904d67e6875mr4166900185a.53.1778576263834; Tue, 12 May 2026
 01:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1778504155.git.tonanli66@gmail.com> <ad183a40c4d906f39e03590b371fdcfdffb863c6.1778504155.git.tonanli66@gmail.com>
 <1bfd86a2-e7f8-42ef-8486-4d7fa91b2199@blackwall.org>
In-Reply-To: <1bfd86a2-e7f8-42ef-8486-4d7fa91b2199@blackwall.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Tue, 12 May 2026 01:57:32 -0700
X-Gm-Features: AVHnY4LW_n3589IrfOW3lcWYMgL_KBweVteUL_iimXamiTRstgHN-Rc9pBaQ1LA
Message-ID: <CAPuPA7JzZC1veoLtdmsGdqZ4xuy7Znu=z=+7FsyX0_iUQxcZAQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: bridge: guard local finish against missing port
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	idosch@nvidia.com, fw@strlen.de, davem@davemloft.net, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, bird@lzu.edu.cn, tonanli66@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 1:29=E2=80=AFAM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 12/05/2026 07:31, Ren Wei wrote:
> > From: Nan Li <tonanli66@gmail.com>
> >
> > The bridge local receive path may be deferred by netfilter and resumed
> > later. By the time br_handle_local_finish() runs, skb->dev may still be
> > valid while its bridge port association has already been removed.
> >
> > br_handle_local_finish() unconditionally looks up the bridge port from
> > skb->dev and dereferences it for source learning. If the port is no
> > longer attached to the bridge, the lookup returns NULL and the deferred
> > local receive path can no longer rely on the port state being present.
> >
> > Skip the learning step when the bridge port lookup fails. In that case
> > there is no port state left to learn on, so returning early preserves
> > the normal behavior for existing ports while avoiding access to stale
> > state.
> >
> > Fixes: 8626c56c8279 ("bridge: fix potential use-after-free when hook re=
turns QUEUE or STOLEN verdict")
>
> I don't think that is the correct commit, it seems to me this bug
> has existed for a very long time. From a quick search I think (Florian
> please correct me if I'm wrong, but I think NF_QUEUE existed back then)
> it was introduced in 2010 by:
>   f350a0a87374 ("bridge: use rx_handler_data pointer to store net_bridge_=
port
> pointer")


After checking the history, I believe f350a0a87374 is indeed the
commit that introduced the underlying root cause.

The 8626c56c8279 commit in the patch is the one that actually made the
bug reachable in practice. I am a bit unsure which commit should be
used in the Fixes: tag. We have run into this situation several times
already, where the commit that introduced the root cause is different
from the commit that actually made the bug triggerable/reachable.

What do you think would be best?

Also, if the Fixes: tag should be changed, would you prefer that we
resend the patch, or would you rather have the committer adjust the
Fixes: tag when applying it in order to reduce traffic on netdev?


>
> because that commit removed the same check for a NULL port.
> The patch itself is ok, it restores the check that was there before the c=
ommit
> I mentioned.
>
> > Cc: stable@kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Signed-off-by: Nan Li <tonanli66@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > ---
> >   net/bridge/br_input.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index 2cbae0f9ae1f..5b0d7450de5f 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -247,6 +247,9 @@ static void __br_handle_local_finish(struct sk_buff=
 *skb)
> >       struct net_bridge_port *p =3D br_port_get_rcu(skb->dev);
> >       u16 vid =3D 0;
> >
> > +     if (unlikely(!p))
> > +             return;
> > +
> >       /* check if vlan is allowed, to avoid spoofing */
> >       if ((p->flags & BR_LEARNING) &&
> >           nbp_state_should_learn(p) &&
>
>
