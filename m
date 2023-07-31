Return-Path: <horms@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A89E40C1F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE35A41479
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1690830438;
 bh=nmClbRXgHNUMiULKcf/Jk+DyC9Yg7VyUEy4VtDl2IjU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qNrewbNAX17gBaT9Awc7kLxyeODJt9zjauiKu558BxEajhl+UBhYRZwqRx6cWeHYn
 /zuVvbQaNBiuopq/kD+gx3SiMgrrB4MgcqFzkwka4tmMi/XAbA2FIpu1zJo3jHGMFS
 jhyimOaJ5FACsZvRjzfBSFnEPlg+YWjqbMAHWa9UE/JGz7oIMYGNYBV6v2pi6RxtNy
 TeakImoXcXW120Qu2jjSuApH00LkcbYkihQNLUz9k0og5rn3y7lNctSODiL9scopmi
 iB0tVmAKbMsbEb2SJqgvXUVTq2OVJTiNE9RZH6YtQ8C4wGrxz5CbDS2228aNpuQVLk
 0MIPw+3+S2ZKg==
Date: Mon, 31 Jul 2023 21:07:06 +0200
From: Simon Horman <horms@kernel.org>
Message-ID: <ZMgGWm4sT+VqDZ3u@kernel.org>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <20230731071728.3493794-4-j.granados@samsung.com>
 <ZMf9vZpGE98oM9W2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMf9vZpGE98oM9W2@kernel.org>
Subject: Re: [Bridge] [PATCH v2 03/14] sysctl: Add ctl_table_size to
	ctl_table_header
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joel Granados <joel.granados@gmail.com>
Cc: Joel Granados <j.granados@samsung.com>, Wen Gu <guwen@linux.alibaba.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Catalin Marinas <catalin.marinas@arm.com>, Nikolay Aleksandrov <razor@blackwall.org>, Alexander Aring <alex.aring@gmail.com>, linux-sctp@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, Jan Karcher <jaka@linux.ibm.com>, Mat Martineau <martineau@kernel.org>, Will Deacon <will@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Steffen Klassert <steffen.klassert@secunet.com>, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Xin Long <lucien.xin@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-rdma@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>, bridge@lists.linux-foundation.org, willy@infradead.org, Jozsef Kadlecsik <kadlec@netfilter.org>, lvs-devel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, coreteam@netfilter.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joerg Reuter <jreuter@yaina.de>, Christian Borntraeger <borntraeger@linux.ibm.com>, Kees Cook <keescook@chromium.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, josh@joshtriplett.org, Wenjia Zhang <wenjia@linux.ibm.com>, Simon Horman <horms@verge.net.au>, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Iurii Zaikin <yzaikin@google.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, mcgrof@kernel.org, netfilter-devel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, linux-wpan@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>

On Mon, Jul 31, 2023 at 08:30:34PM +0200, Simon Horman wrote:
> On Mon, Jul 31, 2023 at 09:17:17AM +0200, Joel Granados wrote:
> > The new ctl_table_size element will hold the size of the ctl_table
> > arrays contained in the ctl_table_header. This value should eventually
> > be passed by the callers to the sysctl register infrastructure. And
> > while this commit introduces the variable, it does not set nor use it
> > because that requires case by case considerations for each caller.
> > 
> > It provides two important things: (1) A place to put the
> > result of the ctl_table array calculation when it gets introduced for
> > each caller. And (2) the size that will be used as the additional
> > stopping criteria in the list_for_each_table_entry macro (to be added
> > when all the callers are migrated)
> > 
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > ---
> >  include/linux/sysctl.h | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> > index 59d451f455bf..33252ad58ebe 100644
> > --- a/include/linux/sysctl.h
> > +++ b/include/linux/sysctl.h
> > @@ -159,12 +159,22 @@ struct ctl_node {
> >  	struct ctl_table_header *header;
> >  };
> >  
> > -/* struct ctl_table_header is used to maintain dynamic lists of
> > -   struct ctl_table trees. */
> > +/**
> > + * struct ctl_table_header - maintains dynamic lists of struct ctl_table trees
> > + * @ctl_table: pointer to the first element in ctl_table array
> > + * @ctl_table_size: number of elements pointed by @ctl_table
> > + * @used: The entry will never be touched when equal to 0.
> > + * @count: Upped every time something is added to @inodes and downed every time
> > + *         something is removed from inodes
> > + * @nreg: When nreg drops to 0 the ctl_table_header will be unregistered.
> > + * @rcu: Delays the freeing of the inode. Introduced with "unfuck proc_sysctl ->d_compare()"
> > + *
> > + */
> 
> Hi Joel,
> 
> Please consider also adding kernel doc entries for the other fields of
> struct ctl_table_header. According to ./scripts/kernel-doc -none
> they are:
> 
>   unregistering
>   ctl_table_arg
>   root
>   set
>   parent
>   node
>   inodes

Sorry, I now realise that I made the same comment on v1.
And I didn't see your response to that until after I wrote the above.

> 
> 
> >  struct ctl_table_header {
> >  	union {
> >  		struct {
> >  			struct ctl_table *ctl_table;
> > +			int ctl_table_size;
> >  			int used;
> >  			int count;
> >  			int nreg;
> > -- 
> > 2.30.2
> > 
