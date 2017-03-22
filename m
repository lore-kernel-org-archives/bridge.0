Return-Path: <peterz@infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209;
	h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=us34iW02DepmeVNWnN4ISATsv5lft3LTrdZQaNlD6es=;
	b=EWTqzTflkJkxK+Ov6iFh+1Mzz
	eHat8kQhJShma18IdD0kplpBabLgLI+yQ6XMuEZZqfxmsYOYBh0PEuQHa9AcxkUf9g9wsO8AiHZBy
	Mk9vQLLwWjZzu1aOr0uwB0VZbAKjZu2SI9+1Jn3eBagXl2rDnDxJKtDp3/60udO6mvajST2/m4EJm
	3SVzIX3p8wEMRCvnJFKZc0K94kqWJtEoRAKL3AZU5OmJnqCkjKvV8xQjDWk15v26TMucRQFQqdBMt
	i6sYk9idiASqLojtzfLqoyV4apbflGyxfQ98eqJlTxBsRui1RYiF6UPcorFM+LIQuNgjqOBIwSWw2
	VsILkNDVA==;
Date: Wed, 22 Mar 2017 13:11:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
Message-ID: <20170322121100.cjeqno4g3s5n2qtl@hirez.programming.kicks-ass.net>
References: <20170318164759.GA23837@gondor.apana.org.au>
	<20170318.182121.439615057765380575.davem@davemloft.net>
	<20170320103937.lq7nfnutupr3gkn7@hirez.programming.kicks-ass.net>
	<20170320131629.GA26405@gondor.apana.org.au>
	<20170320132357.acygo3umw6fiwb4p@hirez.programming.kicks-ass.net>
	<20170320132713.GA26954@gondor.apana.org.au>
	<20170320134017.h3c2jrsnd4guuyu7@hirez.programming.kicks-ass.net>
	<CAGXu5j+HK6jXeA3EdJGMLK_7o04AiTwXmmjuKOmExz0g5rs=kw@mail.gmail.com>
	<1490131389.16816.123.camel@edumazet-glaptop3.roam.corp.google.com>
	<CAGXu5jKPckDxKV8ShY=5VtGm62Qxr5-gO9JDa_C+UL_P84jxVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKPckDxKV8ShY=5VtGm62Qxr5-gO9JDa_C+UL_P84jxVw@mail.gmail.com>
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
To: Kees Cook <keescook@chromium.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Patrick McHardy <kaber@trash.net>, Network Development <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, Hans Liljestrand <ishkamiel@gmail.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, "Reshetova,
	Elena" <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>

On Tue, Mar 21, 2017 at 04:51:13PM -0700, Kees Cook wrote:
> On Tue, Mar 21, 2017 at 2:23 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:

> > Unfortunately there is no good test simulating real-world workloads,
> > which are mostly using TCP flows.
> 
> Sure, but there has to be _something_ that can be used to test to
> measure the effects. Without a meaningful test, it's weird to reject a
> change for performance reasons.

This. How can you optimize if there's no way to actually measure
something?

> > Most synthetic tools you can find are not using epoll(), and very often
> > hit bottlenecks in other layers.
> >
> >
> > It looks like our suggestion to get kernel builds with atomic_inc()
> > being exactly an atomic_inc() is not even discussed or implemented.
> 
> So, FWIW, I originally tried to make this a CONFIG in the first couple
> passes at getting a refcount defense. I would be fine with this, but I
> was not able to convince Peter. :) However, things have evolved a lot
> since then, so perhaps there are things do be done here.

Well, the argument was that unless there's a benchmark that shows it
cares, its all premature optimization.

Similarly, you wanted this enabled at all times because hardening.

