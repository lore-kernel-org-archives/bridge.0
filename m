Date: Thu, 5 Aug 2004 15:10:42 +0200 (CEST)
From: Henrik Nordstrom <hno@marasystems.com>
In-Reply-To: <W5101410375481091705422@asteria.telenet-ops.be>
Message-ID: <Pine.LNX.4.61.0408051507530.405@filer.marasystems.com>
References: <W5101410375481091705422@asteria.telenet-ops.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bridge] Re:  Any way of knowing a packet's been defragmented
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: netfilter-devel <netfilter-devel@lists.netfilter.org>, bridge <bridge@osdl.org>, shemminger@osdl.org

On Thu, 5 Aug 2004 bdschuym@pandora.be wrote:

> As Stephen explained, bridge ports of the same bridge device no longer 
> need to have the same mtu. So the bridge code needs to drop packets 
> (ARP, IP, whatever) that will be too long for the output port.

Eh.. I do not claim to be a bridge guru, but won't such bridge cause 
serious havoc on the network much like PMTU blackholes does?

You should either reject creating such bridge, or make sure to fragment 
packets including ICMP MUST FRAGMENT generation when not allowed (which 
requires an IP).

Regards
Henrik
