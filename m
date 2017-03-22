Return-Path: <keescook@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=dAioBKbwAKWQ4WfSJyy7F1Z99pFPFa3ugtcBpUnRzVc=;
	b=QNTuEs/TweZ+0Aof1JNRTOu+tN45bh9vCfnAPVKTzenO74f+RornMlhULePhR55351
	S1akmBupicUQsRcxjjTdV1EMWYTx8gmGVIMq5ixbyKBY6TLCXASCpE4iLZWnrcWSYD67
	oygMNoMtILZrubUE824iFdA8zTD5G4Lalr2qMzbPZJg2CNsUwYT2t1AblyVv2GvdIoQP
	FUJ0CklsJSBWSR6xz5iTr6D7QdG0Xaca9/pZGHugaAcLWIhe+CAa7nlf3e3MmF/8hVLR
	DPfsbYBZQn50aGR1k1/dgjlqMBrhOc/fYZl5181aUaaMM6u3B5xDYhHygV8BCwwkNr1b
	7tXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=dAioBKbwAKWQ4WfSJyy7F1Z99pFPFa3ugtcBpUnRzVc=;
	b=kdr/qjASaofDsGqKlKdc5HmuL/9ZSJktfstHJVBWavmWWRQUP98HSJgZcLXRLaGEPH
	9r2OJbiSNsnJ36LCrFhy3nV06mK1g65YnLxvCuj4gVzbK4Egw1b+N75B4VO3XPqNsnKY
	OnWiBtWsB3DjzLnwQwCpzJTcWlyoHmuANnKwE=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1490148199.16816.126.camel@edumazet-glaptop3.roam.corp.google.com>
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
	<1490148199.16816.126.camel@edumazet-glaptop3.roam.corp.google.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 22 Mar 2017 12:08:03 -0700
Message-ID: <CAGXu5jKT3So5KcKG5_BOZVtw7HtBn5-g8HpzWSSspmkczZNWTA@mail.gmail.com>
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
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Patrick McHardy <kaber@trash.net>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, Hans Liljestrand <ishkamiel@gmail.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, "Reshetova,
	Elena" <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>

On Tue, Mar 21, 2017 at 7:03 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On Tue, 2017-03-21 at 16:51 -0700, Kees Cook wrote:
>
>> Am I understanding you correctly that you'd want something like:
>>
>> refcount.h:
>> #ifdef UNPROTECTED_REFCOUNT
>> #define refcount_inc(x)   atomic_inc(x)
>> ...
>> #else
>> void refcount_inc(...
>> ...
>> #endif
>>
>> some/net.c:
>> #define UNPROTECTED_REFCOUNT
>> #include <refcount.h>
>>
>> or similar?
>
> At first, it could be something simple like that yes.
>
> Note that we might define two refcount_inc()  : One that does whole
> tests, and refcount_inc_relaxed() that might translate to atomic_inc()
> on non debug kernels.
>
> Then later, maybe provide a dynamic infrastructure so that we can
> dynamically force the full checks even for refcount_inc_relaxed() on say
> 1% of the hosts, to get better debug coverage ?

Well, this isn't about finding bugs in normal workflows. This is about
catching bugs that attackers have found and start exploiting to gain a
use-after-free primitive. The intention is for it to be always
enabled.

-Kees

-- 
Kees Cook
Pixel Security
