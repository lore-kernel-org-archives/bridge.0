Date: Wed, 27 May 2009 10:42:26 +0200
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20090527084226.GB1652@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090326155205.GA28868@psychotron.englab.brq.redhat.com>
	<20090526151717.GB11147@psychotron.englab.brq.redhat.com>
	<4A1C2009.4010507@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4A1C2009.4010507@cosmosbay.com>
Subject: Re: [Bridge] [PATCH net-next] bonding: allow bond in mode
	balance-alb to	work properly in bridge -try4.1
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, mschmidt@redhat.com, bonding-devel@lists.sourceforge.net, jgarzik@pobox.com, davem@davemloft.net

Tue, May 26, 2009 at 06:59:53PM CEST, dada1@cosmosbay.com wrote:
>Jiri Pirko a =E9crit :
>> [PATCH net-next] bonding: allow bond in mode balance-alb to work properl=
y in bridge -try4.1
>>=20
>> Hi all.
>>=20
>> The problem is described in following bugzilla:
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D487763
>>=20
>> Basically here's what's going on. In every mode, bonding interface uses =
the same
>> mac address for all enslaved devices (except fail_over_mac). Only balanc=
e-alb
>> will simultaneously use multiple MAC addresses across different slaves. =
When you
>> put this kind of bond device into a bridge it will only add one of mac a=
dresses
>> into a hash list of mac addresses, say X. This mac address is marked as =
local.
>> But this bonding interface also has mac address Y. Now then packet arriv=
es with
>> destination address Y, this address is not marked as local and the packe=
d looks
>> like it needs to be forwarded. This packet is then lost which is wrong.
>>=20
>> Notice that interfaces can be added and removed from bond while it is in=
 bridge.
>>=20
>> ***
>> When the multiple addresses for bridge port approach failed to solve thi=
s issue
>> due to STP I started to think other way to solve this. I returned to pre=
vious
>> solution but tweaked one.
>>=20
>> This patch solves the situation in the bonding without touching bridge c=
ode.
>> For every incoming frame to bonding the destination address is compared =
to
>> current address of the slave device from which tha packet came. If these=
 two
>> match destination address is replaced by mac address of the master. This=
 address
>> is known by bridge so it is delivered properly.
>>=20
>> I experimentally tried that this works as good as searching through the =
slave
>> list (v4 of this patch).
>>=20
>> I was forced to create a new header because I need to use
>> compare_ether_addr_64bits() (defined in linux/etherdevice.h) in
>> linux/netdevice.h. I've hit some cross include issues. I think that it's=
 good
