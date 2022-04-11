Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=b5wwbXc/MkE2BXw9wRrOvThE2qwMTK/x2Eay3+i8p8Y=;
 b=RuXx0L0svxgM1uUy8O5SR+KE9fQGnauKe/NAG+6BRPfBuD/FSYwu4ue2VpaKvbDF+S
 sx/ts5r6zWUBwb07fKFEpz2WczUL3+IJqiki1yp6dxLGxRr7JOLQL5YzWB9899umkoak
 Qc6lX54QI5mfFTeBmMrJYmU3N1d6eakuWywVC6UvOO+TFXsdpepc5VUr9WU4dL7ffkSp
 WUFmdZPABDS5XAjIAaFnQ/7ovVG5g1SNm9NHjoRKwhHHlt5nJaHq8O5sxt9yRmvIBhFB
 KvBevQtqQ3calc3NDma+2E1IFjLtWNwXzHlp1SwaZMAwAjPl+7PLk2ogNaX6tqzWMLrA
 l1Pw==
Message-ID: <56d91af5-3a5b-be05-a45f-936e427fe746@blackwall.org>
Date: Mon, 11 Apr 2022 12:03:56 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220409105857.803667-1-razor@blackwall.org>
 <20220409105857.803667-6-razor@blackwall.org> <YlPtg6eHuWaOEy/7@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <YlPtg6eHuWaOEy/7@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 5/6] net: bridge: fdb: add support for
 flush filtering based on ifindex
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com

On 11/04/2022 11:57, Ido Schimmel wrote:
> On Sat, Apr 09, 2022 at 01:58:56PM +0300, Nikolay Aleksandrov wrote:
>> Add support for fdb flush filtering based on destination ifindex. The
>> ifindex must either match a port's device ifindex or the bridge's.
>>
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>>  include/uapi/linux/if_bridge.h | 1 +
>>  net/bridge/br_fdb.c            | 7 +++++++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
>> index 4638d7e39f2a..67ee12586844 100644
>> --- a/include/uapi/linux/if_bridge.h
>> +++ b/include/uapi/linux/if_bridge.h
>> @@ -819,6 +819,7 @@ enum {
>>  	FDB_FLUSH_NDM_STATE_MASK,
>>  	FDB_FLUSH_NDM_FLAGS,
>>  	FDB_FLUSH_NDM_FLAGS_MASK,
>> +	FDB_FLUSH_PORT_IFINDEX,
>>  	__FDB_FLUSH_MAX
>>  };
>>  #define FDB_FLUSH_MAX (__FDB_FLUSH_MAX - 1)
>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>> index 340a2ace1d5e..53208adf7474 100644
>> --- a/net/bridge/br_fdb.c
>> +++ b/net/bridge/br_fdb.c
>> @@ -628,6 +628,7 @@ static const struct nla_policy br_fdb_flush_policy[FDB_FLUSH_MAX + 1] = {
>>  	[FDB_FLUSH_NDM_FLAGS]	= { .type = NLA_U16 },
>>  	[FDB_FLUSH_NDM_STATE_MASK]	= { .type = NLA_U16 },
>>  	[FDB_FLUSH_NDM_FLAGS_MASK]	= { .type = NLA_U16 },
>> +	[FDB_FLUSH_PORT_IFINDEX]	= { .type = NLA_S32 },
>>  };
>>  
>>  int br_fdb_flush_nlattr(struct net_bridge *br, struct nlattr *fdb_flush_attr,
>> @@ -664,6 +665,12 @@ int br_fdb_flush_nlattr(struct net_bridge *br, struct nlattr *fdb_flush_attr,
>>  		ndm_flags_mask = nla_get_u16(fdb_flush_tb[FDB_FLUSH_NDM_FLAGS_MASK]);
>>  		desc.flags_mask |= __ndm_flags_to_fdb_flags(ndm_flags_mask);
>>  	}
>> +	if (fdb_flush_tb[FDB_FLUSH_PORT_IFINDEX]) {
>> +		int port_ifidx;
>> +
>> +		port_ifidx = nla_get_u32(fdb_flush_tb[FDB_FLUSH_PORT_IFINDEX]);
>> +		desc.port_ifindex = port_ifidx;
> 
> Commit message says "ifindex must either match a port's device ifindex
> or the bridge's", but there is no validation. I realize such an
> operation won't flush anything, but it's cleaner to just reject it here.
> 

Sure, I can add a check for the device when specified.

>> +	}
>>  
>>  	br_debug(br, "flushing port ifindex: %d vlan id: %u flags: 0x%lx flags mask: 0x%lx\n",
>>  		 desc.port_ifindex, desc.vlan_id, desc.flags, desc.flags_mask);
>> -- 
>> 2.35.1
>>

