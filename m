Return-Path: <cwang@twopensource.com>
MIME-Version: 1.0
In-Reply-To: <1432256161-4425-1-git-send-email-linus.luessing@c0d3.blue>
References: <1432256161-4425-1-git-send-email-linus.luessing@c0d3.blue>
Date: Thu, 21 May 2015 20:11:32 -0700
Message-ID: <CAHA+R7M+F88KsAJy-fGkSjUXxgBNifdML0E3r8jrQqXafZMUpA@mail.gmail.com>
From: Cong Wang <cwang@twopensource.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next] bridge: allow setting hash_max +
 multicast_router if interface is down
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

On Thu, May 21, 2015 at 5:56 PM, Linus L=C3=BCssing <linus.luessing@c0d3.bl=
ue> wrote:
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 2d69d5c..066199e 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1775,8 +1775,6 @@ int br_multicast_set_router(struct net_bridge *br, =
unsigned long val)
>         int err =3D -ENOENT;
>

Nit: err can be initialized to -EINVAL now.

>         spin_lock_bh(&br->multicast_lock);
> -       if (!netif_running(br->dev))
> -               goto unlock;
>
>         switch (val) {
>         case 0:
> @@ -1793,7 +1791,6 @@ int br_multicast_set_router(struct net_bridge *br, =
unsigned long val)
>                 break;
>         }
>
> -unlock:
>         spin_unlock_bh(&br->multicast_lock);
>
>         return err;
> @@ -1802,18 +1799,15 @@ unlock:
>  int br_multicast_set_port_router(struct net_bridge_port *p, unsigned lon=
g val)
>  {
>         struct net_bridge *br =3D p->br;
> -       int err =3D -ENOENT;
> +       int err =3D 0;
>
>         spin_lock(&br->multicast_lock);


Not related with your patch, but why we don't need to disable bh here?

For me it looks like we do use p->rlist in BH context, but I could easily
miss something here.

> -       if (!netif_running(br->dev) || p->state =3D=3D BR_STATE_DISABLED)
> -               goto unlock;
>
>         switch (val) {
>         case 0:
>         case 1:
>         case 2:
>                 p->multicast_router =3D val;
> -               err =3D 0;
>
>                 if (val < 2 && !hlist_unhashed(&p->rlist))
>                         hlist_del_init_rcu(&p->rlist);
> @@ -1834,7 +1828,6 @@ int br_multicast_set_port_router(struct net_bridge_=
port *p, unsigned long val)
>                 break;
>         }
>
> -unlock:
>         spin_unlock(&br->multicast_lock);
>
>         return err;


Thanks!
