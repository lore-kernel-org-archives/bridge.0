Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZG9+n5eeTXjDw0TEthtVnssj2KNpNT9BdmTxnsWf0Uk=;
 b=Nx+HweGFlG/thbNm1CofpaFrKo+JQhvr4NKAgHMtXKq0gkg9t7JrtGbPojNABwv3HQ
 pRxBA8+t4B5AyE7BQAxazr/Gls0ogQ81iZfGTn0luvtdbbr0y02bKr6fdkS1yINrfpLc
 mO4xFqDT3docA1KRCagNFG+WhoW7E4OOKKad4=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <20200731162616.345380-1-nikolay@cumulusnetworks.com>
 <07823615-29a8-9553-d56b-1beef55a07bc@gmail.com>
 <181931fb-dc60-7db6-60ac-b8ff1402efec@cumulusnetworks.com>
 <2bdc90a2-834f-941d-fea7-04e3c8924f7b@cumulusnetworks.com>
Message-ID: <39736ed8-8565-ab64-5163-da6f2acba68a@cumulusnetworks.com>
Date: Fri, 31 Jul 2020 21:10:09 +0300
MIME-Version: 1.0
In-Reply-To: <2bdc90a2-834f-941d-fea7-04e3c8924f7b@cumulusnetworks.com>
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

On 31/07/2020 20:51, Nikolay Aleksandrov wrote:
> On 31/07/2020 20:37, Nikolay Aleksandrov wrote:
>> On 31/07/2020 20:27, David Ahern wrote:
>>> On 7/31/20 10:26 AM, Nikolay Aleksandrov wrote:
>>>> We need to clear all of the bridge private skb variables as they can be
>>>> stale due to the packet being recirculated through the stack and then
>>>> transmitted through the bridge device. Similar memset is already done on
>>>> bridge's input. We've seen cases where proxyarp_replied was 1 on routed
>>>> multicast packets transmitted through the bridge to ports with neigh
>>>> suppress which were getting dropped. Same thing can in theory happen with
>>>> the port isolation bit as well.
>>>>
>>>> Fixes: 821f1b21cabb ("bridge: add new BR_NEIGH_SUPPRESS port flag to suppress arp and nd flood")
>>>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>>>> ---
>>>>  net/bridge/br_device.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
>>>> index 8c7b78f8bc23..9a2fb4aa1a10 100644
>>>> --- a/net/bridge/br_device.c
>>>> +++ b/net/bridge/br_device.c
>>>> @@ -36,6 +36,8 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>>>>  	const unsigned char *dest;
>>>>  	u16 vid = 0;
>>>>  
>>>> +	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
>>>> +
>>>>  	rcu_read_lock();
>>>>  	nf_ops = rcu_dereference(nf_br_ops);
>>>>  	if (nf_ops && nf_ops->br_dev_xmit_hook(skb)) {
>>>>
>>>
>>> What's the performance hit of doing this on every packet?
>>>
>>> Can you just set a flag that tells the code to reset on recirculation?
>>> Seems like br_input_skb_cb has space for that.
>>>
>>
>> Virtually non-existent, we had a patch that turned that field into a 16 byte
>> field so that is really 2 8 byte stores. It is already cache hot, we could
>> initialize each individual field separately as br_input does.
>>
>> I don't want to waste flags on such thing, this makes it future-proof 
>> and I'll remove the individual field zeroing later which will alleviate
>> the cost further.
>>
> 
> Also note that we already do this on input for each packet since the
> struct was reduced to 16 bytes. It's the safest way since every different
> sub-part of the bridge uses some set of these private variables and
> we've had many similar bugs where they were used stale or unintentionally
> were not initialized for some path.
> 

In addition this doesn't need to be a recirculation, in theory it could happen
by a routed packet to svi on the bridge which got its skb->cb initialized before
hitting the bridge's xmit function. So a flag can't catch all possible cases.


