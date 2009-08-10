From: "Fischer, Anna" <anna.fischer@hp.com>
Date: Mon, 10 Aug 2009 15:59:04 +0000
Message-ID: <0199E0D51A61344794750DC57738F58E6D6AE99867@GVW1118EXC.americas.hpqcorp.net>
References: <0199E0D51A61344794750DC57738F58E67D2DCECBB@GVW1118EXC.americas.hpqcorp.net>
	<200908071329.44437.arnd@arndb.de>
	<005101ca1797$70dcf5b0$5296e110$@edu>
	<200908101723.10832.arnd@arndb.de>
In-Reply-To: <200908101723.10832.arnd@arndb.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [evb] Re: [PATCH][RFC] net/bridge: add basic VEPA
	support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, "Fischer,
	Anna" <anna.fischer@hp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 'Or Gerlitz' <ogerlitz@voltaire.com>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "evb@yahoogroups.com" <evb@yahoogroups.com>, "davem@davemloft.net" <davem@davemloft.net>

> Subject: Re: [PATCH][RFC] net/bridge: add basic VEPA support
>=20
> On Friday 07 August 2009, Paul Congdon (UC Davis) wrote:
> >
> > I don't think your scheme works too well because broadcast packet
> coming
> > from other interfaces on br0 would get replicated and sent across the
> wire
> > to ethB multiple times.
>=20
> Right, that won't work. So the bridge patch for the hairpin turn
> is still the best solution.=20

Yes, I think that we should separate the discussions between hairpin=20
mode on the adjacent bridge and the VEPA filtering service residing
within the end-station. The hairpin feature really has to be
implemented in the bridging code.


> Btw, how will that interact with
> the bride-netfilter (ebtables) setup? Can you apply any filters
> that work on current bridges also between two VEPA ports while
> doing the hairpin turn?

The hairpin mode is implemented on the adjacent bridge. The only=20
difference for a hairpin mode port vs. a normal bridge port is that
it can pass frames back out to the same port it came from. All the
netfilter hooks are still in place.

On the VEPA filtering service side, the only change we have implemented
in the bridging code is that in VEPA mode all frames are passed to the
uplink on TX. However, frames are still passed through the netfilter=20
hooks before they go out on the wire. On the inbound path, there are
no changes to the way frames are processed (except the filtering for
the original source port), so netfilter hooks work in the same way
as for a normal bridge.

If a frame is reflected back because of a hairpin turn, then of course
the incoming port is the VEPA uplink port and not the port that
originally sent the frame. So if you are trying to enforce some
packet filtering on that inbound path, then you would have to do that
based on MAC addresses and not on bridge ports. But I would assume that
you would enforce the filtering already before you send out the frame
to the adjacent bridge. Apart from that, if you enable your bridge to
behave in VEPA mode, then you would typically do packet filtering etc
on the adjacent bridge and not use the netfilter hook. You can still use
both though, if you like.

Anna
