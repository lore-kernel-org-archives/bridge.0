Return-Path: <grygorii.strashko@ti.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1536621764;
	bh=Og/1l205iPX/DZmc/JsJDPLfFgjoIJdMivIdN3qzSSw=;
	h=Subject:To:CC:References:From:Date:In-Reply-To;
	b=TwoS0oSDgMh07SmkeRtt1XSIp2ZmfmaE4TDEfEXh18i8b19gcXI9WlgUgo3mDOBXe
	0lcNTAK/noERCjSbxBTYXbXwjhoby3EmxFubQVXchsd80GDtZCIFsWJQ2Cwy+e9eeM
	FniLyqAtkQDRBK+Ce8kpBir6av7IJgUFBV7Am4oI=
References: <20180910101601.28073-1-nikolay@cumulusnetworks.com>
	<20180910141802.268e85c5@shemminger-XPS-13-9360>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <886aea12-29f7-8722-42c9-5db2f3f34421@ti.com>
Date: Mon, 10 Sep 2018 18:22:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180910141802.268e85c5@shemminger-XPS-13-9360>
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
To: Stephen Hemminger <stephen@networkplumber.org>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net



On 09/10/2018 04:18 PM, Stephen Hemminger wrote:
> On Mon, 10 Sep 2018 13:16:01 +0300
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> 
>> Add support for entries which are "sticky", i.e. will not change their port
>> if they show up from a different one. A new ndm flag is introduced for that
>> purpose - NTF_STICKY. We allow to set it only to non-local entries.
> 
> Is there a name for this in other network switch API's?

In TI CPSW hardware we have following definition for similar FDB/ALE entries
(AM437x TRM - 15.3.2.7.1.4 Unicast Address Table Entry):

Block (BLOCK)  – The block bit indicates that a packet with a matching source or
destination address should be dropped (block the address).
0 – Address is not blocked.
1 – Drop a packet with a matching source or destination address (secure must be zero)
    If block and secure are both set, then they no longer mean block and secure.
When both are set, the block and secure bits indicate that the packet is 
a unicast supervisory (super) packet and they determine the unicast forward state test criteria. 
If both bits are set then the packet is forwarded if the receive port is in
   the Forwarding/Blocking/Learning state.
If both bits are not set then the packet is forwarded if the receive port is in
   the Forwarding state.

Secure (SECURE) - This bit indicates that a packet with a matching source address
should be dropped if the received port number is not equal to the table entry port_number.
0 – Received port number is a don’t care.
1 – Drop the packet if the received port is not the secure port for the source
address and do not update the address (block must be zero)

Updating Process:
if ((source address found) and (receive port number != port_number) and (secure or block))
then do not update address

"sticky" would mean SECURE+BLOCK = supervisory (super) packet

> 
>>
>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>> ---
>> I'll send the selftest for sticky with the iproute2 patch if this one is
>> accepted. We've had multiple requests to support such flag and now it's
>> also needed for some eVPN and clag setups.
>>
>>   include/uapi/linux/neighbour.h |  1 +
>>   net/bridge/br_fdb.c            | 19 ++++++++++++++++---
>>   net/bridge/br_private.h        |  1 +
>>   3 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
>> index 904db6148476..998155444e0d 100644
>> --- a/include/uapi/linux/neighbour.h
>> +++ b/include/uapi/linux/neighbour.h
>> @@ -43,6 +43,7 @@ enum {
>>   #define NTF_PROXY	0x08	/* == ATF_PUBL */
>>   #define NTF_EXT_LEARNED	0x10
>>   #define NTF_OFFLOADED   0x20
>> +#define NTF_STICKY	0x40
>>   #define NTF_ROUTER	0x80
>>   
>>   /*
>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>> index 502f66349530..26569ed06a4d 100644
>> --- a/net/bridge/br_fdb.c
>> +++ b/net/bridge/br_fdb.c
>> @@ -584,7 +584,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>>   			unsigned long now = jiffies;
>>   
>>   			/* fastpath: update of existing entry */
>> -			if (unlikely(source != fdb->dst)) {
>> +			if (unlikely(source != fdb->dst && !fdb->is_sticky)) {
>>   				fdb->dst = source;
>>   				fdb_modified = true;
>>   				/* Take over HW learned entry */
>> @@ -656,6 +656,8 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
>>   		ndm->ndm_flags |= NTF_OFFLOADED;
>>   	if (fdb->added_by_external_learn)
>>   		ndm->ndm_flags |= NTF_EXT_LEARNED;
>> +	if (fdb->is_sticky)
>> +		ndm->ndm_flags |= NTF_STICKY;
>>   
>>   	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->key.addr))
>>   		goto nla_put_failure;
>> @@ -772,7 +774,8 @@ int br_fdb_dump(struct sk_buff *skb,
>>   
>>   /* Update (create or replace) forwarding database entry */
>>   static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>> -			 const __u8 *addr, __u16 state, __u16 flags, __u16 vid)
>> +			 const u8 *addr, u16 state, u16 flags, u16 vid,
>> +			 u8 is_sticky)
> 
> Why not change the API to take a full ndm flags, someone is sure to add more later.
> 

-- 
regards,
-grygorii
