From: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20100322082123.4967.77433.sendpatchset@localhost.localdomain>
References: <20100322082059.4967.63492.sendpatchset@localhost.localdomain>
	<20100322082123.4967.77433.sendpatchset@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Mar 2010 17:38:05 -0500
Message-ID: <1269297485.3552.26.camel@calx>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC Patch 3/3] bonding: make bonding support netpoll
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Amerigo Wang <amwang@redhat.com>
Cc: Jay Vosburgh <fubar@us.ibm.com>, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Andy Gospodarek <gospo@redhat.com>, bonding-devel@lists.sourceforge.net

On Mon, 2010-03-22 at 04:17 -0400, Amerigo Wang wrote:
> Based on Andy's work, but I modify a lot.
> 
> Similar to the patch for bridge, this patch does:
> 
> 1) implement the 4 methods to support netpoll for bonding;
> 
> 2) modify netpoll during forwarding packets in bonding;
> 
> 3) disable netpoll support of bridge when a netpoll-unabled device
>    is added to bonding;
> 
> 4) enable netpoll support when all underlying devices support netpoll.

Again, not sure if this is the right policy. Seems to me that on a
bonding device we should simply pick an interface to send netpoll
messages on, without reference to balancing, etc. Thus, if any of the
bonded devices supports polling, it should work.

Hopefully someone more familiar with the goals and philosophy of the
bonding code can comment further.

-- 
http://selenic.com : development and support for Mercurial and Linux


