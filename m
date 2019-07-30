Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=OVJbTjwxJ2V7gEJ1EnH0FtfbT8cNqFpXv0RRwvyIbGo=;
	b=D6/voHBS9dUFEITrTHGgDCMTH2ke7EsEqVZdZ93v1yLAuANCfSibdGPFfAsIbGPp+m
	sO5PeIFsg7mBpdo65ea6RQDnw4TQ81wITBTUcjvYDA3TYMFMCji79v3FlEXWy5VqcOyc
	JPGqK/l6Nrv4WsZzkV3FeOWuK8l9u/jLlvwRc=
References: <20190730112100.18156-1-nikolay@cumulusnetworks.com>
	<4511701d-88c4-a937-2fbc-b557033a24ed@gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <1b6cd3cf-0e01-2730-b8ad-d26e2355ce84@cumulusnetworks.com>
Date: Tue, 30 Jul 2019 17:00:27 +0300
MIME-Version: 1.0
In-Reply-To: <4511701d-88c4-a937-2fbc-b557033a24ed@gmail.com>
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
To: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 30/07/2019 16:58, David Ahern wrote:
> On 7/30/19 5:21 AM, Nikolay Aleksandrov wrote:
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
>>  			rcu_assign_pointer(*pp, p->next);
>>  			hlist_del_init(&p->mglist);
>>  			del_timer(&p->timer);
> 
> Why 'break' and not 'continue' like you have with
> 	if (!br_port_group_equal(p, port, src))
> 

Because we'll hit the goto out after this hunk always, no point in continuing
if we matched a group and it's permanent, the break might as well be a goto out.

