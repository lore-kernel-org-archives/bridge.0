Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIpZ6e6Q2CXjnWADVyUuhGg0L3hnwW/AVtfRVGNqssw=;
 b=R2Qx0riGOmd5ErY7G/JJx35SrD2Lj1/JkWGkAJtXSdEqZqsXcNqzvKTqkNh7ypjCP7lDcW5+vTOmLjUXj/kpKvPWZWnqtb9cSn92wMKactWeEu7nETGzVsy9Cdkz4NpvDrU15bIUJp3Wz4LuhmxOyMHjj9AXa8caGE47DtjNCiV9Tj2+IAkzTEly/EV+Hn/C6R40MxIBlnwfqGRuRXdCng4lk+wGjernQPM4oFS8OEdIZnHkN5jZR263EggWTW9C3CqPAv0SREsMkP4pY+Xi2pQCgpsZkMv6uxwxgafAWOjIEHbKXklj6VMn4DZHZgW/s3Lws9IXXejQClRh5r5lIg==
References: <1619594949-20428-1-git-send-email-zhangzhengming@huawei.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <9b7b2580-a3a3-d071-4db3-4ef795a1ea68@nvidia.com>
Date: Wed, 28 Apr 2021 11:00:44 +0300
In-Reply-To: <1619594949-20428-1-git-send-email-zhangzhengming@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH] bridge: Fix possible races between assigning
 rx_handler_data and setting IFF_BRIDGE_PORT bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: zhangzhengming <zhangzhengming@huawei.com>, roopa@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, wangxiaogang3@huawei.com, bridge@lists.linux-foundation.org, xuhanbing@huawei.com

On 28/04/2021 10:29, zhangzhengming wrote:
> From: Zhang Zhengming <zhangzhengming@huawei.com>
> 
> There is a crash in the function br_get_link_af_size_filtered,
> as the port_exists(dev) is true and the rx_handler_data of dev is NULL.
> But the rx_handler_data of dev is correct saved in vmcore.
> 
> The oops looks something like:
>  ...
>  pc : br_get_link_af_size_filtered+0x28/0x1c8 [bridge]
>  ...
>  Call trace:
>   br_get_link_af_size_filtered+0x28/0x1c8 [bridge]
>   if_nlmsg_size+0x180/0x1b0
>   rtnl_calcit.isra.12+0xf8/0x148
>   rtnetlink_rcv_msg+0x334/0x370
>   netlink_rcv_skb+0x64/0x130
>   rtnetlink_rcv+0x28/0x38
>   netlink_unicast+0x1f0/0x250
>   netlink_sendmsg+0x310/0x378
>   sock_sendmsg+0x4c/0x70
>   __sys_sendto+0x120/0x150
>   __arm64_sys_sendto+0x30/0x40
>   el0_svc_common+0x78/0x130
>   el0_svc_handler+0x38/0x78
>   el0_svc+0x8/0xc
> 
> In br_add_if(), we found there is no guarantee that
> assigning rx_handler_data to dev->rx_handler_data
> will before setting the IFF_BRIDGE_PORT bit of priv_flags.
> So there is a possible data competition:
> 
> CPU 0:                                                        CPU 1:
> (RCU read lock)                                               (RTNL lock)
> rtnl_calcit()                                                 br_add_slave()
>   if_nlmsg_size()                                               br_add_if()
>    >                              -> netdev_rx_handler_register
>                                                                     ...
>                                                                     // The order is not guaranteed
>       ...                                                           -> dev->priv_flags |= IFF_BRIDGE_PORT;
>       // The IFF_BRIDGE_PORT bit of priv_flags has been set
>       -> if (br_port_exists(dev)) {
>         // The dev->rx_handler_data has NOT been assigned
>         -> p = br_port_get_rcu(dev);
>         ....
>                                                                     -> rcu_assign_pointer(dev->rx_handler_data, rx_handler_data);
>                                                                      ...
> 
> Fix this by adding memory barrier instruction to ensure the order.
> 
> Signed-off-by: Zhang Zhengming <zhangzhengming@huawei.com>
> Reviewed-by: Zhao Lei <zhaolei69@huawei.com>
> Reviewed-by: Wang Xiaogang <wangxiaogang3@huawei.com>
> ---
>  net/bridge/br_if.c      | 6 ++++++
>  net/bridge/br_netlink.c | 1 +
>  2 files changed, 7 insertions(+)
> 

No need for memory barriers, just use br_port_get_check_rcu() in br_get_link_af_size_filtered()
and check the return value. It will be much simpler and shorter.

Thanks

> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index f7d2f47..42895be 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -636,6 +636,12 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
>  	err = netdev_rx_handler_register(dev, br_get_rx_handler(dev), p);
>  	if (err)
>  		goto err4;
> +
> +	/* Make sure dev->rx_handler_data is written in netdev_rx_handler_register
> +	 * before the bit IFF_BRIDGE_PORT of dev->priv_flags is set.
> +	 * coupled with smp_rmb() in br_get_link_af_size_filtered.
> +	 */
> +	smp_wmb();
>  
>  	dev->priv_flags |= IFF_BRIDGE_PORT;
>  
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index f2b1343..ccc1fd7 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -103,6 +103,7 @@ static size_t br_get_link_af_size_filtered(const struct net_device *dev,
>  
>  	rcu_read_lock();
>  	if (netif_is_bridge_port(dev)) {
> +		smp_rmb(); /* coupled with smp_wmb() in br_add_if() */
>  		p = br_port_get_rcu(dev);
>  		vg = nbp_vlan_group_rcu(p);
>  	} else if (dev->priv_flags & IFF_EBRIDGE) {
> 

