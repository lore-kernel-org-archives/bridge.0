MIME-Version: 1.0
In-Reply-To: <1258497551-25959-2-git-send-email-arnd@arndb.de>
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<1258497551-25959-2-git-send-email-arnd@arndb.de>
Date: Wed, 18 Nov 2009 11:00:57 +0100
Message-ID: <25e057c00911180200w6d732e29q3aba5f1b9d005cbd@mail.gmail.com>
From: roel kluin <roel.kluin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 1/3] macvlan: Reflect macvlan packets meant for
	other macvlan devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@linux-foundation.com, Herbert Xu <herbert@gondor.apana.org.au>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>

On Tue, Nov 17, 2009 at 11:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> From: Eric Biederman <ebiederm@xmission.com>
>
> Switch ports do not send packets back out the same port they came
> in on. =A0This causes problems when using a macvlan device inside
> of a network namespace as it becomes impossible to talk to
> other macvlan devices.
>
> Signed-off-by: Eric Biederman <ebiederm@xmission.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I found a problem:

> @@ -140,20 +145,45 @@ static void macvlan_broadcast(struct sk_buff *skb,
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static int macvlan_unicast(struct sk_buff *skb, const struct macvlan_dev=
 *dest)
> +{
> + =A0 =A0 =A0 struct net_device *dev =3D dest->dev;
> +
> + =A0 =A0 =A0 if (unlikely(!dev->flags & IFF_UP)) {

parentheses are missing:

if (unlikely(!(dev->flags & IFF_UP))) {

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree_skb(skb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NET_XMIT_DROP;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 skb =3D skb_share_check(skb, GFP_ATOMIC);
> + =A0 =A0 =A0 if (!skb) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->stats.rx_errors++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->stats.rx_dropped++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NET_XMIT_DROP;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev->stats.rx_bytes +=3D skb->len + ETH_HLEN;
> + =A0 =A0 =A0 dev->stats.rx_packets++;
> +
> + =A0 =A0 =A0 skb->dev =3D dev;
> + =A0 =A0 =A0 skb->pkt_type =3D PACKET_HOST;
> + =A0 =A0 =A0 netif_rx(skb);
> + =A0 =A0 =A0 return NET_XMIT_SUCCESS;
> +}
