Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92C34D3B0
	for <bridge@lists.linux.dev>; Sun,  4 Oct 2026 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129941; cv=pass; b=GMii56bqPwf0zAjgZksPtlKkc2v98mthxyI0btd29sDUsMsOb4c6r3a6+lKS41DI6y/a8ePeC5bXCvWMcaqsFVKmoVDjGTufKkYRI8OxZ0tb/wrt5sQKi9ztTz8n08ycwl99UHPGpLyqULrS2f+GX/r7v5Z8NaMwVD/F8Bs+ARM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129941; c=relaxed/simple;
	bh=JqhgSbKXiRs9KJieJ1Lo+MaB0d6v2jx8N12NDJx+2Yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cffLh7ksFsq5kt8j+DRirqsAewNMcDSjIdr3Jgf+c6KtzveLfBhiSSSLsG5q8cf197/zOJtXz5iXVAK5beoMCOzS6TJHPEdWGjmVTFVcrYRDadCZiPwxBCmRL2VRSnHWIfkSWwpQktA/jVqAfA55FEJgCEVD/ZHr3B+zeBZAdwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=DTrqzHKk; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="DTrqzHKk"
Received: by mail-yx2-f38.google.com with SMTP id 956f58d0204a3-675617094f5so599664d50.1
        for <bridge@lists.linux.dev>; Sun, 04 Oct 2026 09:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791129939; cv=none;
        d=google.com; s=arc-20260327;
        b=IRQI4GIsMztQcQFG/CL/1UgLDV/QFd/BI8vqGN2FuXM29kkSaVssSEgz9tt/6uol2c
         Am3gv+jyU46n0+pnM+wRVpoj5nvf58etLxjHgiayhVrpXCaQPpRBJ7hs0Y3lEzvgUR8a
         MOZsR/CTs+VCs1xrnxGRjjUQc4k1O4eCylkUcU3MNe4iVss6ptieaoQzcMcZ3Kilbziy
         sYBjKQx8YpoZxmZGjBWN+w4g3HZ0sqUepJUIj/HvoL2y6JGDdasjunSM2lL2Hr11xVFo
         h35d2fLwlYNRheU/v4SK2nmJkeXKcmoqQCCcAHCYYtMTvIKlaJfe9uz/UT1q5SlAdLYI
         HZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y3fsU5omFgw6BhNB+mUuwA3rZgfGs6fxlIGxVAPmPAU=;
        fh=disYsKunjqPVRlOHgA1TVltyd7LcgVVautrnGqm2dvc=;
        b=ozBBR8cfd3SxDMAVXX+BfwFlfVr7ZltkyLLNf7MJBbttAsyMDfwp8Qa5PARJIRjA8S
         GSeRrJlV0SqFyoy6Uiw5S5CV3Ua2adXl22JpWXZvnhpZtu82FzDj7UYoTsztabp/n9Xo
         xVvOgruX4VaQmnb4S1NBhflkbUfjrp7RkLMDU6jDtrAOz13qJJs4J2hsPqNcbb6FL9SZ
         utgTJ99ZparLGm7srT7E/T3/DQ2VDp914BbZBEddAN1MiPjjiYRdEtzuTdGmW0zH+UND
         5pfc9tFGy0dOojcVagu7+fMAfAwpRf/X3Eu9EaisGCYPXzPAyeVQix7X6sHfXyE3SGvn
         57Og==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791129939; x=1791734739; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y3fsU5omFgw6BhNB+mUuwA3rZgfGs6fxlIGxVAPmPAU=;
        b=DTrqzHKkHsupdJ7WFhwxuNcC4nfHgAIx5v4yrXN9r44MM3SAf152XV8ySlai8mT6/8
         YY9Q4Lssg2ipfhVpcQSDCJu2DRHePryYWPwUbkyEME1f2w3lr6/dD0TNQEUeg2ML53px
         YHQUvcphouJWDSGh9te/WgfvPfHTkekFCtjE+Ccx4OIh5JEBIJufHN0bcn23a26nYCZ+
         9FlQTMlhOrXRvEUzvALagCmn5yOHS/ScpLnySot3duFP0Iib1K4zSuiG2Sh7d83s/kxH
         OoKtnwJwjDiWZ2lZK1rdMhWzkpFaRkM9fk1gwHSUM5RKBtseGZXU2u3BnpG3LQZzkGiD
         rrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791129939; x=1791734739;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y3fsU5omFgw6BhNB+mUuwA3rZgfGs6fxlIGxVAPmPAU=;
        b=zqnCfrWz6DX6kuYXoG1ITvNOumyVihkieLvtZsTFYgmASX6TH1EYoBvtaULr2paOeM
         xGz/i7/ddo0TwhTCGfx2c2ybuGyB2ptJdA+dHDOKS1A8Rx7D7y2t9WdOPykAVl38vxNX
         cddTnWm8l9cMun4LFfezccEsJEADWW6cH34+JtC8JwWybcxOkcf4xa0lrB0Q5WLcW5Zd
         Ms04jzCFE5IVelWNpMhdBkENKoVs6q+3BWe42vYEhTeoYIbYXtsx1O5xoOlJuYwDGyhd
         M0SrmChFa0urmnrDLkJNwDYsp1A4QILHhOM913V+ekbobTn5u54PFyv9+CtfNDeupCSj
         FSmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXl+vGFloLjtC8lHSl8W4stNldroVx7X8S45KRUj3BRwOG+4Z1Ai5PYImWSlSBqvh3na5GuYY=@lists.linux.dev
