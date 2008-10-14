From: Alexis Huxley <ahuxley@gmx.net>
Date: Tue, 14 Oct 2008 18:08:33 +0000 (UTC)
Message-ID: <slrngf9o11.5jp.ahuxley@dione.no-ip.org>
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

> Adding a dummy device to a bridge doesn't do much for you. The dummy
> device never has any incoming packets, and any outgoing packets are
> discarded.

I understand that. But I still want to do it like this. As I mentioned,
I'm trying to make a setup that mirrors a physical setup; i.e. two
physical computers, each with one NIC plugged into a hub which itself
has no IP address.  The closest I can get to this with my (kvm VM)
is: a physical machine with a dummy0 interface plugged into br0
and a VM with a virtual twisted cable with its eth0 (which via the
VM:eth0<->PM:tap0 virtual crossover cable) plugged into br0.

> The veth driver might be more useful for you. If you have the veth
> module buillt (CONFIG_VETH), you can create an interface pair using:
> $ ip link add name veth0 type veth peer name veth1
> This gives you a pair of ethernet devices (veth0 and veth1) set up so
> that a packet sent out on any one is received on the other. With this,
> you can make one of these a bridge port and give the other end the IP
> address.

So you mean without br0 at all? If so then, no, I really want to do 
it with br0.

Simply: why, when this works:

>> brctl addbr br0
>> ifconfig br0 192.168.1.42 up
>> ifconfig dummy0 0.0.0.0
>> brctl addif br0 dummy0
>> brctl addif br0 tap0

does this not work:

>> brctl addbr br0
>> ifconfig dummy0 192.168.1.42 up
>> brctl addif br0 dummy0
>> brctl addif br0 tap0

? Thanks!

Alexis

