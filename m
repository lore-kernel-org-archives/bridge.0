Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2436B223708
	for <bridge@lists.linux.dev>; Sat, 28 Mar 2026 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774679028; cv=pass; b=I2k8FEbsPGBsvgJOWbfzlfirouX9QxBnSYaeLCbJEqHD/fkupIRDs9PqFKCNmopwvSsvpLX2jL5sBciO8MupumwgHIU47ofdb1DpBOS/gKXVGEgZIVoG0Gicqe9quexbguLI4D+9hNqzz3bWMkzTvBZAymw8RAglpjg0Vqnszp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774679028; c=relaxed/simple;
	bh=mGrMw4MiJplVaIj0CCi1OYNWT4Z3Rp1BfJNazbAf/Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbfNWghpAYeRGx6CXGZr/YAJYFFX88GP27XFjSEsG1zG9ZPOzMDOxwIVKbCKflrtd4ajUWcprsGvf/+DfogGp+iGbLsz+mOPCeM01V8xsUcskdCzatNTs0/FqREXXgqI4YXY4KJnnRfsNTQTQLZl/OlvPMI9w5mfNYdwasd1Ftg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Z2HfYkjf; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Z2HfYkjf"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35c1107d4b7so2300279a91.1
        for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 23:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774679026; cv=none;
        d=google.com; s=arc-20240605;
        b=ZkeJrEcJAd29d9ieasf1zQdqMWRQO6iQ7xQOdneqzqdxPXkGPdtFmysrgNfp0W1wg4
         p+3/WOI5z2a5DY4qW9EwFXX3NLUdFWxQl0Poc5Qkqjiz9+BLmBVUtUU5jnR2wFK3Pacy
         uMECVIfef/+MkC8SkFRRJ6J4qalVupR3v6R9Kp92uQe+PEhwoVgwAapPzM5VdYzr+0hm
         e8MLFoZdc4ntiLcWVv4L+i/YTdBqHtXsr7A/WZD2QXrMRRCiGUUyG5lrHgfa0bAJugMi
         xE7kc6YImIuc9T/IjNaaTU5QnZzv7FnOaRCXRB1rYa/QALPMv6pi2R7xg2eUJa1lr6lY
         l3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGrMw4MiJplVaIj0CCi1OYNWT4Z3Rp1BfJNazbAf/Zg=;
        fh=Pvs7WAW+qGyvlALCdRVRv2CoUE0oUsyEwLjdUIYjSmY=;
        b=fu/3lI5x3k6ug6MTz3nSe2orvPzKgfqQiTPpW+zR0nQybo3zpQEAEOZZlkMcfYv0u9
         ihQ0JA9eGI+BefdtYXfMk9a3Ni2W73qgQweKxdos5+Q/D9Sz9Ttt4uiyhGAgRiKoGXC8
         ufD6peiz8fsRbEgGtevwprYbhsygnlwbVCmqnyTjwiX8BN75IfPIEEn0OOkTE+9hmKAb
         7+9pp4iil/maXfkRRlhuSGfB+xmIyvA383k3MTUUQuixNCi36uM22EUh9DgZNLBF55We
         /R20esZvhKyNAxqi7QcTqyKLtC0KergudtWs5esrvD6Thez6pM46a8kL3s2jRtTKDNQC
         5IUw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774679026; x=1775283826; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGrMw4MiJplVaIj0CCi1OYNWT4Z3Rp1BfJNazbAf/Zg=;
        b=Z2HfYkjfLarnlh+dkc12n9S/5gi+IfgcQhYrccT5FVciCxWYRkgDWJi29wR6P//BRE
         t+ox3z3Zd/MieNW0/mgVU8cHoAQHBMwju6uJW9jLRA8oOJfDdSIJzwGSiyh1JYxZsAgJ
         M367oSDGtdY+y1AeXffxo53YXz+7WGb+eUpdbe6nEhTayggJPszOwbXzmzMN5WYefENq
         tgktT1eNySSXYG8sqeUCn8F9q1+9Ho3x3FMsk/jHkX603pT2WU88doFJ+mflSkVOZW8h
         7FSJrEBIhPHjuYZ5QM3PPujKsADhYwRCHEXlEnIgkoEvQprtfsdeP8AVSWGgaMVCx5AC
         qF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774679026; x=1775283826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGrMw4MiJplVaIj0CCi1OYNWT4Z3Rp1BfJNazbAf/Zg=;
        b=C3+yb+pGiZBXvDFXFdHasSyFDj9lYMo9K2viTJeE0cnyPVIljMuYwzLre1rYiGFPq0
         tyCRlNF5Bx9m6DSMbM2sQFv4CiQtLkN13GUZOFIMBVHe+ymnYaAkllTAYMsUJPVpITWZ
         d61CVzvE6K3uvSEKaE+G/nf31NbW9fN9vxdVKPiTdPE52u8NMYYMzQ2fGcQdCNVvqX0s
         EeJ+PcdNIhKCjqkRw+E5j+MLaS8b7bz65+i4JM31NcI709WgTigOWDgKtRoevkThwyyF
         YXCsng6IgaKSKC55G1ZEIidegt9PkAmL6peIhIwGPNlS+xhkoa1R9vJRX0lMh8V7JIsA
         d9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUV7sDT4LXVMI3S5dKWVQcvu9zBZqawHygO34PAYcRjQHh/Py/0nRWkhb7coIs/9wdZSHXOlYs=@lists.linux.dev
