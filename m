Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=vx1WPFQR/0ekdOh6+wil39Vg2uqg8SMm9gVCms4QGi8=;
	b=AD0pl6LeGMES8GvenbHna78EY5+8C1caKBtiTYGFJn1Wc0eFBT1R2CbopiNSmh9yp/
	hhVEDXlV5Hw9oQ0FhBruqUUPgcC6aX18ALSYWeD2steFRwiHsyC5RV57CnwaGVknfOj1
	YSJUbW6H/5ix2A039F6WcZh49aSvNYO/GO8mw=
References: <20190730112100.18156-1-nikolay@cumulusnetworks.com>
	<20190730.101811.1836331521043535108.davem@davemloft.net>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <a3de94a3-5976-9035-69bf-2aee6454b45e@cumulusnetworks.com>
Date: Tue, 30 Jul 2019 20:21:06 +0300
MIME-Version: 1.0
In-Reply-To: <20190730.101811.1836331521043535108.davem@davemloft.net>
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

On 30/07/2019 20:18, David Miller wrote:
> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date: Tue, 30 Jul 2019 14:21:00 +0300
> 
>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>> index 3d8deac2353d..f8cac3702712 100644
>> --- a/net/bridge/br_multicast.c
>> +++ b/net/bridge/br_multicast.c
>> @@ -1388,6 +1388,9 @@ br_multicast_leave_group(struct net_bridge *br,
>>  			if (!br_port_group_equal(p, port, src))
>>  				continue;
>>  
>> +			if (p->flags & MDB_PG_FLAGS_PERMANENT)
>> +				break;
>> +
> 
> Like David, I also don't understand why this can be a break.  Is it because
> permanent entries are always the last on the list?  Why will there be no
> other entries that might need to be processed on the list?
> 

The reason is that only one port can match. See the first clause of br_port_group_equal,
that port can participate only once. We could easily add a break statement in the end
when a match is found and it will be correct. Even in the presence of MULTICAST_TO_UNICAST
flag, the port must match and can be added only once.

