Return-Path: <peterz@infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209;
	h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D0vPb1bmHgiypIcq0GmmmsItTBxr6ld/Btag04OeTwA=;
	b=sUkpsbKgVg9P5zl9tTvaPReGq
	5RZZgwDHKMuO9kgf3IFsQlUqSUvJ1I/JDpGGiNKF6oaTQDhiBN2Rn+jOPJ1dLSpwiBITSoiZTdgj5
	Gu4H0OJGQO1KIfSD7iogwcYlzYhuYD4/QIYIGh0LEKwhp8k1zBJ5eaxruH4lSJ1P9B8AqPeDQvEe1
	gUyFwqwPT0mzPr6cMYmExe3e7Jvn1hfhL/imI8WA4s6DhL7Z/HnZJtMmXxngeJOo3D51BXn6oYimw
	odi3rz2BW1mNfzkVDRkGsDq7Cg0e1lseCqq9xHCzWnYKju1bKyRBazh0+hixNEOmfdUAtew8MbJTE
	nLvkAVA4g==;
Date: Mon, 20 Mar 2017 15:59:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
Message-ID: <20170320145938.cmj5m33uxunladli@hirez.programming.kicks-ass.net>
References: <1489767196.28631.305.camel@edumazet-glaptop3.roam.corp.google.com>
	<20170318164759.GA23837@gondor.apana.org.au>
	<20170318.182121.439615057765380575.davem@davemloft.net>
	<20170320103937.lq7nfnutupr3gkn7@hirez.programming.kicks-ass.net>
	<20170320131629.GA26405@gondor.apana.org.au>
	<20170320132357.acygo3umw6fiwb4p@hirez.programming.kicks-ass.net>
	<20170320132713.GA26954@gondor.apana.org.au>
	<20170320134017.h3c2jrsnd4guuyu7@hirez.programming.kicks-ass.net>
	<1490021461.16816.52.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490021461.16816.52.camel@edumazet-glaptop3.roam.corp.google.com>
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
Cc: keescook@chromium.org, kaber@trash.net, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmorris@namei.org, ishkamiel@gmail.com, kuznet@ms2.inr.ac.ru, akpm@linux-foundation.org, dwindsor@gmail.com, David Miller <davem@davemloft.net>, elena.reshetova@intel.com, Herbert Xu <herbert@gondor.apana.org.au>

On Mon, Mar 20, 2017 at 07:51:01AM -0700, Eric Dumazet wrote:
> PowerPC has no efficient atomic_inc() and this definitely shows on
> network intensive workloads involving concurrent cores/threads.

Correct, PPC LL/SC are dreadfully expensive.

> atomic_cmpxchg() on PowerPC is horribly more expensive because of the
> added two SYNC instructions.

Note that refcount_t uses atomic_cmpxchg_release() and
atomic_cmpxchg_relaxed() which avoid most of the painful barriers.
