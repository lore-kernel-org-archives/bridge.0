Return-Path: <peterz@infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dthYgeX6j2t+jms395gXmEA8nISpEo3Jtw0BjgZ+pDw=;
	b=PVRndvYRjLrpXJAclhTtu26r8
	087Wem6/qD86VSauRbAFSZXwBsfYp6j5tbvZ/sShBy0YO07NN3jVO1HEpdidMn2mgudg3kBuCY6yf
	+SO5bLSg9bY0nea8asKwWkiDo8wvIK142o1MhzDS6URLORcZk1utNIt0jB2QJG/ycDFXT66y/1jBa
	RpVZ+KKwvCT3wTeP7sMesKkdeRyh4AbnQmjUdflDWGAwbn7p4HeS2AWsnSmKd7EBJp1UMGhjNcxVU
	gAkefWBTB+QjZdTpSrF7SRfYdGk/JbtgflbE1j0YAzmefmx27kXPuRtHh7IuTqwbYXU8EffDlM9r7
	IReUUsAgw==;
Date: Mon, 20 Mar 2017 15:28:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
Message-ID: <20170320142807.mhu3xod2x2zzvego@hirez.programming.kicks-ass.net>
References: <1489767196.28631.305.camel@edumazet-glaptop3.roam.corp.google.com>
	<20170318164759.GA23837@gondor.apana.org.au>
	<20170318.182121.439615057765380575.davem@davemloft.net>
	<20170320103937.lq7nfnutupr3gkn7@hirez.programming.kicks-ass.net>
	<20170320131629.GA26405@gondor.apana.org.au>
	<063D6719AE5E284EB5DD2968C1650D6DCFFB5483@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFB5483@AcuExch.aculab.com>
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
To: David Laight <David.Laight@ACULAB.COM>
Cc: "keescook@chromium.org" <keescook@chromium.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "kaber@trash.net" <kaber@trash.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jmorris@namei.org" <jmorris@namei.org>, "ishkamiel@gmail.com" <ishkamiel@gmail.com>, "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dwindsor@gmail.com" <dwindsor@gmail.com>, David Miller <davem@davemloft.net>, "elena.reshetova@intel.com" <elena.reshetova@intel.com>, 'Herbert Xu' <herbert@gondor.apana.org.au>

On Mon, Mar 20, 2017 at 02:10:24PM +0000, David Laight wrote:
> On x86 the cpu flags from the 'lock inc/dec' could be used to reasonably
> cheaply detect errors - provided you actually generate a forwards branch.

Note that currently there is no arch specific implementation. We could
of course cure this.

But note that the thing you propose; using the overflow flag, can only
reasonably be done on PREEMPT=n kernels, otherwise we have an incredible
number of contexts that can nest.

Sure; getting all starts aligned to double overflow is incredibly rare,
but I don't want to be the one to have to debug that.
