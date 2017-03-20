Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=W5m74uPeSkIVSeqwSIxJNYnZWgStJobNtJoELEdGy14=;
	b=qMRykNMk21yAf4WsbTOjaUjXSrYGIYnrg3HiM4k3bkRrNaFEpvZFaUUMtGfbd20OSR
	jpa4UxTpCGDH2vvg4Nd3LwQ9LIdMm4cfduEJnLIOkPeqodf4tYSwXhOhrV2L1FlnI8DF
	N6ZHLUS7ukfSvdWhIWo6HtukZz0nX2VDcQMtKeKk0KU8WsTKrj5On0bXhpJniz1RsN5y
	b2jYgeazhyjeJdJsfZ7uHnH7mQzKGu2zD2dfILIVX1WUWgd+i+2xsjl5fY4+rYR5xKKT
	TBnjHlRR4wRAciT6ytp+TBhwHj8vyzPLuGaicY8wK6AoDZFqlaHO0XXdohqCoi9WMVv9
	EZKQ==
Message-ID: <1490021461.16816.52.camel@edumazet-glaptop3.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 20 Mar 2017 07:51:01 -0700
In-Reply-To: <20170320134017.h3c2jrsnd4guuyu7@hirez.programming.kicks-ass.net>
References: <1489767196.28631.305.camel@edumazet-glaptop3.roam.corp.google.com>
	<20170318164759.GA23837@gondor.apana.org.au>
	<20170318.182121.439615057765380575.davem@davemloft.net>
	<20170320103937.lq7nfnutupr3gkn7@hirez.programming.kicks-ass.net>
	<20170320131629.GA26405@gondor.apana.org.au>
	<20170320132357.acygo3umw6fiwb4p@hirez.programming.kicks-ass.net>
	<20170320132713.GA26954@gondor.apana.org.au>
	<20170320134017.h3c2jrsnd4guuyu7@hirez.programming.kicks-ass.net>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: keescook@chromium.org, kaber@trash.net, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmorris@namei.org, ishkamiel@gmail.com, kuznet@ms2.inr.ac.ru, akpm@linux-foundation.org, dwindsor@gmail.com, David Miller <davem@davemloft.net>, elena.reshetova@intel.com, Herbert Xu <herbert@gondor.apana.org.au>

On Mon, 2017-03-20 at 14:40 +0100, Peter Zijlstra wrote:
> On Mon, Mar 20, 2017 at 09:27:13PM +0800, Herbert Xu wrote:
> > On Mon, Mar 20, 2017 at 02:23:57PM +0100, Peter Zijlstra wrote:
> > >
> > > So what bench/setup do you want ran?
> > 
> > You can start by counting how many cycles an atomic op takes
> > vs. how many cycles this new code takes.
> 
> On what uarch?
> 
> I think I tested hand coded asm version and it ended up about double the
> cycles for a cmpxchg loop vs the direct instruction on an IVB-EX (until
> the memory bus saturated, at which point they took the same). Newer
> parts will of course have different numbers,
> 
> Can't we run some iperf on a 40gbe fiber loop or something? It would be
> very useful to have an actual workload we can run.

If atomic ops are converted one by one, it is likely that results will
be noise.

We can not start a global conversion without having a way to have
selective debugging ?

Then, adopting this fine infra would really not be a problem.

Some arches have efficient atomic_inc() ( no full barriers ) while load
+ test + atomic_cmpxchg() + test + loop" is more expensive.

PowerPC has no efficient atomic_inc() and this definitely shows on
network intensive workloads involving concurrent cores/threads.

atomic_cmpxchg() on PowerPC is horribly more expensive because of the
added two SYNC instructions.

networking performance is quite poor on PowerPC as of today.


