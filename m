Message-ID: <4505B312.4030606@gac.edu>
Date: Mon, 11 Sep 2006 14:03:46 -0500
From: Ethan Sommer <sommere@gac.edu>
MIME-Version: 1.0
References: <20060911174928.GA3451@devicescape.com>
In-Reply-To: <20060911174928.GA3451@devicescape.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms040301060804060808080105"
Subject: Re: [Bridge] RFC: [PATCH] bridge vlan integration
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: David Kimdon <david.kimdon@devicescape.com>
Cc: bridge@lists.osdl.org

This is a cryptographically signed message in MIME format.

--------------ms040301060804060808080105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Have you tested this in a real world scenario?

I attempted to use a linux bridge to bridge a few vlans and found that 
it didn't work as expected. At first I thought it was a performance 
problem relating to the linux bridge code because it was dropping 
packets, but I believe the problem is inherent in using a bridge in a 
vlan environment.

The problem lies in the fact that the switch connected to the bridge 
(which has the vlans tagged) gets confused as to which port that 
particular mac address is out of. Take the following scenario: (based on 
my understanding of how things should work)

1. Computer a on vlan 6 wants to send out a packet to computer b on vlan 7.
2. Computer a sends out an arp request for computer b. (core switch 
records computer A as being on port A14)
3. The arp request reaches the linux bridge, which doesn't know computer 
b yet, so it send out an arp request on all other vlans its bridging. 
(core switch records computer A as being on port A1 because it saw a 
packet from that mac on port A1)
4. Computer b responds to the arp request. (core switch records computer 
b as being on port A10)
5. bridge forwards the arp response out A10 to computer a (core switch 
records computer b as being on A10)

As you can see, the core switch (and I've seen this happen on our HP 
5300 switch) gets confused as to which port to send out unicast packets 
-- hence sometimes when it _thinks_ it sent out a packet to the 
computer, the computer didn't actually receive it and the packet needs 
to be resent multiple times until the mac cache times out on the core 
switch.  Under other circumstances, the switch doesn't seem to get 
confused, so it appears to be flaky, not completely broken.

Is there something I could have done differently which would have 
avoided that problem? Does this patch somehow address that problem? Is 
my HP switch just inept and do most switches keep a mac-port table per 
vlan? (I doubt this, because the SNMP mib doesn't allow that to be 
represented.)

Ethan Sommer
UNIX Systems Administrator
Gustavus Adolphus College

