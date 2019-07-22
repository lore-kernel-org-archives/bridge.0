Return-Path: <wenwen@cs.uga.edu>
MIME-Version: 1.0
References: <1563625366-3602-1-git-send-email-wang6495@umn.edu>
	<20190722123204.rvsqlqgynfgjcif7@oracle.com>
In-Reply-To: <20190722123204.rvsqlqgynfgjcif7@oracle.com>
From: Wenwen Wang <wenwen@cs.uga.edu>
Date: Mon, 22 Jul 2019 07:53:59 -0500
Message-ID: <CAAa=b7cwJ-2wPNtH_j6saHiUWRj7zSwzZ8sGPWfgG9AyxWrOPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH] netfilter: ebtables: compat: fix a memory leak
	bug
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Wenwen Wang <wenwen@cs.uga.edu>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, "open list:ETHERNET BRIDGE" <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Florian Westphal <fw@strlen.de>, open list <linux-kernel@vger.kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, "open list:NETFILTER" <coreteam@netfilter.org>, "open list:NETFILTER" <netfilter-devel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

On Mon, Jul 22, 2019 at 7:34 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> Nice catch.  The code that exists is confusing due to newinfo->entries
> being overwritten and then freed in the existing code path as you state
> in your commit log.
>
> * Wenwen Wang <wang6495@umn.edu> [190720 08:23]:
> > From: Wenwen Wang <wenwen@cs.uga.edu>
> >
> > In compat_do_replace(), a temporary buffer is allocated through vmalloc()
> > to hold entries copied from the user space. The buffer address is firstly
> > saved to 'newinfo->entries', and later on assigned to 'entries_tmp'. Then
> > the entries in this temporary buffer is copied to the internal kernel
> > structure through compat_copy_entries(). If this copy process fails,
> > compat_do_replace() should be terminated. However, the allocated temporary
> > buffer is not freed on this path, leading to a memory leak.
> >
> > To fix the bug, free the buffer before returning from compat_do_replace().
> >
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> > ---
> >  net/bridge/netfilter/ebtables.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
> > index 963dfdc..fd84b48e 100644
> > --- a/net/bridge/netfilter/ebtables.c
> > +++ b/net/bridge/netfilter/ebtables.c
> > @@ -2261,8 +2261,10 @@ static int compat_do_replace(struct net *net, void __user *user,
> >       state.buf_kern_len = size64;
> >
> >       ret = compat_copy_entries(entries_tmp, tmp.entries_size, &state);
> > -     if (WARN_ON(ret < 0))
> > +     if (WARN_ON(ret < 0)) {
> > +             vfree(entries_tmp);
> >               goto out_unlock;
> > +     }
>
>
> Would it be worth adding a new goto label above out_unlock and free this
> entries_tmp?  It could then be used in previous failure path as well.

Yes, that would make the code much clearer and easier to understand.

Thanks!
Wenwen
