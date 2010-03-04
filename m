Date: Thu, 04 Mar 2010 00:42:47 -0800 (PST)
Message-Id: <20100304.004247.10224846.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100304031847.GA22683@elte.hu>
References: <4B8D4607.8070603@xenotime.net>
	<20100303.012359.66790294.davem@davemloft.net>
	<20100304031847.GA22683@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH -next] bridge: depends on INET
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: mingo@elte.hu
Cc: sfr@canb.auug.org.au, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, rdunlap@xenotime.net, linux-next@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Date: Thu, 4 Mar 2010 04:18:47 +0100

> I suspect Randy went by the MAINTAINERS entry - you might want to add netdev 
> as a second 'L:' line:
> 
>  ETHERNET BRIDGE
>  M:      Stephen Hemminger <shemminger@linux-foundation.org>
>  L:      bridge@lists.linux-foundation.org
>  W:      http://www.linux-foundation.org/en/Net:Bridge
>  S:      Maintained
>  F:      include/linux/netfilter_bridge/
>  F:      net/bridge/
> 
> To make it really clear that netdev must be Cc:-ed for those patches.

Thanks for pointing that out, I've made this addition.
