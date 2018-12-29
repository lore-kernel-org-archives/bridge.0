Return-Path: <mhocko@kernel.org>
Date: Sat, 29 Dec 2018 11:06:15 +0100
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20181229100615.GB16738@dhcp22.suse.cz>
References: <20181229015524.222741-1-shakeelb@google.com>
	<20181229073325.GZ16738@dhcp22.suse.cz>
	<20181229095215.nbcijqacw5b6aho7@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229095215.nbcijqacw5b6aho7@breakpoint.cc>
Subject: Re: [Bridge] [PATCH] netfilter: account ebt_table_info to kmemcg
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Westphal <fw@strlen.de>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, coreteam@netfilter.org, Shakeel Butt <shakeelb@google.com>, syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, netfilter-devel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Pablo Neira Ayuso <pablo@netfilter.org>

On Sat 29-12-18 10:52:15, Florian Westphal wrote:
> Michal Hocko <mhocko@kernel.org> wrote:
> > On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
> > > The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> > > memory is already accounted to kmemcg. Do the same for ebtables. The
> > > syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> > > whole system from a restricted memcg, a potential DoS.
> > 
> > What is the lifetime of these objects? Are they bound to any process?
> 
> No, they are not.
> They are free'd only when userspace requests it or the netns is
> destroyed.

Then this is problematic, because the oom killer is not able to
guarantee the hard limit and so the excessive memory consumption cannot
be really contained. As a result the memcg will be basically useless
until somebody tears down the charged objects by other means. The memcg
oom killer will surely kill all the existing tasks in the cgroup and
this could somehow reduce the problem. Maybe this is sufficient for
some usecases but that should be properly analyzed and described in the
changelog.

-- 
Michal Hocko
SUSE Labs
