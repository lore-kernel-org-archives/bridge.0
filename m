Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=N1JQmXY3MiDRND7VSRLrJaIi39qStDN8kUy7mhBbHvU=;
 b=OSplhnKUOwP/veTrvwlJNWoyd87iFGFw8KdsfnskpNvi1DmxUUgeZ0y6FXU0giiaOP
 9BVNdyU7XnlL2cClz2rvZAGklte+z/PEetCiaCped+Uf4MBQcpaplfit3FIKb7AWzd/H
 qrvJS6ujHQQ1suru6bmMtVfnlqCcKiVEoG8rdEhcEGaW/COSjpVP+Esrb4s4UhTA8d4D
 p9x28oqyveUyDWRkb/H5dKvNfzWBNXnlzwHieQzR/W23XRLZB+hT40Kou+DhLb0scGCr
 H8QDY73piaAptUbBkzZaupPKKevN87TEEqJ1jSXSOCQY+WpGSwQXUMvpcYTb+d2RL5OG
 I/Qg==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20220303205921.sxb52jzw4jcdj6m7@skbuf>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-5-tobias@waldekranz.com>
 <20220303205921.sxb52jzw4jcdj6m7@skbuf>
Date: Tue, 08 Mar 2022 09:01:04 +0100
Message-ID: <87y21kna9r.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v2 net-next 04/10] net: bridge: mst: Notify
 switchdev drivers of VLAN MSTI migrations
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 22:59, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Tue, Mar 01, 2022 at 11:03:15AM +0100, Tobias Waldekranz wrote:
>> Whenever a VLAN moves to a new MSTI, send a switchdev notification so
>> that switchdevs can...
>> 
>> ...either refuse the migration if the hardware does not support
>> offloading of MST...
>> 
>> ..or track a bridge's VID to MSTI mapping when offloading is
>> supported.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>>  include/net/switchdev.h   | 10 +++++++
>>  net/bridge/br_mst.c       | 15 +++++++++++
>>  net/bridge/br_switchdev.c | 57 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 82 insertions(+)
>> 
>> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
>> index 3e424d40fae3..39e57aa5005a 100644
>> --- a/include/net/switchdev.h
>> +++ b/include/net/switchdev.h
>> @@ -28,6 +28,7 @@ enum switchdev_attr_id {
>>  	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
>>  	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
>>  	SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
>> +	SWITCHDEV_ATTR_ID_VLAN_MSTI,
>>  };
>>  
>>  struct switchdev_brport_flags {
>> @@ -35,6 +36,14 @@ struct switchdev_brport_flags {
>>  	unsigned long mask;
>>  };
>>  
>> +struct switchdev_vlan_attr {
>> +	u16 vid;
>> +
>> +	union {
>> +		u16 msti;
>> +	};
>
> Do you see other VLAN attributes that would be added in the future, such
> as to justify making this a single-element union from the get-go?

I could imagine being able to control things like multicast snooping on
a per-VLAN basis. Being able to act as a multicast router in one VLAN
but not another.

> Anyway if that is the case, we're lacking an id for the attribute type,
> so we'd end up needing to change drivers when a second union element
> appears. Otherwise they'd all expect an u16 msti.

My idea was that `enum switchdev_attr_id` would hold all of that
information. In this example SWITCHDEV_ATTR_ID_VLAN_MSTI, denotes both
that `vlan_attr` is the valid member of `u` and that `msti` is the valid
member of `vlan_attr`. If we add SWITCHDEV_ATTR_ID_VLAN_SNOOPING, that
would point to both `vlan_attr` and a new `bool snooping` in the union.

Do you think we should just have a SWITCHDEV_ATTR_ID_VLAN_ATTR for all
per-VLAN attributes and then have a separate union?

>> +};
>> +
>>  struct switchdev_attr {
>>  	struct net_device *orig_dev;
>>  	enum switchdev_attr_id id;
>> @@ -50,6 +59,7 @@ struct switchdev_attr {
>>  		u16 vlan_protocol;			/* BRIDGE_VLAN_PROTOCOL */
>>  		bool mc_disabled;			/* MC_DISABLED */
>>  		u8 mrp_port_role;			/* MRP_PORT_ROLE */
>> +		struct switchdev_vlan_attr vlan_attr;	/* VLAN_* */
>>  	} u;
>>  };
>>  
>> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
>> index 8dea8e7257fd..aba603675165 100644
>> --- a/net/bridge/br_mst.c
>> +++ b/net/bridge/br_mst.c
>> @@ -7,6 +7,7 @@
>>   */
>>  
>>  #include <linux/kernel.h>
>> +#include <net/switchdev.h>
>>  
>>  #include "br_private.h"
>>  
>> @@ -65,9 +66,23 @@ static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
>>  
>>  int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
>>  {
>> +	struct switchdev_attr attr = {
>> +		.id = SWITCHDEV_ATTR_ID_VLAN_MSTI,
>> +		.flags = SWITCHDEV_F_DEFER,
>
> Is the bridge spinlock held (atomic context), or otherwise why is
> SWITCHDEV_F_DEFER needed here?

Nope, just copypasta. In fact, it shouldn't be needed when setting the
state either, as you can only change the state via a netlink message. I
will remove it.

>> +		.orig_dev = mv->br->dev,
>> +		.u.vlan_attr = {
>> +			.vid = mv->vid,
>> +			.msti = msti,
>> +		},
>> +	};
>>  	struct net_bridge_vlan_group *vg;
>>  	struct net_bridge_vlan *pv;
>>  	struct net_bridge_port *p;
>> +	int err;
>> +
>> +	err = switchdev_port_attr_set(mv->br->dev, &attr, NULL);
>
> Treating a "VLAN attribute" as a "port attribute of the bridge" is
> pushing the taxonomy just a little, but I don't have a better suggestion.

Isn't there prior art here? I thought things like VLAN filtering already
worked like this?

>> +	if (err && err != -EOPNOTSUPP)
>> +		return err;
>>  
>>  	mv->msti = msti;
>>  
>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>> index 6f6a70121a5e..160d7659f88a 100644
>> --- a/net/bridge/br_switchdev.c
>> +++ b/net/bridge/br_switchdev.c
>> @@ -428,6 +428,57 @@ static int br_switchdev_vlan_replay(struct net_device *br_dev,
>>  	return 0;
>>  }
>>  
>> +static int br_switchdev_mst_replay(struct net_device *br_dev,
>> +				   const void *ctx, bool adding,
>> +				   struct notifier_block *nb,
>> +				   struct netlink_ext_ack *extack)
>
> "bool adding" is unused, and replaying the VLAN to MSTI associations
> before deleting them makes little sense anyway.
>
> I understand the appeal of symmetry, so maybe put an
>
> 	if (adding) {
> 		err = br_switchdev_vlan_attr_replay(...);
> 		if (err && err != -EOPNOTSUPP)
> 			return err;
> 	}
>
> at the end of br_switchdev_vlan_replay()?

Yeah, that is better. Will change.

>> +{
>> +	struct switchdev_notifier_port_attr_info attr_info = {
>> +		.info = {
>> +			.dev = br_dev,
>> +			.extack = extack,
>> +			.ctx = ctx,
>> +		},
>> +	};
>> +	struct net_bridge *br = netdev_priv(br_dev);
>> +	struct net_bridge_vlan_group *vg;
>> +	struct net_bridge_vlan *v;
>> +	int err;
>> +
>> +	ASSERT_RTNL();
>> +
>> +	if (!nb)
>> +		return 0;
>> +
>> +	if (!netif_is_bridge_master(br_dev))
>> +		return -EINVAL;
>> +
>> +	vg = br_vlan_group(br);
>> +
>> +	list_for_each_entry(v, &vg->vlan_list, vlist) {
>> +		struct switchdev_attr attr = {
>> +			.id = SWITCHDEV_ATTR_ID_VLAN_MSTI,
>> +			.flags = SWITCHDEV_F_DEFER,
>
> I don't think SWITCHDEV_F_DEFER has any effect on a replay.

Right, will fix.

>> +			.orig_dev = br_dev,
>> +			.u.vlan_attr = {
>> +				.vid = v->vid,
>> +				.msti = v->msti,
>> +			}
>> +		};
>> +
>> +		if (!v->msti)
>> +			continue;
>> +
>> +		attr_info.attr = &attr;
>> +		err = nb->notifier_call(nb, SWITCHDEV_PORT_ATTR_SET, &attr_info);
>> +		err = notifier_to_errno(err);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>>  struct br_switchdev_mdb_complete_info {
>>  	struct net_bridge_port *port;
>> @@ -695,6 +746,10 @@ static int nbp_switchdev_sync_objs(struct net_bridge_port *p, const void *ctx,
>>  	if (err && err != -EOPNOTSUPP)
>>  		return err;
>>  
>> +	err = br_switchdev_mst_replay(br_dev, ctx, true, blocking_nb, extack);
>> +	if (err && err != -EOPNOTSUPP)
>> +		return err;
>> +
>>  	err = br_switchdev_mdb_replay(br_dev, dev, ctx, true, blocking_nb,
>>  				      extack);
>>  	if (err && err != -EOPNOTSUPP)
>> @@ -719,6 +774,8 @@ static void nbp_switchdev_unsync_objs(struct net_bridge_port *p,
>>  
>>  	br_switchdev_mdb_replay(br_dev, dev, ctx, false, blocking_nb, NULL);
>>  
>> +	br_switchdev_mst_replay(br_dev, ctx, false, blocking_nb, NULL);
>> +
>>  	br_switchdev_vlan_replay(br_dev, ctx, false, blocking_nb, NULL);
>>  }
>>  
>> -- 
>> 2.25.1
>> 
