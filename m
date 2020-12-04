Return-Path: <nikolay@nvidia.com>
References: <20201201214047.128948-1-Joseph.Huang@garmin.com>
 <20201204213900.234913-1-Joseph.Huang@garmin.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <f771d272-3146-2d8c-391d-87d1db8b8e76@nvidia.com>
Date: Sat, 5 Dec 2020 00:11:54 +0200
In-Reply-To: <20201204213900.234913-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1607119925; bh=SIrXPGXC6Hwt8tTaGJT7TVNVxhsXQlzs9LLSzVMWLtw=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
 Authentication-Results:Subject:To:References:From:Message-ID:Date:
 User-Agent:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
 X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=Nyj65cjfR+DAw7oiiXJZKoTK3XLUmdryLntM7KISzcUGnZn1h1phv+rZ/Xs7fBwWm
 L0BAy2U+kFyVzbUx/LYgvRm+D5O3KelNZS5jZFep+rRgB+fiUpb5LMLEshlbtdzNYC
 bu9FqOlY95aUd8iS005ZfC7qv8ir/BsryO+27J+hCv92oCPsnR114hLCP7IpGhp8Ha
 vgiZcKo+DErRMt54TJLbSTtVoH1UxTyYZuRnHInpdnOZkxUpKHdwFmhgkT/rNPErjv
 nyeRqN5aZqZLYjaj4h08PU8Wb5LAJcj4toOG/+dNsu/YvhBwE28xmwhEcSERKerPsc
 sGv7jP5Ai43IA==
Subject: Re: [Bridge] [PATCH v2] bridge: Fix a deadlock when enabling
 multicast snooping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joseph Huang <Joseph.Huang@garmin.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/12/2020 23:39, Joseph Huang wrote:
> When enabling multicast snooping, bridge module deadlocks on multicast_lock
> if 1) IPv6 is enabled, and 2) there is an existing querier on the same L2
> network.
> 
> The deadlock was caused by the following sequence: While holding the lock,
> br_multicast_open calls br_multicast_join_snoopers, which eventually causes
> IP stack to (attempt to) send out a Listener Report (in igmp6_join_group).
> Since the destination Ethernet address is a multicast address, br_dev_xmit
> feeds the packet back to the bridge via br_multicast_rcv, which in turn
> calls br_multicast_add_group, which then deadlocks on multicast_lock.
> 
> The fix is to move the call br_multicast_join_snoopers outside of the
> critical section. This works since br_multicast_join_snoopers only deals
> with IP and does not modify any multicast data structures of the bridge,
> so there's no need to hold the lock.
> 
> Steps to reproduce:
> 1. sysctl net.ipv6.conf.all.force_mld_version=1
> 2. have another querier
> 3. ip link set dev bridge type bridge mcast_snooping 0 && \
>    ip link set dev bridge type bridge mcast_snooping 1 < deadlock >
> 
> A typical call trace looks like the following:
> 
> [  936.251495]  _raw_spin_lock+0x5c/0x68
> [  936.255221]  br_multicast_add_group+0x40/0x170 [bridge]
> [  936.260491]  br_multicast_rcv+0x7ac/0xe30 [bridge]
> [  936.265322]  br_dev_xmit+0x140/0x368 [bridge]
> [  936.269689]  dev_hard_start_xmit+0x94/0x158
> [  936.273876]  __dev_queue_xmit+0x5ac/0x7f8
> [  936.277890]  dev_queue_xmit+0x10/0x18
> [  936.281563]  neigh_resolve_output+0xec/0x198
> [  936.285845]  ip6_finish_output2+0x240/0x710
> [  936.290039]  __ip6_finish_output+0x130/0x170
> [  936.294318]  ip6_output+0x6c/0x1c8
> [  936.297731]  NF_HOOK.constprop.0+0xd8/0xe8
> [  936.301834]  igmp6_send+0x358/0x558
> [  936.305326]  igmp6_join_group.part.0+0x30/0xf0
> [  936.309774]  igmp6_group_added+0xfc/0x110
> [  936.313787]  __ipv6_dev_mc_inc+0x1a4/0x290
> [  936.317885]  ipv6_dev_mc_inc+0x10/0x18
> [  936.321677]  br_multicast_open+0xbc/0x110 [bridge]
> [  936.326506]  br_multicast_toggle+0xec/0x140 [bridge]
> 
> Fixes: 4effd28c1245 ("bridge: join all-snoopers multicast address")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---

Hi,
Thank you for fixing it up, a few minor nits below. Overall the patch
looks good.


