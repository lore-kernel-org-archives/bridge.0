Message-ID: <BD2C19A28F56C24F8B1051FE4CA0A63410A6E6@aiexchange.ai.aiinet.com>
From: "Eble, Dan" <DanE@aiinet.com>
Subject: RE: [Bridge] Re: hang on PPC
Date: Tue, 29 Jun 2004 13:12:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Eble, Dan" <DanE@aiinet.com>, "'arkady-parabel@ngs.ru'" <arkady-parabel@ngs.ru>
Cc: bridge@osdl.org

Scratch that last comment.  The kernel code I have now is identical to what
I posted.  Sorry for the misinformation.

> -----Original Message-----
> From: bridge-bounces@lists.osdl.org=20
> [mailto:bridge-bounces@lists.osdl.org] On Behalf Of Eble, Dan
> Sent: Tuesday, June 29, 2004 12:57 PM
> To: 'arkady-parabel@ngs.ru'
> Cc: bridge@osdl.org
> Subject: RE: [Bridge] Re: hang on PPC
>=20
>=20
> Pavel, you may be interested in my work on Cisco HDLC bridging:
> http://marc.theaimsgroup.com/?l=3Dlinux-netdev&m=3D108802311131855&w=3D2
>=20
> I have used it with the bridge driver (in 2.4) without any=20
> problems (yet
> ;)), and I am sure Krzysztof Halasa, the HDLC maintainer,=20
> would be thrilled
> if you managed to port it to a recent version of the kernel=20
> and make it a
> compile-time option.
>=20
> Oh, it also requires changes to sethdlc that are not in the post cited
> above.  There are also a few lines of modifications I've made=20
> to the kernel
> parts since that post.  Email me off-list if you are=20
> interested and I'll
> send you what I have.
>=20
> --=20
> Dan Eble <dane@aiinet.com>  _____  .
> Software Engineer          |  _  |/|
> Applied Innovation Inc.    | |_| | |
> http://www.aiinet.com/     |__/|_|_|
>=20
>=20
> > -----Original Message-----
> > From: bridge-bounces@lists.osdl.org=20
> > [mailto:bridge-bounces@lists.osdl.org] On Behalf Of=20
> > arkady-parabel@ngs.ru
> > Sent: Tuesday, June 29, 2004 11:57 AM
> > To: Stephen Hemminger
> > Cc: bridge@osdl.org
> > Subject: [Bridge] Re: hang on PPC
> >=20
> >=20
> > On Mon, 28 Jun 2004 09:38:46 -0700
> >  Stephen Hemminger <shemminger@osdl.org> wrote:
> > > > I get
> > > > br0: port 1(eth0) entering learning state
> > > > br0: port 1(eth0) entering forwarding state
> > > > br0: topology change detected, propagating
> > > >=20
> > > > Now brctl is sleeping, forever...
> > > Any brctl or which command? The usual way of debugging
> > > this is
> > > to enable SysRq in kernel and hit SysRq-t to see what is
> > > happening.
> > > Also SysRq-p to show processes.
> >=20
> > The process is locked(slept) by bridge module.
> >=20
> > I've found a reason, the reason is in "LAPB over Ethernet
> > driver (CONFIG_LAPBETHER)" conflict.
> > I think it is in register_netdevice_notifier's handlers lock
> > between lapbether & bridge modules.
> >=20
> > I've made a modification for hdlc_cisco.c, now it can report
> > cisco-hdlc device as Ethernet (with cisco-compatible bridge
> > encapsulation).
> > But I have one problem:
> > hdlc_cisco must add 4-byte header in hard_start_xmit (as
> > long as no one call hard_header. But I have no space, as
> > long as bridge's interface have hard_header_len =3D 0....
> > So' I have to make a COPY os skbuff, instead of cloning if
> > I'm the only user....
> >=20
> > When I add hard_header_len =3D 4, it stopped work even on
> > Ethernet.
> > Is it hard to make bridge working with hard_header_len !=3D 0
> > (It's necessary for Ethernet in (cisco-hdlc, frame-relay,
> > ppp) encapsulation) ?
> > --=20
> > Regards
> > Pavel
> >=20
> > web: http://parabel.inc.ru/
> > mail: pavel[AT]parabel.inc.ru
> > phone: +7 (3832) 13-87-07
> > ---------------------------------------------------------
> > http://relax.ngs.ru - =F7=D3=C5 =CF =C4=CF=D3=D5=C7=C5 =C9 =D2=C1=DA=D7=
=CC=C5=DE=C5=CE=C9=D1=C8 =D7 =EE=CF=D7=CF=D3=C9=C2=C9=D2=D3=CB=C5!
> >=20
> >=20
> >=20
> >=20
> >=20
> > _______________________________________________
> > Bridge mailing list
> > Bridge@lists.osdl.org
> > http://lists.osdl.org/mailman/listinfo/bridge
> >=20
>=20
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge
>=20

