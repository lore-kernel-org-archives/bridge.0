Date: Mon, 30 Jul 2007 18:11:37 +0100
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] VLAN header accounting for packets leaving bridge
Message-ID: <20070730181137.2bf6a4e8@oldman>
In-Reply-To: <46AE1668.9070804@schaus.ca>
References: <46AE1668.9070804@schaus.ca>
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
To: Cameron Schaus <cam@schaus.ca>
Cc: bridge@linux-foundation.org

On Mon, 30 Jul 2007 10:48:40 -0600
Cameron Schaus <cam@schaus.ca> wrote:

> I have been working on an ebtables module to insert an 802.1Q (VLAN) 
> tags into network packets leaving the bridge, via the POSTROUTING NAT 
> chain.  To insert the VLAN tag the ethernet header size needs to be 
> increased by 4 bytes.  I noticed that after increasing the size of the 
> ethernet header that the ethernet header in packets on the wire was 
> incorrect.
> 
> I think it is because the br_dev_queue_push_xmit function does not take 
> the VLAN header into account when it moves the data pointer in the skb 
> to the start of the ethernet header.  The following patch corrects this.
> 
> Does this make sense to do?  I plan to do more extensive testing passing 
> vlan and non-vlan traffic across a bridge, and will report back with the 
> results.
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index ada7f49..f30dc56 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -43,6 +43,8 @@ int br_dev_queue_push_xmit(struct sk_buff *skb)
>                        kfree_skb(skb);
>                else {
>                        skb_push(skb, ETH_HLEN);
> +                       if(skb->protocol == htons(ETH_P_8021Q))
> +                         skb_push(skb, VLAN_HLEN);
> 
>                        dev_queue_xmit(skb);
>                }
>

This might break VLAN transparent bridging (ie. when eth0 is bridged to eth1
and the bridge doesn't know or care about vlan's). There is also the case
where packet comes in over VLAN and goes out without tag.
