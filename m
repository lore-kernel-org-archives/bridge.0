Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 12 Nov 2016 12:52:13 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161112115213.GG3151@otheros>
Reply-To: bridge@lists.linux-foundation.org
References: <E5B11A06AD89DB429345609918715652FBF2FF58@XMB121CNC.rim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E5B11A06AD89DB429345609918715652FBF2FF58@XMB121CNC.rim.net>
Subject: Re: [Bridge] Force IGMP membership
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Corey Melanson <cmelanson@blackberry.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Fri, Nov 04, 2016 at 08:44:48PM +0000, Corey Melanson wrote:
> After the live migration, multicast traffic to 239.236.15.150 stops as expected. If I try to manually add the multicast group membership:
> # bridge mdb add dev br.128 port vnet3 grp 239.236.15.150 temp     
> # bridge mdb list | grep vnet3
> dev onebr.128 port vnet3 grp 239.236.15.150 temp
> 
> The multicast traffic does not resume until the VM sends a IGMP membership report after receiving an IGMP query from the switch, which takes too long most of the time (over a minute). 

Hm, sounds weird. Have you verified with tcpdump that
on <brport-multicast-in> you see the according frame and on vnet3
it is missing then?

Does it make a difference when instead of adding a group
explicitly to mark the whole port as a router port?

($ echo 2 > /sys/class/net/vnet3/brport/multicast_router
- not a solution proposal but just to narrow things down)

Regards, Linus
