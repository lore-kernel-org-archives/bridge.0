Date: Wed, 9 Nov 2005 10:14:13 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridging EAPOL
Message-ID: <20051109101413.5b9cb011@dxpl.pdx.osdl.net>
In-Reply-To: <8DA338857B4F404282EE2088005079EA7701EC@eammlex037-nb.lmc.ericsson.se>
References: <8DA338857B4F404282EE2088005079EA7701EC@eammlex037-nb.lmc.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Andre Beliveau (QB/EMC)" <andre.beliveau@ericsson.com>
Cc: "'bridge@lists.osdl.org'" <bridge@lists.osdl.org>

On Wed, 9 Nov 2005 09:35:54 -0600 
"Andre Beliveau (QB/EMC)" <andre.beliveau@ericsson.com> wrote:

> Hi, 
> 
> I'm trying to bridge a WLAN interface to a Wired interface on a WRTG54GS.
> I'm using openwrt package.

What kernel are they using? are they doing any filtering with ebtables?


> I want to let EAPol messages go through the bridge but it does not work.
> 
> EAPOL start message uses as destination mac 01:80:c2:00:00:03.  If I run
> tcpdump on the
> Wireless interface I can see the packet come in.  But it never gets out on
> the network interface.

That is a spanning tree multicast message, so the bridge will consume it
itself (since it is a member of the spanning tree). The bridge generates
its own STP hello messages as well. 

See
	http://www.iana.org/assignments/ethernet-numbers

Multicast Addresses:
01-80-C2-00-00-00       -802-   Spanning tree (for bridges)

> I wrote a program to listen in promisc. mode and send back the packet toward
> the outgoing interface
> (vlan0) and I can see the packet in tcpdump on vlan0 interface now.
> 
> The problem is that even if I see the packet in tcpdump on vlan0 (and I even
> tried to send it to eth0 with
> the same results) I don't see the packet transmitted on the wire.
> 
> I am running ethereal on a client pc connected to a lan port and nothing
> shows up on ethereal.
> 
> If I change the destination address to another multicast address
> (01:80:c3:00:00:03) instead, the 
> Packet goes through and reaches my client PC and I can see the packet in
> Ethereal.
> 
> Question:  What do I have to do to let packets with d-mac 01:80:c2:00:00:03
> through the switch/bridge/firewall/

you would be better off turning STP on on the bridge and have it
generate it's own STP messages.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
