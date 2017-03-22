Return-Path: <peterz@infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209;
	h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5oGrx6RC/Q8F0JtSQW/Q1Z6aTHL8vYNQRPLhToE4LCg=;
	b=aIswHXHpMaSreOUsaSmT1q6yi
	JJkNzZDXGgWY69XNvBvYeH/eZewM1/qgR8CzsJEIu0hrZ8q7LSsFS+pjUEZXtDYC+GLSEqJ7ifCYx
	Vr2CXbkD1oU/VBTL3RR9h4iZC90sxYD1sGk49BiYI34ers20PEgAchbGf53DqfPVqBBYRLKjfYDg6
	XoeFMkU70rARgcfS3WTUMA7ARoaZCeAqKneWh5oS6lfNNmgoUqyU/II0Pxk9/bG0qQhLYr176UTy6
	iGz/DrfjnHI1jl4O1msXaU1bHWhgadd8f6k31x3oaWDUot6W9C44J8GSATaei3lmjwYxw7qfKYZmV
	aLRh+uFDA==;
Date: Wed, 22 Mar 2017 16:08:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
Message-ID: <20170322150847.rsvhkbft3bn35rim@hirez.programming.kicks-ass.net>
References: <20170320132713.GA26954@gondor.apana.org.au>
	<20170320134017.h3c2jrsnd4guuyu7@hirez.programming.kicks-ass.net>
	<CAGXu5j+HK6jXeA3EdJGMLK_7o04AiTwXmmjuKOmExz0g5rs=kw@mail.gmail.com>
	<1490131389.16816.123.camel@edumazet-glaptop3.roam.corp.google.com>
	<CAGXu5jKPckDxKV8ShY=5VtGm62Qxr5-gO9JDa_C+UL_P84jxVw@mail.gmail.com>
	<1490148199.16816.126.camel@edumazet-glaptop3.roam.corp.google.com>
	<20170322122540.odnm4j3r4c4uf7wt@hirez.programming.kicks-ass.net>
	<1490188936.16816.143.camel@edumazet-glaptop3.roam.corp.google.com>
	<20170322143329.ya5jnretfptf4iud@hirez.programming.kicks-ass.net>
	<1490194444.16816.154.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490194444.16816.154.camel@edumazet-glaptop3.roam.corp.google.com>
Subject: Re: [Bridge] [PATCH 07/17] net: convert sock.sk_refcnt from
 atomic_t to refcount_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Patrick McHardy <kaber@trash.net>, Network Development <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, Hans Liljestrand <ishkamiel@gmail.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@linux-foundation.org>, David Windsor <dwindsor@gmail.com>, David Miller <davem@davemloft.net>, "Reshetova,
	Elena" <elena.reshetova@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>

On Wed, Mar 22, 2017 at 07:54:04AM -0700, Eric Dumazet wrote:
> On Wed, 2017-03-22 at 15:33 +0100, Peter Zijlstra wrote:
> 
> > 
> > But I would feel a whole lot better about the entire thing if we could
> > measure their impact. It would also give us good precedent to whack
> > other potential users of _nocheck over the head with -- show numbers.
> 
> I wont be able to measure the impact on real workloads, our productions
> kernels are based on 4.3 at this moment.

Is there really no micro bench that exercises the relevant network
paths? Do you really fully rely on Google production workloads?

> I guess someone could code a lib/test_refcount.c launching X threads
> using either atomic_inc or refcount_inc() in a loop.
> 
> That would give a rough estimate of the refcount_t overhead among
> various platforms.

Its also a fairly meaningless number. It doesn't include any of the
other work the network path does.
