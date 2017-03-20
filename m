Return-Path: <peterz@infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IBn3hNxei4mgejfaJWDv3W74Y2c1hAvHH2uk7TD7qiM=;
	b=BKj4DqyyHd2lLmaajEaTBQ7ek
	iwi0sgdqFYmFo4R596xkz6R4nT3Bi/p03fakhjpAXUL1k1+nGHmvyVzbRBi3eZ7+Qv/QWy+/OADNH
	uingLuZty1ruPb6cMBC3ivgWjvZEvxJxrgNvn42yvIGKeGlRJW81NT0bCNB9EqQizWzIMRiovv1YL
	HDSdaFo3h6Q6xrypiRbcqrZjwNDQJSgIetXuV8IaliaTBE8FtEf7Ybn9Ygv84+y7b0mR27S8pDylK
	fvZb7ZVEGFWUNlErltbf4Za86qM56o0URf+Cam63Nijnsh4JKC+MOqAD1Bw/1Ur3kdOm+k+i2rnL1
	x0KpAyx2g==;
Date: Mon, 20 Mar 2017 14:40:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
Message-ID: <20170320134017.h3c2jrsnd4guuyu7@hirez.programming.kicks-ass.net>
References: <1489767196.28631.305.camel@edumazet-glaptop3.roam.corp.google.com>
	<20170318164759.GA23837@gondor.apana.org.au>
	<20170318.182121.439615057765380575.davem@davemloft.net>
	<20170320103937.lq7nfnutupr3gkn7@hirez.programming.kicks-ass.net>
	<20170320131629.GA26405@gondor.apana.org.au>
	<20170320132357.acygo3umw6fiwb4p@hirez.programming.kicks-ass.net>
	<20170320132713.GA26954@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320132713.GA26954@gondor.apana.org.au>
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
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: keescook@chromium.org, eric.dumazet@gmail.com, kaber@trash.net, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmorris@namei.org, ishkamiel@gmail.com, kuznet@ms2.inr.ac.ru, akpm@linux-foundation.org, David Miller <davem@davemloft.net>, elena.reshetova@intel.com, dwindsor@gmail.com

On Mon, Mar 20, 2017 at 09:27:13PM +0800, Herbert Xu wrote:
> On Mon, Mar 20, 2017 at 02:23:57PM +0100, Peter Zijlstra wrote:
> >
> > So what bench/setup do you want ran?
> 
> You can start by counting how many cycles an atomic op takes
> vs. how many cycles this new code takes.

On what uarch?

I think I tested hand coded asm version and it ended up about double the
cycles for a cmpxchg loop vs the direct instruction on an IVB-EX (until
the memory bus saturated, at which point they took the same). Newer
parts will of course have different numbers,

Can't we run some iperf on a 40gbe fiber loop or something? It would be
very useful to have an actual workload we can run.