X-Gm-Message-State: AFq9FYJ8ZgoBYCEsBJdKJ/X9oELuwbsVrwfHibkv6z6J+4Id0qywleKc
	pjjsX93uZm/gaYNVjeTHXV2a5FzWpILBiEi1Yjg6uA0SvtrJn2OcA40zLG7wMGVqIlKDV94NyQP
	rVxF5SGOj2W4djZtsEzVXAhfk0yt/VuyvP3E0T5Zx
X-Gm-Gg: AYBFou3QmBDbfzUcrrcb53FzaLYPLsjohepwTf+j1j5A/q10y6HZSQ0OvofDEaTKjpX
	UD4cmOmOMRQ6G9GAi54bc2DiBjnQdDTaSsx3bCtLP9lO5gyogawccCG8yvIN/DL09vGR9uJM+ze
	ZhG6Djf755YJPgMGBmgoqjqooE5Xp51H5iouGuLQ5Z7G2pIlEWQuM8hi1Jfe4wCjRizuf3pF2cZ
	rm1CkElAWyqN3soKFieMsHRaHHAQJa3xuxchUHcOW2EXpCi7mHAli/RtXCsc8weIvftCym/CCmI
	ICebYsiiVCESFzcKs92a0t1f61wLNXF3XHr+9EkBuxstbUOEs1z7CrUNNZxNHl3Laz4aYsls4Zh
	WrNmjRiHPrn6szhZmSx9BvOn4/PucFc9kj6s2uDvwbyKt3nqyXZr0co+mCeV2uUdblZy/3g7z14
	vWrdKAX2oNTcAtqhU4U82XoImurtIHP9R2ajpZtTylriwyNiPWwla7FwluvXCkMhF/hT8MRt44q
	vw/vc1TYh4BXoMTfJyuJTL+Y7p+aE1mni9aWRGK2GOjJ2Taiw/B3i4/hgpq8q15q150uA==
X-Received: by 2002:a05:690e:1616:b0:672:be40:5eaf with SMTP id
 956f58d0204a3-677ac079547mr3282301d50.54.1791129938951; Sun, 04 Oct 2026
 09:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261004124254.3525496-1-julius@bairaktaris.de> <01600be7-3d8b-48b2-a59a-1125eb452714@blackwall.org>
In-Reply-To: <01600be7-3d8b-48b2-a59a-1125eb452714@blackwall.org>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Sun, 4 Oct 2026 16:05:02 +0000
X-Gm-Features: AclHuK90kbEfr1-jBe_BFIZ77DR1u5zlZLof02Y-HmHYvTegFl8NjlWTcp5jAKI
Message-ID: <CAC1t37+4-Pf3j_x4_cYj-+_hj50W66f7TZWQaLavPJwSzmAf5Q@mail.gmail.com>
Subject: Re: [PATCH net] net: bridge: fdb: hold hash_lock when an entry roams
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, 
	Ido Schimmel <idosch@nvidia.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nik,

Thanks for the review. Sounds reasonable to me and I will look into it.

Julius

Am So., 4. Okt. 2026 um 13:44 Uhr schrieb Nikolay Aleksandrov
<razor@blackwall.org>:
>
> On 04/10/2026 15:42, Julius Bairaktaris wrote:
> > br_fdb_update() lets an entry roam to a new port without holding
> > hash_lock. It notifies switchdev that the entry left the old port,
> > writes the new port, then notifies the addition. When two CPUs receive
> > the same source address on different ports, these steps interleave: a
> > driver sees two deletions for one addition, or an addition for the port
> > the other CPU wrote.
> >
> > DSA counts references to a host address on the CPU port. The extra
> > deletion fails and the extra addition is never released:
> >
> >    qca-ppe 3a000000.ppe: port 5 failed to delete 02:5a:0b:a2:1a:46 vid 0 from fdb: -2
> >
> > With one address roaming between a DSA user port and a Wi-Fi AP port of
> > the same bridge, the error appears 3-6 times per address when the two
> > ports receive on different CPUs, and not at all when they share one CPU
> > (4 runs each). With this change it does not appear (6 runs, different
> > CPUs).
> >
> > Take hash_lock when the entry roams or its flags change, and send both
> > notifications under it. The common case, where the entry neither roams
> > nor changes, stays lockless.
> >
> > Fixes: 90dc8fd36078 ("net: bridge: notify switchdev of disappearance of old FDB entry upon migration")
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
> > ---
> >
> > Notes:
> >      net-next 941056f91907 ("net: bridge: fdb: factor out existing entry updates")
> >      moves this code into __fdb_update(); the same change applies there.
> >
> >   net/bridge/br_fdb.c | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> >
>
> Absolutely not, this was made intentionally. Taking the hash_lock would further kill learning
> and roaming scaling. Surely switchdev drivers must have dealt with this for some time
> now, if you'd like to fix it do it so the software path isn't affected.
>
> Cheers,
>   Nik
>
>
>
