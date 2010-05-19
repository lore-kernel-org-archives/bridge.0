Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 May 2010 10:15:35 -0700
Message-ID: <F24C979D1AFD4E4292B911441CBA242407FCC8@2putt.int.lantronix.com>
References: <20100518165112.18669700@nehalam>
From: "Umar Qureshey" <umar.qureshey@lantronix.com>
Subject: Re: [Bridge] Hardware requirements for bridging wired+wireless
	together
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@linux-foundation.org]=20
Sent: Tuesday, May 18, 2010 4:51 PM
To: Umar Qureshey
Cc: Nicolas de Peslo=FCan; bridge@lists.linux-foundation.org
Subject: Re: [Bridge] Hardware requirements for bridging wired+wireless =
together

On Tue, 18 May 2010 16:38:54 -0700
"Umar Qureshey" <umar.qureshey@lantronix.com> wrote:

> -----Original Message-----
> From: Nicolas de Peslo=FCan [mailto:nicolas.2p.debian@free.fr]=20
> Sent: Tuesday, May 18, 2010 12:32 PM
> To: Umar Qureshey
> Cc: bridge@lists.linux-foundation.org
> Subject: Re: [Bridge] Hardware requirements for bridging =
wired+wireless together
>=20
> Umar Qureshey wrote:
> > Hi,
> >
> > I have been trolling the 'net as well as the archives of this list =
for
> > quite a while now.
> >
> > I am still unclear on the requirements for getting an Ethernet and
> > Wireless interface to bridge together.
> >
> > Currently, I am working with an esoteric radio that only supports =
Ad-Hoc
> > and Managed modes.  There seemingly is not support for WDS (Wireless
> > Distribution System) on this radio.
> >
> > I have been trying to bridge my eth0 and wlan0 but it doesn't seem =
to
> > work.  Currently, my commands to get the bridge up are:
> >
> > ifconfig eth0 0.0.0.0
> > ifconfig wlan0 0.0.0.0
> > brctl addbr br0
> > brctl addif br0 eth0
> > brctl setfd br0 1           #BusyBox version of brctl doesn't take 0 =
as
> > a time parameter so I change it to 1 (sec)
> > ifconfig br0 up
> > wpa_supplicant -Dwext -iwlan0 -bbr0 -c/root/wpa_supplicant.conf
>=20
> I think you forgot to add wlan0 to the bridge:
>=20
> brctl addif br0 wlan0
>=20

> > >I believe bridging in station mode won't work (usually).
> > >Recent kernels even reject the attempt.

> > >There are exceptions with some devices and if the stack supports =
WDS
> > > (which Linux wireless doesn't yet).

> > >There are some cases like VMware that appear to do MAC level NAT
> > > (ie replace Ethernet address), but the regular kernel doesn't =
support that.

What about bridging in Ad-Hoc mode?  Would that technically work?

I guess what I am trying to figure out is why bridging would work in WDS =
mode?  What is it about that mode that allows bridging to work?

If one were to try to modify the kernel code to allow MAC-level NAT, =
which area of the kernel code would one look at?

=20
**********************************************************************
This e-mail is the property of Lantronix. It is intended only for the =
person or entity to which it is addressed and may contain information =
that is privileged, confidential, or otherwise protected from =
disclosure. Distribution or copying of this e-mail, or the information =
contained herein, to anyone other than the intended recipient is =
prohibited.
