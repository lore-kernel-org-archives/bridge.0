Message-ID: <20050804123705.10680.qmail@web34108.mail.mud.yahoo.com>
Date: Thu, 4 Aug 2005 05:37:05 -0700 (PDT)
From: Zoran s <s_zoran@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Problem with Routed mode using br2684ctl tool
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

I am writing this email in sincere hope that somebody
experienced similar/same problem and found solution to
it.

The classical bridge setup could be achieved using
brctl tool, which could be found at:
http://home.regit.org/br2684.html

I have an ADSL CO line card Linux based [2.4.24
kernel] with 8 nas interfaces and eth0. Rather than
having bridge, the decision was to have a router,
which does routing functionality between nasx
interfaces and eth0.

From user space, setting up a bridge connection is
quite simple. First, the linking an ATM VC with an
interface should be done followed by configuring this
interface.

The syntax of the command is the following:

br2684ctl [-c n -e 0|1 -b 0|1 -s buf_size -a
[itf].vpi.vci ]+

-a [itf].vpi.vci : ATM PVC number, VPI and VCI.
Mandatory
-c n             : BR2684 interface number such as
nas0,
                   nas1,... Mandatory
-e 0|1           : Encapsulation method. 0=LLC, 1=VC
mux.
                   default is 0, LLC
-b 0|1           : Running background. 1=background,
                   0=foreground. Default is 0
-s buf_size      : send buffer size. Default is 8192.

The problem with setting bridge with brctl tool is
lack of option p 0|1 [bridged or routed
functionality]. I'm using more advanced tool based on
brctl with additional option p:

-p 0|1           : Bridged or routed. 0=routed,
1=bridged
                   Default is 0 [routed].

In other words using ADSL CO line card as IP router
makes every nasx and eth0 interfaces to have their own
IP addresses. The example of setting a nas0 interface:

br2684ctl -b -c 0 -e 0 -p 0 -a 0.0.40, where p is used
as Routed mode option.

When there is need to configure a WAN connection on
CPE side [ADSL modem on other side of twisted pair],
there are 5 possible options for WAN connection
creation:

[1] RFC1483 Bridge
[2] RFC1483 Route
[3] PPP over ATM
[4] PPP over Ethernet
[5] IP over ATM [CLIP]

Choosing option 2 [RFC1483 Route] as an option follows
usage of brctl tool for nas0 interface creation on CO
side in routed mode.

The actual problem is that routed mode does NOT work
after setting the parameters as shown [CPE modem
receives packets on WAN, but discards them, finding
them as bad].

The problem is solved by creating [on CO side] nasx
interfaces in bridged mode. As example, the nas0
interface creation syntax looks a bit different:

br2684ctl -b -c 0 -e 0 -p 1 -a 0.0.40, where -p is
used as Bridged mode option.

On other [CPE] side, the option 1 is used [RFC1483
Bridge (with NAT)] for creating the WAN interface.
This works perfectly, albeit both CO and CPE sides are
set as routers!

Any ideas why RFC1483 Route mode does NOT work? I'll
apprecate any ideas which can show me some direction.

Best Regards,

Zoran Stojsavljevic
DKTS Pupin Telecom, s_zoran@yahoo.com


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
