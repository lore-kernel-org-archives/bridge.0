Return-Path: <makita.toshiaki@lab.ntt.co.jp>
References: <20190113135939.8970-1-zahari.doychev@linux.com>
	<20190113135939.8970-2-zahari.doychev@linux.com>
	<7dee9e67-bad5-84eb-9ff1-fa0d0aef8be0@lab.ntt.co.jp>
	<20190117081707.GA13853@riot>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <28ee9bc4-ab7e-285f-50c4-685dd2468cf5@lab.ntt.co.jp>
Date: Thu, 17 Jan 2019 17:57:30 +0900
MIME-Version: 1.0
In-Reply-To: <20190117081707.GA13853@riot>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/2] net: bridge: fix tc added QinQ forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, johannes@sipsolutions.net

On 2019/01/17 17:17, Zahari Doychev wrote:
> On Tue, Jan 15, 2019 at 03:11:28PM +0900, Toshiaki Makita wrote:
>> On 2019/01/13 22:59, Zahari Doychev wrote:
>>> Use the skb->mac_len instead of using the ETH_HLEN when pushing the skb
>>> data pointer. This fixes sending incorrect packets when more than one
>>> vlan tags are pushed by tc-vlan and the mac header length is bigger than
>>> ETH_HLEN. In this way the vlan tagged contained in the skb is inserted at
>>> right offset in the packet payload before sending the packet.
>>>
>>> Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
>>> ---
>>>  net/bridge/br_forward.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
>>> index 5372e2042adf..55f928043f77 100644
>>> --- a/net/bridge/br_forward.c
>>> +++ b/net/bridge/br_forward.c
>>> @@ -39,7 +39,7 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
>>>  	if (!is_skb_forwardable(skb->dev, skb))
>>>  		goto drop;
>>>  
>>> -	skb_push(skb, ETH_HLEN);
>>> +	skb_push(skb, skb->mac_len);
>>>  	br_drop_fake_rtable(skb);
>>>  
>>>  	if (skb->ip_summed == CHECKSUM_PARTIAL &&
>>>
>>
>> I guess you mean skb->data points to mac_header + ETH_HLEN + VLAN_HLEN
>> when bridge receives skbs in br_handle_frame()?
> 
> yes, this is what I see.
> 
>> If so, the behavior of act_vlan is odd. Normal double tagged skbs from
>> hardware devices should have skb->data pointing to mac_header + ETH_HLEN
>> because they just call eth_type_trans() before entering
>> netif_receive_skb()...
>> I think act_vlan needs some fix.
> 
> The act_valn is using the skb_vlan_push(...) to add the vlan tags and in this
> way increasing the skb->data and mac_len. So I think I can add a fix there to
> set the skb->data to point to mac_header + ETH_HLEN when more tags are added.

As skb->data always points to mac_header after calling skb_vlan_push(),
we probably need to remember mac_len before invocation of it?

The problem should be this part in tcf_vlan_act():

> out:
> 	if (skb_at_tc_ingress(skb))
> 		skb_pull_rcsum(skb, skb->mac_len);

skb->mac_len should not be used here.

-- 
Toshiaki Makita

