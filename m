Return-Path: <davem@davemloft.net>
Date: Wed, 20 Sep 2017 14:09:56 -0700 (PDT)
Message-Id: <20170920.140956.781667692297467325.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170916141833.28344-1-vincent@bernat.im>
References: <m3zi9vbrfp.fsf@luffy.cx>
	<20170916141833.28344-1-vincent@bernat.im>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: also trigger RTM_NEWLINK
 when interface is released from bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vincent@bernat.im
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, dsahern@gmail.com

From: Vincent Bernat <vincent@bernat.im>
Date: Sat, 16 Sep 2017 16:18:33 +0200

David, I am CC:'ing you because you've done work in this area over the
past year.  I'm applying this patch, it's been sitting since the 16th
and likes entirely correct to me.  But if you have objections just let
me know.

> Currently, when an interface is released from a bridge via
> ioctl(), we get a RTM_DELLINK event through netlink:
> 
> Deleted 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 6e:23:c2:54:3a:b3
> 
> Userspace has to interpret that as a removal from the bridge, not as a
> complete removal of the interface. When an bridged interface is
> completely removed, we get two events:
> 
> Deleted 2: dummy0: <BROADCAST,NOARP> mtu 1500 master bridge0 state DOWN
>     link/ether 6e:23:c2:54:3a:b3
> Deleted 2: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
>     link/ether 6e:23:c2:54:3a:b3 brd ff:ff:ff:ff:ff:ff
> 
> In constrast, when an interface is released from a bond, we get a
> RTM_NEWLINK with only the new characteristics (no master):
> 
> 3: dummy1: <BROADCAST,NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UNKNOWN group default
>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
> 3: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
> 4: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
> 3: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noqueue state DOWN group default
>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
> 3: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noqueue state DOWN group default
>     link/ether ca:c8:7b:66:f8:25 brd ff:ff:ff:ff:ff:ff
> 4: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
> 
> Userland may be confused by the fact we say a link is deleted while
> its characteristics are only modified. A first solution would have
> been to turn the RTM_DELLINK event in del_nbp() into a RTM_NEWLINK
> event. However, maybe some piece of userland is relying on this
> RTM_DELLINK to detect when a bridged interface is released. Instead,
> we also emit a RTM_NEWLINK event once the interface is
> released (without master info).
> 
> Deleted 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 8a:bb:e7:94:b1:f8
> 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
>     link/ether 8a:bb:e7:94:b1:f8 brd ff:ff:ff:ff:ff:ff
> 
> This is done only when using ioctl(). When using Netlink, such an
> event is already automatically emitted in do_setlink().
> 
> Signed-off-by: Vincent Bernat <vincent@bernat.im>

Applied, thank you.
