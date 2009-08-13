From: "Fischer, Anna" <anna.fischer@hp.com>
Date: Thu, 13 Aug 2009 22:24:20 +0000
Message-ID: <0199E0D51A61344794750DC57738F58E6D6B0C7112@GVW1118EXC.americas.hpqcorp.net>
References: <0199E0D51A61344794750DC57738F58E67D2DCECBB@GVW1118EXC.americas.hpqcorp.net>
	<0199E0D51A61344794750DC57738F58E6D6AE99C53@GVW1118EXC.americas.hpqcorp.net>
	<001001ca1a93$b6e50ee0$24af2ca0$@edu>
	<200908121519.36808.arnd@arndb.de>
In-Reply-To: <200908121519.36808.arnd@arndb.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH][RFC] net/bridge: add basic VEPA support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "evb@yahoogroups.com" <evb@yahoogroups.com>, "davem@davemloft.net" <davem@davemloft.net>, 'Eric Biederman' <ebiederm@xmission.com>

> Subject: Re: [PATCH][RFC] net/bridge: add basic VEPA support
>=20
> On Tuesday 11 August 2009, Paul Congdon (UC Davis) wrote:
> > > >
> > > > The patch from Eric Biederman to allow macvlan to bridge between
> > > > its slave ports is at
> > > >
> > > > http://kerneltrap.org/mailarchive/linux-netdev/2009/3/9/5125774
> > >
> > > Looking through the discussions here, it does not seem as if a
> decision
> > > was made to integrate those patches, because they would make the
> > > macvlan interface behave too much like a bridge.
>=20
> Right, that question is still open, and dont't see it as very important
> right now, as long as we can still use it for VEPA.
>=20
> > > Also, it seems as if there was still a problem with doing
> > > multicast/broadcast delivery when enabling local VM-to-VM
> > > communication. Is that solved by now?
>=20
> Not yet, but I guess it comes as a natural extension when I fix
> multicast/broadcast delivery from the reflective relay for VEPA.
>=20
> The logic that I would use there is:
>=20
> broadcast from a dowstream port:
>      if (bridge_mode(source_port)) {
>           forward_to_upstream(frame);
>           for_each_downstream(port) {
>                 /* deliver to all bridge ports except self, do
>                    not deliver to any VEPA port. */
>                 if (bridge_mode(port) && port !=3D source_port) {
>                        forward_to_downstream(frame, port);
>                 }
>           }
>      } else {
>           forward_to_upstream(frame);
>      }
>=20
>=20
> broadcast from the upstream port
>      if (bridge_mode(frame.source)) {
>           /* comes from a port in bridge mode, so has already been
>              delivered to all other bridge ports */
>           for_each_downstream(port) {
>                 if (!bridge_mode(port)) {
>                          forward_to_downstream(frame, port);
>                 }
>           }
>      } else if (vepa_mode(frame.source)) {
>           /* comes from VEPA port, so need to deliver to all
>              bridge and all vepa ports except self */
>           for_each_downstream(port) {
>                 if (port !=3D frame.source)
>                        forward_to_downstream(frame, port);
>      } else {
>           /* external source, so flood to everyone */
>           for_each_downstream(port) {
>                 forward_to_downstream(frame, port);
>      }
>=20
> For multicast, we can do the same, or optionally add a per-port filter
> as you mentioned, if it becomes a bottleneck.
>=20
> Do you think this addresses the problem, or did I miss something
> important?

Yes, I think this addresses the problem. It would be very useful if
this functionality was in macvlan.

Thanks,
Anna
