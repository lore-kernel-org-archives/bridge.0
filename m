Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EVbdnM3VWE8j0IwvbJMEc4diNGnNb/B1uyEmvQtSeCE=;
 b=Hnj4coJ1kihuonOox3v5ubtJyIKCGYcpnUSMN34Prm+Zx/o6YUVk+HXGTaTaU1h2Bf
 0FyLpWhWQWOxGp3ML7sD1vIHO1ELDM8iC2r07cSKN+NZSQKUrbATt1QiNhbeegDW6eiT
 Ltbc/MskAF960te2RlFIxEnLrVoWRx2mYvaOk=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <20200731162616.345380-1-nikolay@cumulusnetworks.com>
 <07823615-29a8-9553-d56b-1beef55a07bc@gmail.com>
 <181931fb-dc60-7db6-60ac-b8ff1402efec@cumulusnetworks.com>
Message-ID: <968147d8-616d-364f-cf03-55bb7b08a518@cumulusnetworks.com>
Date: Fri, 31 Jul 2020 20:38:33 +0300
MIME-Version: 1.0
In-Reply-To: <181931fb-dc60-7db6-60ac-b8ff1402efec@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: clear bridge's private skb
	space on xmit
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

On 31/07/2020 20:37, Nikolay Aleksandrov wrote:
> On 31/07/2020 20:27, David Ahern wrote:
>> On 7/31/20 10:26 AM, Nikolay Aleksandrov wrote:
>>> We need to clear all of the bridge private skb variables as they can be
>>> stale due to the packet being recirculated through the stack and then
>>> transmitted through the bridge device. Similar memset is already done on
>>> bridge's input. We've seen cases where proxyarp_replied was 1 on routed
>>> multicast packets transmitted through the bridge to ports with neigh
>>> suppress which were getting dropped. Same thing can in theory happen with
>>> the port isolation bit as well.
>>>
>>> Fixes: 821f1b21cabb ("bridge: add new BR_NEIGH_SUPPRESS port flag to suppress arp and nd flood")
>>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>>> ---
>>>  net/bridge/br_device.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
>>> index 8c7b78f8bc23..9a2fb4aa1a10 100644
>>> --- a/net/bridge/br_device.c
>>> +++ b/net/bridge/br_device.c
>>> @@ -36,6 +36,8 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>>>  	const unsigned char *dest;
>>>  	u16 vid = 0;
>>>  
>>> +	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
>>> +
>>>  	rcu_read_lock();
>>>  	nf_ops = rcu_dereference(nf_br_ops);
>>>  	if (nf_ops && nf_ops->br_dev_xmit_hook(skb)) {
>>>
>>
>> What's the performance hit of doing this on every packet?
>>
>> Can you just set a flag that tells the code to reset on recirculation?
>> Seems like br_input_skb_cb has space for that.
>>
> 
> Virtually non-existent, we had a patch that turned that field into a 16 byte
> field so that is really 2 8 byte stores. It is already cache hot, we could

err, s/field/struct/

> initialize each individual field separately as br_input does.
> 
> I don't want to waste flags on such thing, this makes it future-proof 
> and I'll remove the individual field zeroing later which will alleviate
> the cost further.
> 
> 

