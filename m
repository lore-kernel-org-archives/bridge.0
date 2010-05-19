Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 May 2010 14:01:25 -0700
Message-ID: <F24C979D1AFD4E4292B911441CBA242407FCC9@2putt.int.lantronix.com>
References: <20100518165112.18669700@nehalam>
	<F24C979D1AFD4E4292B911441CBA242407FCC8@2putt.int.lantronix.com>
	<20100519192011.GJ2412@tuxdriver.com>
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
To: "John W. Linville" <linville@tuxdriver.com>
Cc: bridge@lists.linux-foundation.org

> >-----Original Message-----
> >From: John W. Linville [mailto:linville@tuxdriver.com]=20
> >Sent: Wednesday, May 19, 2010 12:20 PM
> >To: Umar Qureshey
> >Cc: Stephen Hemminger; bridge@lists.linux-foundation.org
> >Subject: Re: [Bridge] Hardware requirements for bridging
wired+wireless together
> >
> >On Wed, May 19, 2010 at 10:15:35AM -0700, Umar Qureshey wrote:
> >
> > > What about bridging in Ad-Hoc mode?  Would that technically work?
> >
> >No.
> >=20
> > > I guess what I am trying to figure out is why bridging would work
in WDS mode?  What is it about that mode that allows bridging to work?
> >
> >It has to do with the MAC-layer addressing on wireless LANs.
Wireless
> >frames can use 2, 3, or 4 MAC addresses to identify the transmitter,
> >receiver, sender, and destination.  For most frames and most modes,
> >3 MAC addresses are used.  The FromDS and ToDS bits in the header
> >are used to allow one of the MAC address fields to specify either
> >the transmitter and sender or the destination and receiver.  This is
> >sufficient for non-bridged cases since the wireless station is either
> >an endpoint of the communication or possibly a router (and therefore
> >a Layer-2 endpoint).
> >
> >WDS (or 4 address) mode removes this limitation by using 4 MAC
> >addresses to identify all 4 roles independently.  So, the wireless
> >station is able to forward frames received off the air to the
> >appropriate destination with the correct sender information intact.
> >
> >mac80211-based devices can have interfaces created with support for
> >4 address mode using the iw command.  For this to work, your AP has
> >to be willing to accept and forward those frames appropriately --
> >some do, others don't.  This is only supported for "managed" mode
> >interfaces AFAIK.
> >
> > > If one were to try to modify the kernel code to allow MAC-level
NAT, which area of the kernel code would one look at?
> >
> >netfilter -- I thought there was already some ebtables code to
> >do this...?
> >
> >John
> >--=20
> >John W. Linville		Someday the world will need a hero, and
you
> >linville@tuxdriver.com			might be all we have.
Be ready.

Ok thanks for the explanation about WDS. =20

Stepping back into a Linux box with two interfaces, one Ethernet (eth0)
and one wireless 802.11 (wlan0), and one bridge (br0) that bridges these
two interfaces together:


                           br0
                            |
                 eth0-------+-------wlan0

Can one say that, in this case, the bridge is not working because br0 is
passing to wlan0 Ethernet 802.3 frames which (naturally) the wlan0
interface has no idea how to decode?

=20
**********************************************************************
This e-mail is the property of Lantronix. It is intended only for the =
person or entity to which it is addressed and may contain information =
that is privileged, confidential, or otherwise protected from =
disclosure. Distribution or copying of this e-mail, or the information =
contained herein, to anyone other than the intended recipient is =
prohibited.
