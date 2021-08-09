Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC/sSfgn41mQctQq+VvHgYGUdhl6nJ/LCTzp9qvcphs=;
 b=D5aeMchqmfPZiixRPeFG1OfiEnYgYpa5o5TdSYS6qdP3CtOP1ev6ies5ax4sTehKWHeTj4PV8ISN6OIY06uJfuAoFQ6zjZvqPO13oSdWsvILeAoJAl//Y1x/d++3eCnuCk67bbb6vpu8Ffl5zqsiRuZy2kMShAuzzaSeX9pbhyPJEQ1YnBO6vnCHctQ7pJcAQyuJO5bO5wruGeanTU/C8EKZXzF2JHfQtFk3Bp04B0Ihum79i+BNIb/BqrO/T7aJMCWCax3CuVJXAJNFaLIFFHvujFikbOC3q5+Rqg0Kpefybp+vS+KMZMdgJScsO2SwknfYPao6qdtqO7MSEgVKdw==
References: <20210809132023.978546-1-yangyingliang@huawei.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <01704dc6-23ae-c5f0-d34d-cfa7b8a2f08b@nvidia.com>
Date: Mon, 9 Aug 2021 18:43:55 +0300
In-Reply-To: <20210809132023.978546-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net v3] net: bridge: fix memleak in br_add_if()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: kuba@kernel.org, davem@davemloft.net, roopa@nvidia.com

On 09/08/2021 16:20, Yang Yingliang wrote:
> I got a memleak report:
> 
> BUG: memory leak
> unreferenced object 0x607ee521a658 (size 240):
> comm "syz-executor.0", pid 955, jiffies 4294780569 (age 16.449s)
> hex dump (first 32 bytes, cpu 1):
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> backtrace:
> [<00000000d830ea5a>] br_multicast_add_port+0x1c2/0x300 net/bridge/br_multicast.c:1693
> [<00000000274d9a71>] new_nbp net/bridge/br_if.c:435 [inline]
> [<00000000274d9a71>] br_add_if+0x670/0x1740 net/bridge/br_if.c:611
> [<0000000012ce888e>] do_set_master net/core/rtnetlink.c:2513 [inline]
> [<0000000012ce888e>] do_set_master+0x1aa/0x210 net/core/rtnetlink.c:2487
> [<0000000099d1cafc>] __rtnl_newlink+0x1095/0x13e0 net/core/rtnetlink.c:3457
> [<00000000a01facc0>] rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3488
> [<00000000acc9186c>] rtnetlink_rcv_msg+0x369/0xa10 net/core/rtnetlink.c:5550
> [<00000000d4aabb9c>] netlink_rcv_skb+0x134/0x3d0 net/netlink/af_netlink.c:2504
> [<00000000bc2e12a3>] netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
> [<00000000bc2e12a3>] netlink_unicast+0x4a0/0x6a0 net/netlink/af_netlink.c:1340
> [<00000000e4dc2d0e>] netlink_sendmsg+0x789/0xc70 net/netlink/af_netlink.c:1929
> [<000000000d22c8b3>] sock_sendmsg_nosec net/socket.c:654 [inline]
> [<000000000d22c8b3>] sock_sendmsg+0x139/0x170 net/socket.c:674
> [<00000000e281417a>] ____sys_sendmsg+0x658/0x7d0 net/socket.c:2350
> [<00000000237aa2ab>] ___sys_sendmsg+0xf8/0x170 net/socket.c:2404
> [<000000004f2dc381>] __sys_sendmsg+0xd3/0x190 net/socket.c:2433
> [<0000000005feca6c>] do_syscall_64+0x37/0x90 arch/x86/entry/common.c:47
> [<000000007304477d>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> On error path of br_add_if(), p->mcast_stats allocated in
> new_nbp() need be freed, or it will be leaked.
> 
> Fixes: 1080ab95e3c7 ("net: bridge: add support for IGMP/MLD stats and export them via netlink")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v3:
>   use br_multicast_del_port() to free mcast_stats
> ---
>  net/bridge/br_if.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index 5aa508a08a691..b5fb2b682e191 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -604,6 +604,7 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
>  
>  	err = dev_set_allmulti(dev, 1);
>  	if (err) {
> +		br_multicast_del_port(p);
>  		kfree(p);	/* kobject not yet init'd, manually free */
>  		goto err1;
>  	}
> @@ -708,6 +709,7 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
>  err3:
>  	sysfs_remove_link(br->ifobj, p->dev->name);
>  err2:
> +	br_multicast_del_port(p);
>  	kobject_put(&p->kobj);
>  	dev_set_allmulti(dev, -1);
>  err1:
> 

I currently cannot test it, but it looks good to me.
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
