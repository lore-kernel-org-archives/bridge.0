From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <4BC2F7E2.7020309@redhat.com>
References: <20100408062234.4499.17042.sendpatchset@localhost.localdomain>
	<20100408062246.4499.5670.sendpatchset@localhost.localdomain>
	<20100408083710.2b61ee44@nehalam>  <4BC2F7E2.7020309@redhat.com>
Content-Type: text/plain; charset="utf-8"
Date: Mon, 12 Apr 2010 12:38:57 +0200
Message-ID: <1271068737.16881.18.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [v3 Patch 2/3] bridge: make bridge support netpoll
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: Jay Vosburgh <fubar@us.ibm.com>, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, Matt Mackall <mpm@selenic.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Jeff Moyer <jmoyer@redhat.com>, Andy Gospodarek <gospo@redhat.com>, bonding-devel@lists.sourceforge.net

Le lundi 12 avril 2010 à 18:37 +0800, Cong Wang a écrit :
> Stephen Hemminger wrote:
> > There is no protection on dev->priv_flags for SMP access.
> > It would better bit value in dev->state if you are using it as control flag.
> > 
> > Then you could use 
> > 			if (unlikely(test_and_clear_bit(__IN_NETPOLL, &skb->dev->state)))
> > 				netpoll_send_skb(...)
> > 
> > 
> 
> Hmm, I think we can't use ->state here, it is not for this kind of purpose,
> according to its comments.
> 
> Also, I find other usages of IFF_XXX flags of ->priv_flags are also using
> &, | to set or clear the flags. So there must be some other things preventing
> the race...

Yes, its RTNL that protects priv_flags changes, hopefully...


