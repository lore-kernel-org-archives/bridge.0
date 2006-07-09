Message-ID: <988346560607082052g6e2eb040s8e578909d1fdd69d@mail.gmail.com>
Date: Sat, 8 Jul 2006 23:52:59 -0400
From: cyberfunk <cyberfunk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] Bridging two private lans w/ PPP and brtcl
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi all, I'm trying to do the following (ASCII art diagram viewable in
fixed-width font at end of message):

Take 2 private LANs, seperated by the internet, and bridge them by
creating a bridge from 2 ethernet devices and a ppp interface tunneled
over ssh between the two linux boxes concerned.

The setup on each of the two networks is nearly identical, and is as follows:

The network has it's own router (cable modem) that serves as the local
gateway for the network to the internet.  We dont care about this
except that it provides us a path to the internet through which to
tunnel ppp.

The internet connection is distributed by NAT forwarding, facilitated by
a hub/switch in between the router and the end users.  There are 2
types of end users; "regular" which are not part of the bridged
network, and "bridged" whose ethernet frames are to be forwarded back
and forth over the ssh tunneled ppp connection.  The "regular" users
are connected directly to the same hub as the router.  The "bridged"
users are connected to the Linux box.

Each linux box has 2 ethernet interfaces, eth0 and eth1; eth0 is the
"bridged" users side, and anything connected to this side will have
it's packets bridged through the ppp connection, over the internet,
and to the other bridged users, and vice versa.  eth1 connects the
linux box to the rest of the local network.  Note: it is important for
the "bridged" users on each local network to see the "regular" users
on their same network, but NOT the "regular" users of the OTHER
network.  Therefore, the solution that occurred to me was the
following:

Create a 3-way bridge with filtering.
Merge eth0, eth1, and ppp0 into a bridge that simply blocks traffic
between eth0 and ppp0, but allows eth0 and eth1 to talk freely (do
filtering w/ etables).

I have at least a 2.6.8 kernel installed on each linux box (Debian
Sarge), and I have the bridgectl package installed on each.  I have
the ppp over ssh connection working, using the information gleaned
from: http://tldp.org/HOWTO/ppp-ssh/

Now, here's my questions:

Can I bridge ppp and ethernet ?  If so how?  I've been desperately
looking for a howto, or any information on doing so.  Several "in
passing" comments suggest it can be done, but I've found nothing that
tells me how.  Specifically, do I need to bring up the ppp link
without assigning IP addresses on both sides of the link to bridge it
?  If so, how do I do that? (when I try adding the noip option to the
pppd script from the tutorial above, the ppp link refuses to stay up,
saying there's no protocols in place)

Also, is the order of the bridge creation important ?  I.e. for a
simple 2 interface ppp0/eth0 bridge (ignore the third interface for
the moment) with ppp over ssh tunneling, one needs an active internet
connection to establish the ppp connection, but in order to create the
bridge between ppp0 and eth0, eth0 must be DOWN (right?) meaning I
have no internet connection, meaning ppp dies.  How do I solve this
problem?  In the case of my 2 ethernet interfaces, could I merge the
two interfaces


ASCII ART:




    +-------(PPP link over ssh, ppp0 interface on both sides)--------+
    |                                                                |
    |                                                                |
    |  +--------------+      //-------\\        +-----------------+  |
    |  |      Router1 |    |             |      |Router2          |  |
    |  |(192.168.1.1) +---+-  Internet   -+-----+ (192.168.1.101) |  |
    |  +--------+-----+    |             |      +--+--------------+  |
    |           |            \\-------//           |                 |
    |           |                                  |                 |
    |           |                                  |                 |
    |           |                                  |                 |
  +-|-----------+------------------+  +------------+-----------------|-+
  | |      +----+-------+          |  |      +-----+-------+         | |
  | |      |Hub/Switch  |          |  |      |  Hub/Switch |         | |
  | |      +-+---+-+-+--+          |  |      +-+----+-+-+--+         | |
  | |        |   | | |             |  |        |    | | |            | |
  | |        |   | | +--- Regular  |  |        |    | | +--- Regular | |
  | |     (eth1) | +----- internet |  |      (eth1) | +----- internet| |
  | |        |   +------- users    |  |        |    +------- users   | |
  | |        |                     |  |        |                     | |
  | |      +-+----------+          |  |    +---+--------+            | |
  | |      | Linyx box1 |          |  |    | Linux box2 +------------+ |
  | +------+ "speedy"   |          |  |    | "rig"      |              |
  |        +--+---------+          |  |    +---+--------+              |
  |           |                    |  |        |                       |
  |         (eth0)                 |  |      (eth0)                    |
  |           |                    |  |        |                       |
  |      +----+-------+            |  |   +----+-------+               |
  |      |Hub/Switch  |            |  |   |Hub/Switch  |               |
  |      +-------+-+--+            |  |   +-------+-+--+               |
  |              | |               |  |           | |                  |
  |              | +--- Bridged    |  |           | +--- Bridged       |
  |              +----- users      |  |           +----- users         |
  |   Net1                         |  | Net2                           |
  |   IP addresses: 192.168.1.1-100|  | IP addresses: 192.168.1.101-254|
  +--------------------------------+  +--------------------------------+
