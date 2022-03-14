Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=6n6ZEPynSftslrkkn67A9oe0ON+g8zOOoRrauuQESMk=;
 b=mdNIalz8h2RDTjPqrlM3K4jz0236U7jn5xSEIBvOEbVYU/XbpiHR159ZScGA4hIDYx
 yuL9nVsFKdhvSzggc/aCQm7MaYAF0quz3ReRJfl3YNaP13vvZulbDJzlv6X7A9O9OTy7
 pI3wSVawVh5TNALp7y/RBVPdu1nsqFXZBbZmkAAA+nyGM/4HGglw7KnHsIj6bsba+0K4
 t2R/sBj7TWigNOI6yHniw5MThsD7e9Pdt3uiptfvGhwjZAJAHGyx2NLiO4qVRIYELhUj
 MH/kDdd+9R31vP59FZ4L2Fwm40x5LTQ+tIjfEjBpmSXbk2Jdz/nfQFpL1+nO3OEyhVzC
 evAQ==
Message-ID: <037a8f48-29c5-ae45-b562-df15dbe6d163@blackwall.org>
Date: Mon, 14 Mar 2022 13:09:05 +0200
MIME-Version: 1.0
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-2-tobias@waldekranz.com>
 <9c103a85-f0e2-77cd-9fc6-dc19d99b19ec@blackwall.org>
In-Reply-To: <9c103a85-f0e2-77cd-9fc6-dc19d99b19ec@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 net-next 01/14] net: bridge: mst: Multiple
 Spanning Tree (MST) mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On 14/03/2022 12:37, Nikolay Aleksandrov wrote:
> On 14/03/2022 11:52, Tobias Waldekranz wrote:
>> Allow the user to switch from the current per-VLAN STP mode to an MST
>> mode.
>>
>> Up to this point, per-VLAN STP states where always isolated from each
>> other. This is in contrast to the MSTP standard (802.1Q-2018, Clause
>> 13.5), where VLANs are grouped into MST instances (MSTIs), and the
>> state is managed on a per-MSTI level, rather that at the per-VLAN
>> level.
>>
>> Perhaps due to the prevalence of the standard, many switching ASICs
>> are built after the same model. Therefore, add a corresponding MST
>> mode to the bridge, which we can later add offloading support for in a
>> straight-forward way.
>>
>> For now, all VLANs are fixed to MSTI 0, also called the Common
>> Spanning Tree (CST). That is, all VLANs will follow the port-global
>> state.
>>
>> Upcoming changes will make this actually useful by allowing VLANs to
>> be mapped to arbitrary MSTIs and allow individual MSTI states to be
>> changed.
>>
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
> [snip]
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index 48bc61ebc211..35b47f6b449a 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -178,6 +178,7 @@ enum {
>>   * @br_mcast_ctx: if MASTER flag set, this is the global vlan multicast context
>>   * @port_mcast_ctx: if MASTER flag unset, this is the per-port/vlan multicast
>>   *                  context
>> + * @msti: if MASTER flag set, this holds the VLANs MST instance
>>   * @vlist: sorted list of VLAN entries
>>   * @rcu: used for entry destruction
>>   *
>> @@ -210,6 +211,8 @@ struct net_bridge_vlan {
>>  		struct net_bridge_mcast_port	port_mcast_ctx;
>>  	};
>>  
>> +	u16				msti;
>> +
>>  	struct list_head		vlist;
>>  
>>  	struct rcu_head			rcu;
>> @@ -445,6 +448,7 @@ enum net_bridge_opts {
>>  	BROPT_NO_LL_LEARN,
>>  	BROPT_VLAN_BRIDGE_BINDING,
>>  	BROPT_MCAST_VLAN_SNOOPING_ENABLED,
>> +	BROPT_MST_ENABLED,
>>  };
>>  
>>  struct net_bridge {
>> @@ -1765,6 +1769,29 @@ static inline bool br_vlan_state_allowed(u8 state, bool learn_allow)
>>  }
>>  #endif
>>  
>> +/* br_mst.c */
>> +#ifdef CONFIG_BRIDGE_VLAN_FILTERING
> 
> There is already such ifdef, you can embed all MST code inside it.
> 

My bad, I somehow confused the function placement. This is good. :)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

