Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794207198;
	b=oUxYfx5YURSwAg3oY4gURcv5l+TTB7bnMTzQvXN6Rgi8+rlwraFF4cyxgEUDT9KH1U17
	 PhQQGBwxNVv7McnB7vXykoS/DTV+mVtxLdIH2K4VICB6j6LiDO3u5ZmpxXla6/IGySaGy
	 pfnlOMo7CJucVgou1AUlC47DNNREQxZBGY0hxURIdRhEKFffEzfY0oYdFDKV9VkvDH+GH
	 NXwLwHDkkYIwpisFaLRR2StPWQ8bmdV/scuiGBR8CKTC3X3EP20/F8OozRgdq0/u/AIDi
	 yhE5McDYoERuvGkssF4MbGLXqO1Hgvkg8N+rRzegy8LS+j3hSYmFcyBozZC300GgrvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
	b=fzQ0dwpW27nq5QPx8OPgbRB6HD/0wzdFzQMPKg/QXEXgmHunOXa2vCkwY1eGuWI1gEI0
	 bANgmhDFwplw/wDaIiuzOy23HhkezZKglBO1rSry5aODDYozsMxi85ZNBPfPUp6PIAIVT
	 aTa3URGNQ6hDy2QcQKdlum2DF1Cfpll5scnM4HqzNn04C2h+SGIm8NXOkzOBcfpvqzDD5
	 aK9CX/IH1jZR12n2PaX2eUG2m0zMf2d3ZmmBHS0ty1axSWTSF02A3xCGMWsqSFb6MiTGz
	 Y5H3Ms0TnmXkwB7HT5PPx5BgXITyaKeTbH6vnYOuJ6qz8yFs/WSltCxXwjp1TLgNvEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jwZsm69V;
	arc=fail smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D9606A325
	for <bridge@lists.linux.dev>; Mon,  9 Nov 2026 06:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 548D9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jwZsm69V
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c14f3dab0cso293182e87.1
        for <bridge@lists.linux.dev>; Sun, 08 Nov 2026 22:53:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794207196; cv=none;
        d=google.com; s=arc-20260327;
        b=BoLv3wp+JIoGBUJrx/L/Uf1e+tIHdZS36VwRTjw3IkL1pHhxWkerPV4LUOoe6DOk3d
         ntj/gLBXpzd4yh8seEqYdEVvEEhNabcxLxPy0qe7l96FOyk+7rstOYDiqsesvNbPgU0z
         1lSkvwI/Ac3Arw+rig99A/zJtcAuTZfy8rNmnMkXXr0b+8EKmeypIWIYruBL08wu12lm
         QH7x+NaRaUPH7mPZxffw7CXiX5irnn9JtUOTMVB7Q+cyUifLOYxP8fy3l9NCLIHTwGLG
         Dp4tQGkJbocdCSQf5A9oYcEwGd5/JgX1uILtHLHWlUmdGWG6+/cJZK0DIYGRfIV67o4O
         zKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        fh=XnzWBROVxclsFFXQZ7eh4Qyp22ojeRZqHTpaT+L2Y/8=;
        b=E1+v1PHFOGZGHcf0IXBs/SgGGO77LIjeJnzzzcDJv8cej4O5WeXYECmTce+WqAR2yH
         ONYWZI/dzPmqS/w8b8ixhWhba4o/dNC0heFJ6ng4jUrjS8uc2BE925BgK+ZbqJEpqb+v
         vqBipPAHn5SGEjHRTTsHtd/5L2LSSX3WXM6Rjjw+JL687QddiobFIXr7Y+5ab5PvRJTG
         sbB+VhTh/v2dWUVg50yF1BhRoCBFd0yLAQd4y7Tk5cg0J8Fd2tvwBuSNaEqAw524iLu3
         J3ts27IpZd2rxnl0oz9I+SkPxyr5svlTB7XPab7ubbzEYZNFjHtTKl2o755g06smL/xk
         ArTw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794207196; x=1794811996; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        b=jwZsm69Vie8MWjnuOP9ZiOX3kkiqsYcSbCNUpGAbUt3MobsPki0/qYyqUv2vDyeCmf
         om/XCSsQKxOvsUsvO7YGdc1H9PQgWLTJoVj7LlnNJjy+JKvsgl+XWkHVfvSnLUKYXmvL
         lAKoEpJHTo/qFvLJMw8aGQaktRw+R9OsS2yE06PhEaM8rAaQLVPwq3Xe4jvXvA0xan/6
         rqya2ldQgPl24h6Jx3Wod45vNZNMxXifqq2n4Sxcu9S9oFZnbogLt9Og60NpCpzHd2UU
         MNoWCNSUgTLnOy3KIdZMiBkV5R2z5S+cIKPvE8Y/hCw393QAIs1K7JzuPFupC0cTwQO3
         w5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794207196; x=1794811996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        b=Nkr+WLE5b9txufQX9kosQ4kn4Ye0sOg0iVANnDKpXfhABEDWIl0PAFPJkICPe005Z3
         0Ai2VF7zrr/EIfbo6bx+DcyQgLorI4CrQ169eiT1GWhvR/yoplheYqnd7FKn0IhJg6Gb
         vZH49kMHQioIl6UqJ5wjGitEtSXcF/CrwH+ZlWqVTG/zxYHdklG9CxP9LW7WsdFbJxfs
         YwZjwFRi3ugwUFgFxajX48J+137czwjxpuCG7GeyXgnVv389odaSG9yv5DPDkMLapNzY
         whok+hNny9jTi22NGH3jH+pZzjsbAc/IXIq9Z/uT7y6wjKf/kMNheYSqMrwkIn8p/GSA
         5ymw==
