Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D4B983C09
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F92483BFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1687436869; x=1690028869;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u/ygENi/TRukcGplsNjzBiVqhwMmSkq5YICSahejN1A=;
 b=IaWVH/NfxheHiIX2w+iB/Zgv1GLJfgphI/V62AlVOx0cTJ23faHZsZ7mLXzortoVZ4
 L/uF1RErUsTdNm++peofR5duxFvM1gGZU89sjYnxvTe3L+qkZAbuh2DVePoUp8V9XkQs
 WIyxiaj68uyUIjkl+GaiO9gQugRg0aQMD4bXv3Jmcn7PaCyoU/gNPnnvrhZzGRrqa1w0
 dgtm7ru9Xqduy6trhRzeyihX4iRjg8SCk+Rd8TxnHfNs2vUbmywoqyiG6P8edh3iKvol
 dy4CttPKvjxisVEBjauwyOJOq6bvE5+wg4ELqhrSLQ/a7GqN2onFoBJJcPJkPxLPrLKv
 c02w==
Message-ID: <475afa9a-708d-f06c-e203-4c0c32d1cebf@blackwall.org>
Date: Thu, 22 Jun 2023 15:27:47 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230619071444.14625-1-jnixdorf-oss@avm.de>
 <20230619071444.14625-3-jnixdorf-oss@avm.de>
 <aac18591-b06b-d48d-368a-99fc3ac50e24@blackwall.org>
 <ZJGrLYsT7CcavLeR@u-jnixdorf.ads.avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZJGrLYsT7CcavLeR@u-jnixdorf.ads.avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 2/3] bridge: Add a limit on learned
 FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Vladimir Oltean <vladimir.oltean@nxp.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Oleksij Rempel <linux@rempel-privat.de>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>

On 20/06/2023 16:35, Johannes Nixdorf wrote:
> On Tue, Jun 20, 2023 at 09:55:31AM +0300, Nikolay Aleksandrov wrote:
>> On 6/19/23 10:14, Johannes Nixdorf wrote:
>>> +/* Set a FDB flag that implies the entry was not learned, and account
>>> + * for changes in the learned status.
>>> + */
>>> +static void __fdb_set_flag_not_learned(struct net_bridge *br,
>>> +				       struct net_bridge_fdb_entry *fdb,
>>> +				       long nr)
>>> +{
>>> +	WARN_ON_ONCE(!(BIT(nr) & BR_FDB_NOT_LEARNED_MASK));
>>
>> Please use *_bit
> 
> Can you tell me which *_bit helper you had in mind? The shortest option I could
> come up with the ones I found seemed needlessly verbose and wasteful:
> 
>   static const unsigned long br_fdb_not_learned_mask = BR_FDB_NOT_LEARNED_MASK;
>   ...
>   WARN_ON_ONCE(test_bit(nr, &br_fdb_not_learned_mask));
> 
>>> +
>>> +	/* learned before, but we set a flag that implies it's manually added */
>>> +	if (!(fdb->flags & BR_FDB_NOT_LEARNED_MASK))
>>
>> Please use *_bit
> 
> This will be fixed by the redesign to get rid of my use of hash_lock
> (proposed later in this mail), as I'll only have to test one bit and can
> use test_and_clear_bit then.
> 
>>> +		br->fdb_cur_learned_entries--;
>>> +	set_bit(nr, &fdb->flags);
>>> +}
>>
>> Having a helper that conditionally decrements only is counterintuitive and
>> people can get confused. Either add 2 helpers for inc/dec and use
>> them where appropriate or don't use helpers at all.
> 
> The *_set_bit helper can only cause the count to drop, as there
> is currently no flag that could turn a manually added entry back into
> a dynamically learned one.
> 
> The analogous helper that increments the value would be *_clear_bit,
> which I did not add because it has no users.
> 
>>> +	spin_unlock_bh(&br->hash_lock);
>>> +}
>>> +
>>>   /* When a static FDB entry is deleted, the HW address from that entry is
>>>    * also removed from the bridge private HW address list and updates all
>>>    * the ports with needed information.
>>> @@ -321,6 +353,8 @@ static void fdb_del_hw_addr(struct net_bridge *br, const unsigned char *addr)
>>>   static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
>>>   		       bool swdev_notify)
>>>   {
>>> +	bool learned = !(f->flags & BR_FDB_NOT_LEARNED_MASK);
>>
>> *_bit
> 
> I do not know a *_bit helper that would help me test the intersection
> of multiple bits on both sides. Do you have any in mind?
> 
>>> +
>>>   	return fdb;
>>>   }
>>> @@ -894,7 +940,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>>>   			}
>>>   			if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags)))
>>> -				set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>>> +				fdb_set_flag_not_learned(br, fdb, BR_FDB_ADDED_BY_USER);
>>
>> Unacceptable to take hash_lock and block all learning here, eventual
>> consistency is ok or some other method that is much lighter and doesn't
>> block all learning or requires a lock.
> 
> At the time of writing v2, this seemed difficult because we want to test
> multiple bits and increment a counter, but remembering that clear_bit
> is never called for the bits I care about I came up with the following
> approach:
> 
>   a) Add a new flag BR_FDB_DYNAMIC_LEARNED, which is set to 1 iff
>      BR_FDB_ADDED_BY_USER or BR_FDB_LOCAL are set in br_create.
>      Every time BR_FDB_ADDED_BY_USER or BR_FDB_LOCAL is set, also clear
>      BR_FDB_DYNAMIC_LEARNED, and decrement the count if it was 1 before.
>      This solves the problem of testing two bits at once, and would not
>      have been possible if we had a code path that could clear both bits,
>      as it is not as easy to decide when to set BR_FDB_DYNAMIC_LEARNED
>      again in that case.

I think you can try without adding any new flags, the places that add dynamic
entries are known for the inc part of the problem, and an entry can become
local/added_by_user again only through well known paths as well. You may be able to
infer whether to inc/dec and make it work with careful fn argument passing.
Could you please look into that way? I'd prefer that we don't add new flags as
there are already so many.

>   b) Replace the current count with an atomic_t.
> 

Sounds good.

> I'll change it this way for v3.
> 
>>>   		return -EMSGSIZE;
>>>   #ifdef CONFIG_BRIDGE_VLAN_FILTERING
>>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>>> index 2119729ded2b..df079191479e 100644
>>> --- a/net/bridge/br_private.h
>>> +++ b/net/bridge/br_private.h
>>> @@ -275,6 +275,8 @@ enum {
>>>   	BR_FDB_LOCKED,
>>>   };
>>> +#define BR_FDB_NOT_LEARNED_MASK (BIT(BR_FDB_LOCAL) | BIT(BR_FDB_ADDED_BY_USER))
>>
>> Not learned sounds confusing and doesn't accurately describe the entry.
>> BR_FDB_DYNAMIC_LEARNED perhaps or some other name, that doesn't cause
>> double negatives (not not learned).
> 
> Your proposal would not have captured the mask, as it describes all the
> opposite cases, which were _not_ dynamically learned.
> 
> But with the proposed new flag from the hash_lock comment we can trivially
> flip the meaning, so I went with your proposed name there.

