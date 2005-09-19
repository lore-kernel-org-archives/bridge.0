Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 19 Sep 2005 11:38:13 -0400
Message-ID: <87ABB5B9BD11A240B9CBB3F0485AEC8950CBC4@IMCSRV4.MITRE.ORG>
From: "Feighery,Patrick D." <feighery@mitre.org>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Bridging eth0 and tap0 stop working after a while
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I've developed an TCP proxing application to improve performance over
satellite and wireless links.  When I ported it to linux I used a
combination of bridging and the tap interface to read and write
packets/frames to the physical interface.

I created two separate bridges:  aif bridges between eth2 and tap0
while bif bridges between eth1 and tap1.  After a while I noticed that
the bridge stops working.  It seems to bridge correctly for at least 8
hours then for some reason just stops.

If I tcpdump eth2, I see packets.  If I tcpdump aif, I see packets.
However if I tcpdump tap0, nothing.

I've currently using a 2.4.22-1.2115 kernel. But I believe the problem
also occurs with a 2.6.9 based kernel.

Below is a list of commands to set up the bridge.

:: ip link set dev tap0 up
:: ip link set dev tap1 up
:: brctl addbr aif
:: brctl addif aif tap0
:: brctl addif aif eth2
:: brctl stp aif off
:: ifconfig aif up
:: brctl addbr bif
:: brctl addif bif tap1
:: brctl addif bif eth0
:: brctl stp bif off
:: ifconfig bif up
:: ip addr del 10.50.5.4 dev eth2
:: ifconfig aif 10.50.5.4 netmask 255.255.255.0
:: ip addr del 10.60.5.4 dev eth0
:: ifconfig bif 10.60.5.4 netmask 255.255.255.0

Has anyone seen anything like this?  Any pointers to what I could be
doing wrong, or pointers to how I can debug thus?

Many thanks

	Pat

