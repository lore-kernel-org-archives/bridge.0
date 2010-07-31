Date: Fri, 30 Jul 2010 23:37:17 -0700 (PDT)
Message-Id: <20100730.233717.260088691.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100729111231.GA30021@gondor.apana.org.au>
References: <20100728095825.GC13413@jupiter.n2.diac24.net>
	<20100728120336.GD13413@jupiter.n2.diac24.net>
	<20100729111231.GA30021@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [BUG] bridge leaks 3 references on lo per up&down
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: herbert@gondor.hengli.com.au
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, equinox@diac24.net

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 29 Jul 2010 19:12:31 +0800

> bridge: Fix skb leak when multicast parsing fails on TX
> 
> On the bridge TX path we're leaking an skb when br_multicast_rcv
> returns an error.
> 
> Reported-by: David Lamparter <equinox@diac24.net>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied to net-2.6, thanks!
