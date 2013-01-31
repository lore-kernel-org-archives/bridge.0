Return-Path: <mirqus@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type:content-transfer-encoding;
	bh=ERHHmorLWv1bQCVTOPrA1LegvguJa/kbO1dytJqEDUA=;
	b=SIpQdGXPlYCV4+8hMfx2+uFqda96SUCi3Dmshpicjbz4EoxoCG0dacsaNxq/aC94WY
	MphNoKKlNshvQJvQq9fvYeHWskmesf+SfQRx2VmlEAiZ8Xn03DfuQf6X0imJ3lE2nFIy
	zvnbvzDDGdhYUHzBU7oPq7Oj169mWRDGVJGKKSWxvJ+3KoF++giA9VHaypxxwgk/BqNB
	jcWi8gShia7RirdAlDeTOTkmXWB4234ndR60y6wROhwD/htApdrzMOR6lpGwtrwpsy+y
	VU35GOTJh3kacwx3gszS3WaRmCvmqVEjJiXxZIAYZw6kbTUWlxt0cdzilGCd08yN6YKe
	okOw==
MIME-Version: 1.0
In-Reply-To: <1359601979-14942-2-git-send-email-vyasevic@redhat.com>
References: <1359601979-14942-1-git-send-email-vyasevic@redhat.com>
	<1359601979-14942-2-git-send-email-vyasevic@redhat.com>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Thu, 31 Jan 2013 20:57:01 +0100
Message-ID: <CAHXqBFL88O=cSse5AdhoKMMMrvgvn7oYAhMxt0rw9ffv49Z7hw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH v7 net-next 01/12] bridge: Add vlan filtering
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
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, davem@davemloft.net, shmulik.ladkani@gmail.com

2013/1/31 Vlad Yasevich <vyasevic@redhat.com>:
> Adds an optional infrustructure component to bridge that would allow
> native vlan filtering in the bridge.  Each bridge port (as well
> as the bridge device) now get a VLAN bitmap.  Each bit in the bitmap
> is associated with a vlan id.  This way if the bit corresponding to
> the vid is set in the bitmap that the packet with vid is allowed to
> enter and exit the port.
>
> Write access the bitmap is protected by RTNL and read access
> protected by RCU.
[...]
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
> +               struct net_device *dev =3D vlans_to_port(v)->dev;
> +
> +               if (dev->features & NETIF_F_HW_VLAN_FILTER)
> +                       dev->netdev_ops->ndo_vlan_rx_kill_vid(dev, vid);
> +       }
> +
> +       clear_bit(vid, v->vlan_bitmap);
> +       if (first_bit =3D=3D last_bit) {

if (bitmap_empty(v->vlan_bitmap, BR_VLAN_BITMAP_LEN))

> +               if (v->port_idx) {
> +                       struct net_bridge_port *p =3D vlans_to_port(v);
> +                       rcu_assign_pointer(p->vlan_info, NULL);
> +               } else {
> +                       struct net_bridge *br =3D vlans_to_bridge(v);
> +                       rcu_assign_pointer(br->vlan_info, NULL);
> +               }

You seem to use vlans_to_port/vlans_to_bridge only to get at
vlan_info. Maybe that could be abstracted to a single interface, or
even change v->parent to be a 'net_port_vlans **'?

Best Regards,
Micha=B3 Miros=B3aw
