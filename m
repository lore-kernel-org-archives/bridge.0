Return-Path: <stephen@networkplumber.org>
Date: Fri, 31 Jul 2015 09:30:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20150731093007.290703fe@urahara>
In-Reply-To: <CAJkjprPDtCvofL13CxBwhB=+kjKDP21BZpb40ycaipFcQWN+vw@mail.gmail.com>
References: <CAJkjprMLMZXqPuAEX3Hi46Wsu1QxUuPjK-mK_M9CHPsUFvv3nA@mail.gmail.com>
	<20150731135728.GG6366@odroid>
	<CAJkjprPDtCvofL13CxBwhB=+kjKDP21BZpb40ycaipFcQWN+vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Multicast packets are not bridged from ethernet to
 wireless interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: saurav barik <saurav.barik@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 31 Jul 2015 19:56:12 +0530
saurav barik <saurav.barik@gmail.com> wrote:

> Thanks Linus.
> Sorry, it will not be possible to move to recent kernel.
>=20
> How does the mdb gets updated for multicast addresses? Is it learnt on
> basis of packets received from the network? For example, the multicast
> address I use for iperf is 234.100.100.100. I mentioned two scenarios in =
my
> earlier email. In case of eth0 being the active port on the mbr (multicast
> working scenario), I see br_multicast_new_group() and
> br_multicast_add_group() being called for this IP address moments after m=
br
> is up. However in case of wlan0 as the uplink port of mbr, I don't see
> those functions being called.
>=20
> I guess for unicast packets, if the entry is not present in fdb, the pack=
et
> is flooded on all other ports and its learnt and added to fdb based on the
> port on which response packet arrives. Is it true for Multicast packets t=
oo?
>=20
> Regards,
> Saurav
>=20
> On Fri, Jul 31, 2015 at 7:27 PM, Linus L=C3=BCssing <linus.luessing@c0d3.=
blue>
> wrote:
>=20
> > Hi Saurav,
> >
> > On Fri, Jul 31, 2015 at 03:50:35PM +0530, saurav barik wrote:
> > > I am working on an Access Point device (AP1) running linux kernel 3.0=
.34
> > on
> > > which my bridge configuration is as follows.
> >
> > There were quite some crucial bugs, I'm not quite sure whether
> > 3.0.34 was actually usuable for multicast snooping.
> >
> > Any chance to try a recent kernel?
> >
> > Cheers, Linus
> >

Multicast forwarding table is built off IGMP messages
When application joins a multicast group an IGMP is sent, and bridge
snoops for that.
