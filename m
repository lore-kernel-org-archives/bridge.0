Return-Path: <mirqus@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type:content-transfer-encoding;
	bh=FiAWlTPWN07RH4AdpisKyKe33Hl+QAYAt/eLGVMuf7c=;
	b=ahwaUu5/gPXi+cez078awHH3lfQgE9zFGfNfkkl07V6oCcmSynifksN4GhG6NaDNR0
	ECW3EwYhkfirC2EqrkMnTG24HWoZGpRvp0o3sOSCrbao1XCJlMWVEGD0nBDtLqPIz58q
	PPGhON8jRsTFb2TEJo2al1bNqZbDMR4kDDhzNEHycpwoFAaxoOaCsl5/vjq/7YLcCjTm
	Mef8cNJn02vxZ11lG/AWt1sFxdyckSJp4N7txMJ2sQQ6JkLr5GfA6Iih13f0Xzmutfq4
	kg+S2RFAOyJvjSb+5FSW4/kCd+tucphyqFpvnkf+62NO77mrNNyrc5C4YqVB5+9j0zCC
	vDBg==
MIME-Version: 1.0
In-Reply-To: <1359748930-31475-2-git-send-email-vyasevic@redhat.com>
References: <1359748930-31475-1-git-send-email-vyasevic@redhat.com>
	<1359748930-31475-2-git-send-email-vyasevic@redhat.com>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Sat, 2 Feb 2013 02:04:09 +0100
Message-ID: <CAHXqBFJfPYwnxbeDR6AfG0-PQJ__=rKMxQWRcFJGseGiXyuYGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH v9 net-next 01/12] bridge: Add vlan filtering
	infrastructure
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, davem@davemloft.net

2013/2/1 Vlad Yasevich <vyasevic@redhat.com>:
> Adds an optional infrustructure component to bridge that would allow
> native vlan filtering in the bridge.  Each bridge port (as well
> as the bridge device) now get a VLAN bitmap.  Each bit in the bitmap
> is associated with a vlan id.  This way if the bit corresponding to
> the vid is set in the bitmap that the packet with vid is allowed to
> enter and exit the port.
[...]
+struct net_port_vlans {
+       u16                             port_idx;
+       void                            *parent;
+       struct rcu_head                 rcu;
+       unsigned long                   vlan_bitmap[BR_VLAN_BITMAP_LEN];
+};
[later, in br_vlan.c]
+#define vlans_to_parent(type, pv) ((type *)(pv)->parent)

A really don't like this pointer casting. It's easy to get it wrong
(and you did in __vlan_del).

1. union { struct net_bridge *br; struct net_bridge_port *port; } parent;

2. inline net_port_vlans __rcu **br_vlan_info_parent_ptr(struct
net_port_vlans *v)
{
	return v->port_idx ? &v->parent.port->vlan_info : &v->parent.br->vlan_info=
;
}

(I'm not insisting on #2. Just think about it. ;)

> @@ -156,6 +166,7 @@ struct net_bridge_port
>  #ifdef CONFIG_NET_POLL_CONTROLLER
>         struct netpoll                  *np;
>  #endif
> +       struct net_port_vlans __rcu     *vlan_info;
>  };

Missing #ifdef CONFIG_BRIDGE_VLAN_FILTERING?

> +static int __vlan_del(struct net_port_vlans *v, u16 vid)
> +{
> +       unsigned long first_bit;
> +       unsigned long last_bit;
> +
> +       if (!test_bit(vid, v->vlan_bitmap))
> +               return -EINVAL;
> +
> +       /* Check to see if any other vlans are in this table.  If this
> +        * is the last vlan, delete the whole structure.  If this is not =
the
> +        * last vlan, just clear the bit.
> +        */
> +       first_bit =3D find_first_bit(v->vlan_bitmap, BR_VLAN_BITMAP_LEN);
> +       last_bit =3D find_last_bit(v->vlan_bitmap, BR_VLAN_BITMAP_LEN);
> +
> +       if (v->port_idx && vid) {
> +               struct net_device *dev =3D
> +                       vlans_to_parent(struct net_bridge, v)->dev;

struct net_bridge_port (or union and v->parent.port)

> +
> +               if (dev->features & NETIF_F_HW_VLAN_FILTER)
> +                       dev->netdev_ops->ndo_vlan_rx_kill_vid(dev, vid);
> +       }
> +
> +       clear_bit(vid, v->vlan_bitmap);
> +       if (first_bit =3D=3D last_bit) {

bitmap_empty() is faster than two times find_xxx_bit().

> +               if (v->port_idx) {
> +                       struct net_bridge_port *p =3D
> +                               vlans_to_parent(struct net_bridge_port, v=
);
> +                       rcu_assign_pointer(p->vlan_info, NULL);
> +               } else {
> +                       struct net_bridge *br =3D
> +                               vlans_to_parent(struct net_bridge, v);
> +                       rcu_assign_pointer(br->vlan_info, NULL);
> +               }

With inline function above:

rcu_assign_pointer(*br_vlan_info_parent_ptr(v), NULL);

> +               kfree_rcu(v, rcu);
> +       }
> +       return 0;
> +}
> +
> +static void __vlan_flush(struct net_port_vlans *v)
> +{
> +       bitmap_zero(v->vlan_bitmap, BR_VLAN_BITMAP_LEN);
> +       if (v->port_idx) {
> +               struct net_bridge_port *p =3D
> +                               vlans_to_parent(struct net_bridge_port, v=
);
> +               rcu_assign_pointer(p->vlan_info, NULL);
> +       } else {
> +               struct net_bridge *br =3D
> +                               vlans_to_parent(struct net_bridge, v);
> +               rcu_assign_pointer(br->vlan_info, NULL);
> +       }

Same here.

> +       kfree_rcu(v, rcu);
> +}

Best Regards,
Micha=C5=82 Miros=C5=82aw
