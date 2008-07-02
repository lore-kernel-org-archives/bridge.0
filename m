Date: Wed, 2 Jul 2008 09:48:17 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080702094817.646c6c60@extreme>
In-Reply-To: <486B7CCE.2@trash.net>
References: <486B7CCE.2@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge: fix use-after-free in br_cleanup_bridges()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick McHardy <kaber@trash.net>
Cc: Linux Netdev List <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Wed, 02 Jul 2008 15:04:14 +0200
Patrick McHardy <kaber@trash.net> wrote:

> commit 96f1dd78dad10d61bdd487edadea6adda5425e4c
> Author: Patrick McHardy <kaber@trash.net>
> Date:   Wed Jul 2 15:02:23 2008 +0200
> 
>     bridge: fix use-after-free in br_cleanup_bridges()
> 
>     Unregistering a bridge device may cause virtual devices stacked on the
>     bridge, like vlan or macvlan devices, to be unregistered as well.
>     br_cleanup_bridges() uses for_each_netdev_safe() to iterate over all
>     devices during cleanup. This is not enough however, if one of the
>     additionally unregistered devices is next in the list to the bridge
>     device, it will get freed as well and the iteration continues on
>     the freed element.
> 
>     Restart iteration after each bridge device removal from the beginning to
>     fix this, similar to what rtnl_link_unregister() does.
> 
>     Signed-off-by: Patrick McHardy <kaber@trash.net>

Acked-by: Stephen Hemminger <shemminger@vyatta.com>
