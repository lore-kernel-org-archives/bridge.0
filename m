Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYljgxDCOqBS0cG9ozrUiwS1rxenhMHmVw3PQ2I7MOU=;
 b=d881QzRAD7HJEdK+Qa4qIx9zHxINwZwOfb3kpA3Ua0M4Dm2qioxrpfXOsKKom45GcCon9dpNCxBGFMl4NemX5BWegYcFQ+YctBPCmx95vb8dtYW82Y8LutK3Hp3Nvj568N12pBQ1MEGmif8EbalxInWBesV+Is4lDRGt5i7tbkEhzqNkDe0dhwY4hb5CCeWS1Zr8pa5qlTOqKXuKQJW1ocV7qKspF7I3aBjips3MBXadOchJQ7RLEf+poBqWXxBpaUknPWwUUyUuO56N7CpCtLm7VSS5sdtQiGZJenbQFlHmPEpVHSbTr5IMOGOjzNRO1QqCmkZ0eiDXduL7XHucRA==
Message-ID: <25ec6925-8ebf-d2fa-7d73-708ba72cec0a@nvidia.com>
Date: Tue, 25 Jan 2022 11:51:53 +0200
MIME-Version: 1.0
Content-Language: en-US
From: Nikolay Aleksandrov <nikolay@nvidia.com>
References: <20220125061903.714509-1-bpoirier@nvidia.com>
 <cc425efa-1e20-286a-ba96-bc9555142c9c@nvidia.com>
In-Reply-To: <cc425efa-1e20-286a-ba96-bc9555142c9c@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: vlan: Fix dumping with ifindex
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Roopa Prabhu <roopa@nvidia.com>

On 25/01/2022 10:24, Nikolay Aleksandrov wrote:
> On 25/01/2022 08:19, Benjamin Poirier wrote:
>> Specifying ifindex in a RTM_GETVLAN dump leads to an infinite repetition
>> of the same entries. netlink_dump() normally calls the dump function
>> repeatedly until it returns 0 which br_vlan_rtm_dump() never does in
>> that case.
>>
>> Fixes: 8dcea187088b ("net: bridge: vlan: add rtm definitions and dump support")
>> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
>> ---
>>  net/bridge/br_vlan.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
> [snip]
>>
>> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
>> index 84ba456a78cc..2e606f2b9a4d 100644
>> --- a/net/bridge/br_vlan.c
>> +++ b/net/bridge/br_vlan.c
>> @@ -2013,7 +2013,7 @@ static int br_vlan_rtm_dump(struct sk_buff *skb, struct netlink_callback *cb)
>>  		dump_flags = nla_get_u32(dtb[BRIDGE_VLANDB_DUMP_FLAGS]);
>>  
>>  	rcu_read_lock();
>> -	if (bvm->ifindex) {
>> +	if (bvm->ifindex && !s_idx) {
>>  		dev = dev_get_by_index_rcu(net, bvm->ifindex);
>>  		if (!dev) {
>>  			err = -ENODEV;
>> @@ -2022,7 +2022,9 @@ static int br_vlan_rtm_dump(struct sk_buff *skb, struct netlink_callback *cb)
>>  		err = br_vlan_dump_dev(dev, skb, cb, dump_flags);
>>  		if (err && err != -EMSGSIZE)
>>  			goto out_err;
>> -	} else {
>> +		else if (!err)
>> +			idx++;
>> +	} else if (!bvm->ifindex) {
>>  		for_each_netdev_rcu(net, dev) {
>>  			if (idx < s_idx)
>>  				goto skip;
> 
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

Actually I'd prefer an alternative that would encapsulate handling the single
device dump in its block, avoid all the "else if"s and is simpler (untested):

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 84ba456a78cc..43201260e37b 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -2020,7 +2020,8 @@ static int br_vlan_rtm_dump(struct sk_buff *skb, struct netlink_callback *cb)
                        goto out_err;
                }
                err = br_vlan_dump_dev(dev, skb, cb, dump_flags);
-               if (err && err != -EMSGSIZE)
+               /* if the dump completed without an error we return 0 here */
+               if (err != -EMSGSIZE)
                        goto out_err;
        } else {
                for_each_netdev_rcu(net, dev) {
