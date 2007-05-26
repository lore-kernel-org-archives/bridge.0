From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [Bridge] [BUG] Dropping fragmented IP packets within VLAN frames
	on bridge
Date: Sat, 26 May 2007 16:20:59 +0200
References: <20070525081750.5ba4a411@zonk.pl>
	<20070525174925.41bd6b2e@zonk.pl> <4657EC24.1030407@trash.net>
In-Reply-To: <4657EC24.1030407@trash.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705261621.00385.ioe-lkml@rameria.de>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick McHardy <kaber@trash.net>
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On Saturday 26 May 2007, Patrick McHardy wrote:
> Adam Osuchowski wrote:
> >     if (((skb->protocol == htons(ETH_P_IP) && skb->len > skb->dev->mtu) ||
> >         (IS_VLAN_IP(skb) && skb->len > skb->dev->mtu - VLAN_HLEN)) &&
> > 	!skb_is_gso(skb))
> > 	    return ip_fragment ...
> 
> 
> net/8021q ignores the VLAN header overhead, so we should probably do the
> same here for consistency. Using IS_VLAN_IP (and IS_PPPOE_IP for current
> -rc) looks fine, additionally we should probably also check for
> skb->nfct != NULL to make sure that at least without connection tracking
> the bridge doesn't perform fragmentation.

And could we separe the conditions for that into a static helper function
explaining each of these conditions? e.g. sth. like that:

static bool br_nf_need_fragment(struct sk_buff *skb)
{
	/* Plain IP packet does not fit in MTU */
	if (!(skb->protocol == htons(ETH_P_IP) && skb->len > skb->dev->mtu))
		return true;

	/* VLAN encapsulated IP packet does not fit in MTU */
	if (IS_VLAN_IP(skb) && skb->len > skb->dev->mtu - VLAN_HLEN)
		return true;

	/* PPPoE encapsulated IP packet does not fit in MTU */
	if (IS_PPPOE_IP(skb) && skb->len > skb->dev->mtu - PPPOE_SES_HLEN)
		return true;

	return false;
}

and then br_nf_dev_queue_xmit() becomes:

static int br_nf_dev_queue_xmit(struct sk_buff *skb)
{
        if (br_nf_need_fragment(skb) &&  !skb_is_gso(skb))
                return ip_fragment(skb, br_dev_queue_push_xmit);
        else
                return br_dev_queue_push_xmit(skb);
}

which is much more readable, more documented and doesn't contain a condition monster :-)

@Patrick: Could you check, wether the PPPoE case is correct?

What do you think? Should I submit a patch for that?


Best Regards

Ingo Oeser
