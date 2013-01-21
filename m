Return-Path: <vyasevic@redhat.com>
Message-ID: <50FCA0DA.7000008@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1358360289-23249-1-git-send-email-vyasevic@redhat.com>
	<1358360289-23249-4-git-send-email-vyasevic@redhat.com>
	<20130121002710.5189a959.shmulik.ladkani@gmail.com>
In-Reply-To: <20130121002710.5189a959.shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next V6 03/14] bridge: Validate that vlan
 is permitted on ingress
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 21 Jan 2013 01:58:56 -0000
To: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, davem@davemloft.net, mst@redhat.com

On 01/20/2013 05:27 PM, Shmulik Ladkani wrote:
> Hi Vlad,
>
> On Wed, 16 Jan 2013 13:17:58 -0500 Vlad Yasevich <vyasevic@redhat.com> wrote:
>> @@ -45,6 +45,9 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>>   	brstats->tx_bytes += skb->len;
>>   	u64_stats_update_end(&brstats->syncp);
>>
>> +	if (!br_allowed_ingress(&br->vlan_info, skb))
>> +		goto out;
>> +
>
> Shouldn't you consume the 'skb' in case "not allowed"? the 'out' label
> doesn't take care of that.
>
>> +bool br_allowed_ingress(struct net_port_vlans *v, struct sk_buff *skb)
>> +{
>> +	struct net_port_vlan *pve;
>> +	u16 vid;
>> +
>> +	/* If there are no vlan in the permitted list, all packets are
>> +	 * permitted.
>> +	 */
>> +	if (list_empty(&v->vlan_list))
>> +		return true;
>
> Rethinking this, after discussed at [1].
> The above means the port having no vlans is actually a member of every
> possible vlan.
> IMO it might not be what users expect, and may complicate things.
>
> Maybe we should adapt a simpler approach:
> If the bridge is a vlan enabled bridge, and the port is not a member of
> the given vid, drop.
> If the bridge is "vlan disabled", then all packets are permitted.
>

this is hybrid configuration where some ports have vlan filtering 
enabled while others do not.

Currently the default is to act as a non-vlan bridge when there is no 
configuration.  I'll consider adding a configuration nob to switch the 
behavior so that strict filtering can be enforced.

-vlad

> Regards,
> Shmulik
>
> [1]
> http://marc.info/?l=linux-netdev&m=135602065425514&w=2
>

