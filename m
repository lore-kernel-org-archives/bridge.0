Date: Wed, 25 Aug 2004 16:51:39 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040825165139.3fe6caec.davem@redhat.com>
In-Reply-To: <20040825141539.08ca19b8@dell_ss3.pdx.osdl.net>
References: <20040825141539.08ca19b8@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] fix oops when mangling and brouting and
 tcpdumping packets (revised)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@oss.sgi.com, bdschuym@pandora.be, bridge@osdl.org

On Wed, 25 Aug 2004 14:15:39 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> The ebtables brouting chain, traversed through the call
> br_should_route_hook(), can alter a packet. The redirect target
> does this, f.e., to change the MAC destination.
> 
> Bart discovered this and proposed a patch; this is a revised version.
> This version cleans up the handle_bridge code in net/core/dev.c as well
> as getting rid of extra rcu_read_lock and only does the br_port checking
> once.

Looks good, applied.
