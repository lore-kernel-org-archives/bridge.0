Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=fjY0FTO8qXUt2RMKc1hm3MNTHQeOrTba2M9H2IVVHik=;
 b=Oy3ccJoMPxQacrScaiK5fjgNyTCksoNYehSN8a7xTkU4LrdocSYlSjj+qQec4GbJq2
 2gnjo5J3ep0KULECDMqgiiGz6BW8yy7Ae53z+AKZI0VW27wxBvObFjXYvCXJOTgwb6Y0
 7oMPy7D47EOU/K1KqgD0wZWyVLkW8n+9UP96pczOnIDyVx0zBcc6SQMYR9ii1kd3vtoi
 wkHgltU8G0C50AmhYNn07Oqt/wF7rbWbZ+kYnwQHSSmQtZdfL5EuwgQi5y7F0pOGlP9K
 yQZNTU4E/K7ejs2geW0sxErlcVDtXi6JYTKQiPWX51r9boP86/hCq92CaRMVOlgoDYIY
 mfPg==
Message-ID: <dc47275b-27f8-5de0-ae6e-e82013a03d1f@blackwall.org>
Date: Thu, 10 Mar 2022 18:14:01 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
 <20220310142320.611738-2-schultz.hans+netdev@gmail.com>
 <0eeaf59f-e7eb-7439-3c0a-17e7ac6741f0@blackwall.org>
 <86v8wles1g.fsf@gmail.com>
 <e3f57a64-4823-7cf3-0345-3777c44c2fe4@blackwall.org>
 <8635jp23ez.fsf@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <8635jp23ez.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/3] net: bridge: add fdb flag to
 extent locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On 10/03/2022 18:11, Hans Schultz wrote:
