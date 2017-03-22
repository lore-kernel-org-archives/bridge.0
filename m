Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=rOJGUI2c5O/4oVqGtgIPei4v6P9V7JK1+Owvk600tak=;
	b=Vbw+fImkIxn7NJ3Fxdf0oqTlTEtd0GzWLAeWFw3ipjUeHpmik5efEHiaf8mxaV6Bet
	RJykAvcxiI8XDqlqjCGzIebvuGH/0daWdNkyCXaoRkDb/fqXpkRJI60vav75rxXclPzY
	v8XVUW9cAbcWEnqFNhAOezUga1rV5rPQvAvjA07zOq45+iPodLko49P3z2jHmQVieqAi
	b5wxWsZgf+09RdWbaEp8cKYJKN0qHa1IkIB+bzj0Z6VA8uLRnYMLsLVB4gGRDumXiE/c
	o3EeBvGcA41exKvom4GxZPvXbJee7zoTULkRWIAM2UpSXENtgKtuBbG25DX0S0dlIZYo
	MLGw==
Message-ID: <1490148199.16816.126.camel@edumazet-glaptop3.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 21 Mar 2017 19:03:19 -0700
In-Reply-To: <CAGXu5jKPckDxKV8ShY=5VtGm62Qxr5-gO9JDa_C+UL_P84jxVw@mail.gmail.com>
References: <1489767196.28631.305.camel@edumazet-glaptop3.roam.corp.google.com>
	<20170318164759.GA23837@gondor.apana.org.au>
	<20170318.182121.439615057765380575.davem@davemloft.net>
	<20170320103937.lq7nfnutupr3gkn7@hirez.programming.kicks-ass.net>
	<20170320131629.GA26405@gondor.apana.org.au>
	<20170320132357.acygo3umw6fiwb4p@hirez.programming.kicks-ass.net>
	<20170320132713.GA26954@gondor.apana.org.au>
	<20170320134017.h3c2jrsnd4guuyu7@hirez.programming.kicks-ass.net>
	<CAGXu5j+HK6jXeA3EdJGMLK_7o04AiTwXmmjuKOmExz0g5rs=kw@mail.gmail.com>
	<1490131389.16816.123.camel@edumazet-glaptop3.roam.corp.google.com>
	<CAGXu5jKPckDxKV8ShY=5VtGm62Qxr5-gO9JDa_C+UL_P84jxVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Patrick McHardy <kaber@trash.net>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, Hans Liljestrand <ishkamiel@gmail.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, "Reshetova,
	Elena" <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>

On Tue, 2017-03-21 at 16:51 -0700, Kees Cook wrote:

> Am I understanding you correctly that you'd want something like:
> 
> refcount.h:
> #ifdef UNPROTECTED_REFCOUNT
> #define refcount_inc(x)   atomic_inc(x)
> ...
> #else
> void refcount_inc(...
> ...
> #endif
> 
> some/net.c:
> #define UNPROTECTED_REFCOUNT
> #include <refcount.h>
> 
> or similar?

At first, it could be something simple like that yes.

Note that we might define two refcount_inc()  : One that does whole
tests, and refcount_inc_relaxed() that might translate to atomic_inc()
on non debug kernels.

Then later, maybe provide a dynamic infrastructure so that we can
dynamically force the full checks even for refcount_inc_relaxed() on say
1% of the hosts, to get better debug coverage ?



