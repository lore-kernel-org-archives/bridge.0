Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=1oVtlRZlzkOWP7gwTWq7MlIOnn8fWxbB28QibL93Amg=;
	b=WVqRqL9443+E+qrr++nO4TMaPxV4hjs+Vs9WuMFREto80Dhi5tAp785ZnlbwEuYaTW
	Ag48vE+XBSFYTk4LEylT4tIWsxNHXKL5e6p82CBitFNNmBb8oAr4edIh1M9vGQ8DdYBn
	PKsyAdIB8Y1saSbpwT2EbTCzQvoPICd2K8nrwenbGOeZZvoxiFskjt5k7yq7ilPz7Z/L
	RtZKLR1PIq5vKfHugwWAbKOW1FLdHhZDuHQb2v8pPt7tG6Z/MzhPL9KoII7B5pw/6Paq
	6dqWw/LNsoaC447JttodmYEQJVg9Wucv93zSIWvI9Pl5fa9xGQn3Qwczlz+gp8ND5wLt
	mNRw==
Message-ID: <1490027684.16816.63.camel@edumazet-glaptop3.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 20 Mar 2017 09:34:44 -0700
In-Reply-To: <1490026735.16816.58.camel@edumazet-glaptop3.roam.corp.google.com>
References: <1489767196.28631.305.camel@edumazet-glaptop3.roam.corp.google.com>
	<20170318164759.GA23837@gondor.apana.org.au>
	<20170318.182121.439615057765380575.davem@davemloft.net>
	<20170320103937.lq7nfnutupr3gkn7@hirez.programming.kicks-ass.net>
	<20170320131629.GA26405@gondor.apana.org.au>
	<20170320132357.acygo3umw6fiwb4p@hirez.programming.kicks-ass.net>
	<20170320132713.GA26954@gondor.apana.org.au>
	<20170320134017.h3c2jrsnd4guuyu7@hirez.programming.kicks-ass.net>
	<1490021461.16816.52.camel@edumazet-glaptop3.roam.corp.google.com>
	<1490021946.16816.54.camel@edumazet-glaptop3.roam.corp.google.com>
	<1490026735.16816.58.camel@edumazet-glaptop3.roam.corp.google.com>
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

On Mon, 2017-03-20 at 09:18 -0700, Eric Dumazet wrote:

> Interesting.
> 
> UDP ipv4 xmit path gets a ~25 % improvement on PPC with this patch.
> 
> ( 20 concurrent netperf -t UDP_STREAM  : 2.45 Mpps -> 3.07 Mpps )

Well, there _is_ a difference, but not 25 % (this was probably caused by
different queues on TX or RX between my reboots).

I added a sysctl hack to be able to dynamically change on a given
workload, and we hit other bottlenecks (mainly qdisc locks and driver tx
locks) anyway.






