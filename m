Message-ID: <4D754490.4000105@gmail.com>
Date: Mon, 07 Mar 2011 21:48:16 +0100
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?=
 <nicolas.2p.debian@gmail.com>
MIME-Version: 1.0
References: <1649722795.14144.1299480074110.JavaMail.root@tahiti.vyatta.com>
	<4D748CC3.8060603@gmail.com> <20110307103406.27330529@nehalam>
In-Reply-To: <20110307103406.27330529@nehalam>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] bridge: control carrier based on ports online
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Jay Vosburgh <fubar@us.ibm.com>, "Pekka Savola (ipv6)" <pekkas@netcore.fi>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S. Miller" <davem@davemloft.net>, Adam Majer <adamm@zombino.com>

Le 07/03/2011 19:34, Stephen Hemminger a =E9crit :
> This makes the bridge device behave like a physical device.
> In earlier releases the bridge always asserted carrier. This
> changes the behavior so that bridge device carrier is on only
> if one or more ports are in the forwarding state. This
> should help IPv6 autoconfiguration, DHCP, and routing daemons.
>
> I did brief testing with Network and Virt manager and they
> seem fine, but since this changes behavior of bridge, it should
> wait until net-next (2.6.39).
>
> Signed-off-by: Stephen Hemminger<shemminger@vyatta.com>
>
> ---
>   net/bridge/br_device.c    |    4 ++++
>   net/bridge/br_stp.c       |   35 ++++++++++++++++++++++-------------
>   net/bridge/br_stp_timer.c |    1 +
>   3 files changed, 27 insertions(+), 13 deletions(-)
>
> --- a/net/bridge/br_device.c	2011-03-07 08:40:08.913599513 -0800
> +++ b/net/bridge/br_device.c	2011-03-07 08:40:48.382377389 -0800
> @@ -78,6 +78,8 @@ static int br_dev_open(struct net_device
>   {
>   	struct net_bridge *br =3D netdev_priv(dev);
>
> +	netif_carrier_off(dev);
> +
>   	br_features_recompute(br);
>   	netif_start_queue(dev);
>   	br_stp_enable_bridge(br);
> @@ -94,6 +96,8 @@ static int br_dev_stop(struct net_device
>   {
>   	struct net_bridge *br =3D netdev_priv(dev);
>
> +	netif_carrier_off(dev);
> +
>   	br_stp_disable_bridge(br);
>   	br_multicast_stop(br);
>
> --- a/net/bridge/br_stp.c	2011-03-07 08:41:58.619783678 -0800
> +++ b/net/bridge/br_stp.c	2011-03-07 08:53:58.953558810 -0800
> @@ -397,28 +397,37 @@ static void br_make_forwarding(struct ne
>   void br_port_state_selection(struct net_bridge *br)
>   {
>   	struct net_bridge_port *p;
> +	unsigned int liveports =3D 0;
>
>   	/* Don't change port states if userspace is handling STP */
>   	if (br->stp_enabled =3D=3D BR_USER_STP)
>   		return;
>
>   	list_for_each_entry(p,&br->port_list, list) {
> -		if (p->state !=3D BR_STATE_DISABLED) {
> -			if (p->port_no =3D=3D br->root_port) {
> -				p->config_pending =3D 0;
> -				p->topology_change_ack =3D 0;
> -				br_make_forwarding(p);
> -			} else if (br_is_designated_port(p)) {
> -				del_timer(&p->message_age_timer);
> -				br_make_forwarding(p);
> -			} else {
> -				p->config_pending =3D 0;
> -				p->topology_change_ack =3D 0;
> -				br_make_blocking(p);
> -			}
> +		if (p->state =3D=3D BR_STATE_DISABLED)
> +			continue;
> +
> +		if (p->port_no =3D=3D br->root_port) {
> +			p->config_pending =3D 0;
> +			p->topology_change_ack =3D 0;
> +			br_make_forwarding(p);
> +		} else if (br_is_designated_port(p)) {
> +			del_timer(&p->message_age_timer);
> +			br_make_forwarding(p);
> +		} else {
> +			p->config_pending =3D 0;
> +			p->topology_change_ack =3D 0;
> +			br_make_blocking(p);

Is the above part really related to the purpose of this patch? It looks lik=
e (good) cleanup, but=20
should be in a different patch.

Except from this comment,

Reviewed-by: Nicolas de Peslo=FCan <nicolas.2p.debian@free.fr>

>   		}
>
> +		if (p->state =3D=3D BR_STATE_FORWARDING)
> +			++liveports;
>   	}
> +
> +	if (liveports =3D=3D 0)
> +		netif_carrier_off(br->dev);
> +	else
> +		netif_carrier_on(br->dev);
>   }
>
>   /* called under bridge lock */
> --- a/net/bridge/br_stp_timer.c	2011-03-07 08:53:25.728770710 -0800
> +++ b/net/bridge/br_stp_timer.c	2011-03-07 08:53:40.273116636 -0800
> @@ -94,6 +94,7 @@ static void br_forward_delay_timer_expir
>   		p->state =3D BR_STATE_FORWARDING;
>   		if (br_is_designated_for_some_port(br))
>   			br_topology_change_detection(br);
> +		netif_carrier_on(br->dev);
>   	}
>   	br_log_state(p);
>   	spin_unlock(&br->lock);
>

