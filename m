Return-Path: <davem@davemloft.net>
Date: Mon, 18 Dec 2017 13:31:07 -0500 (EST)
Message-Id: <20171218.133107.1225923645891511984.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171218153509.7822-1-nikolay@cumulusnetworks.com>
References: <e4948ab7-0f3b-a4f5-52ea-853a987f1abb@cumulusnetworks.com>
	<20171218153509.7822-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2] net: bridge: fix early call to
 br_stp_change_bridge_id and plug newlink leaks
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: idosch@mellanox.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, avagin@gmail.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 18 Dec 2017 17:35:09 +0200

> The early call to br_stp_change_bridge_id in bridge's newlink can cause
> a memory leak if an error occurs during the newlink because the fdb
> entries are not cleaned up if a different lladdr was specified, also
> another minor issue is that it generates fdb notifications with
> ifindex = 0. Another unrelated memory leak is the bridge sysfs entries
> which get added on NETDEV_REGISTER event, but are not cleaned up in the
> newlink error path. To remove this special case the call to
> br_stp_change_bridge_id is done after netdev register and we cleanup the
> bridge on changelink error via br_dev_delete to plug all leaks.
> 
> This patch makes netlink bridge destruction on newlink error the same as
> dellink and ioctl del which is necessary since at that point we have a
> fully initialized bridge device.
> 
> To reproduce the issue:
> $ ip l add br0 address 00:11:22:33:44:55 type bridge group_fwd_mask 1
> RTNETLINK answers: Invalid argument
> 
> $ rmmod bridge
> [ 1822.142525] =============================================================================
> [ 1822.143640] BUG bridge_fdb_cache (Tainted: G           O    ): Objects remaining in bridge_fdb_cache on __kmem_cache_shutdown()
> [ 1822.144821] -----------------------------------------------------------------------------
 ...
> Fixes: 30313a3d5794 ("bridge: Handle IFLA_ADDRESS correctly when creating bridge device")
> Fixes: 5b8d5429daa0 ("bridge: netlink: register netdevice before executing changelink")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> v2: it's better to use br_dev_delete to clean up because the sysfs entries
> were leaked as well, basically we use it for the bridge fdb flush and sysfs
> entries delete
> 
> Consequently this also would fix the null ptr deref due to the rhashtable
> not being initialized in net-next when br_stp_change_bridge_id is called.

Applied, but doing state changes after register_netdev() is always dicey.

I hope things go well if the device is brought up immediately during
that register_netdev() call and before the stp bridge ID setting is
done.
