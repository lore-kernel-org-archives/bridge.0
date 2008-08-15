Date: Fri, 15 Aug 2008 15:03:20 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080815150320.0b2e7146@extreme>
In-Reply-To: <48A5EF12.5030902@free.fr>
References: <48A0B4AD.6030703@free.fr> <20080811163159.49cf9980@extreme>
	<48A5E1E3.5060907@free.fr>
	<alpine.DEB.1.10.0808152114540.27001@callisto.moose.malc.org.uk>
	<48A5EF12.5030902@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] frame destinated to individual port MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benoit PAPILLAULT <benoit.papillault@free.fr>
Cc: Bridge@lists.linux-foundation.org

On Fri, 15 Aug 2008 23:03:14 +0200
Benoit PAPILLAULT <benoit.papillault@free.fr> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Malcolm Scott a =C3=A9crit :
> | At 22:06 today, Benoit PAPILLAULT wrote:
> |
> |> I am in a very preliminary phase, trying to learn how to implement
> |> routing and bridging under Linux. In order for the routing protocol to
> |> have proper topology view, it somehow needs to assign a unique IP on a=
ll
> |> interfaces and for bridging and those interfaces needs to be in the sa=
me
> |> bridge.
> |
> | By my understanding (and it's a while since I read that paper so I
> might be
> | wrong) you don't need unique IP addresses on all interfaces;
> everything uses
> | MAC addresses.  To quote section 4.2 of the draft:
> |
> |     o  it runs directly over Layer 2, so therefore may be run with zero
> |        configuration (no IP addresses need to be assigned)
> |
>=20
> Correct since the spec is using IS-IS. However, i'd like to use OSPF
> instead. I'm reading IS-IS and OSPF details to understand whever a
> unique IP is needed per interface. A single IP over the whole would be
> more convenient I must admit.
>=20

Linux has weak-address model so IP per interface is not going
to do what you expect. Use SO_BINDTODEVICE
