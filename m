Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bridge] Election of root port
Date: Thu, 4 Aug 2005 12:36:38 -0400
Message-ID: <EDF30175FE4D804B83444FB153172A506D73FB@louexch.KiZAN.net>
From: "Jeff Gercken" <JeffG@kizan.com>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: sameer.neugui@tatainfotech.com, bridge@lists.osdl.org

STP root port selection is based on port priority which, by default, is
based upon the interface speed.  If they're equal I believe the lowest
port address wins.
http://www.hojmark.net/stp-port-cost.html

You're talking switches right?  Why post to a bridge list?  You'd be
better off at http://www.tek-tips.com/threadminder.cfm?pid=558

-Jeff

-----Original Message-----
From: bridge-bounces@lists.osdl.org
[mailto:bridge-bounces@lists.osdl.org] On Behalf Of sameer
Sent: Thursday, August 04, 2005 4:39 AM
To: bridge@lists.osdl.org
Subject: [Bridge] Election of root port

Hi,

I have a situation where in there are 2 switches A and B.

port 0 of A is connected to port 0 of B
port 1 of A is connected to port 1 of B

all the four ports are in auto negotiation and 100mbps

Last byte of MAC of A = 7F
Last byte of MAC of B = 7E
(remaining bytes of the MAC address are identical)

Considering the switch B will be elected as root bridge which port of
switch A will be root port.

Will this configuration work perpetually?

_______________________________________________
Bridge mailing list
Bridge@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/bridge

