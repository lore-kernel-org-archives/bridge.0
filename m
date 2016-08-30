Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=YMl4uwvZji6NfuBbg1b8QREi+I+qdykOu7FOaZqdl5Q=;
	b=LYTixvpCdEHKw2CCmVJohQFCWu4zZ6vZ0hdJz95eudOFd+XygBGD4nREdUEttAK9by
	bMtVY7we91qgM5vo8x7bIphsXdkN0Ufme6dle0bybnM5vqA1kPuY3mgo8iCxTFuwdUb0
	cXG51Lk/Qm0/Qfaj9yCt7o2befiugUNiKQIeg=
References: <1472562539-23247-1-git-send-email-nikolay@cumulusnetworks.com>
	<1472562539-23247-2-git-send-email-nikolay@cumulusnetworks.com>
	<20160830075953.739291e1@xeon-e3>
	<1344bd99-cc38-2dda-4875-337796892685@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <640052a4-b675-b9a5-2c5c-63dc227dae93@cumulusnetworks.com>
Date: Tue, 30 Aug 2016 17:10:59 +0200
MIME-Version: 1.0
In-Reply-To: <1344bd99-cc38-2dda-4875-337796892685@cumulusnetworks.com>
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

On 30/08/16 17:00, Nikolay Aleksandrov wrote:
> On 30/08/16 16:59, Stephen Hemminger wrote:
[snip]
>>>  	if (p->state == BR_STATE_LEARNING)
>>>  		goto drop;
>>>  
>>>  	BR_INPUT_SKB_CB(skb)->brdev = br->dev;
>>>  
>>> -	local_rcv = !!(br->dev->flags & IFF_PROMISC);
>>> -
>>>  	if (IS_ENABLED(CONFIG_INET) && skb->protocol == htons(ETH_P_ARP))
>>>  		br_do_proxy_arp(skb, br, vid, p);
>>>
>>
>> can't proxy_arp change what was a broadcast packet into a unicast packet?
>>
> 

Sorry I missed this question, no it shouldn't be possible. The proxy arp
code only inspects the skb and acts accordingly, it doesn't do any
modifications IIRC.

