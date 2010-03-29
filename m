In-Reply-To: <4BB05AE7.10905@pandora.be>
References: <OFB9EFBBE7.11608167-ONC12576F1.005B0C79-C12576F1.005BBE51@transmode.se>	<OF55692ECA.4BA1B52C-ONC12576F1.006BA68C-C12576F1.007010C8@transmode.se>
	<4BABCF8A.3040701@free.fr>	<OFDD80C4DC.137F4F61-ONC12576F2.002B1EE4-C12576F2.002B7EA6@transmode.se>
	<4BAD1B85.6020807@free.fr>	<OFC6D98D54.CA7D4A8D-ONC12576F2.007212B2-C12576F2.00725708@transmode.se>
	<2e59e6971003261442g77365b55sa624fe184e5003ac@mail.gmail.com>	<OFCA30CFD8.BFEED34E-ONC12576F3.003AD4F7-C12576F3.003B8B77@transmode.se>
	<20100327201752.51b6f7ad@nehalam> <4BAF5034.5060100@pandora.be>
	<OFDC6DBFAF.3C46B16B-ONC12576F4.00654457-C12576F4.00655D53@LocalDomain>
	<OF59D1A758.6E7DFF8C-ONC12576F4.0068613D-C12576F4.0068C11D@LocalDomain>
	<OF66063C34.9F68251B-ONC12576F5.0025FFA1-C12576F
	<4BB05AE7.10905@pandora.be>
Message-ID: <OF35408968.E095E27C-ONC12576F5.002CCCB7-C12576F5.002F190B@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 29 Mar 2010 10:34:26 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] IP address on physcial interface instead of bridge
	interface?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: bridge@lists.linux-foundation.org

Bart De Schuymer <bdschuym@pandora.be> wrote on 2010/03/29 09:46:47:
>
> Joakim Tjernlund wrote:
> > Joakim Tjernlund/Transmode wrote on 2010/03/28 21:04:11:
> >> Joakim Tjernlund/Transmode wrote on 2010/03/28 20:27:10:
> >>> Bart De Schuymer <bdschuym@pandora.be> wrote on 2010/03/28 14:48:52:
> >>>> Stephen Hemminger schreef:
> >>>>> If you read the network receive code path in the kernel, you
> >>>>> will see that there is a special hook used. Basically,
> >>>>>
> >>>>>   if received_interface_is_part_of_bridge(incoming_interface)
> >>>>>   then process_bridged_packet(packet)
> >>>>>
> >>>>> Then bridge looks at packet and decides whether it is local or forwarded.
> >>>>> The problem is with your application if it wants to use eth0 directly.
> >>>>>
> >>>>>
> >>>> The ebtables brouting chain was designed to enable you to do this.
> >>> Can you give me an example?
> >> Found this on the net:
> >> ebtables -t broute -A BROUTING -p 0800  -i eth1 --ip-dst 192.168.1.16 -j DROP
> >> ebtables -t broute -A BROUTING -p 0806  -i eth1 -d 00:06:9C:00:B2:FB -j DROP
> >> ebtables -t broute -A BROUTING -p 0806  -i eth1 --arp-ip-dst 192.168.1.16 -j DROP
> >>
> >> 192.168.1.16 and 00:06:9C:00:B2:FB are the IP and MAC addresses of eth1.
> >>
> >> Then add eth1 to the bridge and it appears to be working as I want.
> >> Are there any "gotcha's" with this method?
> >
> > What about other protocols such as pppoe and OSPF, will these work over eth1 too?
> > Are outgoing pkgs from the host bridged or just sent out over eth1?
> >
> >     Jocke
>
> The ebtables rules in the brouting chain see all traffic arriving on the
> bridge port (currently unless the port is in learning state). So as long
> as your setup is correct it should work with pppoe and OSPF too.

Ah good. So the outgoing traffic will go out over the bridge port too and
thereby be bridged?

Still I wonder about OSPF. This protocol sends pks to multicast IP address
224.0.0.5/6 so how are these picked up by the broute rule?

How is pppoe picked up by the broute rule? The ethertype is different from ipv4
so I don't understand how it manages to do that.

> I already mailed you and the list on 26/03, but that message seems to
> have been ignored by Stephen and you. The message describes the temporal
> loss of connectivity when the bridge brought up and the bridge port is
> in learning state. As mentioned, this is easily fixed with the simple
> patch (in attachment).

Sorry, but I am not familiar enough with the bride code to comment on that.
It is better if Stephen does that who knows the code/function of the bridge much
better than I do.

> <quote>
> Unfortunately this is impossible in the current bridge implementation
> without temporarily losing connectivity because the ebtables BROUTING
> chain isn't traversed while the bridge port is in learning state. But
> with the patch below, the following scenario works without loss of
> connectivity:
> # (Suppose the bridge isn't configured yet)
> ifconfig eth0 $IP
> # (the routing table should be correct now, if not you need to do it
> yourself)
> # (the ebtables rules below will be effective once br0 is up)
> # direct local IP traffic to eth0
> ebtables -t broute -A BROUTING -p ipv4 -i eth0 --ip-dst $IP -j DROP
> # direct arp replies for $MAC_OF_ETH0 to eth0
> ebtables -t broute -A BROUTING -p arp -i eth0 -d $MAC_OF_ETH0 -j DROP
> # direct arp requests for $IP to eth0
> ebtables -t broute -A BROUTING -p arp -i eth0 --arp-ip-dst $IP -j DROP
> brctl addbr br0
> # make sure to bring br0 up before adding the interface
> ifconfig br0 up
> brctl addif br0 eth0
>
> If you don't mind loss of connectivity while the bridge port is in
> learning state, you don't need the patch.
> </quote>
>
>
> --
> Bart De Schuymer
> www.artinalgorithms.be
> --- linux-2.6.33/net/bridge/br_input.c   2010-02-24 19:52:17.000000000 +0100
> +++ linux-2.6.33-uml/net/bridge/br_input.c   2010-03-26 09:21:50.000000000 +0100
> @@ -148,14 +148,13 @@ struct sk_buff *br_handle_frame(struct n
>  forward:
>     switch (p->state) {
>     case BR_STATE_FORWARDING:
> +   case BR_STATE_LEARNING:
>        rhook = rcu_dereference(br_should_route_hook);
>        if (rhook != NULL) {
>           if (rhook(skb))
>              return skb;
>           dest = eth_hdr(skb)->h_dest;
>        }
> -      /* fall through */
> -   case BR_STATE_LEARNING:
>        if (!compare_ether_addr(p->br->dev->dev_addr, dest))
>           skb->pkt_type = PACKET_HOST;
>

