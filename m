Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E3BC817A7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C6FD8145C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=8CiaLkECx3krBdKp6oIvGxj9L4zpqrT521rHLsVwe9c=;
 b=g1jkYz6hbaud7MJPfP0jk8kKHIWsdovgRzcgSUPODZpbjnDzLbWqeUUvMfhcoOvP2o
 htWSK5oUojOo772tVxb2ovafBDv5nHDssuSAXh0GJ8cr7DNbVH/vcT15T6DsrywtkG5L
 9N2MXav1SOO5iaoM2/si+QncOtmAC0ORMqsdfWEui/zHqOVusXm259fNbVucOTCO+opN
 5uXJo1y/7kZboMlhv5jq7zi5Bl/1QIwfHlz+GnMU49Cg/+iICR3oJzR79/HXC4KyJO1N
 JcH24SsTQu4KQUwyRQaXQbX4+AADrP7Ie842gQXGkPCgI4H7n1r5lA5bPBLHy+glgCN6
 L/Iw==
Message-ID: <d1de0337-ae16-7dca-b212-1a4e85129c31@blackwall.org>
Date: Sat, 27 Aug 2022 16:54:21 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-2-netdev@kapio-technology.com>
 <e9eb5b72-073a-f182-13b7-37fc53611d5f@blackwall.org>
 <YwoZdzVCkMV8vGtl@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <YwoZdzVCkMV8vGtl@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 1/6] net: bridge: add locked entry
 fdb flag to extend locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Hans Schultz <netdev@kapio-technology.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On 27/08/2022 16:17, Ido Schimmel wrote:
> On Sat, Aug 27, 2022 at 02:30:25PM +0300, Nikolay Aleksandrov wrote:
>> On 26/08/2022 14:45, Hans Schultz wrote:
>> Please add the blackhole flag in a separate patch.
> 
> +1
> 
> [...]
> 
>>> @@ -185,6 +196,9 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>>>  		if (test_bit(BR_FDB_LOCAL, &dst->flags))
>>>  			return br_pass_frame_up(skb);
>>>  
>>> +		if (test_bit(BR_FDB_BLACKHOLE, &dst->flags))
>>> +			goto drop;
>>> +
>> Not happy about adding a new test in arguably the most used fast-path, but I don't see
>> a better way to do blackhole right now. Could you please make it an unlikely() ?
>>
>> I guess the blackhole flag will be allowed for user-space to set at some point, why
>> not do it from the start?
>>
>> Actually adding a BR_FDB_LOCAL and BR_FDB_BLACKHOLE would be a conflict above -
>> the packet will be received. So you should move the blackhole check above the
>> BR_FDB_LOCAL one if user-space is allowed to set it to any entry.
> 
> Agree about unlikely() and making it writeable from user space from the
> start. This flag is different from the "locked" flag that should only be
> ever set by the kernel.
> 
> Regarding BR_FDB_LOCAL, I think BR_FDB_BLACKHOLE should only be allowed
> with BR_FDB_LOCAL as these entries are similar in the following ways:
> 
> 1. It doesn't make sense to associate a blackhole entry with a specific
> port. The packet will never be forwarded to this port, but dropped by
> the bridge. This means user space will add them on the bridge itself:
> 

Right, good point.

> # bridge fdb add 00:11:22:33:44:55 dev br0 self local blackhole
> 
> 2. If you agree that these entries should not be associated with a
> specific port, then it also does not make sense to subject them to
> ageing and roaming, just like existing local/permanent entries.
> 
> The above allows us to push the new check under the BR_FDB_LOCAL check:
> 

hmm.. so only the driver will be allowed to add non-BR_FDB_LOCAL blackhole
entries with locked flag set as well, that sounds ok as they will be extern_learn
and enforced by it. It is a little discrepancy as we cannot add similar entries in SW
but it really doesn't make any sense to have blackhole fdbs pointing to a port.
SW won't be able to have a locked entry w/ blackhole set, but I like that it is hidden
in the fdb local case when fwding and that's good enough for me.

> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 68b3e850bcb9..4357445529a5 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -182,8 +182,11 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>         if (dst) {
>                 unsigned long now = jiffies;
>  
> -               if (test_bit(BR_FDB_LOCAL, &dst->flags))
> +               if (test_bit(BR_FDB_LOCAL, &dst->flags)) {
> +                       if (unlikely(test_bit(BR_FDB_BLACKHOLE, &dst->flags)))
> +                               goto drop;
>                         return br_pass_frame_up(skb);
> +               }
>  
>                 if (now != dst->used)
>                         dst->used = now;

