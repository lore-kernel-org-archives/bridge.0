Return-Path: <vyasevic@redhat.com>
Message-ID: <50EF0B76.2040503@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1357751882-8619-1-git-send-email-vyasevic@redhat.com>
	<1357751882-8619-2-git-send-email-vyasevic@redhat.com>
	<20130110102525.2ff40c12@nehalam.linuxnetplumber.net>
In-Reply-To: <20130110102525.2ff40c12@nehalam.linuxnetplumber.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v5 01/14] vlan: wrap hw-acceleration
 calls in separate functions.
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Thu, 10 Jan 2013 18:42:07 -0000
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, stephen@redhat.com, bridge@lists.linux-foundation.org, shmulik.ladkani@gmail.com, davem@davemloft.net

On 01/10/2013 01:25 PM, Stephen Hemminger wrote:
> On Wed,  9 Jan 2013 12:17:48 -0500
> Vlad Yasevich <vyasevic@redhat.com> wrote:
>
>>
>>   /**
>> + * vlan_hw_buggy - Check to see if VLAN hw acceleration is supported.
>> + * @dev: netdevice of the lowerdev/hw nic
>> + *
>> + * Checks to see if HW and driver report VLAN acceleration correctly.
>> + */
>> +static inline bool vlan_hw_buggy(const struct net_device *dev)
>> +{
>> +	const struct net_device_ops *ops = dev->netdev_ops;
>> +
>> +	if ((dev->features & NETIF_F_HW_VLAN_FILTER) &&
>> +	    (!ops->ndo_vlan_rx_add_vid || !ops->ndo_vlan_rx_kill_vid))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +/**
>> + * vlan_vid_add_hw - Add the VLAN vid to the HW filter
>> + * @dev: netdevice of the lowerdev/hw nic
>> + * @vid: vlan id.
>> + *
>> + * Inserts the vid into the HW vlan filter table if hw supports it.
>> + */
>> +static inline int vlan_vid_add_hw(struct net_device *dev,
>> +				  unsigned short vid)
>> +{
>> +	const struct net_device_ops *ops = dev->netdev_ops;
>> +	int err = 0;
>> +
>> +	if ((dev->features & NETIF_F_HW_VLAN_FILTER) &&
>> +	    ops->ndo_vlan_rx_add_vid)
>> +		err = ops->ndo_vlan_rx_add_vid(dev, vid);
>> +
>> +	return err;
>> +}
>> +
>> +/**
>> + * vlan_vid_del_hw - Delete the VLAN vid from the HW filter
>> + * @dev: netdevice of the lowerdev/hw nic
>> + * @vid: vlan id.
>> + *
>> + * Delete the vid from the HW vlan filter table if hw supports it.
>> + */
>> +static inline int vlan_vid_del_hw(struct net_device *dev,
>> +				  unsigned short vid)
>> +{
>> +	const struct net_device_ops *ops = dev->netdev_ops;
>> +	int err = 0;
>> +
>> +	if ((dev->features & NETIF_F_HW_VLAN_FILTER) &&
>> +	    ops->ndo_vlan_rx_kill_vid)
>> +		err = ops->ndo_vlan_rx_add_vid(dev, vid);
>> +
>> +	return err;
>> +}
>> +
>
> I would rather not have all these inline's. This isn't performance critical.

I kind of need to keep them as inlines because of the VLAN support is 
built.  Right now, none of the VLAN files are build if VLAN support is
turned off.  So all we get access to are inlines from if_vlan.h.

I suppose I can change how VLANs get built, but not if that's the right 
thing.  It looks like it is set up the way it is on purpose.

> Also, the check for buggy devices should be done inside the vlan code,
> not repeated in the functions using the add/remove API. When device is
> registered the flag and add/kill should be checked, and if the device driver
> is buggy it should fail the register_netdevice.
>

Not sure what you mean here.  I don't check if it's buggy again.  I 
check that the device supports filter and the pointer is set.  I does
exactly what the code used to do.  I suppose that the checks for valid
function pointers may be a little redundant since otherwise 
vlan_hw_buggy() would have triggered, but it's safer to have them since 
we can't guarantee that other users have checked for buggy implementations.

-vlad
