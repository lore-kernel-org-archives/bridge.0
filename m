Date: Wed, 16 Mar 2011 10:49:37 -0700 (PDT)
Message-Id: <20110316.104937.189702706.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110316082441.45db3018@nehalam>
References: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
	<20110316082441.45db3018@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] build breakage due to br_multicast.c referencing
 ipv6_dev_get_saddr()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: bridge@lists.linux-foundation.org, linus.luessing@web.de, JBeulich@novell.com, netdev@vger.kernel.org

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Wed, 16 Mar 2011 08:24:41 -0700

> On Wed, 16 Mar 2011 12:34:19 +0000
> "Jan Beulich" <JBeulich@novell.com> wrote:
> 
>> With BRIDGE=y and IPV6=m commit
>> fe29ec41aaa51902aebd63658dfb04fe6fea8be5 ("bridge: Use IPv6
>> link-local address for multicast listener queries") causes the build to
>> break.
> 
> Rather than continue with the config games, lets just make the necessary
> ipv6 pieces accessible.

You can't Stephen, ipv6_dev_get_saddr() requires access to the actual ipv6
device state, that means you have to pull in the entire ipv6 stack in because
there are dependencies all the way down into the routing code.

We added a Kconfig fix to cure this specific problem, which made it
into 2.6.38-final, so I don't understand why Jan is even seeing this,
it's supposed to force BRIDGE modular if IPV6 is modular:

commit dcbcdf22f500ac6e4ec06485341024739b9dc241
Author: Randy Dunlap <randy.dunlap@oracle.com>
Date:   Thu Mar 10 13:45:57 2011 -0800

    net: bridge builtin vs. ipv6 modular
    
    When configs BRIDGE=y and IPV6=m, this build error occurs:
    
    br_multicast.c:(.text+0xa3341): undefined reference to `ipv6_dev_get_saddr'
    
    BRIDGE_IGMP_SNOOPING is boolean; if it were tristate, then adding
    	depends on IPV6 || IPV6=n
    to BRIDGE_IGMP_SNOOPING would be a good fix.  As it is currently,
    making BRIDGE depend on the IPV6 config works.
    
    Reported-by: Patrick Schaaf <netdev@bof.de>
    Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
index 9190ae4..6dee7bf 100644
--- a/net/bridge/Kconfig
+++ b/net/bridge/Kconfig
@@ -6,6 +6,7 @@ config BRIDGE
 	tristate "802.1d Ethernet Bridging"
 	select LLC
 	select STP
+	depends on IPV6 || IPV6=n
 	---help---
 	  If you say Y here, then your Linux box will be able to act as an
 	  Ethernet bridge, which means that the different Ethernet segments it
