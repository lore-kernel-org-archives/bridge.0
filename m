Message-ID: <000e01c4128b$8c13f9d0$7f619082@simba>
From: "Rein van Koten" <rein@vankoten.com>
Date: Thu, 25 Mar 2004 18:06:33 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000B_01C41293.E7E7FF10"
Subject: [Bridge] Mirroring an interface to an other by using bridge ?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org
Cc: shemminger@osdl.org

This is a multi-part message in MIME format...

------=_NextPart_000_000B_01C41293.E7E7FF10
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Just wondering....

Currently i'm redesigning an intrusion detection system based on Snort / Li=
nux (in this case Fedora Core 1).
Datastream is tapped physically by means of single-mode fiber taps from a d=
ual path link between router pairs.
By using intel single mode fiber cards and bundling the four tapped streams=
 to one virtual interface with the intel drivers i recreate a virtual mirro=
r of the uplinks we are sampling. Works like a charm.
However, the created datastream is needed for other measurements as well. W=
hat I would like to do is to create a mirror port from the reassembled stre=
am.
Normally you woud have one or more mirror ports on a switch/router but in t=
his case the stream is only complete on the linux box.....
Also, as it is not a real stream a 100mb hub cannot be used as fanout (and =
this only as long as the aggregated load is below 100MB and is not a pure f=
or ids use)

Looking for a solution to this I dug into ebtables / bridging and divert me=
chanisms currently available in the linux kernels.
But I did not find a reference to a real mirror solution. Maybe I'm looking=
 in the wrong place.
Looking at the functionality I think I need, it looks like the bridge modul=
e is my closest bet.
If the bridge forwards everything without keeping mac tables or sending/rec=
eiving arp messages I'm in business.....

So, my question:

Is it possible to adapt the bridge code so it:
- copies all incoming traffic from one interface (in promisc mode) to an ot=
her, regardless of mac address etc
- does not do any sending itself (no proxyarp, arp, broadcasts etc)
- prefferably works one way (a mirror should be read only)?
- This as low as can be in the kernel (so not all the way up to ip/eb table=
s or high in userspace)
In fact this looks like the bridge module without all the more refined stuf=
f (keeping tables, proxying etc)


Example with the envisioned version of bridge module and brctl:

# sniffing / ids on eth1, want to copy all traffic to eth2 for others to us=
e without needing access to the IDS environment.
# setup bridge
brctl addbr <bridgename>
brctl addif eth1
brctl addif eth2
# set bridge type to copy thus creating a mirror port
brctl mode <bridgename> copy
# set the copy direction from eth1 to eth2 (can only be in one direction)
brctl setcopy <bridgename> in eth1
brctl setcopy <bridgename> out eth2
# enjoy...

so:
mode command has options copy or bridge
setcopy out provide the option to copy several interfaces' incoming data to=
 a single (or even multiple?) interfaces.

currently I only see a solution like bridging, ebtables/divert replacing in=
coming macs with the mac of the sniffer attached to my semi mirror interfac=
e, blocking all arp traffic and this only works probably if you know all th=
e mac addresses on the link you are sampling (in my case I do because it's =
the four mac addresses of the upstream and downstream routers).=20
Also, possible trouble comes from :
    - I'm not sure that tools like divert etc work on a virutal interface l=
ike the one created when you bundle interfaces.
    - i/o speed, kernel resources etc
I saw that I at least had to hack the divert.o code to remove the check on =
interface names starting with "eth" as the intel drivers do not allow a vir=
utal interface with a name like eth9...

Anyway,

I would appreciate your opinion on this or whether you know someone working=
 along the same lines...
I myself am not C savvy enough to rewrite the bridge module without additio=
nal input on this idea.
And then again, maybe it already exists.

Regards,

Rein van Koten
The Netherlands.

