Date: Mon, 23 Mar 2009 15:47:51 -0700 (PDT)
Message-Id: <20090323.154751.190788467.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090323154517.2146a357@nehalam>
References: <20090323085122.4c9d21f2@nehalam>
	<20090323.152028.205335400.davem@davemloft.net>
	<20090323154517.2146a357@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net/bridge: use the maximum hard_header_len of
 ports for bridging device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: bridge@lists.linux-foundation.org, leoli@freescale.com, netdev@vger.kernel.org

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Mon, 23 Mar 2009 15:45:17 -0700

> So you dynamically compute the additional space but if the space was
> an awkward size, could it cause driver to breaks alignment assumptions?

Yes, you'd need to 16-byte align or something like that.

> And you didn't fixup the skb that is about to gag in the skb to make
> more space, so transmitting device driver (gfar) is going to overwrite or die.

This particular instance will do the headroom reallocation,
that's unavoidable during the size transition event.

The headroom checks can't ever be removed, but we won't hit
them in the fast path after the adjustment is made by my
patch.
