Date: Thu, 30 Aug 2007 22:15:44 -0700 (PDT)
Message-Id: <20070830.221544.48531675.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070830200313.GF5140@tuxdriver.com>
References: <426497.88154.qm@web51910.mail.re2.yahoo.com>
	<20070830122258.1c606516@freepuppy.rosehill.hemminger.net>
	<20070830200313.GF5140@tuxdriver.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] bridge: packets leaking out of
	disabled/blocked ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linville@tuxdriver.com
Cc: dy_wang@yahoo.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org

From: "John W. Linville" <linville@tuxdriver.com>
Date: Thu, 30 Aug 2007 16:03:13 -0400

> On Thu, Aug 30, 2007 at 12:22:58PM -0700, Stephen Hemminger wrote:
> > This patch fixes some packet leakage in bridge.  The bridging code
> > was allowing forward table entries to be generated even if a device
> > was being blocked. The fix is to not add forwarding database entries
> > unless the port is active.
> 
> Seems reasonable -- ACK

Applied, thanks.
