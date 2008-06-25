Date: Wed, 25 Jun 2008 11:06:33 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080625110633.2c6c6c76@extreme>
In-Reply-To: <87fxr16h9j.fsf@q-software-solutions.de>
References: <87skv27wiv.fsf@q-software-solutions.de>
	<20080624093133.6f2b896b@extreme>
	<87fxr16h9j.fsf@q-software-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Bridge troubles
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Friedrich Dominicus <frido@q-software-solutions.de>
Cc: bridge@lists.linux-foundation.org

On Wed, 25 Jun 2008 10:38:48 +0200
Friedrich Dominicus <frido@q-software-solutions.de> wrote:

> Stephen Hemminger <shemminger@vyatta.com> writes:
>=20
> > On Tue, 24 Jun 2008 16:11:36 +0200
> > Friedrich Dominicus <frido@q-software-solutions.de> wrote:
> >
> >> I'm sorry to bother you but I'm stuck
> >>=20
> >> I can not make a bridge work for me.=20
> >> My current configuration is:
> >> eth0      Link encap:Ethernet  Hardware Adresse 00:1d:7d:d1:06:bd =20
> >>           inet Adresse:192.168.1.1  Bcast:192.168.1.255  Maske:255.255=
.255.0
> >>           inet6-Adresse: fe80::21d:7dff:fed1:6bd/64
> >> G=C3=BCltigkeitsbereich:V
> >>=20
> >> according to all what I could find in the net. The following should do
> >> to build a bridge=20
> >> ifconfig eth0 down
> >> # brctl addbr br0
> >> # addif br0 eth0
> >> # ifconfig eth0 0.0.0.0 up
> >> # ifconfig  br0 192.168.1.1 up
> Ok, I tried exactly the same on  32-bit linux and there this simply
> runs.
>=20
> So I have to conclude that this either is a problem in my 64-bit machine
> setup (however I tried on a different 64-bit platform with the same
> result)=20
> Of that there is some bug on a 64-bit platform
>=20
> Regards
> Friedrich
>=20
>=20
>=20

Or different hardware on the two machines?
