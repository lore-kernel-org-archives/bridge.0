Date: Thu, 29 Jul 2004 09:31:20 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040729093120.58258ba9@dell_ss3.pdx.osdl.net>
In-Reply-To: <1091103164.1046.591.camel@jzny.localdomain>
References: <20040728162413.0de73ea3@dell_ss3.pdx.osdl.net>
	<1091103164.1046.591.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] (3/4) bridge linkstate handling
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: hadi@cyberus.ca
Cc: "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com, bridge@osdl.org

On 29 Jul 2004 08:12:44 -0400
jamal <hadi@cyberus.ca> wrote:

> On Wed, 2004-07-28 at 19:24, Stephen Hemminger wrote:
> > This makes bridge port status reflect both the state of the interface
> > from software (up/down) and the carrier.  It makes STP handle link failure
> > (cable breakage, etc).  The original concept comes from a 
> > Mark Ruijter <bridge@siennax.com> who implemented it differently.
> > My way is simpler and requires no polling.
> > 
> > Obviously, this link state detection will only work if the network card
> > handles the events properly.
> > 
> 
> nice. Does this entrench STP further in the kernel?
> Still planning to move it out to user space?

The same logic would apply in user space, it would just use the netlink
events that come from netlink messages (RTM_NEWLINK) rather than notifier chain (NETDEV_CHANGE).
