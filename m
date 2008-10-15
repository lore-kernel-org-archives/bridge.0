From: Alexis Huxley <ahuxley@gmx.net>
Date: Wed, 15 Oct 2008 07:21:13 +0000 (UTC)
Message-ID: <slrngfb6f9.ses.ahuxley@dione.no-ip.org>
References: <slrngf7br4.5fa.ahuxley@dione.no-ip.org>
	<fed120860810131543w7a0ae9f7wf565d8dc10b06447@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: news <news@ger.gmane.org>
Subject: Re: [Bridge] pinging other side (normal bridge ok,
	anonymous bridge not ok)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

After Richard Voigt's clarification, I came back to this article and
it made a lot more sense to me.

> Adding a dummy device to a bridge doesn't do much for you. The dummy
> device never has any incoming packets, and any outgoing packets are
> discarded.

Understood; plumbing dummy0 into br0 doesn't create a virtual cable.

> The veth driver might be more useful for you. If you have the veth
> module buillt (CONFIG_VETH), you can create an interface pair using:
> $ ip link add name veth0 type veth peer name veth1
> This gives you a pair of ethernet devices (veth0 and veth1) set up so
> that a packet sent out on any one is received on the other. With this,
> you can make one of these a bridge port and give the other end the IP
> address.
>
> One page describing how to use veth for network namespace is:
> http://lxc.sourceforge.net/network/configuration.php

Yes, this is exactly what I need! I tried:

	ifconfig dummy0 down      #  current holder of IP 192.168.1.42
	ip link add name veth0 type veth peer name veth1
	ifconfig veth0 192.168.1.42 up
	ping 192.168.1.42         #  just checking :-)
	brctl addif br0 veth1
	iptables -A INPUT -i veth0 -j ACCEPT
	ping 192.168.1.43

but the ping still did not work. I also ACCEPTed traffic on veth1 and
br0 but no difference. I'll flush all tables and do some more reading
and gooling, but that must all wait till this evening. 

Many thanks for all the help!

Alexis

PS I fully understand that doing it this way is pointless in one way,
   but on the other hand it both helps me to start from a point I
   am familiar with (sticking two physical cables into a physical
   hub) and at the same time I learn something ... even if I do need
   a bit of help! :-) I'm sure in a couple of weeks I'll throw it all 
   out and do it the normal way! :-)

