Date: Wed, 16 Mar 2011 10:49:53 -0700 (PDT)
Message-Id: <20110316.104953.112601933.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
References: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
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
To: JBeulich@novell.com
Cc: bridge@lists.linux-foundation.org, linus.luessing@web.de, netdev@vger.kernel.org

From: "Jan Beulich" <JBeulich@novell.com>
Date: Wed, 16 Mar 2011 12:34:19 +0000

> With BRIDGE=y and IPV6=m commit
> fe29ec41aaa51902aebd63658dfb04fe6fea8be5 ("bridge: Use IPv6
> link-local address for multicast listener queries") causes the build to
> break.

Fixed by:

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
