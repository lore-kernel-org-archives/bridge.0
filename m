Message-ID: <4461F3C7.8090100@mail.com>
Date: Wed, 10 May 2006 15:08:07 +0100
From: Arie Bant <abant@mail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridging a virtual machine(QEMU) to the LAN
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org


Dear all,

I have a problem I could use a little help with.
I have a virtual PC (QEMU 0.8.0+CVS) in my Linux (Mandrake 10.2) box.
The linux bridging runs, with br0 containing eth0 (the physical Ethernet 
interface) and tap0, the virtual interface to the VM.
I also have Shorewall (v2.0.17) running.
I assumed that the level 2 bridging would come before the 
firewalling/netfiltering.
What happens is that I can ping the host computer from the VM, as well 
as any address outside the local zone in Shorewall. conversely I can 
ping the VM from the host, but not from other computers in the same zone.
When I run Shorewall with clean tables all works fine.
The Shorewall documentation says to use the "routeback" attribute on the 
bridge interface, but that can only be done when the interface connects 
to only one zone, which it does not.
On a second machine, without Shorewall, it works as expected, no problem.

A apologise if this problem has already been solved before, I have 
searched for it through Google without success.

Any ideas?

Thanks,

Arie.

