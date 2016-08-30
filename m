Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=9o3ZwQUlHykjXcdmYe1+qglvKcVk22K0D1dGTUenlS8=;
	b=hmEuSls5tAJCVsmi4ovLbHnKpEyoY+cFmYIgieIxN8Q8FK+tXxe4ywGqoTUNkTTvTt
	rkYweS/jdtxhZkzoUVNCDtTgnGGZ3ijtHjnGDNO7ligSNY+CqUhGEmOiINH7ISyhnP4K
	KVOtWWlizY0bWch7ui30lcPPnFpvIhYZzSxLM=
References: <1472562539-23247-1-git-send-email-nikolay@cumulusnetworks.com>
	<1472562539-23247-2-git-send-email-nikolay@cumulusnetworks.com>
	<20160830075953.739291e1@xeon-e3>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <1344bd99-cc38-2dda-4875-337796892685@cumulusnetworks.com>
Date: Tue, 30 Aug 2016 17:00:41 +0200
MIME-Version: 1.0
In-Reply-To: <20160830075953.739291e1@xeon-e3>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: change unicast
 boolean to exact pkt_type
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, davem@davemloft.net, bridge@lists.linux-foundation.org

On 30/08/16 16:59, Stephen Hemminger wrote:
> On Tue, 30 Aug 2016 15:08:58 +0200
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> 
>> -	if (!is_broadcast_ether_addr(dest) && is_multicast_ether_addr(dest) &&
>> -	    br_multicast_rcv(br, p, skb, vid))
>> -		goto drop;
>> +	local_rcv = !!(br->dev->flags & IFF_PROMISC);
> local_rcv is needlessly initialized in existing code. Pls remove that.
> 

Please check again, I did remove it in this patch.

>> +	if (is_multicast_ether_addr(dest)) {
>> +		/* by definition the broadcast is also a multicast address */
>> +		if (is_broadcast_ether_addr(dest)) {
>> +			pkt_type = BR_PKT_BROADCAST;
>> +			local_rcv = true;
>> +		} else {
>> +			pkt_type = BR_PKT_MULTICAST;
>> +			if (br_multicast_rcv(br, p, skb, vid))
>> +				goto drop;
>> +		}
>> +	}
>>
> 
> 
> These could go after the BR_STATE_LEARNING check

They can't because of br_multicast_rcv().

> 
>>  	if (p->state == BR_STATE_LEARNING)
>>  		goto drop;
>>  
>>  	BR_INPUT_SKB_CB(skb)->brdev = br->dev;
>>  
>> -	local_rcv = !!(br->dev->flags & IFF_PROMISC);
>> -
>>  	if (IS_ENABLED(CONFIG_INET) && skb->protocol == htons(ETH_P_ARP))
>>  		br_do_proxy_arp(skb, br, vid, p);
>>
> 
> can't proxy_arp change what was a broadcast packet into a unicast packet?
> 

