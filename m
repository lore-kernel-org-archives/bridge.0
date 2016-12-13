Return-Path: <mirq@rere.qmqm.pl>
Date: Tue, 13 Dec 2016 16:11:10 +0100
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Message-ID: <20161213151110.yapgecrospdd23oj@rere.qmqm.pl>
References: <cover.1481586602.git.mirq-linux@rere.qmqm.pl>
	<e6e09a2f745a652382ac7859770ec16c75d8e149.1481586602.git.mirq-linux@rere.qmqm.pl>
	<f5078470-0fc0-cfcd-36df-3ebb380b547a@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f5078470-0fc0-cfcd-36df-3ebb380b547a@cogentembedded.com>
Subject: Re: [Bridge] [PATCH net-next 13/27] bridge: use __vlan_hwaccel
	helpers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, "open list:NETFILTER ({IP, IP6, ARP, EB ,
	NF}TABLES)" <netfilter-devel@vger.kernel.org>, "Jozsef Kadlecsik (supporter:NETFILTER ({IP, IP6, ARP, EB,
	NF}TABLES))" <kadlec@blackhole.kfki.hu>, "Patrick McHardy (supporter:NETFILTER ({IP, IP6, ARP , EB,
	NF}TABLES))" <kaber@trash.net>, "Pablo Neira Ayuso (supporter:NETFILTER ({IP , IP6, ARP, EB,
	NF}TABLES))" <pablo@netfilter.org>

On Tue, Dec 13, 2016 at 03:59:46PM +0300, Sergei Shtylyov wrote:
> Hello!
>=20
> On 12/13/2016 3:12 AM, Micha=B3 Miros=B3aw wrote:
>=20
> > This removes assumption than vlan_tci !=3D 0 when tag is present.
> >=20
> > Signed-off-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
> > ---
> >  net/bridge/br_netfilter_hooks.c | 14 ++++++++------
> >  net/bridge/br_private.h         |  2 +-
> >  net/bridge/br_vlan.c            |  6 +++---
> >  3 files changed, 12 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_=
hooks.c
> > index b12501a..2cc0747 100644
> > --- a/net/bridge/br_netfilter_hooks.c
> > +++ b/net/bridge/br_netfilter_hooks.c
> [...]
> > @@ -749,8 +747,12 @@ static int br_nf_dev_queue_xmit(struct net *net, s=
truct sock *sk, struct sk_buff
> >=20
> >  		data =3D this_cpu_ptr(&brnf_frag_data_storage);
> >=20
> > -		data->vlan_tci =3D skb->vlan_tci;
> > -		data->vlan_proto =3D skb->vlan_proto;
> > +		if (skb_vlan_tag_present(skb)) {
> > +			data->vlan_tci =3D skb->vlan_tci;
> > +			data->vlan_proto =3D skb->vlan_proto;
> > +		} else
> > +			data->vlan_proto =3D 0;
>=20
>    CodingStyle: should use {} in all branches of *if* if at least one bra=
nch
> has {}.
>=20
> [...]
> > diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> > index b6de4f4..ef94664 100644
> > --- a/net/bridge/br_vlan.c
> > +++ b/net/bridge/br_vlan.c
>=20
> > @@ -444,8 +444,8 @@ static bool __allowed_ingress(const struct net_brid=
ge *br,
> >  			__vlan_hwaccel_put_tag(skb, br->vlan_proto, pvid);
> >  		else
> >  			/* Priority-tagged Frame.
> > -			 * At this point, We know that skb->vlan_tci had
> > -			 * VLAN_TAG_PRESENT bit and its VID field was 0x000.
> > +			 * At this point, We know that skb->vlan_tci VID
>=20
>    s/We/we/.
>=20
> > +			 * field was 0x000.
>=20
>    Simply 0, maybe?

Thanks, fixed.
-- Micha=B3=A0Miros=B3aw
