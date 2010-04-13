Message-ID: <4BC43214.6030009@redhat.com>
Date: Tue, 13 Apr 2010 16:57:56 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
References: <20100408062234.4499.17042.sendpatchset@localhost.localdomain>	<20100408062246.4499.5670.sendpatchset@localhost.localdomain>	<20100408083710.2b61ee44@nehalam>	<4BC2F7E2.7020309@redhat.com>	<1271068737.16881.18.camel@edumazet-laptop>
	<20100412083842.26d71bda@nehalam>
In-Reply-To: <20100412083842.26d71bda@nehalam>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [Bonding-devel] [v3 Patch 2/3] bridge: make bridge
	support netpoll
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Jay Vosburgh <fubar@us.ibm.com>, Eric Dumazet <eric.dumazet@gmail.com>, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, Andy Gospodarek <gospo@redhat.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, bonding-devel@lists.sourceforge.net, Jeff Moyer <jmoyer@redhat.com>, Matt Mackall <mpm@selenic.com>, David Miller <davem@davemloft.net>

Stephen Hemminger wrote:
> On Mon, 12 Apr 2010 12:38:57 +0200
> Eric Dumazet <eric.dumazet@gmail.com> wrote:
> 
>> Le lundi 12 avril 2010 à 18:37 +0800, Cong Wang a écrit :
>>> Stephen Hemminger wrote:
>>>> There is no protection on dev->priv_flags for SMP access.
>>>> It would better bit value in dev->state if you are using it as control flag.
>>>>
>>>> Then you could use 
>>>> 			if (unlikely(test_and_clear_bit(__IN_NETPOLL, &skb->dev->state)))
>>>> 				netpoll_send_skb(...)
>>>>
>>>>
>>> Hmm, I think we can't use ->state here, it is not for this kind of purpose,
>>> according to its comments.
>>>
>>> Also, I find other usages of IFF_XXX flags of ->priv_flags are also using
>>> &, | to set or clear the flags. So there must be some other things preventing
>>> the race...
>> Yes, its RTNL that protects priv_flags changes, hopefully...
>>
> 
> The patch was not protecting priv_flags with RTNL.
> For example..
> 
> 
> @@ -308,7 +312,9 @@ static void netpoll_send_skb(struct netp
>  		     tries > 0; --tries) {
>  			if (__netif_tx_trylock(txq)) {
>  				if (!netif_tx_queue_stopped(txq)) {
> +					dev->priv_flags |= IFF_IN_NETPOLL;
>  					status = ops->ndo_start_xmit(skb, dev);
> +					dev->priv_flags &= ~IFF_IN_NETPOLL;
>  					if (status == NETDEV_TX_OK)
>  						txq_trans_update(txq);

Hmm, but I checked the bonding case (IFF_BONDING), it doesn't
hold rtnl_lock. Strange.

