Message-ID: <5B537508CDBED3118403009027745A210B8C14A1@knant18.kna.flextronics.com>
From: Christian Darnell <Christian.Darnell@se.flextronics.com>
Subject: RE: [Bridge] RE: [VLAN] Re: [PATCH/RFC] Let {ip, arp}tables "see"
	bridged VLAN tagged{I,AR}P packets
Date: Wed, 8 Oct 2003 10:18:26 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Tommy Christensen' <tommy.christensen@tpack.net>
Cc: netdev@oss.sgi.com, "'Linux 802.1Q VLAN'" <vlan@wanfear.com>, Bart De Schuymer <bdschuym@pandora.be>, bridge <bridge@osdl.org>


-----Original Message-----
>From: Tommy Christensen [mailto:tommy.christensen@tpack.net]
>Sent: Wednesday, October 08, 2003 10:09 AM
>To: Christian Darnell
>Cc: 'Linux 802.1Q VLAN'; Bart De Schuymer; netdev@oss.sgi.com; bridge
>Subject: Re: [Bridge] RE: [VLAN] Re: [PATCH/RFC] Let {ip, arp}tables
>"see" bridged VLAN tagged{I,AR}P packets
>
>
>
>This is because the VLAN code is mangling shared data.
>You need to do something like this:
>
>
>--- linux-2.4/net/8021q/vlan_dev.c.org	2003-02-25 15:23:09.000000000
>+0100
>+++ linux-2.4/net/8021q/vlan_dev.c	2003-10-07 16:01:29.000000000 +0200
>@@ -75,7 +75,12 @@
> static inline struct sk_buff *vlan_check_reorder_header(struct sk_buff
>*skb)
> {
> 	if (VLAN_DEV_INFO(skb->dev)->flags & 1) {
>-		skb = skb_share_check(skb, GFP_ATOMIC);
>+		if (skb_shared(skb) || skb_cloned(skb)) {
>+			struct sk_buff *nskb;
>+			nskb = skb_copy(skb, GFP_ATOMIC);
>+			kfree_skb(skb);
>+			skb = nskb;
>+		}
> 		if (skb) {
> 			/* Lifted from Gleb's VLAN code... */
> 			memmove(skb->data - ETH_HLEN,
>
>
>Christian, could you try this out?


Thanks Tommy! I tried this (on kernel 2.4.22) and it works great!


Best Regards, 

Christian Darnell
