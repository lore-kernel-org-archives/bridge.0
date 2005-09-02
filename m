Message-ID: <34d8b2fe05090200376d8182ce@mail.gmail.com>
Date: Fri, 2 Sep 2005 09:37:31 +0200
From: Louis Croisez <louis.croisez@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10887_33204500.1125646651136"
Subject: [Bridge] unregister_netdevice: waiting for br0 to become free.
	Usage count = 1 (2.6.12.3)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org, rbscott@axentra.net

This is a multi-part message in MIME format...

------=_Part_10887_33204500.1125646651136
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Robert,

2. Any ideas of something to try in order to make this repeatable?
>=20

What i would do to reproduce it, is make a script establishing the bridge,=
=20
then flooding the bridge with some external ping -f, then shuting down the=
=20
bridge. If there is a refcount release problem, it should appear on eavy=20
load (some buffer overflow, or something like that).
Also, are you playing with ebtables? How do you use this bridge?
#Louis.


Date: Wed, 31 Aug 2005 19:04:01 -0700
> From: Robert Scott <rbscott@axentra.net>
> Subject: [Bridge] unregister_netdevice: waiting for br0 to become
> free. Usage count =3D 1 (2.6.12.3 <http://2.6.12.3/>)
> To: bridge@lists.osdl.org
> Message-ID: <8189B9F5-DF6E-4032-8D2D-D5301A02A081@axentra.net>
> Content-Type: text/plain; charset=3DUS-ASCII; delsp=3Dyes; format=3Dflowed
>=20
> Hello,
>=20
> I know that this bug has been discussed before at length on this
> mailing list, but previous post seemed to indicate that it was fixed
> before kernel 2.6.12. I am still seeing this occasionally in kernel
> 2.6.12.3 <http://2.6.12.3/>. The system is running knoppix, and IPV6 is=
=20
> not compiled
> into the kernel(other posts mentioned numerous problems with the IPV6
> code). But every so often, when bringing down the bridge (it doesn't
> happen every time), the process hangs, and the following message
> appears in dmesg repeatedly:
>=20
> 'unregister_netdevice: waiting for br0 to become free. Usage count =3D 1'
>=20
> None of the processes involved can be killed, and an attempt to run
> an ifconfig results in a process that is also waiting forever. At
> this point the box must be rebooted forcefully.
>=20
> Two questions.
> 1. In a previous post, someone mentioned one solution was to
> commenting out the check that is hanging in the kernel. Does this
> check preventing something terrible from happening(i assumed that it
> does), or is it safe to remove it.
> 2. Any ideas of something to try in order to make this repeatable?
>=20
> thanks,
> --robert scott

------=_Part_10887_33204500.1125646651136
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><div>Hi Robert,<br>
&nbsp;</div><br>
<blockquote DEFANGED_style=3D"border-left: 1px solid rgb(204, 204, 204); ma=
rgin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class=3D"gmail_quote">2. Any i=
deas of something to try in order to make this repeatable?<br>
</blockquote>
<br>
What i would do to reproduce it, is make a script establishing the
bridge, then flooding the bridge with some external ping -f, then
shuting down the bridge. If there is a refcount release problem, it
should appear on eavy load (some buffer overflow, or something like
that).<br>
Also, are you playing with ebtables? How do you use this bridge?<br>
#Louis.<br>
<br>
</div><br>
<blockquote DEFANGED_style=3D"border-left: 1px solid rgb(204, 204, 204); ma=
rgin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class=3D"gmail_quote">Date: We=
d, 31 Aug 2005 19:04:01 -0700<br>
From: Robert Scott &lt;<a DEFANGED_onclick=3D"return top.js.OpenExtLink(win=
dow,event,this)" href=3D"mailto:rbscott@axentra.net">rbscott@axentra.net</a=
>&gt;<br>
Subject: [Bridge] unregister_netdevice: waiting for br0 to become<br>
 &nbsp; &nbsp; &nbsp; &nbsp;free. &nbsp; Usage count =3D 1 (<a DEFANGED_onc=
lick=3D"return top.js.OpenExtLink(window,event,this)" href=3D"http://2.6.12=
.3/" target=3D"_blank">2.6.12.3</a>)<br>
To: <a DEFANGED_onclick=3D"return top.js.OpenExtLink(window,event,this)" hr=
ef=3D"mailto:bridge@lists.osdl.org">bridge@lists.osdl.org</a><br>
Message-ID: &lt;<a DEFANGED_onclick=3D"return top.js.OpenExtLink(window,eve=
nt,this)" href=3D"mailto:8189B9F5-DF6E-4032-8D2D-D5301A02A081@axentra.net">=
8189B9F5-DF6E-4032-8D2D-D5301A02A081@axentra.net</a>&gt;<br>
Content-Type: text/plain; charset=3DUS-ASCII; delsp=3Dyes; format=3Dflowed<=
br>
  <br>
Hello,<br>
  <br>
I know that this bug has been discussed before at length on this<br>
mailing list, but previous post seemed to indicate that it was fixed<br>
before kernel 2.6.12. &nbsp;I am still seeing this occasionally in kernel<b=
r>
  <a DEFANGED_onclick=3D"return top.js.OpenExtLink(window,event,this)" href=
=3D"http://2.6.12.3/" target=3D"_blank">2.6.12.3</a>. &nbsp;The system is r=
unning knoppix, and IPV6 is not compiled<br>
into the kernel(other posts mentioned numerous problems with the IPV6<br>
code). &nbsp;But every so often, when bringing down the bridge (it doesn't<=
br>
happen every time), the process hangs, and the following message<br>
appears in dmesg repeatedly:<br>
  <br>
'unregister_netdevice: waiting for br0 to become free. Usage count =3D 1'<b=
r>
  <br>
None of the processes involved can be killed, and an attempt to run<br>
an ifconfig results in a process that is also waiting forever. &nbsp;At<br>
this point the box must be rebooted forcefully.<br>
  <br>
Two questions.<br>
1. In a previous post, someone mentioned one solution was to<br>
commenting out the check that is hanging in the kernel. &nbsp; Does this<br>
check preventing something terrible from happening(i assumed that it<br>
does), or is it safe to remove it.<br>
2. Any ideas of something to try in order to make this repeatable?<br>
  <br>
thanks,<br>
--robert scott</blockquote>

------=_Part_10887_33204500.1125646651136--
