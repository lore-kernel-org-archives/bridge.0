Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A9D340AA9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E9A440A96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMG6WauqKhgIWHUSEv1L/F0leQMvyek/gjyf4WFylv0=;
 b=ndbq4mYnFi6Dsp1YU7APD3a+oiwKJCFY8ap4wo2oO6QuzLmwuyehWXKNK2QTs5wceMHhuDEu+AQqI3vv51/S3ThgVERQAhvuFYM8Vfzo8Q4+Ca1pVJvPCNfKpa+hqocembQsfzJfPOpLlBecKDEUtaDY/8fZ9rvsAxZL0hcS2GQZU39P9plUbEEUtBnLc5W8bQ9al7zqBG91nSl1LEHKoELN02f46WhVDh+RTBOuW0ar2xhURur3qLP7hOSkQ7VGme5xjdhDDxywb4S+1PzSTmbLVxtC2ET0u/j/w73vTXLTO8dcJaL5To0VVnIaFEftDfBjFlmaE77essjWV7ietw==
References: <cover.1674752051.git.petrm@nvidia.com>
 <1bb4bfeaeb14e4b484c6d71adef0b21686468153.1674752051.git.petrm@nvidia.com>
 <e46f0af5-ef19-5260-5524-e53b4e4438f1@blackwall.org>
From: Petr Machata <petrm@nvidia.com>
Date: Mon, 30 Jan 2023 12:07:27 +0100
In-Reply-To: <e46f0af5-ef19-5260-5524-e53b4e4438f1@blackwall.org>
Message-ID: <87mt60f2fr.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 08/16] net: bridge: Add netlink knobs
 for number / maximum MDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>


Nikolay Aleksandrov <razor@blackwall.org> writes:

> On 26/01/2023 19:01, Petr Machata wrote:
>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>> index de531109b947..04261dd2380b 100644
>> --- a/net/bridge/br_multicast.c
>> +++ b/net/bridge/br_multicast.c
>> @@ -766,6 +766,102 @@ static void br_multicast_port_ngroups_dec(struct net_bridge_port *port, u16 vid)
>>  	br_multicast_port_ngroups_dec_one(&port->multicast_ctx);
>>  }
>>  
>> +static int
>> +br_multicast_pmctx_ngroups_set_max(struct net_bridge_mcast_port *pmctx,
>> +				   u32 max, struct netlink_ext_ack *extack)
>> +{
>> +	if (max && max < pmctx->mdb_n_entries) {
>> +		NL_SET_ERR_MSG_FMT_MOD(extack, "Can't set mcast_max_groups=%u, which is below mcast_n_groups=%u",
>> +				       max, pmctx->mdb_n_entries);
>
> Why not? All new entries will be rejected anyway, at most some will expire and make room.

Yeah, as I wrote in the other thread, I can relax the relationship
between max and n.

>> +		return -EINVAL;
>> +	}
>> +
>> +	pmctx->mdb_max_entries = max;
>> +	return 0;
>> +}
>> +
>> +u32 br_multicast_port_ngroups_get(const struct net_bridge_port *port)
>> +{
>> +	u32 n;
>> +
>> +	spin_lock_bh(&port->br->multicast_lock);
>> +	n = port->multicast_ctx.mdb_n_entries;
>> +	spin_unlock_bh(&port->br->multicast_lock);
>
> This is too much just to read the value, we block all IGMP/MLD processing and potentially
> block packet processing on the same core just to read it. These reads are done for notifications,
> getlink and also for fill_slave_info. I think we can just use WRITE/READ_ONCE helpers to access
> it. Especially since the lock is taken for both values (max and current count). We still get a
> snapshop that can be wrong by the time it's returned and about changing it we'll start enforcing
> the new limit with a minor delay which is not a big deal.

Makes sense.

>> +
>> +	return n;
>> +}
>> +
>> +int br_multicast_vlan_ngroups_get(struct net_bridge *br,
>> +				  const struct net_bridge_vlan *v,
>> +				  u32 *n)
>> +{
>> +	if (br_multicast_port_ctx_vlan_disabled(&v->port_mcast_ctx))
>> +		return -EINVAL;
>> +
>> +	spin_lock_bh(&br->multicast_lock);
>> +	*n = v->port_mcast_ctx.mdb_n_entries;
>> +	spin_unlock_bh(&br->multicast_lock);
>> +
>
> ditto and for all accesses below that require the lock..

Yah.