David Kimdon wrote:
> Hi,
>
> The attached patches enables the bridge to filter and forward packets
> according to their IEEE 802.1q headers.  The goals behind this change
> include :
>
> - Enable running STP on 802.1q tagged networks.  STP packets
>   must be untagged.  It isn't obvious how else to enable STP
>   with the current bridge and vlan code.
> - Add native support for an untagged vlan.  Currently an untagged
>   vlan can be implimented using ebtables or similar.
> - On devices bridging a large number of interfaces across various
>   vlans this significantly simplifies configuration and, depending on
>   configuration, can improve performance.
>
> Comments appreciated,
>
> David
>
> From: Simon Barber <simon@devicescape.com>
>
> Signed-off-by: Simon Barber <simon@devicescape.com>
> Signed-off-by: David Kimdon <david.kimdon@devicescape.com>
>
> Index: wireless-dev/include/linux/if_bridge.h
> ===================================================================
> --- wireless-dev.orig/include/linux/if_bridge.h
> +++ wireless-dev/include/linux/if_bridge.h
> @@ -44,6 +44,10 @@
>  #define BRCTL_SET_PORT_PRIORITY 16
>  #define BRCTL_SET_PATH_COST 17
>  #define BRCTL_GET_FDB_ENTRIES 18
> +#define BRCTL_SET_PORT_UNTAGGED_VLAN 19
> +#define BRCTL_ADD_PORT_VLAN 20
> +#define BRCTL_DEL_PORT_VLAN 21
> +#define BRCTL_GET_PORT_VLAN_INFO 22
>  
>  #define BR_STATE_DISABLED 0
>  #define BR_STATE_LISTENING 1
> @@ -91,6 +95,12 @@ struct __port_info
>  	__u32 hold_timer_value;
>  };
>  
> +struct __vlan_info
> +{
> +	__u32 untagged;
> +	__u8 filter[4096/8];
> +};
> +
>  struct __fdb_entry
>  {
>  	__u8 mac_addr[6];
> Index: wireless-dev/include/linux/skbuff.h
> ===================================================================
> --- wireless-dev.orig/include/linux/skbuff.h
> +++ wireless-dev/include/linux/skbuff.h
> @@ -296,6 +296,9 @@ struct sk_buff {
>  #endif
>  	__u32			nfmark;
>  #endif /* CONFIG_NETFILTER */
> +#ifdef CONFIG_BRIDGE_VLAN
> +	unsigned int 		vlan;
> +#endif
>  #ifdef CONFIG_NET_SCHED
>  	__u16			tc_index;	/* traffic control index */
>  #ifdef CONFIG_NET_CLS_ACT
> Index: wireless-dev/net/bridge/br_forward.c
> ===================================================================
> --- wireless-dev.orig/net/bridge/br_forward.c
> +++ wireless-dev/net/bridge/br_forward.c
> @@ -24,7 +24,16 @@
>  static inline int should_deliver(const struct net_bridge_port *p, 
>  				 const struct sk_buff *skb)
>  {
> -	return (skb->dev != p->dev && p->state == BR_STATE_FORWARDING);
> +	if (skb->dev == p->dev ||
> +	    p->state != BR_STATE_FORWARDING)
> +		return 0;
> +
> +#ifdef CONFIG_BRIDGE_VLAN
> +	if (skb->vlan && br_vlan_filter(skb, &p->vlan))
> +		return 0;
> +#endif
> +
> +	return 1;
>  }
>  
>  static inline unsigned packet_length(const struct sk_buff *skb)
> @@ -47,6 +56,10 @@ int br_dev_queue_push_xmit(struct sk_buf
>  		{
>  			skb_push(skb, ETH_HLEN);
>  
> +	 		if (br_vlan_output_frame(&skb,
> + 						 skb->dev->br_port->vlan.untagged))
> + 				return 0;
> +
>  			dev_queue_xmit(skb);
>  		}
>  	}
> Index: wireless-dev/net/bridge/br_if.c
> ===================================================================
> --- wireless-dev.orig/net/bridge/br_if.c
> +++ wireless-dev/net/bridge/br_if.c
> @@ -227,6 +227,7 @@ static struct net_device *new_bridge_dev
>  	INIT_LIST_HEAD(&br->age_list);
>  
>  	br_stp_timer_init(br);
> +	br_vlan_init(&br->vlan);
>  
>  	return dev;
>  }
> @@ -278,6 +279,7 @@ static struct net_bridge_port *new_nbp(s
>  	p->state = BR_STATE_DISABLED;
>  	INIT_WORK(&p->carrier_check, port_carrier_check, dev);
>  	br_stp_port_timer_init(p);
> +	br_vlan_init(&p->vlan);
>  
>  	kobject_init(&p->kobj);
>  	kobject_set_name(&p->kobj, SYSFS_BRIDGE_PORT_ATTR);
> Index: wireless-dev/net/bridge/br_input.c
> ===================================================================
> --- wireless-dev.orig/net/bridge/br_input.c
> +++ wireless-dev/net/bridge/br_input.c
> @@ -26,12 +26,20 @@ static void br_pass_frame_up(struct net_
>  {
>  	struct net_device *indev;
>  
> +	if (br_vlan_filter(skb, &br->vlan)) {
> +		kfree_skb(skb);
> +		return;
> +	}
> +
>  	br->statistics.rx_packets++;
>  	br->statistics.rx_bytes += skb->len;
>  
>  	indev = skb->dev;
>  	skb->dev = br->dev;
>  
> +	if (br_vlan_output_frame(&skb, br->vlan.untagged))
> +		return;
> +
>  	NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, indev, NULL,
>  		netif_receive_skb);
>  }
> @@ -136,6 +144,10 @@ int br_handle_frame(struct net_bridge_po
>  	}
>  
>  	if (p->state == BR_STATE_FORWARDING || p->state == BR_STATE_LEARNING) {
> +		if (br_vlan_input_frame(skb, &p->vlan)) {
> +			return 1;
> +		}
> +
>  		if (br_should_route_hook) {
>  			if (br_should_route_hook(pskb)) 
>  				return 0;
> Index: wireless-dev/net/bridge/br_ioctl.c
> ===================================================================
> --- wireless-dev.orig/net/bridge/br_ioctl.c
> +++ wireless-dev/net/bridge/br_ioctl.c
> @@ -302,6 +302,18 @@ static int old_dev_ioctl(struct net_devi
>  	case BRCTL_GET_FDB_ENTRIES:
>  		return get_fdb_entries(br, (void __user *)args[1], 
>  				       args[2], args[3]);
> +
> +#ifdef CONFIG_BRIDGE_VLAN
> +	case BRCTL_SET_PORT_UNTAGGED_VLAN:
> +		return br_vlan_set_untagged(br, args[1], args[2]);
> +
> +	case BRCTL_ADD_PORT_VLAN:
> +	case BRCTL_DEL_PORT_VLAN:
> +		return br_vlan_set_filter(br, args[0], args[1], args[2]);
> +
> +	case BRCTL_GET_PORT_VLAN_INFO:
> +		return br_vlan_get_info(br, (void *)args[1], args[2]);
> +#endif
>  	}
>  
>  	return -EOPNOTSUPP;
> Index: wireless-dev/net/bridge/br_private.h
> ===================================================================
> --- wireless-dev.orig/net/bridge/br_private.h
> +++ wireless-dev/net/bridge/br_private.h
> @@ -59,6 +59,14 @@ struct net_bridge_fdb_entry
>  	unsigned char			is_static;
>  };
>  
> +#ifdef CONFIG_BRIDGE_VLAN
> +struct net_bridge_port_vlan
> +{
> +	int				untagged;
> +	u8				filter[4096/8];
> +};
> +#endif
> +
>  struct net_bridge_port
>  {
>  	struct net_bridge		*br;
> @@ -84,6 +92,9 @@ struct net_bridge_port
>  	struct kobject			kobj;
>  	struct work_struct		carrier_check;
>  	struct rcu_head			rcu;
> +#ifdef CONFIG_BRIDGE_VLAN
> +	struct net_bridge_port_vlan 	vlan;
> +#endif
>  };
>  
>  struct net_bridge
> @@ -96,6 +107,9 @@ struct net_bridge
>  	struct hlist_head		hash[BR_HASH_SIZE];
>  	struct list_head		age_list;
>  	unsigned long			feature_mask;
> +#ifdef CONFIG_BRIDGE_VLAN
> +	struct net_bridge_port_vlan 	vlan;
> +#endif
>  
>  	/* STP */
>  	bridge_id			designated_root;
> @@ -258,4 +272,32 @@ extern void br_sysfs_delbr(struct net_de
>  #define br_sysfs_delbr(dev)	do { } while(0)
>  #endif /* CONFIG_SYSFS */
>  
> +#ifdef CONFIG_BRIDGE_VLAN
> +#include <linux/if_vlan.h>
> +
> +static inline int br_vlan_filter(const struct sk_buff *skb,
> +				 const struct net_bridge_port_vlan *vlan)
> +{
> +	return !(vlan->filter[skb->vlan / 8] & (1 << (skb->vlan & 7)));
> +}
> +
> +/* br_vlan.c */
> +extern int br_vlan_input_frame(struct sk_buff *skb,
> +			       struct net_bridge_port_vlan *vlan);
> +extern int br_vlan_output_frame(struct sk_buff **pskb, unsigned int untagged);
> +extern void br_vlan_init(struct net_bridge_port_vlan *vlan);
> +extern int br_vlan_set_untagged(struct net_bridge *br,
> +				unsigned int port, unsigned int vid);
> +extern int br_vlan_set_filter(struct net_bridge *br,
> +			      unsigned int cmd,
> +			      unsigned int port, unsigned int vid);
> +extern int br_vlan_get_info(struct net_bridge *br,
> +			    void *user_mem, unsigned long port);
> +#else
> +
> +#define br_vlan_filter(skb, vlan)		(0)
> +#define br_vlan_input_frame(skb, vlan)		(0)
> +#define br_vlan_output_frame(pskb, untagged)	(0)
> +#define br_vlan_init(vlan)			do { } while(0)
> +#endif /* CONFIG_BRIDGE_VLAN */
>  #endif
> Index: wireless-dev/net/bridge/br_vlan.c
> ===================================================================
> --- /dev/null
> +++ wireless-dev/net/bridge/br_vlan.c
> @@ -0,0 +1,203 @@
> +/*
> + *	VLAN support
> + *	Linux ethernet bridge
> + *
> + *	Authors:
> + *	Simon Barber			<simon@devicescape.com>
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/netdevice.h>
> +#include <linux/inetdevice.h>
> +#include <linux/skbuff.h>
> +#include <linux/if_bridge.h>
> +#include <linux/netfilter_bridge.h>
> +#include <asm/uaccess.h>
> +#include "br_private.h"
> +
> +int br_vlan_input_frame(struct sk_buff *skb, struct net_bridge_port_vlan *vlan)
> +{
> +	if (skb->protocol != htons(ETH_P_8021Q)) {
> +		skb->vlan = vlan->untagged;
> +	} else {
> +		struct vlan_ethhdr *vhdr = (struct vlan_ethhdr *)(skb->mac.raw);
> +		unsigned short vlan_TCI = ntohs(vhdr->h_vlan_TCI);
> +		unsigned short vid = (vlan_TCI & VLAN_VID_MASK);
> +
> +		skb->vlan = vid ? vid : vlan->untagged;
> +	}
> +
> +	if (skb->vlan == 0)
> +		goto err;
> +
> +	if (br_vlan_filter(skb, vlan))
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	kfree_skb(skb);
> +	return 1;
> +}
> +
> +int br_vlan_output_frame(struct sk_buff **pskb, unsigned int untagged)
> +{
> +	struct sk_buff *skb = *pskb;
> +
> +	if (skb->vlan == 0)	/* don't touch the frame */
> +		return 0;
> +
> +	if (skb->vlan == untagged) {
> +		/* frame should be untagged */
> +		if (eth_hdr(skb)->h_proto == htons(ETH_P_8021Q)) {
> +			/* remove VLAN tag */
> +			if (skb_cloned(skb) || skb_shared(skb)) {
> +				struct sk_buff *new_skb;
> +
> +				new_skb = skb_copy(skb, GFP_ATOMIC);
> +				kfree_skb(skb);
> +				if (!new_skb)
> +					return 1;
> +				*pskb = skb = new_skb;
> +			}
> +
> +			skb->mac.raw += VLAN_HLEN;
> +			memmove(skb->mac.raw, skb->data, ETH_ALEN * 2);
> +			skb_pull(skb, VLAN_HLEN);
> +		}
> +	} else {
> +		/* frame should be tagged */
> +		if (eth_hdr(skb)->h_proto != htons(ETH_P_8021Q)) {
> +			/* add VLAN tag */
> +			struct vlan_ethhdr *vhdr;
> +			if (skb_cloned(skb) || skb_shared(skb)) {
> +				struct sk_buff *new_skb;
> +
> +				new_skb = skb_copy(skb, GFP_ATOMIC);
> +				kfree_skb(skb);
> +				if (!new_skb)
> +					return 1;
> +				*pskb = skb = new_skb;
> +			}
> +
> +			if (skb_headroom(skb) < VLAN_HLEN) {
> +				if (pskb_expand_head(skb, VLAN_HLEN, 0,
> +						     GFP_ATOMIC)) {
> +					kfree_skb(skb);
> +					return 1;
> +				}
> +			}
> +
> +			skb_push(skb, VLAN_HLEN);
> +
> +			skb->mac.raw -= VLAN_HLEN;
> +			memmove(skb->mac.raw, skb->mac.raw + VLAN_HLEN,
> +				ETH_ALEN * 2);
> +			vhdr = (struct vlan_ethhdr *)skb->mac.raw;
> +			vhdr->h_vlan_proto = htons(ETH_P_8021Q);
> +			vhdr->h_vlan_TCI = htons(skb->vlan);
> +		} else {
> +			/* ensure VID is correct */
> +			struct vlan_ethhdr *vhdr =
> +				(struct vlan_ethhdr *)skb->mac.raw;
> +			vhdr->h_vlan_TCI = (vhdr->h_vlan_TCI & htons(~VLAN_VID_MASK)) |
> +					    htons(skb->vlan);
> +		}
> +		// TODO: set priority in tag correctly
> +	}
> +
> +	return 0;
> +}
> +
> +void br_vlan_init(struct net_bridge_port_vlan *vlan)
> +{
> +	vlan->untagged = 1;
> +	vlan->filter[0] = 1 << 1;
> +}
> +
> +/* ioctl functions */
> +int br_vlan_set_untagged(struct net_bridge *br,
> +			 unsigned int port, unsigned int vid)
> +{
> +	struct net_bridge_port_vlan *vlan;
> +
> +	if (vid > 4094)
> +		return -EINVAL;
> +
> +	if (port) {
> +		struct net_bridge_port *p = br_get_port(br, port);
> +
> +		if (p == NULL)
> +			return -EINVAL;
> +		vlan = &p->vlan;
> +	} else {
> +		vlan = &br->vlan;
> +	}
> +
> +	vlan->untagged = vid;
> +
> +	return 0;
> +}
> +
> +int br_vlan_set_filter(struct net_bridge *br,
> +		       unsigned int cmd, unsigned int port, unsigned int vid)
> +{
> +	struct net_bridge_port_vlan *vlan;
> +	int add = (cmd == BRCTL_ADD_PORT_VLAN);
> +
> +	if (vid > 4094)
> +		return -EINVAL;
> +
> +	if (port) {
> +		struct net_bridge_port *p = br_get_port(br, port);
> +
> +		if (p == NULL)
> +			return -EINVAL;
> +		vlan = &p->vlan;
> +	} else {
> +		vlan = &br->vlan;
> +	}
> +
> +	if (vid == 0) {
> +		/* special case - add/del for all vlans */
> +		memset(vlan->filter, add ? 255 : 0, 4096 / 8);
> +		if (add) {
> +			vlan->filter[4095 / 8] &= ~(1 << (4095 & 7));
> +		}
> +	} else if (add)
> +		vlan->filter[vid / 8] |= 1 << (vid & 7);
> +	else
> +		vlan->filter[vid / 8] &= ~(1 << (vid & 7));
> +
> +	return 0;
> +}
> +
> +int br_vlan_get_info(struct net_bridge *br, void *user_mem, unsigned long port)
> +{
> +	struct net_bridge_port_vlan *vlan;
> +	struct __vlan_info v;
> +
> +	if (port) {
> +		struct net_bridge_port *p = br_get_port(br, port);
> +
> +		if (p == NULL)
> +			return -EINVAL;
> +		vlan = &p->vlan;
> +	} else {
> +		vlan = &br->vlan;
> +	}
> +
> +	memset(&v, 0, sizeof(v));
> +	v.untagged = vlan->untagged;
> +	memcpy(v.filter, vlan->filter, 4096 / 8);
> +
> +	if (copy_to_user((void __user *)user_mem, &v, sizeof(v)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> Index: wireless-dev/net/bridge/Makefile
> ===================================================================
> --- wireless-dev.orig/net/bridge/Makefile
> +++ wireless-dev/net/bridge/Makefile
> @@ -12,4 +12,6 @@ bridge-$(CONFIG_SYSFS) += br_sysfs_if.o 
>  
>  bridge-$(CONFIG_BRIDGE_NETFILTER) += br_netfilter.o
>  
> +bridge-$(CONFIG_BRIDGE_VLAN) += br_vlan.o
> +
>  obj-$(CONFIG_BRIDGE_NF_EBTABLES) += netfilter/
> Index: wireless-dev/net/core/skbuff.c
> ===================================================================
> --- wireless-dev.orig/net/core/skbuff.c
> +++ wireless-dev/net/core/skbuff.c
> @@ -486,6 +486,9 @@ struct sk_buff *skb_clone(struct sk_buff
>  	nf_bridge_get(skb->nf_bridge);
>  #endif
>  #endif /*CONFIG_NETFILTER*/
> +#ifdef CONFIG_BRIDGE_VLAN
> +	C(vlan);
> +#endif
>  #ifdef CONFIG_NET_SCHED
>  	C(tc_index);
>  #ifdef CONFIG_NET_CLS_ACT
> @@ -550,6 +553,9 @@ static void copy_skb_header(struct sk_bu
>  	nf_bridge_get(old->nf_bridge);
>  #endif
>  #endif
> +#ifdef CONFIG_BRIDGE_VLAN
> +	new->vlan	= old->vlan;
> +#endif
>  #ifdef CONFIG_NET_SCHED
>  #ifdef CONFIG_NET_CLS_ACT
>  	new->tc_verd = old->tc_verd;
> Index: wireless-dev/net/bridge/Kconfig
> ===================================================================
> --- wireless-dev.orig/net/bridge/Kconfig
> +++ wireless-dev/net/bridge/Kconfig
> @@ -30,3 +30,13 @@ config BRIDGE
>  	  will be called bridge.
>  
>  	  If unsure, say N.
> +
> +config BRIDGE_VLAN
> +	bool "802.1Q bridge support"
> +	depends on BRIDGE
> +	---help---
> +	  If you say Y here, then your bridge will be able to filter and
> +	  forward packets according to their IEEE 802.1Q headers.
> +
> +	  If unsure, say N.
> +
> Index: wireless-dev/net/bridge/br_device.c
> ===================================================================
> --- wireless-dev.orig/net/bridge/br_device.c
> +++ wireless-dev/net/bridge/br_device.c
> @@ -34,6 +34,9 @@ int br_dev_xmit(struct sk_buff *skb, str
>  	const unsigned char *dest = skb->data;
>  	struct net_bridge_fdb_entry *dst;
>  
> +	if (br_vlan_input_frame(skb, &br->vlan))
> +		return 0;
> +
>  	br->statistics.tx_packets++;
>  	br->statistics.tx_bytes += skb->len;
>  
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
>
>
>   


-- 
Ethan Sommer
UNIX Systems Administrator
Gustavus Adolphus College
507-933-7042
sommere@gac.edu


--------------ms040301060804060808080105
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII+zCC
AtgwggJBoAMCAQICEGXJjmNZhwsanR85yTaORI8wDQYJKoZIhvcNAQEEBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA2MDQwNDE3Mjg0NVoX
DTA3MDQwNDE3Mjg0NVowQTEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEeMBwG
CSqGSIb3DQEJARYPc29tbWVyZUBnYWMuZWR1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAvd0izskVrCeBWOsXokIFHLHB3lZc6GVEKOQ5ZksATRXapJ01SRvKUSK8y/wO61sj
4wVTh6BDWHgQFe5cBtJliITDqQlzRnySq9hrWhR4tQpkIvIcrzY0vcIfpzZpx1YPMEnhbsnJ
KT43ro7xFwLsDqa4is1TNumC8Nidd2OyIXrPHxht9lPTtcJvwFds0op9exL65wOEK5rOCGp4
3hxAMECw0/1SaQ5kZnxRS3dv8/5DVOfv9yCHMhXpv2WSWrFeWOtrvEonRQFfDWuqxubwmYBX
dhTqPjx5Cnm9OrKdcGepA0OCQlK+mVVLkN5IkiTuKTM13K+s4T/TnrHckIHcXQIDAQABoyww
KjAaBgNVHREEEzARgQ9zb21tZXJlQGdhYy5lZHUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0B
AQQFAAOBgQBvSFnEE8mQW/EWhV41zdfKrGIwMde0XGGsDR778EBpgazf1pPKmuTvrK/6BqzY
NJB0VBZyY47SBcTu2sDHfgxUZyaOQP443dFXC0WQvT6/AqfZ6Ms1b6djkVBCb9rBsT7fVpTA
muBuJMQ4N6I+ESlJ1GpKoTSy/1xjHEXkMqY3lzCCAtgwggJBoAMCAQICEGXJjmNZhwsanR85
yTaORI8wDQYJKoZIhvcNAQEEBQAwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBMB4XDTA2MDQwNDE3Mjg0NVoXDTA3MDQwNDE3Mjg0NVowQTEfMB0GA1UE
AxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEeMBwGCSqGSIb3DQEJARYPc29tbWVyZUBnYWMu
ZWR1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvd0izskVrCeBWOsXokIFHLHB
3lZc6GVEKOQ5ZksATRXapJ01SRvKUSK8y/wO61sj4wVTh6BDWHgQFe5cBtJliITDqQlzRnyS
q9hrWhR4tQpkIvIcrzY0vcIfpzZpx1YPMEnhbsnJKT43ro7xFwLsDqa4is1TNumC8Nidd2Oy
IXrPHxht9lPTtcJvwFds0op9exL65wOEK5rOCGp43hxAMECw0/1SaQ5kZnxRS3dv8/5DVOfv
9yCHMhXpv2WSWrFeWOtrvEonRQFfDWuqxubwmYBXdhTqPjx5Cnm9OrKdcGepA0OCQlK+mVVL
kN5IkiTuKTM13K+s4T/TnrHckIHcXQIDAQABoywwKjAaBgNVHREEEzARgQ9zb21tZXJlQGdh
Yy5lZHUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQBvSFnEE8mQW/EWhV41zdfK
rGIwMde0XGGsDR778EBpgazf1pPKmuTvrK/6BqzYNJB0VBZyY47SBcTu2sDHfgxUZyaOQP44
3dFXC0WQvT6/AqfZ6Ms1b6djkVBCb9rBsT7fVpTAmuBuJMQ4N6I+ESlJ1GpKoTSy/1xjHEXk
MqY3lzCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUw
EwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhh
d3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNp
b24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJ
ARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3
MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAo
UHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me
7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQq
E88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEA
AaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9j
cmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIB
BjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcN
AQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNw
PP2t4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq72
6jTlEBpbNU1341YheILcIRk13iSx0x1G/11fZU8xggNkMIIDYAIBATB2MGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQZcmOY1mHCxqdHznJNo5EjzAJ
BgUrDgMCGgUAoIIBwzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0wNjA5MTExOTAzNDZaMCMGCSqGSIb3DQEJBDEWBBT5C6IOaPH3Im3vLDLIBLQ6iI78yDBS
BgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0D
AgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBhQYJKwYBBAGCNxAEMXgwdjBiMQswCQYD
VQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEGXJjmNZhwsanR85yTaO
RI8wgYcGCyqGSIb3DQEJEAILMXigdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3Rl
IENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0ECEGXJjmNZhwsanR85yTaORI8wDQYJKoZIhvcNAQEBBQAEggEAcIS9
thHo6sjzmERuPFmkCG3+nSBAJhUXkVHHwj5tfUfkJIbox293LcYmKpVWXpt33VwnzyFgehWg
OebIzWIINRint1KI8L24UXFYMbkf+wBYy25xPkcRyWGBRJ7fQ6CXmD0OI2ebZmLsXWV68SB9
uh9CHHJEqW1yp0aYnMofL7niHHeg4XlPAUVV0s5F3s75S+JTuaFHInj+PVVB3/ImwfhvRYks
bsNQcs4+tVwVIlwSAguCRB0EcMeH7QxM3jrguLiZQtCupATM0jESRNjUp5mY1RlkneM6BaSL
7KDSqxitMp7QkWirtx8S1YUUaeCcbXPV7/E3tPPT+zIQaGuiOwAAAAAAAA==
--------------ms040301060804060808080105--
