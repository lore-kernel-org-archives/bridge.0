Date: Tue, 9 Aug 2005 14:34:03 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] how to silence the "br0: port X(ethX) doing something"
	messages?
Message-ID: <20050809143403.4c0602b9@dxpl.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.62.0508080930090.29573@localhost.localdomain>
References: <Pine.LNX.4.62.0508080930090.29573@localhost.localdomain>
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

On Mon, 8 Aug 2005 09:33:06 +0300 (EEST)
Martin-=C9ric Racine <q-funk@iki.fi> wrote:

> Greetings,
>=20
> I'm just wondering how one can make the bridging tools stop spamming
> the virtual consoles? I would rather have all those "entering
> forwarding state", "entering learning state" and "entering disabled
> state" messages go to a log than have them plastered all over
> whichever console I happened to be logged into to work.
>=20
> Thanks!
>=20

Assuming you are running relatively recent kernel, the messages show up
at loglevel 6 (informational).

You need to change the console log level and possibly
change syslog.conf.  To change console log level, either boot
without "debug" on the command line, preferably with "quiet"
on the command line. In /etc/syslog.conf look for anylines
of the form:

	kern.*	/dev/console
and either comment it out completely, or change the '*'
to
	kern.notice	/dev/console

