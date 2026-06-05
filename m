Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F602D8DC2
	for <bridge@lists.linux.dev>; Fri,  5 Jun 2026 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647873; cv=pass; b=OO4mAulCKmYsz2d5Io5wSEyh6tGBBqIZKnCXkpjeIvPO2e3uA1z0YFFcJVXXyttKFHLxIbey/Ht/OICVtaWPMP1ewuLcaLoBfwg5opGREJlEwcyX4resV++MXoFfn1R1u+YjEyuO3OH5f6eat9em+QcZRx8OxrxYBUepINJuHiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647873; c=relaxed/simple;
	bh=//piZpS4JqLzDTuCDQ4SM8AQklgNjfVxCndwQALTVT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwrPVMvKnXNdzRC8yF6zY503xiHYAJdbNHF+xWH03eqTnZprmWvoQAwVCDEzOIVOPVgAQwdRJrUhIAMOwKPzadO1LjOOub4TTLNoyr/2hx5WWLW2VwyWKrlkFg2T8gg7jCdGiOLQ5P9G/XNtwOkL6+oDNax94EyGQzn/35lGvB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xeo4t5mV; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xeo4t5mV"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa612bf6efso1682968e87.3
        for <bridge@lists.linux.dev>; Fri, 05 Jun 2026 01:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780647870; cv=none;
        d=google.com; s=arc-20240605;
        b=JHJZhs1/TIsvkv9BH2WJulgbBvfTRKz79KVvDEQoDkqam73R2NO4bJeepGvszJ/P9q
         y8KACaiOEuOC3mFmoO5sAOdwedfdbjC2YimFL5PTQ3G8AkJnpiWXW2rBpp3JmPH4U8yF
         3oDmu526fNr9jvYQibwiWSQYpsf1iAPOV0FvQzies2nZzoZqaoL6HXuXZoa1dCAqAac0
         5M7jdLK2Epa04UmuvcKpmWStyQEwru7a9gIjcD5mebqE8xZEEZtAZDE0MbeFQxPIUD4g
         OUKuykxrTK0t1wcKiKXe0wLV7+IiLf/3jXEIPgm0cmtgq8ygZFmnrtlijVOw9FWxTryS
         ZGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+RZhurI/q7oJqN3iUeEhWQQThIPk8thOCCIV1vfD+a8=;
        fh=SXv7ywkzoeUPrVLd69rchzTiQSn9Iw6LxHGYgByV6mc=;
        b=GokzOvcMixfwRx5Gm/6Fr2jtAFVgnn0D+JXJ209TRvDJh7z9kp9jBfA8xCj2zmH4Bl
         XubLEvRmKhzQzPTtb3Lm3i1KPGY2MgPUyfrJzs/kDg5vvnsB7lMk3pTgjppCd1/EKLLw
         V8DUj/nf3rsdooOVOFg+GC8h2n5FIvB0Fg1SPEg0MTR20C0/jL108jmp+n0elE4VtDn+
         vEMYtuT5nYtcspaWfqnxUbK/je14seGMes5rbjURwWVq6QoCqaO04+oY9R+okXX4YrlC
         HvAR0KgMdQ70iJ2oxkimBC2kdRLAI3E+534ZAg/Y2xgy2eklTbvYsVsdzVtvN7mRJnXO
         lXqA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780647870; x=1781252670; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RZhurI/q7oJqN3iUeEhWQQThIPk8thOCCIV1vfD+a8=;
        b=Xeo4t5mVOItoOCbMRn6yM4iSeRMWyBofM2t68ElCmUwcHeguyn+QIpHuAhML1/iYKN
         CbxKYdtjhPukFK8oofNE8LYw0bseE9w3EfZ98XS/fbQlU8qgpu6RMRiiBu8jDET4POB7
         qHNlM5fVuaWcaYt8GrshPebwgRb30ekKtKc1t5IH9SgQGq1fpbSYXg5U4V8k49HS2X25
         udjAzepQumkzCxpaetoqhqo0WahLyrOdVsRTQY+R7gScfRqFI5FGQkRolcK0kwUTD0ZT
         lxJ9ACeiTLihIwO863Jpk5MYc6UgX9x7qssGqew8j/UqnUAfxzVQn2PKgFg7UMVMfkVb
         av0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647870; x=1781252670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+RZhurI/q7oJqN3iUeEhWQQThIPk8thOCCIV1vfD+a8=;
        b=sxAPhNv0bkuHpzaKAV1sk6R/osOu2YaBZwURoHUL9lJpkinUnhA2BrT9szNifDrgQ1
         ieoRazgYAietV2baZOYi9+pxQu0KyHrFQFsKmM4Ghe7W76WfVxll4ngtXBGTvzTimez0
         DmFM8c/aqNHJy/KBfacPDozTH6n2KB3MEM9PeFx56Xy27UyJGUDhcov5I6vF0nA7OHDL
         sYRmxzI5qv3grIDVleCJ3h8bCg/fFwGqIKNCtdPgjQR+ZGQh7tnZZwOnDqgJyJeGOvK0
         Yahwdbkk+UhO//Dqo7TvxyYwLADDwHEh7FKeH6URA7ZnNMERcjgPBt7LHmOfra/3JjhQ
         BeYw==
