Return-Path: <toshiaki.makita1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=q8w9mCkM8udYzUvjqgq6CDPtUDmcBw8U8lJ15dX6BfI=;
	b=tA4TNvwH62ZiMZyRsbg5J1rdT0fBKSP9Vn2poJYc5W0rXw8QiGZWtS/RrWvD7/+ZvJ
	Elz3+yWMF1GaaI+fm0bxvIb75uu6G+soOIa48bIDIzPROZfvQxY6mx8/B1YxYjgmPCyM
	qnzEAqxTrHQGWIbuBSd3aWxSdh+ku/YaqiNFD1chR3CiOTBLzOCw+BRCO2lbbKoIdgZ3
	iVGD3CfOG6QveINt4cIyt6lCdA7yQXExe0xJ0HPx8ssWRa/3SYIz1nUFDkFJnkOtmnxD
	C8kwao4KbA64BhiVSDYQJDlgv81u632TfONdqP1L8C4X79ib+iCsitFUYbXhzCPLllnW
	m3dw==
References: <20190902181000.25638-1-zahari.doychev@linux.com>
	<76b7723b-68dd-0efc-9a93-0597e9d9b827@gmail.com>
	<20190903133635.siw6xcaqwk7m5a5a@tycho>
	<a9a093f2-1ec6-339c-b015-eb658618cf2b@gmail.com>
	<20190904143227.5jpn2gnu3fed55wg@tycho>
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
Message-ID: <f6cff1d2-c8f0-17c6-388c-aa42128bbc3c@gmail.com>
Date: Thu, 5 Sep 2019 20:20:51 +0900
MIME-Version: 1.0
In-Reply-To: <20190904143227.5jpn2gnu3fed55wg@tycho>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 1/2] net: bridge: use mac_len in bridge
 forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: bridge@lists.linux-foundation.org, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, makita.toshiaki@lab.ntt.co.jp, jhs@mojatatu.com, alexei.starovoitov@gmail.com, simon.horman@netronome.com, xiyou.wangcong@gmail.com, johannes@sipsolutions.net, dsahern@gmail.com

On 2019/09/04 23:32, Zahari Doychev wrote:
> On Wed, Sep 04, 2019 at 04:14:28PM +0900, Toshiaki Makita wrote:
>> On 2019/09/03 22:36, Zahari Doychev wrote:
>>> On Tue, Sep 03, 2019 at 08:37:36PM +0900, Toshiaki Makita wrote:
>>>> Hi Zahari,
>>>>
>>>> Sorry for reviewing this late.
>>>>
>>>> On 2019/09/03 3:09, Zahari Doychev wrote:
>>>> ...
>>>>> @@ -466,13 +466,14 @@ static bool __allowed_ingress(const struct net_bridge *br,
>>>>>     		/* Tagged frame */
>>>>>     		if (skb->vlan_proto != br->vlan_proto) {
>>>>>     			/* Protocol-mismatch, empty out vlan_tci for new tag */
>>>>> -			skb_push(skb, ETH_HLEN);
>>>>> +			skb_push(skb, skb->mac_len);
>>>>>     			skb = vlan_insert_tag_set_proto(skb, skb->vlan_proto,
>>>>>     							skb_vlan_tag_get(skb));
>>>>
>>>> I think we should insert vlan at skb->data, i.e. mac_header + mac_len, while this
>>>> function inserts the tag at mac_header + ETH_HLEN which is not always the correct
>>>> offset.
>>>
>>> Maybe I am misunderstanding the concern here but this should make sure that
>>> the VLAN tag from the skb is move back in the payload as the outer most tag.
>>> So it should follow the ethernet header. It looks like this e.g.,:
>>>
>>> VLAN1 in skb:
>>> +------+------+-------+
>>> | DMAC | SMAC | ETYPE |
>>> +------+------+-------+
>>>
>>> VLAN1 moved to payload:
>>> +------+------+-------+-------+
>>> | DMAC | SMAC | VLAN1 | ETYPE |
>>> +------+------+-------+-------+
>>>
>>> VLAN2 in skb:
>>> +------+------+-------+-------+
>>> | DMAC | SMAC | VLAN1 | ETYPE |
>>> +------+------+-------+-------+
>>>
>>> VLAN2 moved to payload:
>>>
>>> +------+------+-------+-------+
>>> | DMAC | SMAC | VLAN2 | VLAN1 | ....
>>> +------+------+-------+-------+
>>>
>>> Doing the skb push with mac_len makes sure that VLAN tag is inserted in the
>>> correct offset. For mac_len == ETH_HLEN this does not change the current
>>> behaviour.
>>
>> Reordering VLAN headers here does not look correct to me. If skb->data points to ETH+VLAN,
>> then we should insert the vlan at the offset.
>> Vlan devices with reorder_hdr disabled produce packets whose mac_len includes ETH+VLAN header,
>> and they expects vlan insertion after the outer vlan header.
> 
> I see so in this case we should handle differently as it seems sometimes
> we have to insert after or before the tag in the packet. I am not quite sure
> if this is possible to be detected here. I was trying to do bridging with VLAN
> devices with reorder_hdr disabled working but somehow I was not able to get
> mac_len longer then ETH_HLEN in all cases that I tried. Can you provide some
> example how can I try this out? It will really help me to understand the
> problem better.

I'm not sure if there is a case where we should insert tags before data pointer.
Your case does not look valid to me because skb is already broken in TC (I think I
explained this in the previous discussion). Bridge should not workaround the broken skb.

>> Also I'm not sure there is standard ethernet header in mac_len, as mac_len is not ETH_HLEN.
>> E.g. tun devices can produce vlan packets without ehternet header.
> 
> How is the bridge forwarding decision done in this case when there are no
> MAC addresses, vlan based only?

Tun is just an example for header shorter than we expect. It's more like an attack vector.
So maybe it's sufficient to make sure we don't crash or write data to unexpected offset
for such packets. Or if such packets cannot make it to this point, that's ok.

> 
>>
>>>
>>>>
>>>>>     			if (unlikely(!skb))
>>>>>     				return false;
>>>>>     			skb_pull(skb, ETH_HLEN);
>>>>
>>>> Now skb->data is mac_header + ETH_HLEN which would be broken when mac_len is not
>>>> ETH_HLEN?
>>>
>>> I thought it would be better to point in this case to the outer tag as otherwise
>>> if mac_len is used the skb->data will point to the next tag which I find somehow
>>> inconsistent or do you see some case where this can cause problems?
>>
>> Vlan devices with reorder_hdr off will break because it relies on skb->data offset
>> as I described in the previous discussion.
> 
> I also see in vlan_do_receive that the VLAN tag is moved to the payload when
> reorder_hdr is off and the vlan_dev is not a bridge port. So it seems that
> I am misunderstanding the reorder_hdr option so if you can give me some more
> details about how it is supposed to be used will be highly appreciated.

No, you don't misunderstand it. I just forgot the condition was added.

Now reorder_hdr does not look like a problem, I lost the reason to handle
mac_len != ETH_HLEN case, as I'm thinking this change should not be a workaround for your problem.
If we fix the broken data pointer in TC, there should not be problems with mac_len in bridge.
Do you have any other possible cases this works for?

Toshiaki Makita
