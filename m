Return-Path: <vyasevich@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=SGOjUuTUh4ZuIl0cP24RgKiBnevpVQpuqacqREwGUo0=;
	b=V2kX3vrxu7qTW8fG9CjDDTTVSrLicmu2l+eCuS5jsJgVhVFCSZOQNujCX/p63Q2L+c
	DXcSiJWB9fQ7SdBfNJ9FAc3j9CP8B84ItUFE+xyE5dupLaGbp1T4z9bnZWCAKP+Re7Gy
	1mWyCi8/l1E3BLBKiMzybrR4L6uJIa296SOW/xA4oDvSTEgTvb5uJNEX3QQM8UVl0vuZ
	1+P6cZphqX9c3MHxbDRInIUD2Sv6uCsvNtzkl/1l13BQLWqnP3dupDmuwlOQao5348Si
	ZxCJuxKCm7qTwytOZnB6kd7ZhLT6yBub9YyienSP/5z0fR68DMZ9HVQlKG/rnm82Hp4y
	EpSQ==
Message-ID: <53908565.5050402@gmail.com>
Date: Thu, 05 Jun 2014 10:57:41 -0400
From: Vlad Yasevich <vyasevich@gmail.com>
MIME-Version: 1.0
References: <1401969212-19193-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20140605123039.GA18310@redhat.com>
	<53906A23.5040006@lab.ntt.co.jp>
In-Reply-To: <53906A23.5040006@lab.ntt.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next] bridge: Fix incorrect judgment of
	promisc
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Vlad Yasevich <vyasevic@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Stephen Hemminger <stephen@networkplumber.org>, David Laight <David.Laight@ACULAB.COM>, "David S . Miller" <davem@davemloft.net>

On 06/05/2014 09:01 AM, Toshiaki Makita wrote:
> (2014/06/05 21:30), Michael S. Tsirkin wrote:
>> On Thu, Jun 05, 2014 at 08:53:32PM +0900, Toshiaki Makita wrote:
>>> br_manage_promisc() incorrectly expects br_auto_port() to return only 0
>>> or 1, while it actually returns flags, i.e., a subset of BR_AUTO_MASK.
>>>
>>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>>> ---
>>>  net/bridge/br_if.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
>>> index a08d2b8..3eca3fd 100644
>>> --- a/net/bridge/br_if.c
>>> +++ b/net/bridge/br_if.c
>>> @@ -153,7 +153,8 @@ void br_manage_promisc(struct net_bridge *br)
>>>  			 * This lets us disable promiscuous mode and write
>>>  			 * this config to hw.
>>>  			 */
>>> -			if (br->auto_cnt <= br_auto_port(p))
>>> +			if (br->auto_cnt == 0 ||
>>> +			    (br->auto_cnt == 1 && br_auto_port(p)))
>>>  				br_port_clear_promisc(p);
>>>  			else
>>>  				br_port_set_promisc(p);
>>
>> It's all a nasty side-effect of using macros IMHO.
>>
>> How about we just make these inline functions returning bool?
>>
>> The bugfix will fall out naturally.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Warning: untested.
>>
>>
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index 53d6e32..5818dd2 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -200,8 +200,15 @@ struct net_bridge_port
>>  #endif
>>  };
>>  
>> -#define br_auto_port(p) ((p)->flags & BR_AUTO_MASK)
>> -#define br_promisc_port(p) ((p)->flags & BR_PROMISC)
>> +static inline bool br_auto_port(struct net_bridge_port *p)
>> +{
>> +	return p->flags & BR_AUTO_MASK;
>> +}
>> +
>> +static inline bool br_promisc_port(struct net_bridge_port *p)
>> +{
>> +	return p->flags & BR_PROMISC;
>> +}
>>  
>>  #define br_port_exists(dev) (dev->priv_flags & IFF_BRIDGE_PORT)
> 
> This also looks good.
> 
> IMHO, the caller side should not assume these macros (or inline
> functions) return boolean value.  There exists similar macro such as
> br_port_exists() that doesn't return boolean.
> 
> Ohterwise, we should change all macros into boolean functions, but it
> might affect performance a little if such a macro is used in fast path?
> (I'm worried about the cost of casting non-zero values into 1.)

The following works correctly for me:
#define br_auto_port(p) !!((p)->flags & BR_AUTO_MASK)

Small test shows:

printf("%d\n", br_auto_port(0x20);
1 <-- correct.  learning is set.

printf("%d\n", br_auto_port(0x40);
1 <-- correct.  flooding is set.

printf("%d\n", br_auto_port(0x60);
1 <-- correct, both are set.

printf("%d\n", br_auto_port(0x08);
0 <-- correct.  neither are set.

-vlad

> 
> Thanks,
> Toshiaki Makita
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

