Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=wwrYKSzod5B13tzmTC9Z9/obGJ2f04ezaf6yzHL3HBA=;
	b=UkCK5ByX7m99HkPcaZM/nhLQIql8buyItX+jVXFdMGnNFAaIEly97aKrp5dAtUSZI4
	FzvOJt2jO0T1yda/9W6IfuIeIVZ3ANTUsVPXuqkOXzMnvJVoyujGFinqnhHFrd25qtTN
	WjRuRXoENpuxp6Bk2W/8WCbkN9DWico/prSoc=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <20180910101601.28073-1-nikolay@cumulusnetworks.com>
	<20180910141802.268e85c5@shemminger-XPS-13-9360>
	<886aea12-29f7-8722-42c9-5db2f3f34421@ti.com>
	<38bfcada-abea-be8d-c794-154113ca17f8@cumulusnetworks.com>
Message-ID: <c2d8a4c0-1ca9-913d-03a6-4623ea0c8c12@cumulusnetworks.com>
Date: Tue, 11 Sep 2018 09:23:31 +0300
MIME-Version: 1.0
In-Reply-To: <38bfcada-abea-be8d-c794-154113ca17f8@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add support for sticky
	fdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Grygorii Strashko <grygorii.strashko@ti.com>, Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 11/09/18 02:55, Nikolay Aleksandrov wrote:
> On 11/09/18 02:22, Grygorii Strashko wrote:
>>
>>
>> On 09/10/2018 04:18 PM, Stephen Hemminger wrote:
>>> On Mon, 10 Sep 2018 13:16:01 +0300
>>> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
>>>
>>>> Add support for entries which are "sticky", i.e. will not change their port
>>>> if they show up from a different one. A new ndm flag is introduced for that
>>>> purpose - NTF_STICKY. We allow to set it only to non-local entries.
>>>
>>> Is there a name for this in other network switch API's?
>>
>> In TI CPSW hardware we have following definition for similar FDB/ALE entries
>> (AM437x TRM - 15.3.2.7.1.4 Unicast Address Table Entry):
>>
>> Block (BLOCK)  – The block bit indicates that a packet with a matching source or
>> destination address should be dropped (block the address).
>> 0 – Address is not blocked.
>> 1 – Drop a packet with a matching source or destination address (secure must be zero)
>>     If block and secure are both set, then they no longer mean block and secure.
>> When both are set, the block and secure bits indicate that the packet is 
>> a unicast supervisory (super) packet and they determine the unicast forward state test criteria. 
>> If both bits are set then the packet is forwarded if the receive port is in
>>    the Forwarding/Blocking/Learning state.
>> If both bits are not set then the packet is forwarded if the receive port is in
>>    the Forwarding state.
>>
>> Secure (SECURE) - This bit indicates that a packet with a matching source address
>> should be dropped if the received port number is not equal to the table entry port_number.
>> 0 – Received port number is a don’t care.
>> 1 – Drop the packet if the received port is not the secure port for the source
>> address and do not update the address (block must be zero)
>>
>> Updating Process:
>> if ((source address found) and (receive port number != port_number) and (secure or block))
>> then do not update address
>>
>> "sticky" would mean SECURE+BLOCK = supervisory (super) packet
>>
> 
> That could work. but we haven't really made any arrangements w.r.t. to current implementations.
> So if IUC secure+block should be: 
>    - block:
>       1 – Drop a packet with a matching source or destination address (secure must be zero)
>       If block and secure are both set, then they no longer mean block and secure.> 
>     - secure:
>       1 – Drop the packet if the received port is not the secure port for the source
>           address and do not update the address (block must be zero)
> 
> These could mean a very different config based on their description. Feel free to add.
> 

Nevermind my comment, got it. To support them fully though we will need to have more options.
They should be achievable through firewall as well.

>>>
>>>>
>>>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>>>> ---
>>>> I'll send the selftest for sticky with the iproute2 patch if this one is
>>>> accepted. We've had multiple requests to support such flag and now it's
>>>> also needed for some eVPN and clag setups.
>>>>
>>>>   include/uapi/linux/neighbour.h |  1 +
>>>>   net/bridge/br_fdb.c            | 19 ++++++++++++++++---
>>>>   net/bridge/br_private.h        |  1 +
>>>>   3 files changed, 18 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
>>>> index 904db6148476..998155444e0d 100644
>>>> --- a/include/uapi/linux/neighbour.h
>>>> +++ b/include/uapi/linux/neighbour.h
>>>> @@ -43,6 +43,7 @@ enum {
>>>>   #define NTF_PROXY	0x08	/* == ATF_PUBL */
>>>>   #define NTF_EXT_LEARNED	0x10
>>>>   #define NTF_OFFLOADED   0x20
>>>> +#define NTF_STICKY	0x40
>>>>   #define NTF_ROUTER	0x80
>>>>   
>>>>   /*
>>>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>>>> index 502f66349530..26569ed06a4d 100644
>>>> --- a/net/bridge/br_fdb.c
>>>> +++ b/net/bridge/br_fdb.c
>>>> @@ -584,7 +584,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>>>>   			unsigned long now = jiffies;
>>>>   
>>>>   			/* fastpath: update of existing entry */
>>>> -			if (unlikely(source != fdb->dst)) {
>>>> +			if (unlikely(source != fdb->dst && !fdb->is_sticky)) {
>>>>   				fdb->dst = source;
>>>>   				fdb_modified = true;
>>>>   				/* Take over HW learned entry */
>>>> @@ -656,6 +656,8 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
>>>>   		ndm->ndm_flags |= NTF_OFFLOADED;
>>>>   	if (fdb->added_by_external_learn)
>>>>   		ndm->ndm_flags |= NTF_EXT_LEARNED;
>>>> +	if (fdb->is_sticky)
>>>> +		ndm->ndm_flags |= NTF_STICKY;
>>>>   
>>>>   	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->key.addr))
>>>>   		goto nla_put_failure;
>>>> @@ -772,7 +774,8 @@ int br_fdb_dump(struct sk_buff *skb,
>>>>   
>>>>   /* Update (create or replace) forwarding database entry */
>>>>   static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>>>> -			 const __u8 *addr, __u16 state, __u16 flags, __u16 vid)
>>>> +			 const u8 *addr, u16 state, u16 flags, u16 vid,
>>>> +			 u8 is_sticky)
>>>
>>> Why not change the API to take a full ndm flags, someone is sure to add more later.
> 
> Sure, I've added a similar "fix" on my bridge todo list which is getting very long by the way,
> 
> but it is not the point of this patch.
> 

I'll send v2 with your proposed change, indeed more people will probably make use of it in the
future. Thanks for the feedback.

Cheers,
 Nik