>  net/bridge/br_device.c    |  6 ++++++
>  net/bridge/br_multicast.c | 33 ++++++++++++++++++++++++---------
>  net/bridge/br_private.h   | 10 ++++++++++
>  3 files changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 7730c8f3cb53..d3ea9d0779fb 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -177,6 +177,9 @@ static int br_dev_open(struct net_device *dev)
>  	br_stp_enable_bridge(br);
>  	br_multicast_open(br);
>  
> +	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
> +		br_multicast_join_snoopers(br);
> +
>  	return 0;
>  }
>  
> @@ -197,6 +200,9 @@ static int br_dev_stop(struct net_device *dev)
>  	br_stp_disable_bridge(br);
>  	br_multicast_stop(br);
>  
> +	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
> +		br_multicast_leave_snoopers(br);
> +
>  	netif_stop_queue(dev);
>  
>  	return 0;
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index eae898c3cff7..426fe00db708 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -3286,7 +3286,7 @@ static inline void br_ip6_multicast_join_snoopers(struct net_bridge *br)
>  }
>  #endif
>  
> -static void br_multicast_join_snoopers(struct net_bridge *br)
> +void br_multicast_join_snoopers(struct net_bridge *br)
>  {
>  	br_ip4_multicast_join_snoopers(br);
>  	br_ip6_multicast_join_snoopers(br);
> @@ -3317,7 +3317,7 @@ static inline void br_ip6_multicast_leave_snoopers(struct net_bridge *br)
>  }
>  #endif
>  
> -static void br_multicast_leave_snoopers(struct net_bridge *br)
> +void br_multicast_leave_snoopers(struct net_bridge *br)
>  {
>  	br_ip4_multicast_leave_snoopers(br);
>  	br_ip6_multicast_leave_snoopers(br);
> @@ -3336,9 +3336,6 @@ static void __br_multicast_open(struct net_bridge *br,
>  
>  void br_multicast_open(struct net_bridge *br)
>  {
> -	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
> -		br_multicast_join_snoopers(br);
> -
>  	__br_multicast_open(br, &br->ip4_own_query);
>  #if IS_ENABLED(CONFIG_IPV6)
>  	__br_multicast_open(br, &br->ip6_own_query);
> @@ -3354,9 +3351,6 @@ void br_multicast_stop(struct net_bridge *br)
>  	del_timer_sync(&br->ip6_other_query.timer);
>  	del_timer_sync(&br->ip6_own_query.timer);
>  #endif
> -
> -	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
> -		br_multicast_leave_snoopers(br);
>  }
>  
>  void br_multicast_dev_del(struct net_bridge *br)
> @@ -3487,6 +3481,8 @@ static void br_multicast_start_querier(struct net_bridge *br,
>  int br_multicast_toggle(struct net_bridge *br, unsigned long val)
>  {
>  	struct net_bridge_port *port;
> +	bool join_snoopers = false;
> +	bool leave_snoopers = false;
>  

We use reverse xmas tree order, longest to shortest, so these two have to be
swapped, but one more related thing further below..

>  	spin_lock_bh(&br->multicast_lock);
>  	if (!!br_opt_get(br, BROPT_MULTICAST_ENABLED) == !!val)
> @@ -3495,7 +3491,7 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
>  	br_mc_disabled_update(br->dev, val);
>  	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
>  	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
> -		br_multicast_leave_snoopers(br);
> +		leave_snoopers = true;
>  		goto unlock;
>  	}
>  
> @@ -3506,9 +3502,28 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
>  	list_for_each_entry(port, &br->port_list, list)
>  		__br_multicast_enable_port(port);
>  
> +	join_snoopers = true;
> +
>  unlock:
>  	spin_unlock_bh(&br->multicast_lock);
>  
> +	/* br_multicast_join_snoopers has the potential to cause
> +	 * an MLD Report/Leave to be delivered to br_multicast_rcv,
> +	 * which would in turn call br_multicast_add_group, which would
> +	 * attempt to acquire multicast_lock. This function should be
> +	 * called after the lock has been released to avoid deadlocks on
> +	 * multicast_lock.
> +	 *
> +	 * br_multicast_leave_snoopers does not have the problem since
> +	 * br_multicast_rcv first checks BROPT_MULTICAST_ENABLED, and
> +	 * returns without calling br_multicast_ipv4/6_rcv if it's not
> +	 * enabled. Moved both functions out just for symmetry.
> +	 */

Nice comment, thanks!

> +	if (join_snoopers)
> +		br_multicast_join_snoopers(br);
> +	else if (leave_snoopers)
> +		br_multicast_leave_snoopers(br);

If I'm not missing anything this can be just 1 bool like "change_snoopers" or something
which if set to true will check BROPT_MULTICAST_ENABLED and act accordingly, i.e.
if (change_snoopers) {
    if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
         br_multicast_join_snoopers(br);
    else
         br_multicast_leave_snoopers(br);
}
 
This is not really something critical, just an observation. Up to your
preference if you decide to leave it with 2 bools. :-)

Cheers,
 Nik

> +
>  	return 0;
>  }
>  
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 345118e35c42..8424464186a6 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -792,6 +792,8 @@ void br_multicast_del_port(struct net_bridge_port *port);
>  void br_multicast_enable_port(struct net_bridge_port *port);
>  void br_multicast_disable_port(struct net_bridge_port *port);
>  void br_multicast_init(struct net_bridge *br);
> +void br_multicast_join_snoopers(struct net_bridge *br);
> +void br_multicast_leave_snoopers(struct net_bridge *br);
>  void br_multicast_open(struct net_bridge *br);
>  void br_multicast_stop(struct net_bridge *br);
>  void br_multicast_dev_del(struct net_bridge *br);
> @@ -969,6 +971,14 @@ static inline void br_multicast_init(struct net_bridge *br)
>  {
>  }
>  
> +static inline void br_multicast_join_snoopers(struct net_bridge *br)
> +{
> +}
> +
> +static inline void br_multicast_leave_snoopers(struct net_bridge *br)
> +{
> +}
> +
>  static inline void br_multicast_open(struct net_bridge *br)
>  {
>  }
> 

