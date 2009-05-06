MIME-Version: 1.0
Date: Wed, 6 May 2009 13:32:09 -0400
Message-ID: <e6e2252e0905061032pc4bf5cfjb9eb32379d8e6323@mail.gmail.com>
From: Andrew Watts <systemstalker@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] PPP and Ethernet Half-bridge
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

I have a cellular modem that configures a ppp interface for IP
communication.  I would like to bridge the ppp and Ethernet interface
together.  brctl does not allow for bridging between ppp and ethernet
interface.  I expect this mainly due to the fact that I am trying to
bridge 2 different layer 2 protocols, PPP and Ethernet.  I have seen
mention that many ADSL routers support "half bridge mode" or "ZIPB"
(Zero IP Bridge), this is also called IP-Passthrough.  Basically I
need a device that works like a modem such that the Public IP address
that the modem receives from the ISP is passed trough and assigned to
a node (router or SINGLE host).  One of the devices I want to connect
doesn't play well with NAT nor does it have the ability to support
PPPoE/USB Modems.  I am also trying to make a secondary modem as a
failover connection that uses a 3G modem.  A company by the name of
cradlepoint sells a device that does this called the CBA250.  I have a
Linksys NSLU2 that would be PERFECT for this, I just don't know how to
do it.  If possible I would also like to be able to firewall a little
too.

http://www.evdoinfo.com/content/view/2601/64/

I want to do this to, just with Linux.  What code should I look at to
do this or is there a way to configure the system to do what I want.
In a perfect world ppp and ethernet would bridge and play nice but its
not.  Any advice would be greatly appreciated.  I am more than willing
to write code to get this to work but I'm pretty new to this and have
no idea where to even start.

Thanks

Andrew
