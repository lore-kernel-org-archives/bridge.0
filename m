Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C26076102D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 019CA6102F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JUUjEFx3Nk/775g2gSfW9ymadFWHIooRW2ZkQPyxtlc=;
 b=cB5KPcXPZTKe4+Ra9C+fiK1YlpRE9AKHeXyKkRJvgLS2OON6Wn7yQbf1MTUjbLI8wO
 QN4r9b7h0eCbu28FI7Tcel2LJBGKMtDMteqxGHo0aNd+hEUiaDKYptcj4ohWbDX6phom
 gtMQ/ijTcSxcHDNM7UufwBAIAjD54uS+E+AzU7zaZ9EFOcgZu2w8qavBonZ7f8HC/W+/
 2PvHReMcjio4c333/wEO8qxLbRGUP/pOX6Z6r8F9jzG6az763Wz0OG796UbxB9eifR/o
 /ICCN9tVaHy6DhMNLQcPgvJlIE7sNqZ+fErHLFZmE7BO8BTrDMeH/J48ybRUCij7rEOg
 oilg==
Message-ID: <9ed8f5c0-ef73-3e12-a822-b0153f5237bb@blackwall.org>
Date: Thu, 2 Feb 2023 10:57:07 +0200
MIME-Version: 1.0
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
References: <cover.1675271084.git.petrm@nvidia.com>
 <706d902460b69454ffeb57908beb8dce46e9b064.1675271084.git.petrm@nvidia.com>
 <18e82e5a-1ee9-94ee-78a7-15bc08b62978@blackwall.org>
In-Reply-To: <18e82e5a-1ee9-94ee-78a7-15bc08b62978@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next mlxsw v2 07/16] net: bridge: Maintain
 number of MDB entries in net_bridge_mcast_port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

On 02/02/2023 10:56, Nikolay Aleksandrov wrote:
> On 01/02/2023 19:28, Petr Machata wrote:
>> The MDB maintained by the bridge is limited. When the bridge is configured
>> for IGMP / MLD snooping, a buggy or malicious client can easily exhaust its
>> capacity. In SW datapath, the capacity is configurable through the
>> IFLA_BR_MCAST_HASH_MAX parameter, but ultimately is finite. Obviously a
>> similar limit exists in the HW datapath for purposes of offloading.
>>
>> In order to prevent the issue of unilateral exhaustion of MDB resources,
>> introduce two parameters in each of two contexts:
>>
>> - Per-port and per-port-VLAN number of MDB entries that the port
>>   is member in.
>>
>> - Per-port and (when BROPT_MCAST_VLAN_SNOOPING_ENABLED is enabled)
>>   per-port-VLAN maximum permitted number of MDB entries, or 0 for
>>   no limit.
>>
>> The per-port multicast context is used for tracking of MDB entries for the
>> port as a whole. This is available for all bridges.
>>
>> The per-port-VLAN multicast context is then only available on
>> VLAN-filtering bridges on VLANs that have multicast snooping on.
>>
>> With these changes in place, it will be possible to configure MDB limit for
>> bridge as a whole, or any one port as a whole, or any single port-VLAN.
>>
>> Note that unlike the global limit, exhaustion of the per-port and
>> per-port-VLAN maximums does not cause disablement of multicast snooping.
>> It is also permitted to configure the local limit larger than hash_max,
>> even though that is not useful.
>>
>> In this patch, introduce only the accounting for number of entries, and the
>> max field itself, but not the means to toggle the max. The next patch
>> introduces the netlink APIs to toggle and read the values.
>>
>> Signed-off-by: Petr Machata <petrm@nvidia.com>
>> ---
>>
>> Notes:
>>     v2:
>>     - In br_multicast_port_ngroups_inc_one(), bounce
>>       if n>=max, not if n==max
>>     - Adjust extack messages to mention ngroups, now that
>>       the bounces appear when n>=max, not n==max
>>     - In __br_multicast_enable_port_ctx(), do not reset
>>       max to 0. Also do not count number of entries by
>>       going through _inc, as that would end up incorrectly
>>       bouncing the entries.
>>
>>  net/bridge/br_multicast.c | 132 +++++++++++++++++++++++++++++++++++++-
>>  net/bridge/br_private.h   |   2 +
>>  2 files changed, 133 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>> index 51b622afdb67..e7ae339a8757 100644
>> --- a/net/bridge/br_multicast.c
>> +++ b/net/bridge/br_multicast.c
>> @@ -31,6 +31,7 @@
>>  #include <net/ip6_checksum.h>
>>  #include <net/addrconf.h>
>>  #endif
>> +#include <trace/events/bridge.h>
>>  
>>  #include "br_private.h"
>>  #include "br_private_mcast_eht.h"
>> @@ -234,6 +235,29 @@ br_multicast_pg_to_port_ctx(const struct net_bridge_port_group *pg)
>>  	return pmctx;
>>  }
>>  
>> +static struct net_bridge_mcast_port *
>> +br_multicast_port_vid_to_port_ctx(struct net_bridge_port *port, u16 vid)
>> +{
>> +	struct net_bridge_mcast_port *pmctx = NULL;
>> +	struct net_bridge_vlan *vlan;
>> +
>> +	lockdep_assert_held_once(&port->br->multicast_lock);
>> +
>> +	if (!br_opt_get(port->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
>> +		return NULL;
>> +
>> +	/* Take RCU to access the vlan. */
>> +	rcu_read_lock();
>> +
>> +	vlan = br_vlan_find(nbp_vlan_group_rcu(port), vid);
>> +	if (vlan && !br_multicast_port_ctx_vlan_disabled(&vlan->port_mcast_ctx))
>> +		pmctx = &vlan->port_mcast_ctx;
>> +
>> +	rcu_read_unlock();
>> +
>> +	return pmctx;
>> +}
>> +
>>  /* when snooping we need to check if the contexts should be used
>>   * in the following order:
>>   * - if pmctx is non-NULL (port), check if it should be used
>> @@ -668,6 +692,82 @@ void br_multicast_del_group_src(struct net_bridge_group_src *src,
>>  	__br_multicast_del_group_src(src);
>>  }
>>  
>> +static int
>> +br_multicast_port_ngroups_inc_one(struct net_bridge_mcast_port *pmctx,
>> +				  struct netlink_ext_ack *extack)
>> +{
>> +	if (pmctx->mdb_max_entries &&
>> +	    pmctx->mdb_n_entries >= pmctx->mdb_max_entries)
> 
> These should be using *_ONCE() because of the next patch.
> KCSAN might be sad otherwise. :)
> 
>> +		return -E2BIG;
>> +
>> +	pmctx->mdb_n_entries++;
> 
> WRITE_ONCE()
> 
>> +	return 0;
>> +}
>> +
>> +static void br_multicast_port_ngroups_dec_one(struct net_bridge_mcast_port *pmctx)
>> +{
>> +	WARN_ON_ONCE(pmctx->mdb_n_entries-- == 0);
> 
> READ_ONCE()

err, I meant WRITE_ONCE() of course. :)
Need to get coffee.

> 
>> +}
>> +

