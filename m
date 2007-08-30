Date: Thu, 30 Aug 2007 08:58:41 -0600
From: Matthew Wilcox <matthew@wil.cx>
Message-ID: <20070830145840.GU14130@parisc-linux.org>
References: <20070829223752.GA6969@seehuhn.de>
	<1188475530.2963.20.camel@johannes.berg>
	<20070830074949.7cd25b04@freepuppy.rosehill.hemminger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070830074949.7cd25b04@freepuppy.rosehill.hemminger.net>
Subject: [Bridge] Re: oops with recent wireless-dev tree
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@linux-foundation.org, Jochen Voss <voss@seehuhn.de>, netdev <netdev@vger.kernel.org>, linux wireless list <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>

On Thu, Aug 30, 2007 at 07:49:49AM -0700, Stephen Hemminger wrote:
> > >     static int port_cost(struct net_device *dev)
> > >     {
> > > 	    if (dev->ethtool_ops->get_settings) {
> > >                                ^^^^
> > > 
> > > As far as I can figure out, dev->ethtool_ops is NULL and the crash
> > > happens while trying to derefernce ...->get_settings.
> 
> Devices aren't required to have ethtool_ops. The code there used to
> call ethtool directly, and it would handle the error cases. I'll rollup
> a fix this morning.

Yep, clearly my fault; that should read:

	if (dev->ethtool_ops && dev->ethtool_ops->get_settings) {

Since Stephen's already bagged fixing this, I shan't send a patch.
But if it includes something like the line above please add:

Acked-by: Matthew Wilcox <matthew@wil.cx>

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
