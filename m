Return-Path: <shakeelb@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=HucXhT1A5BsfCWwXDCGEmDntqGT95qD9mv34uGfHnxM=;
	b=RsuU+lvfvuTkfqdJFBT8SLdXXznzlurD/F+aInXrpFa6GSP1fSjyw9q2m3Bau5zyDI
	dbelbjh6tB6WNln9v0wEi7oYQ2qGhxKwygG0+EFT8hgVL9owteRvqjBDDIT+R80Hb5p7
	f91auxNDqrYHTqNyZdIno7sRFtGHqqvz2oqegQzfBlu+vAmNZ6IC647YOAwvgKDwimpo
	doJ7peKGizkv0XNrw6XE8DceI4Ucv6f5HjratekTiSaqsBXVe4S2Uf1iiermj/g3ZZFw
	tLmWb2exvIfMvyST/43xDhptQM90g8BqL+tHxDbTVJnT5QfAZPmj3D+oBkS9vdj80q7V
	33bA==
MIME-Version: 1.0
References: <20181229015524.222741-1-shakeelb@google.com>
	<20181229073325.GZ16738@dhcp22.suse.cz>
	<20181229095215.nbcijqacw5b6aho7@breakpoint.cc>
	<20181229100615.GB16738@dhcp22.suse.cz>
	<CALvZod7v-CC1XipLAerFj1Zp_M=qXZq6MzDL4pubJMTRCsMFNw@mail.gmail.com>
	<20181230074513.GA22445@dhcp22.suse.cz>
In-Reply-To: <20181230074513.GA22445@dhcp22.suse.cz>
From: Shakeel Butt <shakeelb@google.com>
Date: Sun, 30 Dec 2018 20:00:55 -0800
Message-ID: <CALvZod7sCXxVXwfvsR3jR8apq1BVFwv1sOinrgUfW+H5K3RJww@mail.gmail.com>
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
To: Michal Hocko <mhocko@kernel.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Andrew Morton <akpm@linux-foundation.org>, Pablo Neira Ayuso <pablo@netfilter.org>

On Sat, Dec 29, 2018 at 11:45 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sat 29-12-18 11:34:29, Shakeel Butt wrote:
> > On Sat, Dec 29, 2018 at 2:06 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Sat 29-12-18 10:52:15, Florian Westphal wrote:
> > > > Michal Hocko <mhocko@kernel.org> wrote:
> > > > > On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
> > > > > > The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> > > > > > memory is already accounted to kmemcg. Do the same for ebtables. The
> > > > > > syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> > > > > > whole system from a restricted memcg, a potential DoS.
> > > > >
> > > > > What is the lifetime of these objects? Are they bound to any process?
> > > >
> > > > No, they are not.
> > > > They are free'd only when userspace requests it or the netns is
> > > > destroyed.
> > >
> > > Then this is problematic, because the oom killer is not able to
> > > guarantee the hard limit and so the excessive memory consumption cannot
> > > be really contained. As a result the memcg will be basically useless
> > > until somebody tears down the charged objects by other means. The memcg
> > > oom killer will surely kill all the existing tasks in the cgroup and
> > > this could somehow reduce the problem. Maybe this is sufficient for
> > > some usecases but that should be properly analyzed and described in the
> > > changelog.
> > >
> >
> > Can you explain why you think the memcg hard limit will not be
> > enforced? From what I understand, the memcg oom-killer will kill the
> > allocating processes as you have mentioned. We do force charging for
> > very limited conditions but here the memcg oom-killer will take care
> > of
>
> I was talking about the force charge part. Depending on a specific
> allocation and its life time this can gradually get us over hard limit
> without any bound theoretically.
>
> > Anyways, the kernel is already charging the memory for
> > [ip,ip6,arp]_tables and this patch adds the charging for ebtables.
> > Without this patch, as Kirill has described and shown by syzbot, a low
> > priority memcg can force system OOM.
>
> I am not opposing the patch per-se. I would just like the changelog to
> be more descriptive about the life time and consequences.
> --

I will resend the patch with more detailed change log.

thanks,
Shakeel
