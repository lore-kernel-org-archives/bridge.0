From: Oz <osama@wayout.net>
Content-Type: text/plain
Message-Id: <1118043051.2066.14.camel@juptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] ARP weirdness
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Sun, 05 Jun 2005 07:33:48 -0000
To: bridge@lists.osdl.org

All

I have the following setup:

4 VLAN interfaces enslaved in a bridge interface. All VLAN interfaces
don't have IP address. The bridge interface has 192.168.1.1/24.

Now, when I try to ping from one of the VLAN interfaces, through a host
connected to a VLAN switch, while dumping the traffic, the following
happens:
- Host sends ARP who-has broadcast to the VLAN interface (tagged
correctly, originating from the host MAC)
- Linux receives the who-has and does 2 things:
	- It floods all VLAN interfaces with the same ARP who-has request
	- It responds with a unicast is-at on the correct VLAN interface

The question is: why does it flood while the ARP is destined to the
bridge interface?

The problem: I have a another switch connected passively between the
Linux box and the VLAN switch. When the bridge floods (which naturally
happens from the source of the originating box), it causes the switch to
be confused on where to find this specific MAC address and hence
dropping the frame.

Please advice.

