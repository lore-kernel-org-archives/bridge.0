From: Bart De Schuymer <bdschuym@pandora.be>
Date: Thu, 2 Dec 2004 18:59:58 +0100
References: <004c01c4d8ee$1be82030$6c01a8c0@kingz>
In-Reply-To: <004c01c4d8ee$1be82030$6c01a8c0@kingz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412021859.58421.bdschuym@pandora.be>
Subject: [Bridge] Re: My configuration in Bridge, 802.1Q VLAN,
	and hotmail login, Thanks to all
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: jzhang@cienettechnologies.com, vlan@lanforge.com, ebtables-user@lists.sourceforge.net, bridge@lists.osdl.org
Cc: stuge-vlan@cdy.org, greearb@candelatech.com, shemminger@osdl.org, 'Derek Storvik' <it@consultech.net>

On Friday 03 December 2004 05:10, kingz wrote:
> Hi All,
>
> For my issue, first thanks to ALL, I have some idea of it.
> Also Thank Peter for his kind remind, I would become one good guy in
> this list.
>
> Most mentioned MTU, but how I assure that the problem is just MTU, how I
> debug it?

Try pinging hxtmxxl with a Linux host behind the bridge, use the -s option to 
increase the packet size. That way you can find out when the problem occurs. 
Then try the same to another host on the net (I like pinging google). If you 
can make your ping packet bigger than the Ethernet packet length, then it's 
not a problem with MTU.
If you have acces to the gateway, you can monitor the traffic there too, to 
see what's going on.

> Here is my bridge configuration:
> Internet
>
>
>   Gateway
>
>        |   eth0
>
> Ethernet Bridge
>
>        |   eth1
>
>      H u b    ( one normal hub or switch , no VLAN settings)
>
>       |   \
>       |     \
>
>   D-Link  802.1Q VLAN Switches (their uplink port-port 1  connected to
> the upper hub are tagged, those ports connected with PCs are untagged).
>
> Bridge configuration:
> Linux 2.4.26 ( kernel built in bridge function)
> Eth0   RTL8139 driver
> Eth1   Intel e100 NIC with eepro100 driver
>
> With VLAN tag, I met the hotmail login error, if without VLAN tag, all
> are OK!

So, your bridge setup does not have a tagged vlan port? The bridge ports are 
always the physical devices eth0 and eth1? If that is so, then I guess it 
must be a problem with your network cards, as has been suggested by others.

cheers,
Bart

