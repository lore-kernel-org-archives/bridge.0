Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=K1ycfoLVUCNDSl1C8grfygEpLiGBq3Ag+1mXeQ3pLCc=;
	b=d0Kd5bsDuBxEG+NTCgOcY4RXVJ0S/1B8QQx166NzXRD8D0velnrwZLPGOZMq6vLTeT
	UYkcIgsvPvhJHUiCOoM1wJ6CGeG/9wvDkXh8q/7qVay7V1A//+sLwW9y/2sAJR4RS2zP
	+NBq7fPhS0g1fhiR/56fFOLNiGhtvTQ/ynMOs=
References: <20190108164732.4024-1-idosch@mellanox.com>
	<20190108164732.4024-9-idosch@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <db6d7137-28d2-795d-34fd-58b61f70b027@cumulusnetworks.com>
Date: Tue, 8 Jan 2019 20:33:57 +0200
MIME-Version: 1.0
In-Reply-To: <20190108164732.4024-9-idosch@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net 08/11] net: bridge: Fix VLANs memory leak
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: mlxsw <mlxsw@mellanox.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, Nir Dotan <nird@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

On 08/01/2019 18:48, Ido Schimmel wrote:
> When adding / deleting VLANs to / from a bridge port, the bridge driver
> first tries to propagate the information via switchdev and falls back to
> the 8021q driver in case the underlying driver does not support
> switchdev. This can result in a memory leak [1] when VXLAN and mlxsw
> ports are enslaved to the bridge:
> 
> $ ip link set dev vxlan0 master br0
> # No mlxsw ports are enslaved to 'br0', so mlxsw ignores the switchdev
> # notification and the bridge driver adds the VLAN on 'vxlan0' via the
> # 8021q driver
> $ bridge vlan add vid 10 dev vxlan0 pvid untagged
> # mlxsw port is enslaved to the bridge
> $ ip link set dev swp1 master br0
> # mlxsw processes the switchdev notification and the 8021q driver is
> # skipped
> $ bridge vlan del vid 10 dev vxlan0
> 
> This results in 'struct vlan_info' and 'struct vlan_vid_info' being
> leaked, as they were allocated by the 8021q driver during VLAN addition,
> but never freed as the 8021q driver was skipped during deletion.
> 
> Fix this by introducing a new VLAN private flag that indicates whether
> the VLAN was added on the port by switchdev or the 8021q driver. If the
> VLAN was added by the 8021q driver, then we make sure to delete it via
> the 8021q driver as well.
> 
> [1]
> unreferenced object 0xffff88822d20b1e8 (size 256):
>   comm "bridge", pid 2532, jiffies 4295216998 (age 1188.830s)
>   hex dump (first 32 bytes):
>     e0 42 97 ce 81 88 ff ff 00 00 00 00 00 00 00 00  .B..............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000f82d851d>] kmem_cache_alloc_trace+0x1be/0x330
>     [<00000000e0178b02>] vlan_vid_add+0x661/0x920
>     [<00000000218ebd5f>] __vlan_add+0x1be9/0x3a00
>     [<000000006eafa1ca>] nbp_vlan_add+0x8b3/0xd90
>     [<000000003535392c>] br_vlan_info+0x132/0x410
>     [<00000000aedaa9dc>] br_afspec+0x75c/0x870
>     [<00000000f5716133>] br_setlink+0x3dc/0x6d0
>     [<00000000aceca5e2>] rtnl_bridge_setlink+0x615/0xb30
>     [<00000000a2f2d23e>] rtnetlink_rcv_msg+0x3a3/0xa80
>     [<0000000064097e69>] netlink_rcv_skb+0x152/0x3c0
>     [<000000008be8d614>] rtnetlink_rcv+0x21/0x30
>     [<000000009ab2ca25>] netlink_unicast+0x52f/0x740
>     [<00000000e7d9ac96>] netlink_sendmsg+0x9c7/0xf50
>     [<000000005d1e2050>] sock_sendmsg+0xbe/0x120
>     [<00000000d51426bc>] ___sys_sendmsg+0x778/0x8f0
>     [<00000000b9d7b2cc>] __sys_sendmsg+0x112/0x270
> unreferenced object 0xffff888227454308 (size 32):
>   comm "bridge", pid 2532, jiffies 4295216998 (age 1188.882s)
>   hex dump (first 32 bytes):
>     88 b2 20 2d 82 88 ff ff 88 b2 20 2d 82 88 ff ff  .. -...... -....
>     81 00 0a 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000f82d851d>] kmem_cache_alloc_trace+0x1be/0x330
>     [<0000000018050631>] vlan_vid_add+0x3e6/0x920
>     [<00000000218ebd5f>] __vlan_add+0x1be9/0x3a00
>     [<000000006eafa1ca>] nbp_vlan_add+0x8b3/0xd90
>     [<000000003535392c>] br_vlan_info+0x132/0x410
>     [<00000000aedaa9dc>] br_afspec+0x75c/0x870
>     [<00000000f5716133>] br_setlink+0x3dc/0x6d0
>     [<00000000aceca5e2>] rtnl_bridge_setlink+0x615/0xb30
>     [<00000000a2f2d23e>] rtnetlink_rcv_msg+0x3a3/0xa80
>     [<0000000064097e69>] netlink_rcv_skb+0x152/0x3c0
>     [<000000008be8d614>] rtnetlink_rcv+0x21/0x30
>     [<000000009ab2ca25>] netlink_unicast+0x52f/0x740
>     [<00000000e7d9ac96>] netlink_sendmsg+0x9c7/0xf50
>     [<000000005d1e2050>] sock_sendmsg+0xbe/0x120
>     [<00000000d51426bc>] ___sys_sendmsg+0x778/0x8f0
>     [<00000000b9d7b2cc>] __sys_sendmsg+0x112/0x270
> 
> Fixes: d70e42b22dd4 ("mlxsw: spectrum: Enable VxLAN enslavement to VLAN-aware bridges")
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> Reviewed-by: Petr Machata <petrm@mellanox.com>
> Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
> Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Cc: bridge@lists.linux-foundation.org
> ---
>  net/bridge/br_private.h |  1 +
>  net/bridge/br_vlan.c    | 26 +++++++++++++-------------
>  2 files changed, 14 insertions(+), 13 deletions(-)

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

