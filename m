From: bdschuym@pandora.be
Message-ID: <W1746121773184611091718134@asteria.telenet-ops.be>
Date: Thu, 05 Aug 2004 15:02:14 +0000
Subject: Re: [Bridge] Re:  Any way of knowing a packet's been defragmented
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

>----- Oorspronkelijk bericht -----
>Van
: Henrik Nordstrom [mailto:hno@marasystems.com]
>Verzonden
: donderdag
, augustus
 5, 2004 01:10 PM
>Eh.. I do not claim to be a bridge guru, but won't such bridge cause 
>serious havoc on the network much like PMTU blackholes does?

Someone who sets up such a bridge should obviously know what she is doing. That's not our problem.

>You should either reject creating such bridge, or make sure to fragment 
>packets including ICMP MUST FRAGMENT generation when not allowed (which 
>requires an IP).

It's connection tracking that is responsible for the defragmentation and connection tracking WILL refragment the packets, BUT only if the bridge code doesn't drop the packet first.
The bridge code should obviously not send any ICMP message.



