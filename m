Message-ID: <478010E3.3020409@kotiportti.fi>
Date: Sun, 06 Jan 2008 01:21:07 +0200
From: Casper Gripenberg <casper.gripenberg@kotiportti.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge with DHCP IP address 
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


Hi. I'm trying to run a bridge between my "internal"
network (eth1) and the external internet (eth0). I.e.
a very basic setup.

But I also want the bridge to have an IP address. I
read the docs here:
http://www.linux-foundation.org/en/Net:Bridge

Which say to set the forwarding delay to 0 and then run
dhclient on eth0:

# ifconfig eth0 0.0.0.0
# ifconfig eth1 0.0.0.0
# brctl setfd br0 0
# brctl addif br0 eth0
# dhclient eth0
# brctl addif br0 eth1
# ifconfig br0 up

The bridge works fine as a bridge, and eth0 gets
an IP address (although it takes a very long time
for the dhclient to aquire it).

But I can't reach the eth0 address from anywhere
except localhost. And I can't get out of the bridge
either to any other address..even though the routing
table it set up correctly I get destination unreachable
when I try to ping an external IP address from the
bridge box (logged in through the console).

What I want is for the bridge to have an IP address
and then I want to allow access to specific ports on
the bridge depending on if the packets are coming in
through eth0 or eth1. Is this possible to do?

Thanks.

Casper


