Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=rB2q7MQ7J/KaEymVOQJLRMIh7rosEQW9d1ETUlUXggU=;
	b=MtIq3LcI58Mesf8GVIMun54+kiesmdve1j8s57w7RC+fFn+Kuy9pIIYMYHBBC1/jbpNhpuJsnBUe9B4dUzdz9BRIr+QenFd1kZ27UYgMN+JtB/mDKWcBMANh//s8IlQbJc4ZGNbQdyLLTMkNCwxGU7RA0uEF3Te1bLGIeThKHkk=
From: Petr Machata <petrm@mellanox.com>
References: <20180426090637.25262-1-idosch@mellanox.com>
	<20180426090637.25262-7-idosch@mellanox.com>
	<1e3e120f-821a-2d99-b720-0585ce9c1803@cumulusnetworks.com>
Date: Thu, 26 Apr 2018 16:03:03 +0300
In-Reply-To: <1e3e120f-821a-2d99-b720-0585ce9c1803@cumulusnetworks.com>
	(Nikolay Aleksandrov's message of "Thu, 26 Apr 2018 13:50:12 +0300")
Message-ID: <wihh8nyunlk.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 6/6] mlxsw: spectrum_span: Allow
	bridge for gretap mirror
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: mlxsw@mellanox.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, davem@davemloft.net

Nikolay Aleksandrov <nikolay@cumulusnetworks.com> writes:

> On 26/04/18 12:06, Ido Schimmel wrote:
>> From: Petr Machata <petrm@mellanox.com>
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
>> index 65a77708ff61..92fb81839852 100644
>> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
>> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
>> @@ -167,6 +169,79 @@ mlxsw_sp_span_entry_unoffloadable(struct mlxsw_sp_span_parms *sparmsp)
>>   	return 0;
>>   }
>>   +static struct net_device *
>> +mlxsw_sp_span_entry_bridge_8021q(const struct net_device *br_dev,
>> +				 unsigned char *dmac,
>> +				 u16 *p_vid)
>> +{
>> +	struct net_bridge_vlan_group *vg = br_vlan_group_rtnl(br_dev);
>> +	u16 pvid = br_vlan_group_pvid(vg);
>> +	struct net_device *edev = NULL;
>> +	struct net_bridge_vlan *v;
>> +
>
> Hi,
> These structures are not really exported anywhere outside of br_private.h
> Instead of passing them around and risking someone else actually trying to
> dereference an incomplete type, why don't you add just 2 new helpers -
> br_vlan_pvid(netdevice) and br_vlan_info(netdevice, vid, *bridge_vlan_info)
>
> br_vlan_info can return the exported and already available type "bridge_vlan_info"
> (defined in uapi/linux/if_bridge.h) into the bridge_vlan_info arg
> and br_vlan_pvid is obvious - return the current dev pvid if available.
>
> Another bonus you'll avoid dealing with the bridge's vlan internals.

All right, I'll do it like that.

>
>> +	if (pvid)
>> +		edev = br_fdb_find_port_hold(br_dev, dmac, pvid);
>> +	if (!edev)
>> +		return NULL;
>> +
>> +	/* RTNL prevents edev from being removed. */
>> +	dev_put(edev);
>
> Minor point here - since this is always called in rtnl, the dev_hold/put dance isn't needed,
> unless you plan to use the fdb_find_port_hold outside of rtnl of course. In case that is
> not planned why don't you do br_fdb_find_port_rtnl() instead with RCU inside (thus not blocking
> learning) and ASSERT_RTNL() to avoid some complexity ?

OK, sounds good.

I'll spin a v2.

Thanks,
Petr