>> to have skb_bond_should_drop() in a separate file anyway.
>>=20
>> Jirka
>>=20
>>=20
>> Signed-off-by: Jiri Pirko <jpirko@redhat.com>
>>=20
>> diff --git a/include/linux/bonding.h b/include/linux/bonding.h
>> new file mode 100644
>> index 0000000..3081ddb
>> --- /dev/null
>> +++ b/include/linux/bonding.h
>> @@ -0,0 +1,78 @@
>> +/*
>> + * include/linux/bonding.h
>> + *
>> + * Copyright (C) 2009 Jiri Pirko <jpirko@redhat.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2
>> + * as published by the Free Software Foundation.
>> + *
>> + * Bonding device helpers.
>> + */
>> +
>> +#ifndef _LINUX_BONDING_H
>> +#define _LINUX_BONDING_H
>> +
>> +#ifdef __KERNEL__
>> +
>> +#include <linux/skbuff.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/if.h>
>> +#include <linux/etherdevice.h>
>> +#include <linux/if_ether.h>
>> +
>> +static inline void skb_bond_set_mac_by_master(struct sk_buff *skb,
>> +					      struct net_device *dev,
>> +					      struct net_device *master)
>> +{
>> +	unsigned char *dest =3D eth_hdr(skb)->h_dest;
>> +
>> +	if (compare_ether_addr_64bits(dest, master->dev_addr) &&
>> +	    !compare_ether_addr_64bits(dest, dev->dev_addr))
>> +		memcpy(dest, master->dev_addr, ETH_ALEN);
>
>But couldnt we test skb->pkt_type =3D=3D PACKET_HOST instead,
>Or eth_type_trans() not yet called at this point ?
>
>I would suggest :
>
>if (skb->pkt_type =3D=3D PACKET_HOST)
>	memcpy(dest, master->dev_addr, ETH_ALEN);

Yes Eric, you are right, good point.

eth_type_trans() is called in any driver before and
compare_ether_addr_64bits(dest, dev->dev_addr) is done there. So it's safe
to use this here (and save some ticks). I'm going to make a new patch and
test it.

		Jirka
>
>> +}
>> +
>> +/* On bonding slaves other than the currently active slave, suppress
>> + * duplicates except for 802.3ad ETH_P_SLOW, alb non-mcast/bcast, and
>> + * ARP on active-backup slaves with arp_validate enabled.
>> + */
>> +static inline int skb_bond_should_drop(struct sk_buff *skb)
>> +{
>> +	struct net_device *dev =3D skb->dev;
>> +	struct net_device *master =3D dev->master;
>> +
>> +	if (master) {
>> +		if (master->priv_flags & IFF_MASTER_ARPMON)
>> +			dev->last_rx =3D jiffies;
>> +
>> +		if ((master->priv_flags & IFF_MASTER_ALB) && master->br_port) {
>> +			/* Do address unmangle. The local destination address
>> +			 * will be always the one master has. Provides the right
>> +			 * functionality in a bridge.
>> +			 */
>> +			skb_bond_set_mac_by_master(skb, dev, master);
>> +		}
>> +
>> +		if (dev->priv_flags & IFF_SLAVE_INACTIVE) {
>> +			if ((dev->priv_flags & IFF_SLAVE_NEEDARP) &&
>> +			    skb->protocol =3D=3D __cpu_to_be16(ETH_P_ARP))
>> +				return 0;
>> +
>> +			if (master->priv_flags & IFF_MASTER_ALB) {
>> +				if (skb->pkt_type !=3D PACKET_BROADCAST &&
>> +				    skb->pkt_type !=3D PACKET_MULTICAST)
>> +					return 0;
>> +			}
>> +			if (master->priv_flags & IFF_MASTER_8023AD &&
>> +			    skb->protocol =3D=3D __cpu_to_be16(ETH_P_SLOW))
>> +				return 0;
>> +
>> +			return 1;
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>> +#endif /* __KERNEL__ */
>> +
>> +#endif	/* _LINUX_BONDING_H */
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index ae3c209..06e24ae 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -1897,39 +1897,6 @@ static inline void netif_set_gso_max_size(struct =
net_device *dev,
>>  	dev->gso_max_size =3D size;
>>  }
>> =20
>> -/* On bonding slaves other than the currently active slave, suppress
>> - * duplicates except for 802.3ad ETH_P_SLOW, alb non-mcast/bcast, and
>> - * ARP on active-backup slaves with arp_validate enabled.
>> - */
>> -static inline int skb_bond_should_drop(struct sk_buff *skb)
>> -{
>> -	struct net_device *dev =3D skb->dev;
>> -	struct net_device *master =3D dev->master;
>> -
>> -	if (master) {
>> -		if (master->priv_flags & IFF_MASTER_ARPMON)
>> -			dev->last_rx =3D jiffies;
>> -
>> -		if (dev->priv_flags & IFF_SLAVE_INACTIVE) {
>> -			if ((dev->priv_flags & IFF_SLAVE_NEEDARP) &&
>> -			    skb->protocol =3D=3D __cpu_to_be16(ETH_P_ARP))
>> -				return 0;
>> -
>> -			if (master->priv_flags & IFF_MASTER_ALB) {
>> -				if (skb->pkt_type !=3D PACKET_BROADCAST &&
>> -				    skb->pkt_type !=3D PACKET_MULTICAST)
>> -					return 0;
>> -			}
>> -			if (master->priv_flags & IFF_MASTER_8023AD &&
>> -			    skb->protocol =3D=3D __cpu_to_be16(ETH_P_SLOW))
>> -				return 0;
>> -
>> -			return 1;
>> -		}
>> -	}
>> -	return 0;
>> -}
>> -
>>  extern struct pernet_operations __net_initdata loopback_net_ops;
>> =20
>>  static inline int dev_ethtool_get_settings(struct net_device *dev,
>> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
>> index 7f7de1a..c6eae40 100644
>> --- a/net/8021q/vlan_core.c
>> +++ b/net/8021q/vlan_core.c
>> @@ -2,6 +2,7 @@
>>  #include <linux/netdevice.h>
>>  #include <linux/if_vlan.h>
>>  #include <linux/netpoll.h>
>> +#include <linux/bonding.h>
>>  #include "vlan.h"
>> =20
>>  /* VLAN rx hw acceleration helper.  This acts like netif_{rx,receive_sk=
b}(). */
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 241613f..221b43f 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -127,6 +127,7 @@
>>  #include <linux/jhash.h>
>>  #include <linux/random.h>
>>  #include <trace/napi.h>
>> +#include <linux/bonding.h>
>> =20
>>  #include "net-sysfs.h"
>> =20
>> --
>> To unsubscribe from this list: send the line "unsubscribe netdev" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>>=20
>
>
