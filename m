From: bdschuym@pandora.be
Message-ID: <W5101410375481091705422@asteria.telenet-ops.be>
Date: Thu, 05 Aug 2004 11:30:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Re:  Any way of knowing a packet's been defragmented
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Henrik Nordstrom <hno@marasystems.com>, Bart De Schuymer <bdschuym@pandora.be>
Cc: netfilter-devel <netfilter-devel@lists.netfilter.org>, bridge <bridge@osdl.org>, shemminger@osdl.org

>Van
: Henrik Nordstrom [mailto:hno@marasystems.com]
>Verzonden
: donderdag
, augustus
 5, 2004 07:55 AM
>Aan
: 'Bart De Schuymer'

>The question on why the bridge needs to drop oversized fragments instead 
>of simply letting iptables fragment them remains...

As Stephen explained, bridge ports of the same bridge device no longer need to have the same mtu. So the bridge code needs to drop packets (ARP, IP, whatever) that will be too long for the output port.
The whole idea behind the new flag is giving the bridge code enough information so it doesn't drop to-be-fragmented packets.

cheers,
Bart




