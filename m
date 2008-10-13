From: Alexis Huxley <ahuxley@gmx.net>
Date: Mon, 13 Oct 2008 20:28:20 +0000 (UTC)
Message-ID: <slrngf7br4.5fa.ahuxley@dione.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: news <news@ger.gmane.org>
Subject: [Bridge] pinging other side (normal bridge ok,
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

Hi, if I set up a bridge, assign an IP address to it, remove the
IP from a real interface (in my case dummy0, but the same situation
might apply to an physically unconnected eth1 NIC), plumb that real
interface into the bridge and plumb one end of a virtual cross-over
cable (tap0 <-> eth0-in-a-VM) into the bridge too, like this:

	brctl addbr br0 
	ifconfig br0 192.168.1.42 up
	ifconfig dummy0 0.0.0.0
	brctl addif br0 dummy0
	brctl addif br0 tap0

then I can now ping the other side, from both sides. Good.

Actually, dummy0 is superfluous; I might just as well not use it
in the above lines.

However, purely because I want my bridge to behave like a physical
bridge/hub/switch which I am used to not having an IP address, I would
like to use an *anonymous* bridge instead based on a command sequence 
like this:

brctl addbr br0
ifconfig dummy0 192.168.1.42 up
brctl addif br0 dummy0
brctl addif br0 tap0

But all attempts to do this have fail: I cannot ping the other side
from either side.

What is odd is than a tcpdump on the physical host shows that packets
are arriving on br0 but not on dummy0, also both sides ARP tables
contain the IP of the other side. It's almost like the bridge is saying
"I'll let ARP traffic through but not IP!"

I googled that this might be an iptables issue, so I flushed all
rules from all tables and set policy to ACCEPT. No dice.

Also, and please correct me if I am wrong in this assumption, I assume
that forwarding is not needed in this scenario; the bridge does not
behave as a computer and actually *require* forwarding to be turned on.
(Sure, if I wanted the VM to be able to reach something *beyond* the
physical machine then I would need to tell the physical machine to
do forwarding and maybe masquerading.)

I've also echoed '1' onto various things under /proc as per googled
docs. All to no avail.

Finally, I wanted to plumb dummy0 into an anonymous br0 to be analogous
with real hardware, but is there an advantage to doing it the usual
bridge-with-an-ip-address way? (Other than that it seems to work
whereas the anonymous way doesn't - for me.)

Many thanks for any assistance you can offer!

Alexis

