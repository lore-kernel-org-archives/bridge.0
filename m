Return-Path: <shakeelb@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=sBBN2mphyXf7II5d9cbYV+3gNH1blN+Ub//bXMWso6o=;
	b=IeK8dGvyQFN1k5SZbplWXk3V0SIzw9j2rmL9koMjC7iv+qPVeovSwAMzOdqgUS3Kcl
	//2YwH0lVSrhCJlRATLtfOrcdYoOQHC3jCT3jFt2UZJaa/3FlOQ95FC5UUiwBan0RacU
	LDnWYlyPEXx2bKploZ3oYHeihW3luV6f0+VKJlrn5CUw8gRkUGdGIrzEgrOYTU7byRpv
	Tu7gL96vgYK3WtV5ssyHpNNKjTtTtWOBOqf10+WcS0fii4X3P4JFJG2+QhEphYoY5Tn2
	6x4aeFCKX0ZWcD5CaemqpzJCKLptsuukhgC65wMqmM9tsYdi1xliAQyTvqCzmiG9rqoc
	CRLQ==
MIME-Version: 1.0
References: <20181229015524.222741-1-shakeelb@google.com>
	<20181229073325.GZ16738@dhcp22.suse.cz>
	<7c0fa75f-df2f-668e-ebc2-3d3e9831030f@virtuozzo.com>
In-Reply-To: <7c0fa75f-df2f-668e-ebc2-3d3e9831030f@virtuozzo.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Sat, 29 Dec 2018 11:39:06 -0800
Message-ID: <CALvZod5FxsHk9UFvDewoVftWU0AB=1JJCEgd6B-5np1CrXwRvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH] netfilter: account ebt_table_info to kmemcg
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Andrew Morton <akpm@linux-foundation.org>, Pablo Neira Ayuso <pablo@netfilter.org>

Hi Kirill,

On Sat, Dec 29, 2018 at 1:52 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> Hi, Michal!
>
> On 29.12.2018 10:33, Michal Hocko wrote:
> > On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
> >> The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> >> memory is already accounted to kmemcg. Do the same for ebtables. The
> >> syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> >> whole system from a restricted memcg, a potential DoS.
> >
> > What is the lifetime of these objects? Are they bound to any process?
>
> These are list of ebtables rules, which may be displayed with $ebtables-save command.
> In case of we do not account them, a low priority container may eat all the memory
> and OOM killer in berserk mode will kill all the processes on machine. They are not bound
> to any process, but they are bound to network namespace.
>
> OOM killer does not analyze such the memory cgroup-related allocations, since it
> is task-aware only. Maybe we should do it namespace-aware too...

This is a good idea. I am already brainstorming on a somewhat similar
idea to make shmem/tmpfs files oom-killable. I will share once I have
something more concrete and will think on namespace angle too.

thanks,
Shakeel
