Return-Path: <shakeelb@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=nRuzp0vI0flryI3MP5+vDJIF6vIrlB4Ktla0xA64B1Y=;
	b=P9PpFd3n7HFykVrlxL8ZDNljuAJ/n4gopOyvWY6bWuAMNKTRC8Xro/HUuAj2m+8Q+w
	tvTGTCrHEGsoSaFRZnR4jBBwCl5W5K+Jcap4iSOC29bEZeTvAQeh6LpUcYZt9UWRUDm/
	V07rtj1AARtUg4eJR1vZueQaNHE4PmTrtxvpLUb+Dx8b+DyI4KocCEC9E6gNMqfUKw2P
	ynAQgrWxWdMUZcFyR2dN+CkU7mHx40FNdy8gVu5iDVUfsUETVMEdbQunpaRdXfKb0KFs
	FmMikP6SYycVjla6fgf5S4WLb0KQsEnOPCXZ737utsNhrdzo1HfuovNeWa7cawc386Kl
	mgqw==
MIME-Version: 1.0
References: <20190103031431.247970-1-shakeelb@google.com>
	<313C6566-289D-4973-BB15-857EED858DA3@oracle.com>
In-Reply-To: <313C6566-289D-4973-BB15-857EED858DA3@oracle.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 3 Jan 2019 08:18:09 -0800
Message-ID: <CALvZod5YSKZvWq13ptbfignECxLVH5H_1YbdvoghrmicuDwuSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH v2] netfilter: account ebt_table_info to kmemcg
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: William Kucharski <william.kucharski@oracle.com>
Cc: coreteam@netfilter.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>, Kirill Tkhai <ktkhai@virtuozzo.com>, netfilter-devel@vger.kernel.org, syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Andrew Morton <akpm@linux-foundation.org>, Pablo Neira Ayuso <pablo@netfilter.org>

On Thu, Jan 3, 2019 at 2:15 AM William Kucharski
<william.kucharski@oracle.com> wrote:
>
>
>
> > On Jan 2, 2019, at 8:14 PM, Shakeel Butt <shakeelb@google.com> wrote:
> >
> >       countersize = COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
> > -     newinfo = vmalloc(sizeof(*newinfo) + countersize);
> > +     newinfo = __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUNT,
> > +                         PAGE_KERNEL);
> >       if (!newinfo)
> >               return -ENOMEM;
> >
> >       if (countersize)
> >               memset(newinfo->counters, 0, countersize);
> >
> > -     newinfo->entries = vmalloc(tmp.entries_size);
> > +     newinfo->entries = __vmalloc(tmp.entries_size, GFP_KERNEL_ACCOUNT,
> > +                                  PAGE_KERNEL);
> >       if (!newinfo->entries) {
> >               ret = -ENOMEM;
> >               goto free_newinfo;
> > --
>
> Just out of curiosity, what are the actual sizes of these areas in typical use
> given __vmalloc() will be allocating by the page?
>

We don't really use this in production, so, I don't have a good idea
of the size in the typical case. The size depends on the workload. The
motivation behind this patch was the system OOM triggered by a syzbot
running in a restricted memcg.

Shakeel
