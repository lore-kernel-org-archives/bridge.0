Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Date: Sat, 8 Jul 2006 09:10:21 -0700
Message-ID: <57F9959B46E0FA4D8BA88AEDFBE582901678EB@pxtbenexd01.pxt.primeexalia.com>
In-Reply-To: <1152357913.5738.12.camel@medion.barbatre.net>
From: "Gary W. Smith" <gary@primeexalia.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] bridge+filter+failover+rules&state sync+traffic	shaping
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Tristan DEFERT <tristan.d@alphamosa.fr>
Cc: bridge@lists.osdl.org

Tristan,=20

I believe there have been a few threads in the netfilter list talking about=
 connection synching between cluster nodes.  I believe they have some scrip=
ts for this in the contrib directory on the distribution files.

We currently run a Linux-HA clustered bridge and it works great.  We aren't=
 synching the connections at this time though. =20

Hope that helps,=20

Gary=20

> -----Original Message-----
> From: bridge-bounces@lists.osdl.org [mailto:bridge-bounces@lists.osdl.org]
> On Behalf Of Tristan DEFERT
> Sent: Saturday, July 08, 2006 4:25 AM
> Cc: bridge@lists.osdl.org
> Subject: Re: [Bridge] bridge+filter+failover+rules&state sync+traffic
> shaping
>=20
> I suggest that anyone interested in building a failover filtering bridge
> with rules and connection state synching / QoS+TC to join me about
> building this project: if we are enough with good skills we can do great
> job.
>=20
> What we have:
> * STP protocol is already implemented
> * Traffic shaping and QoS with iptables + cbq (or another traffic
> shaper) should be fine in this context (needs to be tested)
>=20
> What we need:
> * an elegant way of synching rules and conntrack
> * testers and volunteers !
> * documentation
>=20
> What should be nice:
> * load balancing
>=20
> Any idea or contributor welcome!
>=20
> Feel free to contact me, and list me your resources & skills !
>=20
> Le vendredi 07 juillet 2006 =E0 16:36 -0400, Shankar_Natarajan@emc.com a
> =E9crit :
> >
> > > -----Original Message-----
> > > From: bridge-bounces@lists.osdl.org
> > [mailto:bridge-bounces@lists.osdl.org]
> > > On Behalf Of Stephen Hemminger
> > > Sent: Friday, July 07, 2006 11:46 AM
> > > To: Tristan DEFERT
> > > Cc: bridge@lists.osdl.org
> > > Subject: Re: [Bridge] bridge+filter+failover+rules&state sync+traffic
> > > shaping
> > >
> > > On Tue, 27 Jun 2006 16:11:01 +0200
> > > Tristan DEFERT <tristan.d@alphamosa.fr> wrote:
> > >
> > > > hi list!
> > > > i'm trying to find a convenient way to build a redundant filtering
> > > > bridge under linux
> > > >
> > > > i looked at carp project, but carp doesn't support bridge
> > > >
> > > > now i thing the most appropriate way is using stp or rstp
> > > > it seems that 2.6 kernel supports stp but what about rstp?
> > >
> > > The 2.6.18 kernel has hooks to allow building STP protocols in user
> > land.
> > > There is a student working on RSTP as a Google Summer of Code project.
> >
> > Is there a customary wary of posting/watching status/progress on this
> > RSTP work? How is the work progressing? Any dates that can be shared?
> >
> > I'd like to volunteer my team to be an early consumer and test the
> > implementation when it is ready. Possible?
> >
> > Thanks,
> > Shankar
> >
> >
> > > _______________________________________________
> > > Bridge mailing list
> > > Bridge@lists.osdl.org
> > > https://lists.osdl.org/mailman/listinfo/bridge
> >
> > _______________________________________________
> > Bridge mailing list
> > Bridge@lists.osdl.org
> > https://lists.osdl.org/mailman/listinfo/bridge
>=20
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge

