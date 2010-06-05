Message-ID: <4C09FBF2.80606@gmail.com>
Date: Sat, 05 Jun 2010 09:25:38 +0200
From: Marco Stornelli <marco.stornelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge eth0 usb0 arp reply problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I'm using a bridge between two interface (usb0 and eth1) to connect a
development board to my pc. On the board there's a usb ethernet gadget
because there's no eth interface. The communication seems to work but
the problem is that I see arp request from the board and no arp reply.
To add a bridge I'm using this commands:

brctl addbr br0
brctl addif br0 eth0
brctl addif br0 usb0
brctl setfd br0 0
ifconfig br0 192.168.0.2 promisc
ifconfig br0 up

I tried even to set promiscous mode for eth1 and usb0 but nothing.
Firewall is down both on by my pc and on the board. In the board I'm
using kernel 2.6.34 and for my pc 2.6.31.12. Is there a way to populate
the arp cache with a parameter or to modify the kernel to add the mac
address in hard coded way? (I know it's bad but only to see if I can do
the next steps). Please help me!!

Marco
