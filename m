Date: Tue, 9 Aug 2005 16:00:47 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] how to silence the "br0: port X(ethX) doing something"
	messages?
Message-ID: <20050809160047.40ea94f5@dxpl.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.62.0508100046480.12525@localhost.localdomain>
References: <Pine.LNX.4.62.0508080930090.29573@localhost.localdomain>
	<20050809143403.4c0602b9@dxpl.pdx.osdl.net>
	<Pine.LNX.4.62.0508100046480.12525@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: =?ISO-8859-1?B?TWFydGluLclyaWM=?= Racine <q-funk@iki.fi>
Cc: bridge@lists.osdl.org

On Wed, 10 Aug 2005 00:57:14 +0300 (EEST)
Martin-=C9ric Racine <q-funk@iki.fi> wrote:

> On Tue, 9 Aug 2005, Stephen Hemminger wrote:
>=20
> > On Mon, 8 Aug 2005 09:33:06 +0300 (EEST)
> > Martin-=C9ric Racine <q-funk@iki.fi> wrote:
> >
> >> Greetings,
> >>
> >> I'm just wondering how one can make the bridging tools stop
> >> spamming the virtual consoles? I would rather have all those
> >> "entering forwarding state", "entering learning state" and
> >> "entering disabled state" messages go to a log than have them
> >> plastered all over whichever console I happened to be logged into
> >> to work.
> >>
> >> Thanks!
> >
> > Assuming you are running relatively recent kernel, the messages
> > show up at loglevel 6 (informational).
>=20
> Noted.
>=20
> Linux omena 2.6.11-imac #2 Thu Jun 23 11:44:22 EEST 2005 ppc GNU/Linux
>=20
> ...and other similar 2.6 kernels also on my i386 and hppa hosts.
>=20
>=20
> > You need to change the console log level and possibly change
> > syslog.conf.
>=20
> > To change console log level, either boot without "debug" on the
> > command line, preferably with "quiet" on the command line.
>=20
> Sorry, to which kernel option are you refering, exactly?
>=20
> My bootloader options are already rather spartan as it is; no debug
> there:
>=20
> root=3D/dev/hda1 ro elevator=3Dcfq
>=20

cat /proc/cmdline

You could also try:
	echo 5 >/proc/sysrq-trigger

