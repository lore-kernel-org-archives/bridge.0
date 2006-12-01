Sender: fulvio@zeroshell.net
From: "Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net>
Date: Fri, 01 Dec 2006 22:19:17 +0100
Message-id: <45709c55.376.25d.475472111@webmailh4.aruba.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [Bridge] Passing vlan tagged packets through linux bridge
Reply-To: fulvio.ricciardi@zeroshell.net
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

> > I compiled the latest 2.6.19 kernel and tested it with
> > two 3COM 3c905c fast ethernet interfaces which work fine
> > with vlan 802.1q tagging, but when I have added the eth0
> > and eth1 to br0 the bridge doesn't forward tagged
> > packets larger than 1472 bytes. I remember that with
> > older kernels (<2.6.15) large tagged packets was
> > forwarded.  What is the problem? Any chance to have a
> > patch? Thanks in advance for your answers.
> >  Best Regards
> >    Fulvio Ricciardi
> > 
> 
> 
> This code might be dropping it, but don't see why because
> it is already checking for VLAN
> 
> net/bridge/br_forward.c
> 
> static inline unsigned packet_length(const struct sk_buff
> *skb) {
>     return skb->len - (skb->protocol == htons(ETH_P_8021Q)
> ? VLAN_HLEN : 0); }
> 
> int br_dev_queue_push_xmit(struct sk_buff *skb)
> {
>     /* drop mtu oversized packets except gso */
>     if (packet_length(skb) > skb->dev->mtu &&
> !skb_is_gso(skb))
>         kfree_skb(skb);
> 
> -- 
> Stephen Hemminger <shemminger@osdl.org>

I don't think the function  br_dev_queue_push_xmit(struct
sk_buff *skb) drops the large tagged packets because the
size limit I found with the tests is 1472 bytes and not 1496
(MTU-4).

--------------------------------------------------------------------
Fulvio Ricciardi
web: http://www.zeroshell.net/eng/
skype: zeroshellnet
Phone: +3908321835630
--------------------------------------
   This Email Was brought to you by
               WebMail
    A Netwin Web Based EMail Client
  http://netwinsite.com/webmail/tag.htm
