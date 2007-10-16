Date: Tue, 16 Oct 2007 19:11:05 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [Bridge] [PATCH 2.6.23.1] Kill STP hello timer if STP is not
	enabled
Message-ID: <20071016171105.GA6649@rere.qmqm.pl>
References: <20071015214812.GA789@rere.qmqm.pl>
	<20071016094003.45593fa6@freepuppy.rosehill>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20071016094003.45593fa6@freepuppy.rosehill>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On Tue, Oct 16, 2007 at 09:40:03AM -0700, Stephen Hemminger wrote:
> On Mon, 15 Oct 2007 23:48:12 +0200
> Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl> wrote:
> > Quick CPU eater kill. This might be not the best fix possible.
> > Without this patch, hello_timer is firing 250 times/sec and eating about
> > 8% CPU time on my an otherwise idle system (dynticks enabled). 2.6.21.5=
 was
> > even worse - 20% (HZ=3D1000). (br->hello_time was supposedly 0 when STP=
 was
> > disabled).
> Good idea, but patch needs work.
>=20
> The default hello_time is 2 seconds, so if it is going up to 250/sec then
> maybe other root bridge is updating it. =20
> I don't see where hello_time gets set to 0 if STP disabled?

Huh! I now checked my config and it turned out, that I set hello_time=3D0
there (maybe to disable hellos...) and forgot about it. It's removed now -
just in case.

> My preference would be to have hello_time set to zero if not running STP
> and not start timer if it is zero.

What about:
brctr stp br0 off
brctr stp br0 on

This sequence would disable HELLO's unless you would keep backup of this
field and restore it while turning STP back on.

> Also, the check for not sending config BPDU is separate. We do was time
> deciding to send BPDU when STP is disabled, the existing test could
> just be moved up the call chain.

That would move the STP logic to br_device.c. It's mixed up anyway, but
maybe I'm missing some point - I expected that by disabling STP I'm
turning my Linux box to a dump switch, that doesn't even care about
other switches nor forwarding loops that may happen (and so doesn't need
to send nor receive any BPDUs).

  -- Michal Miroslaw
