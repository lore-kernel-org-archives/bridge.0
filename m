Return-Path: <davem@davemloft.net>
Date: Sat, 30 May 2015 23:33:12 -0700 (PDT)
Message-Id: <20150530.233312.180465980506007204.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1432813374.16878.5.camel@edumazet-glaptop2.roam.corp.google.com>
References: <1432813374.16878.5.camel@edumazet-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: fix br_multicast_query_expired()
	bug
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: eric.dumazet@gmail.com
Cc: netdev@vger.kernel.org, linus.luessing@web.de, sesse@samfundet.no, bridge@lists.linux-foundation.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 28 May 2015 04:42:54 -0700

> From: Eric Dumazet <edumazet@google.com>
> 
> br_multicast_query_expired() querier argument is a pointer to
> a struct bridge_mcast_querier :
> 
> struct bridge_mcast_querier {
>         struct br_ip addr;
>         struct net_bridge_port __rcu    *port;
> };
> 
> Intent of the code was to clear port field, not the pointer to querier.
> 
> Fixes: 2cd4143192e8 ("bridge: memorize and export selected IGMP/MLD querier port")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Applied, thanks Eric.
