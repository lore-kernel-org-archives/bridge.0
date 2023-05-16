Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20D5E83C4D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50E0583C4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1684225855; x=1686817855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M34/aMKN7ljoeujRQEvpnGsETt4x3AV3rvDr+t0qo4I=;
 b=mIHFwFj4/b/BrjiM1IfcwgiHg2Z25LopZs63qB+UIFWa1KKJvsXiITrff343N6CSOk
 T4DXsjUXNmlWSk07koYZJbuqxQDRRWeYeTTlN+8T3F4lkIwddDNQBI+9gbT/QV8SzONo
 QeYwAHE76QLQevJaR0UsAxCZ6kbtoyIPROFGT+bphLahpBfs0LZrPIYE4BxvjDB2bVNW
 lJJOKhNoVxxcEpOwfWqQvzBDCAPQGuCcVIePNflw9bUYSiimpnRER3doCWo6l4K0R5TE
 95Imleo5fUwejVkWafhskPgwwZIPQMP/lx2Jv/2m3jI6KjBW9Fy/0qtLC7LGzaCAiFR4
 f0Mg==
Message-ID: <c4602c0f-76b1-c9a4-f7f1-1f5a02a56564@blackwall.org>
Date: Tue, 16 May 2023 11:30:53 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
 <e8d98be6-d540-59c6-79eb-353715625ea5@blackwall.org>
 <ZGM64ODoVwK8J4u2@u-jnixdorf.ads.avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZGM64ODoVwK8J4u2@u-jnixdorf.ads.avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/2] bridge: Add a limit on FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 16/05/2023 11:12, Johannes Nixdorf wrote:
[snip]
>>>  		return -EMSGSIZE;
>>>  
>>>  #ifdef CONFIG_BRIDGE_VLAN_FILTERING
>>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>>> index 2119729ded2b..64fb359c6e3e 100644
>>> --- a/net/bridge/br_private.h
>>> +++ b/net/bridge/br_private.h
>>> @@ -494,6 +494,8 @@ struct net_bridge {
>>>  #endif
>>>  
>>>  	struct rhashtable		fdb_hash_tbl;
>>> +	u32				fdb_n_entries;
>>> +	u32				fdb_max_entries;
>>
>> These are not critical, so I'd use 4 byte holes in net_bridge and pack it better
>> instead of making it larger.
> 
> For a v2 I now moved it into (conditional) holes now in front of
> CONFIG_BRIDGE_VLAN_FILTERING (only a hole if it is enabled) and
> CONFIG_SWITCHDEV (only a hole if it is disabled). I could not find any
> other holes, but please tell me if you had any others in mind.
> 

Just please don't add them in the first 64 bytes (first cache line) as we use that
in the hot path and keep it for variables used there. I'd say use any of the other
4 byte holes and just add both, so another 4 byte hole would be left after the second one.

>>>  	struct list_head		port_list;
>>>  #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
>>>  	union {
>>
> 
> Thanks for your detailed feedback.

