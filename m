Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=MbhRis1i84PDaCQwNwRgdxEO402R/WzKiEy/M830NEw=;
	b=bvANNkEHwXp2/0/INp3P4ol5bYTRqK5Rkkk1VQLAF3jFNRqXLMfvlcsfWUcMkTcbrC
	EzHdzDYADIWrIf4ZCQj5LNr6NoUAXOstAFsDv64ryxXUFxRn1xlejexyNQdKwzRANtR9
	HNEAoXAdIYDFedBWMUglE38EFY96eZzAvxJpq/RGx4JP5iLDvEQES5xjbsMDdHSP0R03
	YWEb9ZV8V0whkxNusGWf/R0TZWa9/4QeXvPCIZSdbnRq4X1B48y+7qEoHbcx5Sc+MBra
	VNjx/ZvTJ0YfIGpiNbh4+gOot70471vH5Xp4COuqTnXF1XK8AeqCWvMlMs5E235B0LLS
	GhUA==
Message-ID: <1490131389.16816.123.camel@edumazet-glaptop3.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 21 Mar 2017 14:23:09 -0700
In-Reply-To: <CAGXu5j+HK6jXeA3EdJGMLK_7o04AiTwXmmjuKOmExz0g5rs=kw@mail.gmail.com>
References: <1489767196.28631.305.camel@edumazet-glaptop3.roam.corp.google.com>
	<20170318164759.GA23837@gondor.apana.org.au>
	<20170318.182121.439615057765380575.davem@davemloft.net>
	<20170320103937.lq7nfnutupr3gkn7@hirez.programming.kicks-ass.net>
	<20170320131629.GA26405@gondor.apana.org.au>
	<20170320132357.acygo3umw6fiwb4p@hirez.programming.kicks-ass.net>
	<20170320132713.GA26954@gondor.apana.org.au>
	<20170320134017.h3c2jrsnd4guuyu7@hirez.programming.kicks-ass.net>
	<CAGXu5j+HK6jXeA3EdJGMLK_7o04AiTwXmmjuKOmExz0g5rs=kw@mail.gmail.com>
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

On Tue, 2017-03-21 at 13:49 -0700, Kees Cook wrote:

> Yeah, this is exactly what I'd like to find as well. Just comparing
> cycles between refcount implementations, while interesting, doesn't
> show us real-world performance changes, which is what we need to
> measure.
> 
> Is Eric's "20 concurrent 'netperf -t UDP_STREAM'" example (from
> elsewhere in this email thread) real-world meaningful enough?

Not at all ;)

This was targeting the specific change I had in mind for
ip_idents_reserve(), which is not used by TCP flows.

Unfortunately there is no good test simulating real-world workloads,
which are mostly using TCP flows.

Most synthetic tools you can find are not using epoll(), and very often
hit bottlenecks in other layers.


It looks like our suggestion to get kernel builds with atomic_inc()
being exactly an atomic_inc() is not even discussed or implemented.

Coding this would require less time than running a typical Google kernel
qualification (roughly one month, thousands of hosts..., days of SWE).


