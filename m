Date: Sun, 22 Aug 2010 21:14:36 -0700 (PDT)
Message-Id: <20100822.211436.212698198.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100823033532.GA28463@verge.net.au>
References: <20100823033532.GA28463@verge.net.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [rfc] bridge: is PACKET_LOOPBACK unlikely()?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: horms@verge.net.au
Cc: netdev@vger.kernel.org, jesse@nicira.com, bridge@lists.linux-foundation.org, jpirko@redhat.com

From: Simon Horman <horms@verge.net.au>
Date: Mon, 23 Aug 2010 12:35:32 +0900

> While looking at using netdev_rx_handler_register for openvswitch Jesse
> Gross suggested that an unlikely() might be worthwhile in that code.
> I'm interested to see if its appropriate for the bridge code.
> 
> Cc: Jesse Gross <jesse@nicira.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

Seems reasonable to me, applied to net-next-2.6
