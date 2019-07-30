Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=CebsPQQ+A/tAcok2X5TEltsBQZm10wgsb2ydNwe/jUE=;
	b=ciKx901FLxMho74O4qfh1g8mYd8eUybnoMlvQTYTurAwU1Rmi/lwC7+o9oHVmnBKCb
	2hEpZpZOwwCJLhJa8ql5I/6EzFULyd1ZsEdHUYQmJ+FX9D2Bi1ZZ0suUvjZwiP/vWlCk
	3FUPdxNp1z1MBU8cRNSbMm99sTR78J0R4GFa8=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <20190730112100.18156-1-nikolay@cumulusnetworks.com>
	<20190730.101811.1836331521043535108.davem@davemloft.net>
	<a3de94a3-5976-9035-69bf-2aee6454b45e@cumulusnetworks.com>
Message-ID: <651caecf-00dc-cb1a-1908-cb606f263843@cumulusnetworks.com>
Date: Tue, 30 Jul 2019 20:23:29 +0300
MIME-Version: 1.0
In-Reply-To: <a3de94a3-5976-9035-69bf-2aee6454b45e@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: mcast: don't delete permanent
 entries when fast leave is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

On 30/07/2019 20:21, Nikolay Aleksandrov wrote:
> On 30/07/2019 20:18, David Miller wrote:
>> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>> Date: Tue, 30 Jul 2019 14:21:00 +0300
>>
>>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>>> index 3d8deac2353d..f8cac3702712 100644
>>> --- a/net/bridge/br_multicast.c
>>> +++ b/net/bridge/br_multicast.c
>>> @@ -1388,6 +1388,9 @@ br_multicast_leave_group(struct net_bridge *br,
>>>  			if (!br_port_group_equal(p, port, src))
>>>  				continue;
>>>  
>>> +			if (p->flags & MDB_PG_FLAGS_PERMANENT)
>>> +				break;
>>> +
>>
>> Like David, I also don't understand why this can be a break.  Is it because
>> permanent entries are always the last on the list?  Why will there be no
>> other entries that might need to be processed on the list?
>>
> 
> The reason is that only one port can match. See the first clause of br_port_group_equal,
> that port can participate only once. We could easily add a break statement in the end
> when a match is found and it will be correct. Even in the presence of MULTICAST_TO_UNICAST
> flag, the port must match and can be added only once.
> 

Like I wrote in the patch I plan to re-work that code in net-next to remove the
duplication and make it more understandable to avoid such confusions. This code
will be functionally equivalent if I put continue there, we'll just walk over
all of them even after a match or permanent are found. There can only be one
match though as I said, so walking the rest of the ports is a waste.


