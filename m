Return-Path: <keescook@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=UiCbNlpmplRZDey2hnLqzJUAXWp28PFHzaz8hGhZJJM=;
	b=ceidLr1ad37DVef/NdGfC3/MNJ5reZQUyqR0sN8xkInhTPg0b3n16IUUtWTyfJVtcl
	+7nyIWG/yFx+mAB8d6WptNkPnXMiSKxAwqx0120eXQLgev4ePfhmKVap9z4pLLnfqSo8
	yizCmn/EE2yv7Tz8BMyiFqnkWlb/4r0gIRSCsALZXFwqdXKXmTOZzriwgYY44QLzL9Tu
	tQjBYsB02oR0kJ4E/K7siD+FFKXaDJy6Gu1la9TwPKA/c15r8QaXhcQP5ShLGK2afBPt
	3kmdDTXy1WMhdTCjRDPi7rmtpPlXtIp/Sb4u9G/Z65Kz53vbO3A66M4nEjOah1q/chVX
	Ci2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=UiCbNlpmplRZDey2hnLqzJUAXWp28PFHzaz8hGhZJJM=;
	b=ZSeO3SVdahS/7FxnsvsmpyFLB+IwToRu4OQ8Xh7QiBXvDFknZPld/V3Gjk+sBiywZI
	92MMyld2rjos3TVlpoVslhO5i9y/vkatEQkO74oBsXDPhy07qTPPh8cOaSShZF3vqmwN
	6QcVPQ2bBePuQXwCjSPDgShR+mmInD1MQBlHE=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20170320134017.h3c2jrsnd4guuyu7@hirez.programming.kicks-ass.net>
References: <1489767196.28631.305.camel@edumazet-glaptop3.roam.corp.google.com>
	<20170318164759.GA23837@gondor.apana.org.au>
	<20170318.182121.439615057765380575.davem@davemloft.net>
	<20170320103937.lq7nfnutupr3gkn7@hirez.programming.kicks-ass.net>
	<20170320131629.GA26405@gondor.apana.org.au>
	<20170320132357.acygo3umw6fiwb4p@hirez.programming.kicks-ass.net>
	<20170320132713.GA26954@gondor.apana.org.au>
	<20170320134017.h3c2jrsnd4guuyu7@hirez.programming.kicks-ass.net>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 21 Mar 2017 13:49:00 -0700
Message-ID: <CAGXu5j+HK6jXeA3EdJGMLK_7o04AiTwXmmjuKOmExz0g5rs=kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Patrick McHardy <kaber@trash.net>, Network Development <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, Hans Liljestrand <ishkamiel@gmail.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, "Reshetova,
	Elena" <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>

On Mon, Mar 20, 2017 at 6:40 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Mar 20, 2017 at 09:27:13PM +0800, Herbert Xu wrote:
>> On Mon, Mar 20, 2017 at 02:23:57PM +0100, Peter Zijlstra wrote:
>> >
>> > So what bench/setup do you want ran?
>>
>> You can start by counting how many cycles an atomic op takes
>> vs. how many cycles this new code takes.
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

Yeah, this is exactly what I'd like to find as well. Just comparing
cycles between refcount implementations, while interesting, doesn't
show us real-world performance changes, which is what we need to
measure.

Is Eric's "20 concurrent 'netperf -t UDP_STREAM'" example (from
elsewhere in this email thread) real-world meaningful enough?

-Kees

-- 
Kees Cook
Pixel Security
