Date: Wed, 7 May 2008 11:34:26 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080507113426.68f865e9@extreme>
In-Reply-To: <85c88fd30805070546m6b5c22acu62c121fe8e5ed1d2@mail.gmail.com>
References: <85c88fd30805070546m6b5c22acu62c121fe8e5ed1d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] br_send_bpdu and br_log_state PATCH
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?U8OpYmFzdGllbg==?= JEFFROY <sebastien.jeffroy.cxr@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Wed, 7 May 2008 14:46:59 +0200
"S=C3=A9bastien JEFFROY" <sebastien.jeffroy.cxr@gmail.com> wrote:

Please read kernel documentation on formatting and submitting patches:
  Documentation/SubmittingPatches

> Hi all,
> 1) I modified br_send_bpdu() function.
> I use an hardware switch that need to add 4 bytes after the DA/SA MAC
> address. So it's a special header.
> I used p->dev->hard_header() instead of llc_mac_hdr_init() which fills
> default ethernet header (14 bytes : DA+SA+Len/Type)
> My bridge code is based on kernel 2.6.17.8

Patches need to be against current version

> 2) I also added ioctl to device in br_log_state to inform the network dev=
ice
> driver that port state has changed. This is useful if you need to modify
> hardware registers.
> I used this ID for ioctls : *SIOCDEVPRIVATE + 16
> *Maybe it can be a good idea to define a standard ioctl for this ??
>=20

Please use sysfs instead. It avoids creating additional ioctl's. ioctl's
are hard to manage in mixed 32/64 bit environment where 32 bit application
request has to be translated in kernel.


> *Code 1)*
>=20
> static void br_send_bpdu(struct net_bridge_port *p,
>               const unsigned char *data, int length)
> {
>     struct sk_buff *skb;
> *    int extra_header_len =3D p->dev->hard_header_len - ETH_HLEN;
> *
>     if (!p->br->stp_enabled)
>         return;
>=20
>     skb =3D dev_alloc_skb(length+LLC_RESERVE*+extra_header_len*);
>     if (!skb)
>         return;
>=20
> *    // Reserve area for extra header info
>     if (extra_header_len)
>         skb_reserve(skb, extra_header_len);
> *
>     skb->dev =3D p->dev;
>     skb->protocol =3D htons(ETH_P_802_2);
>=20
>     skb_reserve(skb, LLC_RESERVE);
>     memcpy(__skb_put(skb, length), data, length);
>=20
>     llc_pdu_header_init(skb, LLC_PDU_TYPE_U, LLC_SAP_BSPAN,
>                 LLC_SAP_BSPAN, LLC_PDU_CMD);
>     llc_pdu_init_as_ui_cmd(skb);
>=20
> *    // Check pointers and fill header
>     if (p->dev!=3DNULL && p->dev->hard_header!=3DNULL &&
> p->dev->hard_header_len!=3DETH_HLEN)
>     {
>         // LLC_RESERVE can be 3 or 4 bytes !
>         p->dev->hard_header(skb, p->dev, ETH_P_802_3,
>                             p->br->group_addr, p->dev->dev_addr, skb->len=
);
>     }
>     else
> *    {    // deafault ethernet header
>         llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr);
>     }
>=20
>     NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
>         dev_queue_xmit);
> }
>=20
>=20
> *Code 2*
> void br_log_state(const struct net_bridge_port *p)
> {
>     pr_info("%s: port %d(%s) entering %s state\n",
>         p->br->dev->name, p->port_no, p->dev->name,
>         br_port_state_names[p->state]);
>=20
> *    p->dev->do_ioctl(    p->dev,     // network device
>                         (struct ifreq*)p,    // data (struct net_bridge)
>                         SIOCDEVPRIVATE + 16);    // command ID
> *}
