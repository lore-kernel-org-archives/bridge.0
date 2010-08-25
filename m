Date: Wed, 25 Aug 2010 13:39:59 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100825133959.6b409cd8@nehalam>
In-Reply-To: <4C75724F.2000400@free.fr>
References: <4C752DD9.7040302@tiolive.com>
	<4C75724F.2000400@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Number of addresses limitation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nicolas de =?ISO-8859-1?B?UGVzbG/8YW4=?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org

On Wed, 25 Aug 2010 21:43:11 +0200
Nicolas de Peslo=FCan <nicolas.2p.debian@free.fr> wrote:

> Le 25/08/2010 16:51, Fran=E7ois Schmidts a =E9crit :
> >    Hi,
> >
> > I'm using bridge-utils to add a bunch of tap interfaces to my computer
> > so I can run different qemu vm at the same time without using nat to
> > give them network access. It works fine.
> >
> > But at the same time I would like to add a lot of IPv6s addresses to the
> > bridge interface (br0). I find myself limitated to more or less 56
> > addresses. If I add one more, one of the addresses already existing just
> > disappear from the br0 interface.
> >
> > Is there something I could do to remove or extent this limitation ?
>=20
> Did you try the same IPv6 configuration on a normal ethernet NIC ? Do you=
 think this is a bridge=20
> only related problem ?
>=20

Also what tools are you using? Don't use ifconfig (iputils) for IPv6;
only ip command (iproute2) works correctly with multiple addresses.
--=20
