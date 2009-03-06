From: Dirk Gouders <gouders@et.bocholt.fh-gelsenkirchen.de>
In-Reply-To: <49B00385.1010401@superduper.net> (Simon Barber's message of
	"Thu\, 05 Mar 2009 08\:53\:25 -0800")
References: <giab80caq6.fsf@karga.hank.lab> <49B00385.1010401@superduper.net>
Date: Fri, 06 Mar 2009 12:45:05 +0100
Message-ID: <giy6vi98ou.fsf@karga.hank.lab>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] IP address on bridged interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Simon Barber <simon@superduper.net>
Cc: bridge@lists.linux-foundation.org


> Normally it does not make sense to put any L3 protocol address on port 
> interfaces - because incoming packets are diverted to the bridge 
> interface before the L3 protocol is examined. This means the L3 protocol 
> running on the port interface will never see any incoming packets.

Meanwhile, I played with a one-port setup that works with an IP address
(out of 192.168.106.0/24) only on the port interface:

brctl addbr br0
ip link set br0 up
# delete the network-route via the eth0 interface
ip route del 192.168.106.0/24
ip route add default dev br0
brctl addif br0 eth0

After I put the one and only interface eth0 into this experimental
"bridge", network connections are possible as if eth0 was used directly.
As br0 does not have an L3 protocol address, isn't it the port interface
eth0 that sees the L3 packets in this case?

Dirk
