Return-Path: <vyasevic@redhat.com>
Message-ID: <50FCA038.1010307@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1358360289-23249-1-git-send-email-vyasevic@redhat.com>
	<1358360289-23249-3-git-send-email-vyasevic@redhat.com>
	<20130120233851.3f589fa4.shmulik.ladkani@gmail.com>
In-Reply-To: <20130120233851.3f589fa4.shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next V6 02/14] bridge: Add vlan filtering
	infrastructure
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 21 Jan 2013 01:56:12 -0000
To: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, davem@davemloft.net, mst@redhat.com

On 01/20/2013 04:38 PM, Shmulik Ladkani wrote:
> Hi Vlad,
>
> On Wed, 16 Jan 2013 13:17:57 -0500 Vlad Yasevich <vyasevic@redhat.com> wrote:
>> @@ -156,6 +183,7 @@ struct net_bridge_port
>>   #ifdef CONFIG_NET_POLL_CONTROLLER
>>   	struct netpoll			*np;
>>   #endif
>> +	struct net_port_vlans		vlan_info;
>
> (here and at 'struct net_bridge' as well)
>
> Not sure what the policy is; Isn't it preferred to enclose the new
> fields under CONFIG_BRIDGE_VLAN_FILTERING?

Good catch.  Missed this one.

>
>> +static inline struct net_bridge *vlans_to_bridge(struct net_port_vlans *vlans)
>> +{
>> +	struct net_bridge *br;
>> +
>> +	if (!vlans->port_idx)
>> +		br = container_of((vlans), struct net_bridge, vlan_info);
>> +	else
>> +		br = vlans_to_port(vlans)->br;
>> +
>> +	return br;
>> +}
>
> Guess it would simplify things if the bridge "master port" had an 'nbp'
> representation of its own ;-)

Yes that would simplify things for this case, but it will also add a lot 
of state that's not necessary. I considered doing this, but the master 
device doesn't really act as  port in on things, just some.

>
>> +extern struct net_bridge_vlan *br_vlan_find(struct net_bridge *br, u16 vid);
>
> Seems 'br_vlan_find' can be declared static within br_vlan.c.

Will check.

>
>> +extern void br_vlan_flush(struct net_bridge *br);
>
> According to your preference, consider s/br_vlan_flush/br_vlans_flush/
> since it better suggest acting on all bridge's vlans.
>
>> +extern void nbp_vlan_flush(struct net_port_vlans *vlans);
>
> According to your preference, consider s/nbp_vlan_flush/nbp_vlans_flush/
> since it better suggest acting on all port's vlans.
>
>> +void br_vlan_flush(struct net_bridge *br)
>> +{
>> +	struct net_bridge_vlan *vlan;
>> +	struct hlist_node *node;
>> +	struct hlist_node *tmp;
>> +	int i;
>> +
>> +	nbp_vlan_flush(&br->vlan_info);
>> +
>> +	/* Make sure that there are no vlans left in the bridge after
>> +	* all the ports have been removed.
>> +	*/
>
> Improper indent.

will fix

>
>> +	for (i = 0; i < BR_VID_HASH_SIZE; i++) {
>> +		hlist_for_each_entry_safe(vlan, node, tmp,
>> +					  &br->vlan_hlist[i], hlist) {
>> +			br_vlan_del(vlan);
>
> Can there be any vlans left at that point? Shouldn't del_nbp() on all
> ports take care of that?

I think this function might have been a leftover from prior series when
bridge didn't have its vlan list.  With the new series, I don't this it 
is needed.  I'll double-check.

Thanks
-vlad

> Also, if there _were_ any vlans left (whose bitmap isn't cleared),
> 'br_vlan_del' won't do a thing.
> Am I missing something?
>
> Regards,
> Shmulik
>

