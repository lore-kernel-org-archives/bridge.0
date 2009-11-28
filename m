Date: Fri, 27 Nov 2009 22:58:21 -0800 (PST)
Message-Id: <20091127.225821.38680951.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091127213824.53c5a23a@nehalam>
References: <200911280043.58784.arnd@arndb.de>
	<20091127.161957.243886653.davem@davemloft.net>
	<20091127213824.53c5a23a@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 0/3] macvlan: support for guest vm direct rx/tx
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@vyatta.com
Cc: arnd@arndb.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alacrityvm-devel@lists.sourceforge.net, pmullaney@novell.com

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Fri, 27 Nov 2009 21:38:24 -0800

> Maybe we should figure out a way for protocols to return new skb in netif_receive_skb
> to avoid extra softirq, but avoid stack overflow?

Eric Dumazet and I tried to find ways to handle this, please see the
archives.  It's not an easy problem to solve and none of the patches
we came up with avoided crashes under high stress scenarios.
