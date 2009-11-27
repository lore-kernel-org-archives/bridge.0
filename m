Message-Id: <4B0FA4AD020000C70007B9AE@soto.provo.novell.com>
Date: Fri, 27 Nov 2009 10:06:37 -0700
From: "Patrick Mullaney" <pmullaney@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Bridge] [PATCH 1/3] netdevice: provide common routine for
	macvlan	 and vlan operstate management
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

Thanks. I'll post an updated patch.

On Fri, 2009-11-27 at 14:09 +0100, Arnd Bergmann wrote:
> On Friday 13 November 2009, Patrick Mullaney wrote:
> > @@ -551,7 +532,7 @@ static int macvlan_newlink(struct net_device *dev,
> >                 return err;
> > =20
> >         list_add_tail(&vlan->list, &port->vlans);
> > -       macvlan_transfer_operstate(dev);
> > +       netif_stacked_transfer_operstate(dev, lowerdev);
> >         return 0;
> >  }
> > =20
> > @@ -591,7 +572,8 @@ static int macvlan_device_event(struct notifier_blo=
ck *unused,
> >         switch (event) {
> >         case NETDEV_CHANGE:
> >                 list_for_each_entry(vlan, &port->vlans, list)
> > -                       macvlan_transfer_operstate(vlan->dev);
> > +                       netif_stacked_transfer_operstate(vlan->dev,
> > +                                                        vlan->lowerdev=
);
> >                 break;
> >         case NETDEV_FEAT_CHANGE:
> >                 list_for_each_entry(vlan, &port->vlans, list) {
>=20
> These have the arguments reversed, lowerdev should come first.
>=20
> 	Arnd <><

