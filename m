Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=nsTVaT+UT9MHEz7rhHRMqhy05TbGiCCQO6axpgS2mow=;
 b=bSNPCd7D7+ZPmKMhWJm+NE7jDlibmc7BV/Wfg3NIFdY6l5NMTPKPjWG4G1SeghmOiW
 4Mo4FTsE2ARgtf/IPMJ8sMVVbiq+BfVlkCnjdqMsJSTwpl+dV0rRlU+TLUuCvPZ8zTLK
 dlO/k/qeIP+RjIEMrDMwElUmhfFKcY+Sq1RLnd5K+mUiwHWTthNL6cVQOu8jhEXxu3wL
 3fKQpbhBxaKDLe/ZkhiQee9T+VZxK+uPmVBTyvzVRnbW0T3LklhEDGQXWqcuxZLJ/WAm
 Eu7v5rjieKB9FK668L7of1I8vnl8S4illOAhUxTN63oAAWFk0gbCZKidv2q5I63YqmXE
 RzBA==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <fed43e8d-de8c-aa76-1451-877cf4cc76d2@blackwall.org>
References: <20220209130538.533699-1-schultz.hans+netdev@gmail.com>
 <20220209130538.533699-6-schultz.hans+netdev@gmail.com>
 <fed43e8d-de8c-aa76-1451-877cf4cc76d2@blackwall.org>
Date: Thu, 10 Feb 2022 10:22:17 +0100
Message-ID: <86o83fuldi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next v2 5/5] net: bridge: Refactor bridge
 port in locked mode to use jump labels
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, Hans Schultz <schultz.hans@gmail.com>, davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Hans Schultz <schultz.hans+lkml@gmail.com>

On tor, feb 10, 2022 at 10:31, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> On 09/02/2022 15:05, Hans Schultz wrote:
>> From: Hans Schultz <schultz.hans+lkml@gmail.com>
>> 
>> As the locked mode feature is in the hot path of the bridge modules
>> reception of packets, it needs to be refactored to use jump labels
>> for optimization.
>> 
>> Signed-off-by: Hans Schultz <schultz.hans+lkml@gmail.com>
>> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
>> ---
>
> Why two (almost) identical sign-offs?

Ups, a mistake...

>
> Also, as Ido mentioned, please fold this patch into patch 01.
>
>>  net/bridge/br_input.c   | 22 ++++++++++++++++++----
>>  net/bridge/br_netlink.c |  6 ++++++
>>  net/bridge/br_private.h |  2 ++
>>  3 files changed, 26 insertions(+), 4 deletions(-)
>> 
>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>> index 469e3adbce07..6fc428d6bac5 100644
>> --- a/net/bridge/br_input.c
>> +++ b/net/bridge/br_input.c
>> @@ -23,6 +23,18 @@
>>  #include "br_private.h"
>>  #include "br_private_tunnel.h"
>>  
>> +static struct static_key_false br_input_locked_port_feature;
>> +
>> +void br_input_locked_port_add(void)
>> +{
>> +	static_branch_inc(&br_input_locked_port_feature);
>> +}
>> +
>> +void br_input_locked_port_remove(void)
>> +{
>> +	static_branch_dec(&br_input_locked_port_feature);
>> +}
>> +
>>  static int
>>  br_netif_receive_skb(struct net *net, struct sock *sk, struct sk_buff *skb)
>>  {
>> @@ -91,10 +103,12 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>>  				&state, &vlan))
>>  		goto out;
>>  
>> -	if (p->flags & BR_PORT_LOCKED) {
>> -		fdb_entry = br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
>> -		if (!(fdb_entry && fdb_entry->dst == p))
>> -			goto drop;
>> +	if (static_branch_unlikely(&br_input_locked_port_feature)) {
>> +		if (p->flags & BR_PORT_LOCKED) {
>> +			fdb_entry = br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
>> +			if (!(fdb_entry && fdb_entry->dst == p))
>> +				goto drop;
>> +		}
>>  	}
>>  
>>  	nbp_switchdev_frame_mark(p, skb);
>> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
>> index 7d4432ca9a20..e3dbe9fed75c 100644
>> --- a/net/bridge/br_netlink.c
>> +++ b/net/bridge/br_netlink.c
>> @@ -860,6 +860,7 @@ static int br_set_port_state(struct net_bridge_port *p, u8 state)
>>  static void br_set_port_flag(struct net_bridge_port *p, struct nlattr *tb[],
>>  			     int attrtype, unsigned long mask)
>>  {
>> +	bool locked = p->flags & BR_PORT_LOCKED;
>>  	if (!tb[attrtype])
>>  		return;
>>  
>> @@ -867,6 +868,11 @@ static void br_set_port_flag(struct net_bridge_port *p, struct nlattr *tb[],
>>  		p->flags |= mask;
>>  	else
>>  		p->flags &= ~mask;
>> +
>> +	if ((p->flags & BR_PORT_LOCKED) && !locked)
>> +		br_input_locked_port_add();
>> +	if (!(p->flags & BR_PORT_LOCKED) && locked)
>> +		br_input_locked_port_remove();
>>  }
>>  
>>  /* Process bridge protocol info on port */
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index 2661dda1a92b..0ec3ef897978 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -832,6 +832,8 @@ void br_manage_promisc(struct net_bridge *br);
>>  int nbp_backup_change(struct net_bridge_port *p, struct net_device *backup_dev);
>>  
>>  /* br_input.c */
>> +void br_input_locked_port_add(void);
>> +void br_input_locked_port_remove(void);
>>  int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
>>  rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
>>  
