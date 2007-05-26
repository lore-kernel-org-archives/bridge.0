Message-ID: <4657EC24.1030407@trash.net>
Date: Sat, 26 May 2007 10:13:24 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
Subject: Re: [Bridge] [BUG] Dropping fragmented IP packets within VLAN frames
	on bridge
References: <20070525081750.5ba4a411@zonk.pl>	<20070525085947.12841835@freepuppy>
	<20070525174925.41bd6b2e@zonk.pl>
In-Reply-To: <20070525174925.41bd6b2e@zonk.pl>
Content-Type: text/plain; charset=ISO-8859-15
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
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Adam Osuchowski wrote:
> Stephen Hemminger wrote:
> 
>>It would be better to account for the tag in the length check.
>>Something like
>>	if (skb->protocol == htons(ETH_P_IP) &&
>>	    skb->len > skb->dev->mtu - (IS_VLAN_IP(skb) ? VLAN_HLEN : 0) &&
>>	    !skb_is_gso(skb))
>>		return ip_fragment ...
> 
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


net/8021q ignores the VLAN header overhead, so we should probably do the
same here for consistency. Using IS_VLAN_IP (and IS_PPPOE_IP for current
-rc) looks fine, additionally we should probably also check for
skb->nfct != NULL to make sure that at least without connection tracking
the bridge doesn't perform fragmentation.

