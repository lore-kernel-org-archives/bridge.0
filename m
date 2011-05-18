Date: Wed, 18 May 2011 18:10:42 -0400 (EDT)
Message-Id: <20110518.181042.1332278156476011677.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110518081718.0b1fc390@nehalam>
References: <20110518081718.0b1fc390@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: add notification over netlink
 when STP changes state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@vyatta.com
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Wed, 18 May 2011 08:17:18 -0700

> The first netlink code in the bridge module was to notify
> user space implementations of Spanning Tree Protocol about
> new ports. It did not handle the case of kernel mode STP 
> changing states which could be useful for monitoring.
> 
> This patch causes RTM_NEWLINK message to occur on kernel
> transitions. It does not send message if request was from user
> space STP, since that would cause reflection and break existing
> API.
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

I agree with Ben that hiding events in any way is going to
be a severe limitation, long term.

I do not want to apply this and keep going down this road.

Sorry.
