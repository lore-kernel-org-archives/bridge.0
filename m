Return-Path: <davem@davemloft.net>
Date: Tue, 02 Jul 2019 11:54:07 -0700 (PDT)
Message-Id: <20190702.115407.589130187506465260.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190702120021.13096-1-nikolay@cumulusnetworks.com>
References: <20190702120021.13096-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net 0/4] net: bridge: fix possible stale skb
	pointers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: martin@linuxlounge.net, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, yoshfuji@linux-ipv6.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue,  2 Jul 2019 15:00:17 +0300

> In the bridge driver we have a couple of places which call pskb_may_pull
> but we've cached skb pointers before that and use them after which can
> lead to out-of-bounds/stale pointer use. I've had these in my "to fix"
> list for some time and now we got a report (patch 01) so here they are.
> Patches 02-04 are fixes based on code inspection. Also patch 01 was
> tested by Martin Weinelt, Martin if you don't mind please add your
> tested-by tag to it by replying with Tested-by: name <email>.
> I've also briefly tested the set by trying to exercise those code paths.

Series applied, thanks.
