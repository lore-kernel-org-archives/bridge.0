MIME-Version: 1.0
Date: Fri, 8 May 2009 15:31:43 -0600
Message-ID: <de7adc5e0905081431v58989abch5e7271de302afd99@mail.gmail.com>
From: Daniel Robbins <drobbins@funtoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Bridge] 2.6.27: persistent MAC assignment to bridge not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi All,

I am trying to figure out how to get a persistent, non-changing MAC
address assigned to a bridge. It looks like there is new functionality
in 2.6.27 to allow this to happen, specifically, in:

void br_stp_recalculate_bridge_id(struct net_bridge *br)
[...]
       /* user has chosen a value so keep it */
        if (br->flags & BR_SET_MAC_ADDR)
                return;

and in..

static int br_set_mac_address(struct net_device *dev, void *p)
[...]
        br->flags |= BR_SET_MAC_ADDR;

However, I cannot get this functionality to work as it appears it
should. If I manually set a bridge's MAC address to an arbitrary
value, as follows:

# ifconfig br0 hw ether "xx:xx:xx:xx:xx:xx"

Then, subsequent calls such as the following seem to still change the
bridge's MAC address:

# brctl addif br0 veth100.0
# brctl delif br0 veth100.0

Am I doing something wrong? What is the proper way to take advantage
of the new code in 2.6.27?

The only mechanism that I have found that appears to achieve my
desired result is application of Deitmar Maurer's 2.6.24 patch which,
after being applied, seems to disable the dynamic nature of the
bridge's MAC, so that br0 persistently uses the MAC of the first
interface that was added to the bridge. Here is this patch that seems
to be working for me:

--- linux-2.6.24-openvz.org/net/bridge/br_stp_if.c.org  2008-06-11
09:15:16.000000000 +0200
+++ linux-2.6.24-openvz.org/net/bridge/br_stp_if.c      2008-06-11
09:44:53.000000000 +0200
@@ -217,10 +217,7 @@
       struct net_bridge_port *p;

       list_for_each_entry(p, &br->port_list, list) {
-               if (addr == br_mac_zero ||
-                   memcmp(p->dev->dev_addr, addr, ETH_ALEN) < 0)
-                       addr = p->dev->dev_addr;
-
+               addr = p->dev->dev_addr;
       }

       if (compare_ether_addr(br->bridge_id.addr, addr))
--------------------------

However, when I look at the 2.6.27 source code, it seems like this
patch should no longer be needed and an "ifconfig br0 hw ether
"xx:xx:xx:xx:xx:xx" should be sufficient. Am I doing something wrong?

Thanks for your time,

Daniel Robbins
