Date: Tue, 2 Mar 2010 09:22:09 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20100302092209.048f5682@nehalam>
In-Reply-To: <1267509690.2843.5.camel@edumazet-laptop>
References: <20100301161658.5a61143b@nehalam>
	<1267509690.2843.5.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH]  bridge: per-cpu packet statistics
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

On Tue, 02 Mar 2010 07:01:30 +0100
Eric Dumazet <eric.dumazet@gmail.com> wrote:

> Le lundi 01 mars 2010 =C3=A0 16:16 -0800, Stephen Hemminger a =C3=A9crit :
> > The shared packet statistics are a potential source of slow down
> > on bridged traffic. Convert to per-cpu array, but only keep those
> > statistics which change per-packet.
> >=20
> > Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> >=20
> > ---
> >=20
> >  net/bridge/br_device.c  |   43 ++++++++++++++++++++++++++++++++++++++-=
----
> >  net/bridge/br_if.c      |    6 ++++++
> >  net/bridge/br_input.c   |    5 +++--
> >  net/bridge/br_private.h |    8 ++++++++
> >  4 files changed, 55 insertions(+), 7 deletions(-)
> >=20
> > --- a/net/bridge/br_device.c	2010-03-01 08:22:23.476657998 -0800
> > +++ b/net/bridge/br_device.c	2010-03-01 15:31:36.737227465 -0800
> > @@ -26,11 +26,12 @@ netdev_tx_t br_dev_xmit(struct sk_buff *
> >  	const unsigned char *dest =3D skb->data;
> >  	struct net_bridge_fdb_entry *dst;
> >  	struct net_bridge_mdb_entry *mdst;
> > +	struct br_cpu_netstats *brstats =3D this_cpu_ptr(br->stats);
> > =20
> > -	BR_INPUT_SKB_CB(skb)->brdev =3D dev;
> > +	brstats->tx_packets++;
> > +	brstats->tx_bytes +=3D skb->len;
>=20
>=20
> On TX path, this is not really necessary, since we already dirtied
> txq->lock before calling br_dev_xmit(), we can use txq->tx_packets and
> txq->tx_bytes for free ?

Bridge is already using lockless transmit LLTX, so tx_lock is not touched.
