Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF80B41CC0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F87F41C87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKnfzw/ViIlREqwjQaW/erWOkesMY9oYi+bz2iUs/0Y=;
 b=tREmWIqTEJs+68i9aFFssv5LzhyYKBOfroMf80Qt/YvcvH9a2n4QV1Ewbelby7XD2HbYFYI6xsHdQ3GMGL/P+jKq/iJR+J6+UIonSfbYwRSs03mUpPkpOMIcfTrSrzs5R/QJF31ARLMmBLPSJwGwO59QzqheMgwwGi6xR+O11eBZ5gKB2ak8HN7coG8TAzeh78vj8CTTV9/Z4m7viSUcgO2n0L/LpJ2qM8WmrhnBUZ+3fCN/32N3o0P3IYkWpuTP7KEj61VasEXZQEHnq//lbAqDbmvQU7gtmQ8ah1js5I/ziu0XMf+ZL5Lumj0sciqqYrPxb/PutnrHk3vN8uweQQ==
References: <cover.1675271084.git.petrm@nvidia.com>
 <706d902460b69454ffeb57908beb8dce46e9b064.1675271084.git.petrm@nvidia.com>
 <18e82e5a-1ee9-94ee-78a7-15bc08b62978@blackwall.org>
From: Petr Machata <petrm@nvidia.com>
Date: Thu, 2 Feb 2023 11:09:30 +0100
In-Reply-To: <18e82e5a-1ee9-94ee-78a7-15bc08b62978@blackwall.org>
Message-ID: <87v8kke30l.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>


Nikolay Aleksandrov <razor@blackwall.org> writes:

> On 01/02/2023 19:28, Petr Machata wrote:
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

I didn't see any (relevant) KCSAN warnings on x86_64. But yeah, it
(and the others you cited) should be *_ONCE.
