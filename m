Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=RkL5kdWAWnAys8UGPMTyw2/M7xRALcLu52ccYqX/ku4=;
	b=kXrko6TzljT1kqPUFgu1aTqlaLA7jKWG1hTp+flFgR792sUgX4kjebrJJJa8U/Vnps
	H9TcPsOu7ZZyfhffUaHRgrWsQOAF/wqSsFfLr8yrgm2w5M67dcalxea8s3yU2PAVPSkj
	68duUI8kGVxRxhYXmPzAZysiSj3LxrcW+bmIiob5sky88p0AMSET8y/cjx6te1firIfQ
	I0oO3zbno6F9FJMZSCDCWEkJjIOtGZwhdqoz9XHj5NpfCss+ej086cnyjJd1BKpDTPir
	mrAR8Vntpw10adC2vTmaeaUae6bmOF0aIqs1CkiBAjwR54ohLwFYqiJduStz01/xoDb5
	Y29w==
Message-ID: <1490021946.16816.54.camel@edumazet-glaptop3.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 20 Mar 2017 07:59:06 -0700
In-Reply-To: <1490021461.16816.52.camel@edumazet-glaptop3.roam.corp.google.com>
References: <1489767196.28631.305.camel@edumazet-glaptop3.roam.corp.google.com>
	<20170318164759.GA23837@gondor.apana.org.au>
	<20170318.182121.439615057765380575.davem@davemloft.net>
	<20170320103937.lq7nfnutupr3gkn7@hirez.programming.kicks-ass.net>
	<20170320131629.GA26405@gondor.apana.org.au>
	<20170320132357.acygo3umw6fiwb4p@hirez.programming.kicks-ass.net>
	<20170320132713.GA26954@gondor.apana.org.au>
	<20170320134017.h3c2jrsnd4guuyu7@hirez.programming.kicks-ass.net>
	<1490021461.16816.52.camel@edumazet-glaptop3.roam.corp.google.com>
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

On Mon, 2017-03-20 at 07:51 -0700, Eric Dumazet wrote:

> atomic_cmpxchg() on PowerPC is horribly more expensive because of the
> added two SYNC instructions.

Although I just saw that refcount was using atomic_cmpxchg_relaxed()

Time to find some documentation (probably missing) or get some specs for
this thing.



