In-Reply-To: <OFDC6DBFAF.3C46B16B-ONC12576F4.00654457-C12576F4.00655D53@LocalDomain>
References: <OFB9EFBBE7.11608167-ONC12576F1.005B0C79-C12576F1.005BBE51@transmode.se>	<2e59e6971003251003g34f45ccsf7feecbcb2d68cbf@mail.gmail.com>
	<OF55692ECA.4BA1B52C-ONC12576F1.006BA68C-C12576F1.007010C8@transmode.se>	<4BABCF8A.3040701@free.fr>
	<OFDD80C4DC.137F4F61-ONC12576F2.002B1EE4-C12576F2.002B7EA6@transmode.se>	<4BAD1B85.6020807@free.fr>
	<OFC6D98D54.CA7D4A8D-ONC12576F2.007212B2-C12576F2.00725708@transmode.se>	<2e59e6971003261442g77365b55sa624fe184e5003ac@mail.gmail.com>
	<OFCA30CFD8.BFEED34E-ONC12576F3.003AD4F7-C12576F3.003B8B77@transmode.se>
	<20100327201752.51b6f7ad@nehalam> <4BAF5034.5060100@pandora.be>
	<OFDC6DBFAF.3C46B16B-ONC12576F4.00654457-C12576F4.00655D53@LocalDomain>
Message-ID: <OF59D1A758.6E7DFF8C-ONC12576F4.0068613D-C12576F4.0068C11D@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sun, 28 Mar 2010 21:04:11 +0200
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
Cc: bridge@lists.linux-foundation.org, Bart De Schuymer <bdschuym@pandora.be>

Joakim Tjernlund/Transmode wrote on 2010/03/28 20:27:10:
>
> Bart De Schuymer <bdschuym@pandora.be> wrote on 2010/03/28 14:48:52:
> >
> > Stephen Hemminger schreef:
> > >
> > > If you read the network receive code path in the kernel, you
> > > will see that there is a special hook used. Basically,
> > >
> > >   if received_interface_is_part_of_bridge(incoming_interface)
> > >   then process_bridged_packet(packet)
> > >
> > > Then bridge looks at packet and decides whether it is local or forwarded.
> > > The problem is with your application if it wants to use eth0 directly.
> > >
> > >
> > The ebtables brouting chain was designed to enable you to do this.
> Can you give me an example?

Found this on the net:
ebtables -t broute -A BROUTING -p 0800  -i eth1 --ip-dst 192.168.1.16 -j DROP
ebtables -t broute -A BROUTING -p 0806  -i eth1 -d 00:06:9C:00:B2:FB -j DROP
ebtables -t broute -A BROUTING -p 0806  -i eth1 --arp-ip-dst 192.168.1.16 -j DROP

192.168.1.16 and 00:06:9C:00:B2:FB are the IP and MAC addresses of eth1.

Then add eth1 to the bridge and it appears to be working as I want.
Are there any "gotcha's" with this method?

 Jocke

