Date: Sat, 15 May 2010 23:12:23 -0700 (PDT)
Message-Id: <20100515.231223.124044249.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100510193320.936126854@vyatta.com>
References: <20100510193107.722574297@vyatta.com>
	<20100510193320.936126854@vyatta.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 3/4] bridge: netfilter use net_ratelimit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@vyatta.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Mon, 10 May 2010 12:31:10 -0700

> The function __br_dnat_complain is basically reimplementing existing
> net_ratelimit.
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

This code is no longer there after the recent netfilter merges.
