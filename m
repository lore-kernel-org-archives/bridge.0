In-Reply-To: <20100330082228.2b377572@nehalam>
References: <OFC050A0FC.1BF55EDB-ONC12576F6.002669E3-C12576F6.00281EEA@transmode.se>
	<20100330082228.2b377572@nehalam>
Message-ID: <OFDE4508FF.0D82CDA9-ONC12576F6.005B5B38-C12576F6.005BCD2C@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 30 Mar 2010 18:42:43 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] [RFC patch] allow IP address on enslaved interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Bridge@lists.linux-foundation.org, Bart De Schuymer <bdschuym@pandora.be>

Stephen Hemminger <shemminger@linux-foundation.org> wrote on 2010/03/30 17:22:28:
>
> On Tue, 30 Mar 2010 09:18:13 +0200
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>
> >
> > This quick hack lets me use an IP address on an enslaved interface:
> >  #eth1 has IP 192.168.1.16
> >  brctl addbr br0
> >  brctl setfd br0 0
> >  ifconfig br0 up
> >  brctl addif br0 eth1
> >
> > After this I can use eth1 as if it was the br0 interface.
> > This obviously needs cleanup(skb->cb[42] = 99 needs to be fixed)
> > I probably broke something else too :(
> > Is this useful for someone else too?
> >
> >           Jocke
> >
> > diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> > index 1a99c4e..60d04eb 100644
> > --- a/net/bridge/br_device.c
> > +++ b/net/bridge/br_device.c
> > @@ -32,6 +32,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
> >     skb_reset_mac_header(skb);
> >     skb_pull(skb, ETH_HLEN);
> >
> > +   skb->cb[42] = 99;
> >
>
> Using skb->cb is an ugly hack and won't work if qdisc modifies.
> So sorry no.

I know(I wrote that it needed fixing) but that was the only thing I could think of at the moment.
Problem is that I need to tag the skb so I know if the bride already have seen the skb, otherwise
an endless loop occurs. Any ideas what to use instead?

Other than that, is the idea OK or is something else needed?

 Jocke

