Date: Thu, 30 Aug 2007 10:48:13 -0600
From: Matthew Wilcox <matthew@wil.cx>
Message-ID: <20070830164812.GW14130@parisc-linux.org>
References: <20070829223752.GA6969@seehuhn.de>
	<1188475530.2963.20.camel@johannes.berg>
	<20070830074949.7cd25b04@freepuppy.rosehill.hemminger.net>
	<20070830145840.GU14130@parisc-linux.org>
	<20070830082932.71272c3d@freepuppy.rosehill.hemminger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070830082932.71272c3d@freepuppy.rosehill.hemminger.net>
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
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@linux-foundation.org, Jochen Voss <voss@seehuhn.de>, netdev <netdev@vger.kernel.org>, linux wireless list <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>

On Thu, Aug 30, 2007 at 08:29:32AM -0700, Stephen Hemminger wrote:
> Bridge code calls ethtool to get speed. The conversion to using
> only ethtool_ops broke the case of devices without ethtool_ops.
> This is a new regression in 2.6.23.
> 
> Rearranged the switch to a logical order, and use gcc initializer.
> 
> Ps: speed should have been part of the network device structure from
>     the start rather than burying it in ethtool.

Feel free to do the conversion ;-)  One of the things I like about the
ethtool framework is it gives us a way to take stuff out of the drivers
and put it in the midlayer without disturbing userspace.

> Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

Acked-by: Matthew Wilcox <matthew@wil.cx>

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