X-Gm-Message-State: AOJu0YzL9TIZz8xqF3npwTsoaTVAYwZBqKUbwpmqZAzd0PsOeKnPMvq7
	zy+Q4+muzcAtubsIAW36wIa0ndPLTFPsRYuqJHOeQnl1U7xeSH46mIyFWVxIhH3CRx1HhlCx82A
	PJKfwpbI/w6Pn4Nal1oUwZ1Kpm2nF8EG/MiNfy4Ze
X-Gm-Gg: ATEYQzz1sidin+Lm1xbkN+YL7c7GZZJJlBnJoqQ+SJFq6enzBQNW0cXU+OcwVYJdbYX
	IsuhkJ9cdBmjTjJ+Qv8AhJEb2UINZYPNPnZG4qQYBti2Qvljw1PnAWEt0VIOMqSY+V8a5SCZyoh
	EDaqLR7Hq6dKdo84Y1v9Xi7SCtX5YzZwu9c4apupkVppmI5V8pI88lbF9V/NsDcHgYDS8okE0aN
	5cNWEBVjU1zXXR2ys3C8wd4xmETx5VWc0345S7z2bX7Z0BaSJC85TMPLbgs8G7Fk9oeDW34+nnD
	06iWBGrv
X-Received: by 2002:a17:90a:e705:b0:353:5595:3247 with SMTP id
 98e67ed59e1d1-35c2ff618edmr5113370a91.12.1774679026308; Fri, 27 Mar 2026
 23:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260326032438.3307549-1-xmei5@asu.edu> <20260327113412.GD567789@horms.kernel.org>
 <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org> <20260327171917.7575d715@kernel.org>
In-Reply-To: <20260327171917.7575d715@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Fri, 27 Mar 2026 23:23:35 -0700
X-Gm-Features: AQROBzDsd7uTa4Y8C1u6puTZAJ7JTHkpQpXfmYuMWfXq0kecoUQ_Yx7IUQh2sm4
Message-ID: <CAPpSM+SHL8VQU2jfzbs8vEVhdHiV=VQb3Dx-9iwryQEFK-QkSw@mail.gmail.com>
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM panic
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your review. interval=3D1 works fine even in the case when we
use netem to delay the consumer. I'll correct the fix tag and send a
v2.

On Fri, Mar 27, 2026 at 5:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 27 Mar 2026 13:46:39 +0200 Nikolay Aleksandrov wrote:
> > On 27/03/2026 13:34, Simon Horman wrote:
> > > On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
> > >> br_mrp_start_test() and br_mrp_start_in_test() accept the user-suppl=
ied
> > >> interval value from netlink without validation. When interval is 0,
> > >> usecs_to_jiffies(0) yields 0, causing the delayed work
> > >> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedu=
le
> > >> itself with zero delay. This creates a tight loop on system_percpu_w=
q
> > >> that allocates and transmits MRP test frames at maximum rate, exhaus=
ting
> > >> all system memory and causing a kernel panic via OOM deadlock.
> > >
> > > I would suspect the primary outcome of this problem is high CPU consu=
mption
> > > rather than memory exhaustion. Is there a reason to expect that
> > > the transmitted fames can't be consumed as fast as they are created?
> >
> > +1
> > More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu =
usage
> > conditions. This is a configuration error and OOM doesn't lead to panic=
 unless
> > instructed to. I don't think this is worth changing at all.
>
> Then again if there's no practical use for 0 we should consider
> the risk of getting this sort of submission over and over again?
> Dunno..
