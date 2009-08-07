Date: Fri, 7 Aug 2009 14:36:52 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090807143652.1659ac57@nehalam>
In-Reply-To: <000001ca17a3$03f841f0$0be8c5d0$@edu>
References: <D2E118A1E7268F449C469EA2F301D92902BC39B2@exil.voltaire.com>
	<000001ca17a3$03f841f0$0be8c5d0$@edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [evb] RE: [PATCH][RFC] net/bridge: add basic VEPA
	support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>
Cc: arnd@arndb.de, anna.fischer@hp.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, adobriyan@gmail.com, virtualization@lists.linux-foundation.org

On Fri, 7 Aug 2009 14:06:58 -0700
"Paul Congdon \(UC Davis\)" <ptcongdon@ucdavis.edu> wrote:

> Yaron,
>=20
>=20
> The interface multiplexing can be achieved using macvlan driver or using =
an SR-IOV capable NIC (the preferred option), macvlan may need to be extend=
ed to support VEPA multicast handling, this looks like a rather simple task=
=20
>=20
> Agreed that the hardware solution is preferred so the macvlan implementat=
ion doesn=E2=80=99t really matter.  If we are talking SR-IOV, then it is di=
rect mapped, regardless of whether there is a VEB or VEPA in the hardware b=
elow, so you are bypassing the bridge software code also. =20
>=20
> I disagree that adding the multicast handling is simple =E2=80=93 while n=
ot conceptually hard, it will basically require you to put an address table=
 into the macvlan implementation =E2=80=93 if you have that, then why not h=
ave just used the one already in the bridge code.  If you hook a VEPA up to=
 a non-hairpin mode external bridge, you get the macvlan capability as well.

I have a patch that forwards all multicast packets, and another that does
proper forwarding. It should have worked that way in original macvlan, the
current behavior is really a bug.


--=20