X-Forwarded-Encrypted: i=1; AFNElJ8bR8lNozg31437FG1MvTImoUE4981Y/yrEn0HTkXJ0dffXKE+5wgKj41WLMRGYcVRUk1HjC38=@lists.linux.dev
X-Gm-Message-State: AOJu0YyOihANra72wgWb7SI19ZBDOj6lqtBm2bc8vbrjBp7paN8h/SZu
	CAFF2Yy88VX0M7y/1jwJPf8u8RuAuQr578r7dS24J7y8lP+FWzIbaOJLMlfqi1+l9nSm5tPF7h4
	HfXPU6VQK3naUK+JRT+A8BbwdVSqO2xnrkQbXUHzFeQ==
X-Gm-Gg: Acq92OEkERKvsO652E4Wyjwoj0ah0YqiW1LdvoeA1fP1djrfiZGDGRow1lh9CQ3sQkn
	tAu5ZHp5CFD6uZ9IEZMMBkMZTQUiOmNG/K5MfX6EgbMIx7L1+fIpUE7MeREJtM/83OCn/GpiKJd
	FUuTLZLvmLA2z/0TcAHw1wBJS471nE87/hYQVXRFt1o2TLoZiL+sfwJQJyRdLg6pPBpNkuNEsgJ
	ihJfVOfdVHqb/iQ+IcG5CRioAS7E8If/JUnUhH7AtFeDNLUsxmtN/6HfYfKMdSEPgKIQxp8w8X7
	/bhL+2kyomWCJECrZU81G3Xy1++dpGLUNftCjURYmtiboX5xuQA=
X-Received: by 2002:a05:6512:3b10:b0:5a4:d44:99f0 with SMTP id
 2adb3069b0e04-5aa87b4019cmr757909e87.6.1780647870036; Fri, 05 Jun 2026
 01:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260507134815.295588-1-marco.crivellari@suse.com>
 <CAAofZF6CcyxoOsYr94KARUFtfi+=H1nF3mBQAtFWxEujdVgXUw@mail.gmail.com>
 <4d9067d9-2a4a-45e2-aa43-c456648989da@blackwall.org> <8186bef1-aa58-47c5-9816-1b707ec949da@blackwall.org>
In-Reply-To: <8186bef1-aa58-47c5-9816-1b707ec949da@blackwall.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 5 Jun 2026 10:24:18 +0200
X-Gm-Features: AVVi8CcX_QIeknkz-xXX_HwyABpbbtsK9sCbzxQSWw8Cjcwh7JYr-iUtJ1QO5Nc
Message-ID: <CAAofZF6uW+tE0p2FK+8S=x1OUObhYqK56g3T0u+4oJF-r0Sqvw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: bridge: Move long delayed work on system_dfl_long_wq
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	bridge@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Simon Horman <horms@verge.net.au>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:21=E2=80=AFAM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 05/06/2026 11:20, Nikolay Aleksandrov wrote:
> > On 05/06/2026 11:16, Marco Crivellari wrote:
> >> Hi,
> >>
> >> On Thu, May 7, 2026 at 3:48=E2=80=AFPM Marco Crivellari
> >> <marco.crivellari@suse.com> wrote:
> >>> [...]
> >>>   net/bridge/br_fdb.c    | 2 +-
> >>>   net/bridge/br_stp.c    | 2 +-
> >>>   net/bridge/br_stp_if.c | 2 +-
> >>>   3 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> Gentle ping.
> >>
> >> Thanks!
> >>
> >
> > Ping about what? The patch is marked as RFC so it is not
> > going to be considered. It already got a reviewed-by one
>
> err, considered to be applied

I haven't resent it without the RFC prefix because many other
maintainers applied the RFC version.

BTW thanks, I hadn't noticed it was already applied!

--=20

Marco Crivellari

SUSE Labs
