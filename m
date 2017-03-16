Return-Path: <keescook@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=vmCYz3imhkOxt0ona3TrMXgnE0qriIjH7P7O+Ded8+8=;
	b=Xvm+eYEowtcTImlBaXWvRhk2MZKGK77+4jCDWXuRGWo7cL6JM96Awvh1/teMi+53Ho
	hUazfQfvT8VHUlEP0Jh6DNy1zt2nxrNuBtcsC0OP+zTBX8Gd+sFdGH4yvJeCKbTnf1Z4
	U1eQ7RvE56ar1F0Wh03SUk8QIaXo5KbBzGunsTxzr0JZkdFKRaJYI9OzudC/amRPx97N
	s0/ZbVhVtppkjyx0hbWrGiyWyE0srEee1JBRS6DIlU4F+0KL9OkTZjmKb4HEyeT27tkm
	Q/W4qaOSLQqjqrGMIGtaSgfk7eEfxVifKXIiaoWXCPXIH8mfrO4z3WKd3ZzdJxORG5XF
	QK9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=vmCYz3imhkOxt0ona3TrMXgnE0qriIjH7P7O+Ded8+8=;
	b=Wf0dWesINUlftA9ilnuZejjFSHLqYH+g+TasaDmXYR5twDjw4y0R/ebFN7I4t3Nur6
	9MnEas+AE5EQqPIjitQvSedGgAVchkfVfJk/ufPkTL95/6YIOxTNR2Y1VLcs8B9VY3KM
	B3nq+YNZQC+zUsFGVR8mAqVFiOdTiZuMo0KEQ=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1489683534.28631.231.camel@edumazet-glaptop3.roam.corp.google.com>
References: <1489678147-21404-1-git-send-email-elena.reshetova@intel.com>
	<1489678147-21404-8-git-send-email-elena.reshetova@intel.com>
	<1489683534.28631.231.camel@edumazet-glaptop3.roam.corp.google.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 16 Mar 2017 11:38:25 -0600
Message-ID: <CAGXu5jJpFwiDR_o=oarN_2vDr56cwQ=Bg-5NikUmDtxtzWnAcQ@mail.gmail.com>
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
To: Eric Dumazet <eric.dumazet@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Network Development <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>, Hans Liljestrand <ishkamiel@gmail.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Patrick McHardy <kaber@trash.net>, Elena Reshetova <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>

On Thu, Mar 16, 2017 at 10:58 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On Thu, 2017-03-16 at 17:28 +0200, Elena Reshetova wrote:
>> refcount_t type and corresponding API should be
>> used instead of atomic_t when the variable is used as
>> a reference counter. This allows to avoid accidental
>> refcounter overflows that might lead to use-after-free
>> situations.
>
>
> ...
>
>>  static __always_inline void sock_hold(struct sock *sk)
>>  {
>> -     atomic_inc(&sk->sk_refcnt);
>> +     refcount_inc(&sk->sk_refcnt);
>>  }
>>
>
> While I certainly see the value of these refcount_t, we have a very
> different behavior on these atomic_inc() which were doing a single
> inlined LOCK RMW on x86.

I think we can certainly investigate arch-specific ways to improve the
performance, but the consensus seemed to be that getting the
infrastructure in and doing the migration was the first set of steps.

> We now call an external function performing a
> atomic_read(), various ops/tests, then atomic_cmpxchg_relaxed(), in a
> loop, loosing the nice ability for x86 of preventing live locks.
>
> Looks a lot of bloat, just to be able to chase hypothetical bugs in the
> kernel.
>
> I would love to have a way to enable extra debugging when I want a debug
> kernel, like LOCKDEP or KASAN.
>
> By adding all this bloat, we assert linux kernel is terminally buggy and
> every atomic_inc() we did was suspicious, and need to be always
> instrumented/validated.

This IS the assertion, unfortunately. With average 5 year lifetimes on
security flaws[1], and many of the last couple years' public exploits
being refcount flaws[2], this is something we have to get done. We
need the default kernel to be much more self-protective, and this is
one of many places to make it happen.

I am, of course, biased, but I think the evidence of actual
refcounting attacks outweighs the theoretical performance cost of
these changes. If there is a realistic workflow that shows actual
problems, let's examine it and find a solution for that as a separate
part of this work without blocking this migration.

-Kees

[1] https://outflux.net/blog/archives/2016/10/18/security-bug-lifetime/
[2] http://kernsec.org/wiki/index.php/Bug_Classes/Integer_overflow

-- 
Kees Cook
Pixel Security
