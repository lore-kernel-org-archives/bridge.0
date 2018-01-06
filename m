Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=W4faYY0M01U4ESfD57KMLJ7ffDNzKcm/UAsSHBt08pA=;
	b=0sjvMzBzuwpSWM+h/eZK457VwinrWElnNeUFGGhYyQ+RWa/qNBZ0kPdvG8RMWhAXgv
	mK6N0LuCHDSoRBri6Gfz7xnvZwvE9gaNT8xDNxurJK06fTo1CCsmxn3y0r5NFf0ziJcm
	7OpQN6Vg0xvasmM25+c3lxje5xeeLIgTMQf978ozNKIWSk7zmQIHso+la/33rhqBuZuE
	Sl8xDLblhcNUMI/KQB2mhkjmPNNmKo9zhti7g+vpQvIzDbYpsnyKLp8n6cVqHRz6JU7b
	9pgeub9lx6S9U2xLTjgKhJgvuo+7IKRkHm527t3TcyInosmtUfEkuVZ2gbEEd/gUO8Gu
	EPog==
Date: Sat, 6 Jan 2018 06:33:37 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180106063337.33e2a3fa@xeon-e3>
In-Reply-To: <CAOtoAkc_prks5PcRtwqh2Agp0TTT2jY4jpQzOoi_CgiSPjST-w@mail.gmail.com>
References: <CAOtoAkc_prks5PcRtwqh2Agp0TTT2jY4jpQzOoi_CgiSPjST-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 3.2 01/06] "bridge should send gratuitous ARP
 to notify peer while a bond, which is a port of this bridge, changes."
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?6YKi5bqG5p2w?= <xqjcool@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, linux-kernel@vger.kernel.org

On Sat, 6 Jan 2018 17:25:20 +0800
=E9=82=A2=E5=BA=86=E6=9D=B0 <xqjcool@gmail.com> wrote:

> We create bond0 and add eth0&eth1 as slaves. Eth0 is active. Then we add
> bond0
> into br0 as a bridge port. Br0 has ip address. When eth0 is down, after
> bond0's
> failover eth1 become active. At this moment, we need br0 send a gratuitous
> ARP
> to notify peer to update ARP table.
>=20
> Signed-off-by: Xing.Qingjie <xqjcool@gmail.com>
> ---
>  net/bridge/br_notify.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> diff --git a/net/bridge/br_notify.c b/net/bridge/br_notify.c
> index a76b621..90cf123 100644
> --- a/net/bridge/br_notify.c
> +++ b/net/bridge/br_notify.c
> @@ -34,6 +34,7 @@ static int br_device_event(struct notifier_block *unuse=
d,
> unsigned long event, v
>         struct net_device *dev =3D ptr;
>         struct net_bridge_port *p;
>         struct net_bridge *br;
> +       struct in_device *in_dev;
>         bool changed_addr;
>         int err;
> @@ -102,6 +103,17 @@ static int br_device_event(struct notifier_block
> *unused, unsigned long event, v
>         case NETDEV_PRE_TYPE_CHANGE:
>                 /* Forbid underlaying device to change its type. */
>                 return NOTIFY_BAD;
> +
> +       case NETDEV_NOTIFY_PEERS:
> +               /* Send gratuitous arp while bond,a port of bridge, chang=
es
> */
> +               if (dev->priv_flags & IFF_BONDING && dev->flags &
> IFF_MASTER) {
> +                       in_dev =3D __in_dev_get_rtnl(br->dev);
> +
> +                       ASSERT_RTNL();
> +                       if (in_dev)
> +                               inetdev_send_gratuitous_arp(br->dev,
> in_dev);
> +               }
> +               break;
>         }
>         /* Events that may cause spanning tree to refresh */
> --
> 1.7.1

Thanks for your patch.

There is no reason a bridge has to have an IP address.
This should be done in bonding device, doing it here is error prone.
Plus there are many more layered devices than bonding.

The patch also has many formatting issues.
Your mail client mangles patches.
Conditional expressions with & and && should have parenthesis.


