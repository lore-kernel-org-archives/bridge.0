Message-Id: <4B17C107020000C70007C8CE@soto.provo.novell.com>
Date: Thu, 03 Dec 2009 13:45:43 -0700
From: "Patrick Mullaney" <pmullaney@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Bridge] [PATCH 3/3] macvlan: allow in-kernel modules to create
	and	 manage macvlan devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, alacrityvm-devel@lists.sourceforge.net


I hope I didn't confuse things by posting:

netdevice: provide common routine for macvlan and vlan operstate
management

again. I offered to send that out patched against net-next-2.6 last
week and I just got back to following up. I'm fine with you rolling
them into your series too.

Thanks.

On Fri, 2009-11-27 at 23:19 +0100, Arnd Bergmann wrote:
> On Friday 13 November 2009, Patrick Mullaney wrote:
> > @@ -318,7 +318,7 @@ static struct lock_class_key macvlan_netdev_addr_lo=
ck_key;
> >  #define MACVLAN_FEATURES \
> >         (NETIF_F_SG | NETIF_F_ALL_CSUM | NETIF_F_HIGHDMA | NETIF_F_FRAG=
LIST | \
> >          NETIF_F_GSO | NETIF_F_TSO | NETIF_F_UFO | NETIF_F_GSO_ROBUST =
| \
> > -        NETIF_F_TSO_ECN | NETIF_F_TSO6)
> > +        NETIF_F_TSO_ECN | NETIF_F_TSO6 | NETIF_F_GRO)
> > =20
> >  #define MACVLAN_STATE_MASK \
> >         ((1<<__LINK_STATE_NOCARRIER) | (1<<__LINK_STATE_DORMANT))
>=20
> This hunk looks like it should be a separate patch, because we will
> want to have this independently of the rest. I have taken it into
> a series I'm preparing for a new posting of macvtap based on the
> current net-next tree with my bridge mode changes. I also have
> your patch 1 (the fixed version) and 2 in there. It's currently
> work in progress, but if you are interested, take a look at [1].
>=20
> 	Arnd <><
>=20
> [1] http://git.kernel.org/?p=3Dlinux/kernel/git/arnd/playground.git;a=3Ds=
hortlog;h=3Drefs/heads/macvlan