X-Forwarded-Encrypted: i=1; AL+hErF5tk30iXNz1K1vtLO7SYQFN5Z498VTJYpbZQyxxip2uyw80j/aKPZPti7lDiOKapWcob+G6vY=@lists.linux.dev
X-Gm-Message-State: APuU4Z8/7SKq+JM+KShqD5v2nlYrzIvCCFj4tyUkW1JOMyoXbJpfXwJJ
	/KgvH7+YTo6M7PZRsP9+XI6d9kYO93G8BbspZ0m6XMRrIbP7ZJ64JDL/B2PNBL/J5yn+yjmL6jw
	oPjWSVKrcs5wVZ9++Qb+q3Zxmx700gxU=
X-Gm-Gg: AYBFou2eWyplwtFM3mlWpaWKRG55Q84c12O+JuES/8Gynj/gDL6JLxVPVBa4eM0c1UZ
	DLGDh7jeN/WezMULOOlBui1HjTMMgHbI9GfpFUQPYCsEmpMDazeWApENluzMfxPuqBl03qK0loT
	UlCmvBFYsIHCpeOcZknBC8QhpFbO9KIe4PzXz2nDQgfp6HdKZGplG8zppYLtk+YcXBJKerhZ/qm
	bwXcNSBmgnZbLSjzYxYKSmDG9sgZNqvBbfW5l9HoBmmsD/cEhA3bYrQjHOgyHYYmqAVxEUMc05Q
	LLCXpV0Me7oBEt+1j7TMQ0MFIuNgf4RQBOvzvkKGVjoqdilwCYQeyuMaHCYk44swBZUh37zV7/C
	q2b+r9sHpMFFG72hnQ6gFlPtrGkK2pxkEbKx6EQOBqjgHu06CmQH+AYMjUMSkipULMYluDdkSfO
	GzQYaeYID0m6G6i7w/ZnS2tIEDcaJXZ2cT3B0Ny1da/BQxy5Y8uSA=
X-Received: by 2002:a05:6512:3e1c:b0:5c1:4a48:c2db with SMTP id
 2adb3069b0e04-5c14c01f805mr810751e87.43.1794207196170; Sun, 08 Nov 2026
 22:53:16 -0800 (PST)
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261109025425.328445-1-jiayuan.chen@linux.dev>
 <CAL+tcoDvFNAZubOjw9+Z1eyaVeiBzt_Xg3KMNucY879bg-ZLow@mail.gmail.com> <dbdb9385-89cd-4e4f-bfb8-b72510e8801b@linux.dev>
In-Reply-To: <dbdb9385-89cd-4e4f-bfb8-b72510e8801b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 9 Nov 2026 14:52:37 +0800
X-Gm-Features: AclHuK9hO_h4FFhel_M7AacjBweA615sygy6vgIfEMNG5ukVHhzyCYoysXzMOxw
Message-ID: <CAL+tcoA6_gROiprd7YgxvwbaiuzEUPfuWTNMjKu6vDkbUJ5KPw@mail.gmail.com>
Subject: Re: [PATCH net-next 00/14] net: annotate data-races around sysctl knobs
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>, Paul Moore <paul@paul-moore.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Julian Anastasov <ja@ssi.bg>, Allison Henderson <achender@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bridge@lists.linux.dev, 
	linux-security-module@vger.kernel.org, mptcp@lists.linux.dev, 
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 11:33=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 11/9/26 11:11 AM, Jason Xing wrote:
> > On Mon, Nov 9, 2026 at 10:55=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linu=
x.dev> wrote:
> >> While testing the recent sysctl range fixes I noticed that a lot of ou=
r
> >> sysctl knobs are read with plain loads while the handlers update them
> >> with WRITE_ONCE() and no lock, so KCSAN reports them as data races. I
> >> then used an LLM to go through every ctl_table under net/ and list the
> >> readers that were left behind. This series annotates them with
> >> READ_ONCE(), and adds WRITE_ONCE() to a few custom handlers and netlin=
k
> >> paths that store to the same fields with plain writes. Most of it is a
> >> plain READ_ONCE() at each read; where a function reads the same knob
> >> twice to make one decision, it now reads it once into a local, so the
> >> comparison and the value it acts on cannot come from two different
> >> writes.
> >>
> >> There are no Fixes tags. Done one knob per patch this would be well ov=
er
> >> a hundred commits, so I grouped them by subsystem and feature instead =
to
> >> keep the review manageable. If maintainers prefer, I can split it up
> >> further with a Fixes tag on each one, as several smaller series.
> > Over the last year, I've been thinking about the annotation stuff
> > especially around sysctls, which, I suppose, shouldn't actually affect
> > the real workload but does affect the outcome of the syzbot.
> >
> > Out of sheer curiosity, my question would be what is the point of
> > trying to change all of them? Or what kind of benefits can we get from
> > the big series?
>
>
> Three things:
>
> 1. A plain load may be emitted twice by the compiler. ip_error() compares
> peer->rate_tokens against ip_rt_error_cost and then subtracts it again;
> if the sysctl changes in between, the u32 wraps. A few readers have that
> shape and now read the knob once into a local.
>
> 2. Tearing is not involved here, all the fields are at most word sized.
>
> 3. The rest is the memory model: a lockless read of a field written with
> WRITE_ONCE() is a data race unless it is marked
> (tools/memory-model/Documentation/access-marking.txt). That is what KCSAN
> reports, and why most of the series is plain READ_ONCE().
>
>
> I think the benefit is doing it in one pass.
>
>

I was curious about the REAL impact. If this thing really matters, we
have a lot of work to do even not only in the networking subsystem.
Sorry, I still think none of those points are convincing enough, but
that doesn't mean I object to this series. Anyway, it's just my
2-cents.

Thanks,
Jason