> On tor, mar 10, 2022 at 17:57, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>> On 10/03/2022 17:38, Hans Schultz wrote:
>>> On tor, mar 10, 2022 at 16:42, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>>> On 10/03/2022 16:23, Hans Schultz wrote:
>>>>> Add an intermediate state for clients behind a locked port to allow for
>>>>> possible opening of the port for said clients. This feature corresponds
>>>>> to the Mac-Auth and MAC Authentication Bypass (MAB) named features. The
>>>>> latter defined by Cisco.
>>>>>
>>>>> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
>>>>> ---
>>>>>     include/uapi/linux/neighbour.h |  1 +
>>>>>     net/bridge/br_fdb.c            |  6 ++++++
>>>>>     net/bridge/br_input.c          | 11 ++++++++++-
>>>>>     net/bridge/br_private.h        |  3 ++-
>>>>>     4 files changed, 19 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
>>>>> index db05fb55055e..83115a592d58 100644
>>>>> --- a/include/uapi/linux/neighbour.h
>>>>> +++ b/include/uapi/linux/neighbour.h
>>>>> @@ -208,6 +208,7 @@ enum {
>>>>>     	NFEA_UNSPEC,
>>>>>     	NFEA_ACTIVITY_NOTIFY,
>>>>>     	NFEA_DONT_REFRESH,
>>>>> +	NFEA_LOCKED,
>>>>>     	__NFEA_MAX
>>>>>     };
>>>>
>>>> Hmm, can you use NDA_FLAGS_EXT instead ?
>>>> That should simplify things and reduce the nl size.
>>>>
>>>
>>> I am using NDA_FDB_EXT_ATTRS. NFEA_LOCKED is just the
>>> flag as the other flags section is full wrt the normal flags, but maybe it
>>> doesn't fit in that section?
>>>
>>
>> Actually wait a second, this is completely wrong use of NDA_FDB_EXT_ATTRS.
>> That is a nested attribute, so the code below is wrong. More below..
>>
>>> I will just note that iproute2 support for parsing nested attributes
>>> does not work, thus the BR_FDB_NOTIFY section (lines 150-165) are
>>> obsolete with respect to iproute2 as it is now. I cannot rule out that
>>> someone has some other tool that can handle this BR_FDB_NOTIFY, but I
>>> could not make iproute2 as it stands handle nested attributes. And of
>>> course there is no handling of NDA_FDB_EXT_ATTRS in iproute2 now.
>>>>>>     #define NFEA_MAX (__NFEA_MAX - 1)
>>>>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>>>>> index 6ccda68bd473..396dcf3084cf 100644
>>>>> --- a/net/bridge/br_fdb.c
>>>>> +++ b/net/bridge/br_fdb.c
>>>>> @@ -105,6 +105,7 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
>>>>>     	struct nda_cacheinfo ci;
>>>>>     	struct nlmsghdr *nlh;
>>>>>     	struct ndmsg *ndm;
>>>>> +	u8 ext_flags = 0;
>>>>>     
>>>>>     	nlh = nlmsg_put(skb, portid, seq, type, sizeof(*ndm), flags);
>>>>>     	if (nlh == NULL)
>>>>> @@ -125,11 +126,16 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
>>>>>     		ndm->ndm_flags |= NTF_EXT_LEARNED;
>>>>>     	if (test_bit(BR_FDB_STICKY, &fdb->flags))
>>>>>     		ndm->ndm_flags |= NTF_STICKY;
>>>>> +	if (test_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags))
>>>>> +		ext_flags |= 1 << NFEA_LOCKED;
>>>>>     
>>>>>     	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->key.addr))
>>>>>     		goto nla_put_failure;
>>>>>     	if (nla_put_u32(skb, NDA_MASTER, br->dev->ifindex))
>>>>>     		goto nla_put_failure;
>>>>> +	if (nla_put_u8(skb, NDA_FDB_EXT_ATTRS, ext_flags))
>>>>> +		goto nla_put_failure;
>>>>> +
>>
>> This is wrong. NDA_FDB_EXT_ATTRS is a nested attribute, you can't use it as a u8.
>> You need to have this structure:
>>    [ NDA_FDB_EXT_ATTRS ]
>>     ` [ NFEA_LOCKED ]
>>
>> But that's why I asked if you could use the NDA_FLAGS_EXT attribute. You can see
>> the logic from the neigh code.
> 
> Ahh yes, NDA_FLAGS_EXT was not there in the 5.15.x kernel I have
> originally being making the patches in.
> 
> I hope that the handling of nested attributes has been fixed in
> iproute2. ;-)
> 

It hasn't been broken, I'm guessing you're having issues with the nested bit being set.
Check NLA_F_NESTED and NLA_TYPE_MASK.

>>
>> Also note that you need to account for the new attribute's size in fdb_nlmsg_size().
>>
>>
>>>>>     	ci.ndm_used	 = jiffies_to_clock_t(now - fdb->used);
>>>>>     	ci.ndm_confirmed = 0;
>>>>>     	ci.ndm_updated	 = jiffies_to_clock_t(now - fdb->updated);
>>>>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>>>>> index e0c13fcc50ed..897908484b18 100644
>>>>> --- a/net/bridge/br_input.c
>>>>> +++ b/net/bridge/br_input.c
>>>>> @@ -75,6 +75,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>>>>>     	struct net_bridge_mcast *brmctx;
>>>>>     	struct net_bridge_vlan *vlan;
>>>>>     	struct net_bridge *br;
>>>>> +	unsigned long flags = 0;
>>>>
>>>> Please move this below...
>>>>
>>>>>     	u16 vid = 0;
>>>>>     	u8 state;
>>>>>     
>>>>> @@ -94,8 +95,16 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>>>>>     			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
>>>>>     
>>>>>     		if (!fdb_src || READ_ONCE(fdb_src->dst) != p ||
>>>>> -		    test_bit(BR_FDB_LOCAL, &fdb_src->flags))
>>>>> +		    test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
>>>>> +			if (!fdb_src) {
>>>>
>>>> ... here where it's only used.
>>>>
>>>
>>> Forgot that one. Shall do!
>>>
>>>>> +				set_bit(BR_FDB_ENTRY_LOCKED, &flags);
>>>>> +				br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, flags);
>>>>> +			}
>>>>>     			goto drop;
>>>>> +		} else {
>>>>> +			if (test_bit(BR_FDB_ENTRY_LOCKED, &fdb_src->flags))
>>>>> +				goto drop;
>>>>> +		}
>>>>>     	}
>>>>>     
>>>>>     	nbp_switchdev_frame_mark(p, skb);
>>>>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>>>>> index 48bc61ebc211..f5a0b68c4857 100644
>>>>> --- a/net/bridge/br_private.h
>>>>> +++ b/net/bridge/br_private.h
>>>>> @@ -248,7 +248,8 @@ enum {
>>>>>     	BR_FDB_ADDED_BY_EXT_LEARN,
>>>>>     	BR_FDB_OFFLOADED,
>>>>>     	BR_FDB_NOTIFY,
>>>>> -	BR_FDB_NOTIFY_INACTIVE
>>>>> +	BR_FDB_NOTIFY_INACTIVE,
>>>>> +	BR_FDB_ENTRY_LOCKED,
>>>>>     };
>>>>>     
>>>>>     struct net_bridge_fdb_key {

