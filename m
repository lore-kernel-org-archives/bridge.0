From: <arkady-parabel@ngs.ru>
Date: Tue, 29 Jun 2004 22:56:35 +0700
Message-ID: <web-127675562@intranet.ru>
In-Reply-To: <20040628093846.6b417369@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Re: hang on PPC
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

On Mon, 28 Jun 2004 09:38:46 -0700
 Stephen Hemminger <shemminger@osdl.org> wrote:
> > I get
> > br0: port 1(eth0) entering learning state
> > br0: port 1(eth0) entering forwarding state
> > br0: topology change detected, propagating
> >=20
> > Now brctl is sleeping, forever...
> Any brctl or which command? The usual way of debugging
> this is
> to enable SysRq in kernel and hit SysRq-t to see what is
> happening.
> Also SysRq-p to show processes.

The process is locked(slept) by bridge module.

I've found a reason, the reason is in "LAPB over Ethernet
driver (CONFIG_LAPBETHER)" conflict.
I think it is in register_netdevice_notifier's handlers lock
between lapbether & bridge modules.

I've made a modification for hdlc_cisco.c, now it can report
cisco-hdlc device as Ethernet (with cisco-compatible bridge
encapsulation).
But I have one problem:
hdlc_cisco must add 4-byte header in hard_start_xmit (as
long as no one call hard_header. But I have no space, as
long as bridge's interface have hard_header_len =3D 0....
So' I have to make a COPY os skbuff, instead of cloning if
I'm the only user....

When I add hard_header_len =3D 4, it stopped work even on
Ethernet.
Is it hard to make bridge working with hard_header_len !=3D 0
(It's necessary for Ethernet in (cisco-hdlc, frame-relay,
ppp) encapsulation) ?
--=20
Regards
Pavel

web: http://parabel.inc.ru/
mail: pavel[AT]parabel.inc.ru
phone: +7 (3832) 13-87-07
---------------------------------------------------------
http://relax.ngs.ru - =F7=D3=C5 =CF =C4=CF=D3=D5=C7=C5 =C9 =D2=C1=DA=D7=CC=
=C5=DE=C5=CE=C9=D1=C8 =D7 =EE=CF=D7=CF=D3=C9=C2=C9=D2=D3=CB=C5!





