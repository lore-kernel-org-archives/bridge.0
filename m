Date: Tue, 17 Aug 2004 18:28:00 +0400
From: Aleksey Serba <lucky@rbcmail.ru>
Message-ID: <562736197.20040817182800@rbcmail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge and ip aliasing on Debian
Reply-To: Aleksey Serba <lucky@rbcmail.ru>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

   Hello,

   I can't figure out how to set up several IP addresses on bridge
   interface in Debian way.

   Server - Debian GNU/Linux 2.6.7-1-k7
   Interfaces - br0 ( eth0, eth1 )

------------- /etc/network/interfaces.conf ---------------
auto br0
iface br0 inet static
    address X.X.X.X
    netmask X.X.X.X
    network X.X.X.X
    broadcast X.X.X.X
    gateway X.X.X.X
    bridge_ports eth0 eth1
----------------------------------------------------------
   It works fine.
   I need to add unroutable ip address on bridge interface.
   I doubt, adding new bridge interface - this is the right way to do it.
----------------------------------------------------------
auto br1
iface br1 inet static
    address 192.168.0.1
    netmask 255.255.255.0
    network 192.168.0.0
    broadcast 192.168.0.255
    bridge_ports eth0 eth1
----------------------------------------------------------

   Any ideas? Any help will be greatly appreciated.
   Please CC all replies, i'm not subscribed.

          Aleksey

