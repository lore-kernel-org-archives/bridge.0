Message-ID: <000001c43553$b663d490$2ee5393e@dck>
From: "Sttf" <vklengh@menta.net>
Date: Sat, 8 May 2004 22:32:12 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001F_01C4354C.4EB3CF50"
Subject: [Bridge] Bridge question (VPN related)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_NextPart_000_001F_01C4354C.4EB3CF50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello everybody. I'll try to explain my problem the best i can.

After setting up the tunnel between a simple win xp station and a bridged l=
inux box (only with the eth0 and the tap bridged), sending also either the =
vpn data and the normal data over the same ethernet, can i set an internal =
tap IP in the linux bridged station in order to receive tunneled data for i=
tself?=20

If not, the XP station will never be able to send tunneled data to the Linu=
x one. Can you understand me?

I'm really stressed about the issue, i've tried everything in the route tab=
le, adding the remote (XP) subnet mask in a new virtual interface (ifconfig=
 eth0 add MyVirtual [since you can not set any IP to the tap one]) as a new=
 route with the tap interface as gateway (rather than the br0/eth0). Didn't=
 work. Which do you think that is the problem?

Can't i actually add another 'virtual' interface only for having the suppos=
ed to have TAP IP in this other interface, just like a trick, and to really=
 use the tap one as gateway to send and receive tunneled data? I gues that =
not, because that interface will be not bridged, and then will be not able =
to send the traffic across the TAP one..?

Thanks
------=_NextPart_000_001F_01C4354C.4EB3CF50
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<DEFANGED_style_0 </STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>
<DIV><FONT face=3DArial size=3D2>Hello everybody. I'll try to explain my pr=
oblem the=20
best i can.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>After setting up the tunnel between a simp=
le win xp=20
station and a bridged linux box (only with the eth0 and the tap bridged),=
=20
sending also either the vpn data and the normal data&nbsp;over the same=20
ethernet,&nbsp;can i&nbsp;set an internal tap IP in the linux bridged stati=
on in=20
order to receive tunneled data for itself? </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT><FONT face=3DArial size=3D2></FONT>=
&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If not, the XP station will never be able =
to send=20
tunneled data to the Linux one. Can you understand me?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm really stressed about the issue, i've =
tried=20
everything in the route table, adding the remote (XP) subnet mask in a new=
=20
virtual interface (ifconfig eth0 add MyVirtual [since you can not set any I=
P to=20
the tap one]) as a new route with the tap interface as&nbsp;gateway&nbsp;(r=
ather=20
than the br0/eth0). Didn't work. Which do you think that is the=20
problem?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Can't i actually add another 'virtual' int=
erface=20
only for having the supposed to have TAP IP in this other interface, just l=
ike a=20
trick, and to really use the tap one as gateway to send and receive tunnele=
d=20
data?&nbsp;I gues that not, because that interface will be not bridged, and=
 then=20
will be not able to send the traffic across the TAP one..?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks</FONT></DIV></DIV></BODY></HTML>

------=_NextPart_000_001F_01C4354C.4EB3CF50--
