Message-ID: <4C04D93E.7050905@trash.net>
Date: Tue, 01 Jun 2010 11:56:14 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <1275340993.2478.27.camel@edumazet-laptop>
In-Reply-To: <1275340993.2478.27.camel@edumazet-laptop>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next-2.6] br_netfilter: use skb_set_noref()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: netdev <netdev@vger.kernel.org>, Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

Eric Dumazet wrote:
> Avoid dirtying bridge_parent_rtable refcount, using new dst noref
> infrastructure.

Applied, thanks Eric.
