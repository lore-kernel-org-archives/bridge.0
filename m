Return-Path: <bernhard@bwalle.de>
Message-ID: <4FDDEB61.7030306@bwalle.de>
Date: Sun, 17 Jun 2012 16:36:17 +0200
From: Bernhard Walle <bernhard@bwalle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Almost no traffic in br0 / tap0 combination
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

probably the question is stupid, but I just don't get it.

I have a Linux host with a bridge that contain my normal eth interface
and a tap device. The br0 interface has the IP address, tap0 and eth0
are up and don't have any IP.

The tap0 interface is opened and read()s the frames coming in. On a
second console, tcpdump is monitoring the traffic. No traffic is
actually written to the tap0 interface.

# brctl show
bridge name	bridge id		STP enabled	interfaces
br0		8000.a24ecad3959c	no		eth0
							tap0
No iptables. I configured even hub-like behaviour:

# brctl setageingtime br0 0
# brctl setfd br0 0

Now my question: Why don't I see any traffic apart from broadcasts?
Shouldn't I see any traffic that is incoming? Because both eth0 and tap0
are in promisc mode?

Thanks for the advise!


Regards,
Bernhard
