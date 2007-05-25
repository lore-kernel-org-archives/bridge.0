Date: Fri, 25 May 2007 11:00:13 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] [BUG] Dropping fragmented IP packets within VLAN
	frames on bridge
Message-ID: <20070525110013.1d2242e8@oldman>
In-Reply-To: <20070525174925.41bd6b2e@zonk.pl>
References: <20070525081750.5ba4a411@zonk.pl>
	<20070525085947.12841835@freepuppy>
	<20070525174925.41bd6b2e@zonk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Adam Osuchowski <adwol@zonk.pl>
Cc: bridge@lists.linux-foundation.org

On Fri, 25 May 2007 19:49:25 +0200
Adam Osuchowski <adwol@zonk.pl> wrote:

> Stephen Hemminger wrote:
> > It would be better to account for the tag in the length check.
> > Something like
> > 	if (skb->protocol == htons(ETH_P_IP) &&
> > 	    skb->len > skb->dev->mtu - (IS_VLAN_IP(skb) ? VLAN_HLEN : 0) &&
> > 	    !skb_is_gso(skb))
> > 		return ip_fragment ...
> 
> It isn't good solution because one of IS_VLAN_IP() necessary condition is
> 
>     skb->protocol == htons(ETH_P_8021Q)
> 
> which is, of course, mutually exclusive with
> 
>     skb->protocol == htons(ETH_P_IP)
> 
> from br_nf_dev_queue_xmit(). IMHO, one should check length of ETH_P_IP
> and ETH_P_8021Q frames separately:
> 
>     if (((skb->protocol == htons(ETH_P_IP) && skb->len > skb->dev->mtu) ||
>         (IS_VLAN_IP(skb) && skb->len > skb->dev->mtu - VLAN_HLEN)) &&
> 	!skb_is_gso(skb))
> 	    return ip_fragment ...

There is a function in br_forward.c that handles VLAN packet length
maybe use that
