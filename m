Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yRKnsqksDCSbn1gQAG/Im68So9MbU1So6FBxhsZpd8=;
 b=RDdkA5Dbc6E4WgN9K/9ty52KMpqODUrnet7H7nDXLqdQDRu7a0pNxF3SilOug3qOERDmr0/lXytlk8Lcw+zOARvC08Yh7gx123rXvhy0N1sRsgjyGXynD+IPzsoVt/fox29PYL7dtJFkRf/sPKQ4lfNCrYWwI8n1CJhermPWiHc=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 6 May 2022 14:36:45 +0000
Message-ID: <20220506143644.mzfffht44t3glwci@skbuf>
References: <20220505225904.342388-1-andrew@lunn.ch>
In-Reply-To: <20220505225904.342388-1-andrew@lunn.ch>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECEC713428F14E41B651B9D65089A9B9@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH RFC] net: bridge: Clear offload_fwd_mark when
 passing frame up bridge interface.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ido Schimmel <idosch@mellanox.com>, netdev <netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

Hi Andrew,

On Fri, May 06, 2022 at 12:59:04AM +0200, Andrew Lunn wrote:
> It is possible to stack bridges on top of each other. Consider the
> following which makes use of an Ethernet switch:
>=20
>        br1
>      /    \
>     /      \
>    /        \
>  br0.11    wlan0
>    |
>    br0
>  /  |  \
> p1  p2  p3
>=20
> br0 is offloaded to the switch. Above br0 is a vlan interface, for
> vlan 11. This vlan interface is then a slave of br1. br1 also has
> wireless interface as a slave. This setup trunks wireless lan traffic
> over the copper network inside a VLAN.
>=20
> A frame received on p1 which is passed up to the bridge has the
> skb->offload_fwd_mark flag set to true, indicating it that the switch
> has dealt with forwarding the frame out ports p2 and p3 as
> needed. This flag instructs the software bridge it does not need to
> pass the frame back down again. However, the flag is not getting reset
> when the frame is passed upwards. As a result br1 sees the flag,
> wrongly interprets it, and fails to forward the frame to wlan0.
>=20
> When passing a frame upwards, clear the flag.
>=20
> RFC because i don't know the bridge code well enough if this is the
> correct place to do this, and if there are any side effects, could the
> skb be a clone, etc.

Each skb has its own offload_fwd_mark, so clearing it for this skb does
not affect a clone. And when a packet is simultaneously forwarded and
locally received, the order is first forward/flood it, then receive it.
Cloning takes place during forwarding using deliver_clone(), so it
shouldn't be the case that you are clearing the offload_fwd_mark for a
yet-to-be-forwarded packet, either. So I think we're good there.

>=20
> Fixes: f1c2eddf4cb6 ("bridge: switchdev: Use an helper to clear forward m=
ark")
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  net/bridge/br_input.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 196417859c4a..9327a5fad1df 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -39,6 +39,13 @@ static int br_pass_frame_up(struct sk_buff *skb)
>  	dev_sw_netstats_rx_add(brdev, skb->len);
> =20
>  	vg =3D br_vlan_group_rcu(br);
> +
> +	/* Reset the offload_fwd_mark because there could be a stacked
> +	 * bridge above, and it should not think this bridge it doing
> +	 * that bridges work forward out its ports.

"this bridge is doing that bridge's work forwarding out its ports"

> +	 */
> +	br_switchdev_frame_unmark(skb);
> +
>  	/* Bridge is just like any other port.  Make sure the
>  	 * packet is allowed except in promisc mode when someone
>  	 * may be running packet capture.
> --=20
> 2.36.0
>

The good thing with this patch is that it avoids conditionals.
The bad thing is that it prevents true offloading of this configuration
from being possible (when "wlan0" is "p4").

I don't know what hardware is capable of doing this, but I think it's
cautious to not exclude it, either.

Some safer alternatives to this patch are based on the idea that we
could ignore skb->offload_fwd_mark coming from an unoffloaded bridge
port (i.e. treat this condition at br1, not at br0). We could:
- clear skb->offload_fwd_mark in br_handle_frame_finish(), if p->hwdom is 0
- change nbp_switchdev_allowed_egress() to return true if cb->src_hwdom =3D=
=3D 0=
