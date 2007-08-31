Date: Thu, 30 Aug 2007 22:16:42 -0700 (PDT)
Message-Id: <20070830.221642.41875712.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070830164812.GW14130@parisc-linux.org>
References: <20070830145840.GU14130@parisc-linux.org>
	<20070830082932.71272c3d@freepuppy.rosehill.hemminger.net>
	<20070830164812.GW14130@parisc-linux.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] bridge: fix OOPS when bridging device without
	ethtool
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: matthew@wil.cx
Cc: bridge@linux-foundation.org, voss@seehuhn.de, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, johannes@sipsolutions.net

From: Matthew Wilcox <matthew@wil.cx>
Date: Thu, 30 Aug 2007 10:48:13 -0600

> On Thu, Aug 30, 2007 at 08:29:32AM -0700, Stephen Hemminger wrote:
> > Bridge code calls ethtool to get speed. The conversion to using
> > only ethtool_ops broke the case of devices without ethtool_ops.
> > This is a new regression in 2.6.23.
> > 
> > Rearranged the switch to a logical order, and use gcc initializer.
> > 
> > Ps: speed should have been part of the network device structure from
> >     the start rather than burying it in ethtool.
> 
> Feel free to do the conversion ;-)  One of the things I like about the
> ethtool framework is it gives us a way to take stuff out of the drivers
> and put it in the midlayer without disturbing userspace.
> 
> > Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>
> 
> Acked-by: Matthew Wilcox <matthew@wil.cx>

Applied, thanks!
