Message-ID: <40FD57D7.8070202@signalblast.com>
Date: Tue, 20 Jul 2004 12:35:19 -0500
From: Wes Hegge <whegge@signalblast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Destination Host Unreachable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hopefully this is a simple answer.  I am new to setting up bridges on a 
linux system.  Here is what I have set up:

Laptop directly connected to the eth0 port on the bridge (A Soekris 4521 
board).  The otherside of the bridge is a wirelass lan card (SMC2532b-w) 
as wlan0.  The wlan0 is setup in managed mode to communicate to my test 
ap2000.

When I do a 'brctl showmacs br0' on the bridge it shows a bunch of mac 
addresses. So, I beleive the problem of using a wireless card is not 
relevant in this case.  If I am wrong please let me know.

If I do a ping from the bridge (I can telnet into it), all packets are 
lost.  If I do a ping from the laptop, all packets are lost, but I also 
receive the message Destination Host Unreachable.

Here is the commands in the 'interfaces' file for setting up the bridge:
iface br0 inet dhcp
	bridge_ports eth0 wlan0
	pre-up ifconfig eth0 0.0.0.0 up
	pre-up ifconfig wlan0 0.0.0.0 up
	pre-up iwconfig wlan0 mode managed
	pre-up iwconfig wlan0 essid test
	pre-up iwconfig wlan0 key off
	pre-up brctl addbr br0
	pre-up brctl addif br0 eth0
	pre-up brctl addif br0 wlan0
	pre-up ifconfig br0 172.17.4.10 netmask 255.255.0.0 gateway 172.17.1.1 up

Any ideas on what I need to do to get this bridge working?

Thanks,

Wes Hegge
SignalBlast.Com, Inc.
e: whegge@signalblast.com
p: (815) 397-1700

