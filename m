From: jamal <hadi@cyberus.ca>
In-Reply-To: <20040728162413.0de73ea3@dell_ss3.pdx.osdl.net>
References: <20040728162413.0de73ea3@dell_ss3.pdx.osdl.net>
Message-Id: <1091103164.1046.591.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: [Bridge] Re: [PATCH] (3/4) bridge linkstate handling
Reply-To: hadi@cyberus.ca
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Thu, 29 Jul 2004 12:12:52 -0000
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com, bridge@osdl.org

On Wed, 2004-07-28 at 19:24, Stephen Hemminger wrote:
> This makes bridge port status reflect both the state of the interface
> from software (up/down) and the carrier.  It makes STP handle link failure
> (cable breakage, etc).  The original concept comes from a 
> Mark Ruijter <bridge@siennax.com> who implemented it differently.
> My way is simpler and requires no polling.
> 
> Obviously, this link state detection will only work if the network card
> handles the events properly.
> 

nice. Does this entrench STP further in the kernel?
Still planning to move it out to user space?

cheers,
jamal

