Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=LS4bwekvLf/AuI9WOaVDpV+PlQJkRrabTErSQfGc7aQ=;
	b=V0M+l4okFwf+FHqrDja2oKdKdLbq8Jh7J6u87d1OxhcLH8iwRtU1BmQp4ozd01/RcHajx4Ov4sy66o7npKNSPg4BnqAXV11qnu9McV9XZxcbaxMnyAnrDJJKnQs6uTtrgWX4PBSWM1ELS0nbynpXWQPCwSQIkqT89mo+gTbDJLI=
From: Petr Machata <petrm@mellanox.com>
References: <cover.1527173527.git.petrm@mellanox.com>
	<af1bed5ce2b236544edd591b8cfb8425c2cb5ca0.1527173527.git.petrm@mellanox.com>
	<87d0xjzpf2.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
Date: Fri, 25 May 2018 19:56:10 +0300
In-Reply-To: <87d0xjzpf2.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
	(Vivien Didelot's message of "Fri, 25 May 2018 12:10:57 -0400")
Message-ID: <wih4livhdxx.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 1/7] net: bridge: Extract boilerplate
	around switchdev_port_obj_*()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: devel@driverdev.osuosl.org, f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, davem@davemloft.net

Vivien Didelot <vivien.didelot@savoirfairelinux.com> writes:

> Hi Petr,
>
> Petr Machata <petrm@mellanox.com> writes:
>
>> -static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
>> -			  u16 vid, u16 flags)
>> +static int br_switchdev_port_obj_add(struct net_device *dev, u16 vid, u16 flags)
>>  {
>>  	struct switchdev_obj_port_vlan v = {
>>  		.obj.orig_dev = dev,
>> @@ -89,12 +88,29 @@ static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
>>  		.vid_begin = vid,
>>  		.vid_end = vid,
>>  	};
>> -	int err;
>>  
>> +	return switchdev_port_obj_add(dev, &v.obj);
>> +}
>> +
>> +static int br_switchdev_port_obj_del(struct net_device *dev, u16 vid)
>> +{
>> +	struct switchdev_obj_port_vlan v = {
>> +		.obj.orig_dev = dev,
>> +		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
>> +		.vid_begin = vid,
>> +		.vid_end = vid,
>> +	};
>> +
>> +	return switchdev_port_obj_del(dev, &v.obj);
>> +}
>
> Shouldn't they be br_switchdev_port_vlan_add (or similar) implemented in
> net/bridge/br_switchdev.c instead, since they are VLAN specific?

(You mean switchdev-specific?)

This logic was in br_vlan.c before as well, so it's natural to think
about the functions as helpers of VLAN module. I can move to
br_switchdev.c if you think that's the better place.

Thanks,
Petr
