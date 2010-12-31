Date: Fri, 31 Dec 2010 11:10:03 -0800 (PST)
Message-Id: <20101231.111003.48499853.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1293284490-17114-1-git-send-email-xiaosuo@gmail.com>
References: <1293284490-17114-1-git-send-email-xiaosuo@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: check the length of skb after
 nf_bridge_maybe_copy_header()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: xiaosuo@gmail.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Changli Gao <xiaosuo@gmail.com>
Date: Sat, 25 Dec 2010 21:41:30 +0800

> Since nf_bridge_maybe_copy_header() may change the length of skb,
> we should check the length of skb after it to handle the ppoe skbs.
> 
> Signed-off-by: Changli Gao <xiaosuo@gmail.com>

This is really strange.

packet_length() subtracts VLAN_HLEN from the value it returns, so the
correct fix seems to be to make this function handle the PPPOE case
too.

Otherwise I suspect you have many other functions to fix as well.

I'm not applying this patch.
