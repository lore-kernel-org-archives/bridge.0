Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6137E409BD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8B99C4002B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695300707; x=1695905507;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pywDHr26aMIdNlh92ssNp5yeq0EGO9N0Av0l9CJtRTM=;
 b=PKtHqhoXGn9nIQ9VkDzdQ9ZYuibtPM+5sBfvPjfnHGuxcNFLqg8UHQEasNJ2Udm4oA
 mOA5Byvsylgm0UIyUK8RyHfX9GZ3BwMsO0w3t7jCVP6pnbsFey0EGsdrR0nQd4jumJ6c
 g2iBMc7eP+UupKkd2OHyVLPMPjD2P0JKlRZNbPlba3LkGK/QS3LgQTdFYrV+zA5aySaK
 c87ekdu9FT12YrB0ZHJpxmgWv9FBDyn+NHxJL/5JJiQZnvDmoBcg4snlK+qeXnXlxiTV
 O09WYDdPDjj1u1MXAgxEuJ2xT2bdAlssLKaX+bNxpY+4ZNBHFGClvRRa80Gg60+Cg/bo
 Nwew==
Message-ID: <6d06e629-3d6b-98dc-fecc-c5336c434d81@blackwall.org>
Date: Thu, 21 Sep 2023 15:51:45 +0300
MIME-Version: 1.0
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-4-39f0293807b8@avm.de>
 <0ae67e4d-0d51-5290-1255-1fe1b699ca14@blackwall.org>
In-Reply-To: <0ae67e4d-0d51-5290-1255-1fe1b699ca14@blackwall.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v4 4/6] net: bridge: Add netlink knobs
 for number / max learned FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

On 9/21/23 15:41, Nikolay Aleksandrov wrote:
> On 9/19/23 11:12, Johannes Nixdorf wrote:
>> The previous patch added accounting and a limit for the number of
>> dynamically learned FDB entries per bridge. However it did not provide
>> means to actually configure those bounds or read back the count. This
>> patch does that.
>>
>> Two new netlink attributes are added for the accounting and limit of
>> dynamically learned FDB entries:
>>   - IFLA_BR_FDB_N_LEARNED (RO) for the number of entries accounted for
>>     a single bridge.
>>   - IFLA_BR_FDB_MAX_LEARNED (RW) for the configured limit of entries for
>>     the bridge.
>>
>> The new attributes are used like this:
>>
>>   # ip link add name br up type bridge fdb_max_learned 256
>>   # ip link add name v1 up master br type veth peer v2
>>   # ip link set up dev v2
>>   # mausezahn -a rand -c 1024 v2
>>   0.01 seconds (90877 packets per second
>>   # bridge fdb | grep -v permanent | wc -l
>>   256
>>   # ip -d link show dev br
>>   13: br: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 [...]
>>       [...] fdb_n_learned 256 fdb_max_learned 256
>>
>> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
>> ---
>>   include/uapi/linux/if_link.h |  2 ++
>>   net/bridge/br_netlink.c      | 15 ++++++++++++++-
>>   2 files changed, 16 insertions(+), 1 deletion(-)
[snip]
>> @@ -1670,7 +1680,10 @@ static int br_fill_info(struct sk_buff *skb, 
>> const struct net_device *brdev)
>>           nla_put_u8(skb, IFLA_BR_TOPOLOGY_CHANGE_DETECTED,
>>                  br->topology_change_detected) ||
>>           nla_put(skb, IFLA_BR_GROUP_ADDR, ETH_ALEN, br->group_addr) ||
>> -        nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm))
>> +        nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm) ||
>> +        nla_put_u32(skb, IFLA_BR_FDB_N_LEARNED,
>> +            atomic_read(&br->fdb_n_learned)) ||
>> +        nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED, br->fdb_max_learned))
>>           return -EMSGSIZE;
>>   #ifdef CONFIG_BRIDGE_VLAN_FILTERING
>>
> 
> Actually you're using atomic for counting, but using a u32 for the 
> limit, you should cap it because the count can overflow. Or you should
> use atomic64 for the counting.
> 

Scratch all that, I'm speaking nonsense. Need to refresh my mind. :)
EVerything's alright. Sorry for the noise.

