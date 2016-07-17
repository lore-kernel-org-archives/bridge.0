Return-Path: <davem@davemloft.net>
Date: Sat, 16 Jul 2016 19:58:02 -0700 (PDT)
Message-Id: <20160716.195802.931580320600384868.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1468465802-4571-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1468465802-4571-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/4] net: bridge: simplify receive
 path and consolidate forwarding paths
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 14 Jul 2016 06:09:58 +0300

> This set tries to simplify the receive and forwarding paths. Patch 01 is
> a trivial style adjustment, patch 02 removes one conditional from the
> unicast fast path, patch 03 removes another conditional and more imporantly
> removes the skb0/skb2 ambiguity about locally receiving the skb and
> switches to a boolean called "local_rcv".
> Patch 04 is the most important change which consolidates the forwarding
> paths for locally originated and forwarded packets into __br_forward. This
> allows us to remove the function pointers giving a minor performance boost,
> more importantly it makes it much easier to reason about the forwarding
> path and reduces the code duplication that was needed when making changes.
> Also it allows the receive path to fully setup the environment prior to
> calling any forwarding functions (i.e. to properly set unicast, local_rcv
> and search for unicast/mcast dst).
> Functionally everything should stay the same after this set.
> 
> I've done basic tests with unicast/multicast/broadcast Tx/Rx. Please
> review carefully.

I've reviewed this twice and can't find any problems, so applied to
net-next, thanks.
