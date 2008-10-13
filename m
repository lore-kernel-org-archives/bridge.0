Message-ID: <fed120860810131543w7a0ae9f7wf565d8dc10b06447@mail.gmail.com>
Date: Tue, 14 Oct 2008 04:13:38 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <slrngf7br4.5fa.ahuxley@dione.no-ip.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <slrngf7br4.5fa.ahuxley@dione.no-ip.org>
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
To: Alexis Huxley <ahuxley@gmx.net>
Cc: bridge@osdl.org

Hi,

Adding a dummy device to a bridge doesn't do much for you. The dummy
device never has any incoming packets, and any outgoing packets are
discarded.

The veth driver might be more useful for you. If you have the veth
module buillt (CONFIG_VETH), you can create an interface pair using:
$ ip link add name veth0 type veth peer name veth1
This gives you a pair of ethernet devices (veth0 and veth1) set up so
that a packet sent out on any one is received on the other. With this,
you can make one of these a bridge port and give the other end the IP
address.

One page describing how to use veth for network namespace is:
http://lxc.sourceforge.net/network/configuration.php

On Tue, Oct 14, 2008 at 1:58 AM, Alexis Huxley <ahuxley@gmx.net> wrote:
> Hi, if I set up a bridge, assign an IP address to it, remove the
> IP from a real interface (in my case dummy0, but the same situation
> might apply to an physically unconnected eth1 NIC), plumb that real
> interface into the bridge and plumb one end of a virtual cross-over
> cable (tap0 <-> eth0-in-a-VM) into the bridge too, like this:
>
>        brctl addbr br0
>        ifconfig br0 192.168.1.42 up
>        ifconfig dummy0 0.0.0.0
>        brctl addif br0 dummy0
>        brctl addif br0 tap0
>
> then I can now ping the other side, from both sides. Good.
>
> Actually, dummy0 is superfluous; I might just as well not use it
> in the above lines.
>
> However, purely because I want my bridge to behave like a physical
> bridge/hub/switch which I am used to not having an IP address, I would
> like to use an *anonymous* bridge instead based on a command sequence
> like this:
>
> brctl addbr br0
> ifconfig dummy0 192.168.1.42 up
> brctl addif br0 dummy0
> brctl addif br0 tap0
>
> But all attempts to do this have fail: I cannot ping the other side
> from either side.
