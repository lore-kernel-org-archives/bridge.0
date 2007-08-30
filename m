Date: Thu, 30 Aug 2007 09:45:13 -0600
From: Matthew Wilcox <matthew@wil.cx>
Message-ID: <20070830154513.GV14130@parisc-linux.org>
References: <20070829223752.GA6969@seehuhn.de>
	<1188475530.2963.20.camel@johannes.berg>
	<20070830074949.7cd25b04@freepuppy.rosehill.hemminger.net>
	<1188486091.3978.32.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1188486091.3978.32.camel@johannes.berg>
Subject: [Bridge] Re: oops with recent wireless-dev tree
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: bridge@linux-foundation.org, Jochen Voss <voss@seehuhn.de>, netdev <netdev@vger.kernel.org>, linux wireless list <linux-wireless@vger.kernel.org>

On Thu, Aug 30, 2007 at 05:01:31PM +0200, Johannes Berg wrote:
> Jochen had a patch: http://marc.info/?l=linux-wireless&m=118842715026614&w=2

That's exactly the right patch, please add

Acked-by: Matthew Wilcox <matthew@wil.cx>

I just checked over the commit that introduced the bug, and I didn't
make the same mistake anywhere else.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
