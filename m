Date: Fri, 1 Dec 2006 10:29:24 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061201102924.7e1045d2@freekitty>
In-Reply-To: <457061ba.3a6.7c77.1170958095@webmailh3.aruba.it>
References: <457061ba.3a6.7c77.1170958095@webmailh3.aruba.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Passing vlan tagged packets through linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: fulvio.ricciardi@zeroshell.net
Cc: bridge@lists.osdl.org

On Fri, 01 Dec 2006 18:09:14 +0100
"Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net> wrote:

> > Use an Intel pro/100 or pro/1000 driver..they are known to
> > work with VLANs.
> > 
> > I guess it's also possible that it's a problem in the
> > bridging code, so  try the latest kernel
> > as well...
> 
> I compiled the latest 2.6.19 kernel and tested it with two
> 3COM 3c905c fast ethernet interfaces which work fine with
> vlan 802.1q tagging, but when I have added the eth0 and eth1
> to br0 the bridge doesn't forward tagged packets larger than
> 1472 bytes. I remember that with older kernels (<2.6.15)
> large tagged packets was forwarded. 
> What is the problem? Any chance to have a patch?
> Thanks in advance for your answers.
>  Best Regards
>    Fulvio Ricciardi
> 


This code might be dropping it, but don't see why because it
is already checking for VLAN

net/bridge/br_forward.c

static inline unsigned packet_length(const struct sk_buff *skb)
{
	return skb->len - (skb->protocol == htons(ETH_P_8021Q) ? VLAN_HLEN : 0);
}

int br_dev_queue_push_xmit(struct sk_buff *skb)
{
	/* drop mtu oversized packets except gso */
	if (packet_length(skb) > skb->dev->mtu && !skb_is_gso(skb))
		kfree_skb(skb);

-- 
Stephen Hemminger <shemminger@osdl.org>
