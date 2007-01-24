Message-ID: <45B797C1.50803@pacbell.net>
Date: Wed, 24 Jan 2007 09:30:41 -0800
From: Michael Boutte <mboutte@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] LAN-WAN Bridging Problem
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hello,
I am experiencing what may be a unique problem with operating the 
bridge. My hardware is custom Freescale MPC875 processor based with one 
ethernet (eth0) and one hdlc (hdlc0) WAN port and I am connecting two of 
these boards together using the WAN ports over a long distance - 
essentially two bridges in series.  They are running Linux 2.6.15 with 
bridging enabled in the kernel configuration. When I first power up both 
boards the bridge comes up fine and the two outside LANs are connected 
as if it were one LAN with a smart long cable in between. brctl works to 
set it up and the "showmacs" properly shows all of the MACs on each end.

The problem occurs If I disconnect the ethernet cable directly from the 
bridge at either end. The console on the disconnected units says "br0: 
port 2(eth0) entering disabled state". When I reconnect the cable it 
shows "br0: port 2(eth0) entering learning state" plus messages about 
network topology change detected. That LAN end no longer has a link to 
the other end, yet at the console of the unit disconnected and 
reconnected I can ping in either direction to any device in both LAN 
segments. Time makes no difference, but if I issue the command "ifconfig 
eth0 down" and then back "up" the link is almost immediately restored. 
This works either while the cable is disconnected or after it is 
reconnected.

I compared the effect of a cable disconnect with a standard PC running 
Linux and it seems to be identical, that is, ifconfig shows the port as 
up even when the cable is disconnected on both. I tried having STP 
enabled or disabled, and adding the ports into br0 in the opposite order 
with no difference either. Any ideas on why the bridge does not 
automatically restore? and especially on how I can make it automatically 
restore itself?

Thank you for your kind attention.

Mike Boutte
