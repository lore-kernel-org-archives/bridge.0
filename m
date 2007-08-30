Date: Thu, 30 Aug 2007 16:03:13 -0400
From: "John W. Linville" <linville@tuxdriver.com>
Message-ID: <20070830200313.GF5140@tuxdriver.com>
References: <20070829150515.54dd7ecf@freepuppy.rosehill.hemminger.net>
	<426497.88154.qm@web51910.mail.re2.yahoo.com>
	<20070830122258.1c606516@freepuppy.rosehill.hemminger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070830122258.1c606516@freepuppy.rosehill.hemminger.net>
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
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: wang dengyi <dy_wang@yahoo.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org

On Thu, Aug 30, 2007 at 12:22:58PM -0700, Stephen Hemminger wrote:
> This patch fixes some packet leakage in bridge.  The bridging code
> was allowing forward table entries to be generated even if a device
> was being blocked. The fix is to not add forwarding database entries
> unless the port is active.

Seems reasonable -- ACK

John
-- 
John W. Linville
linville@tuxdriver.com