------=_NextPart_000_000B_01C41293.E7E7FF10
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
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Just wondering....</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Currently i'm redesigning an intrusion det=
ection=20
system based on Snort / Linux (in this case Fedora Core 1).<BR>Datastream i=
s=20
tapped physically by means of single-mode fiber taps from a dual path link=
=20
between router pairs.<BR>By using intel single mode fiber cards and bundlin=
g the=20
four tapped streams to one virtual interface with the intel drivers i recre=
ate a=20
virtual mirror of the uplinks we are sampling. Works like a charm.<BR>Howev=
er,=20
the created datastream is needed for other measurements as well. What I wou=
ld=20
like to do is to create a mirror port from the reassembled stream.<BR>Norma=
lly=20
you woud have one or more mirror ports on a switch/router but in this case =
the=20
stream is only complete on the linux box.....<BR>Also, as it is not a real=
=20
stream a 100mb hub cannot be used as fanout (and this only as long as the=
=20
aggregated load is below 100MB and is not a pure for ids use)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Looking for a solution to this I dug into =
ebtables=20
/ bridging and divert mechanisms currently available in the linux=20
kernels.<BR>But I did not find a reference to a real mirror solution. Maybe=
 I'm=20
looking in the wrong place.<BR>Looking at the functionality I think I need,=
 it=20
looks like the bridge module is my closest bet.<BR>If the bridge forwards=
=20
everything without keeping mac tables or sending/receiving arp messages I'm=
 in=20
business.....</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>So, my question:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Is it possible to adapt the bridge code so=
 it:<BR>-=20
copies all incoming traffic from one interface (in promisc mode) to an othe=
r,=20
regardless of mac address etc<BR>- does not do any sending itself (no proxy=
arp,=20
arp, broadcasts etc)<BR>- prefferably works one way (a mirror should be rea=
d=20
only)?<BR>- This as low as can be in the kernel (so not all the way up to i=
p/eb=20
tables or high in userspace)<BR>In fact this looks like the bridge module=
=20
without all the more refined stuff (keeping tables, proxying etc)</FONT></D=
IV>
<DIV>&nbsp;</DIV><FONT face=3DArial size=3D2>
<DIV><BR>Example with the envisioned version of bridge module and brctl:</D=
IV>
<DIV>&nbsp;</DIV>
<DIV># sniffing / ids on eth1, want to copy all traffic to eth2 for others =
to=20
use without needing access to the IDS environment.<BR># setup bridge<BR>brc=
tl=20
addbr &lt;bridgename&gt;<BR>brctl addif eth1<BR>brctl addif eth2<BR># set b=
ridge=20
type to copy thus creating a mirror port<BR>brctl mode &lt;bridgename&gt;=
=20
copy<BR># set the copy direction from eth1 to eth2 (can only be in one=20
direction)<BR>brctl setcopy &lt;bridgename&gt; in eth1<BR>brctl setcopy=20
&lt;bridgename&gt; out eth2<BR># enjoy...</DIV>
<DIV>&nbsp;</DIV>
<DIV>so:<BR>mode command has options copy or bridge<BR>setcopy out provide =
the=20
option to copy several interfaces' incoming data to a single (or even multi=
ple?)=20
interfaces.</DIV>
<DIV>&nbsp;</DIV>
<DIV>currently I only see a solution like bridging, ebtables/divert replaci=
ng=20
incoming macs with the mac of the sniffer attached to my semi mirror interf=
ace,=20
blocking all arp traffic and this only works probably if you know all the m=
ac=20
addresses on the link you are sampling (in my case I do because it's the fo=
ur=20
mac addresses of the upstream and downstream routers). <BR>Also, possible=
=20
trouble comes from :<BR>&nbsp;&nbsp;&nbsp; - I'm not sure that tools like d=
ivert=20
etc work on a virutal interface like the one created when you bundle=20
interfaces.<BR>&nbsp;&nbsp;&nbsp; - i/o speed, kernel resources etc<BR>I sa=
w=20
that I at least had to hack the divert.o code to remove the check on interf=
ace=20
names starting with "eth" as the intel drivers do not allow a virutal inter=
face=20
with a name like eth9...</DIV>
<DIV>&nbsp;</DIV>
<DIV>Anyway,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I would appreciate your opinion on this or whether you know someone wo=
rking=20
along the same lines...<BR>I myself am not C savvy enough to rewrite the br=
idge=20
module without additional input on this idea.</DIV>
<DIV>And then again, maybe it already exists.</DIV>
<DIV><BR>Regards,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Rein van Koten</DIV>
<DIV>The Netherlands.<BR></DIV></FONT></BODY></HTML>

------=_NextPart_000_000B_01C41293.E7E7FF10--
