Message-ID: <003801c44db8$99d7bb70$6401a8c0@accessme.net>
From: "Jim" <br0@harborworld.com>
Date: Tue, 8 Jun 2004 17:27:50 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0035_01C44D7D.EC8F46C0"
Subject: [Bridge] Problem with startup script
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

------=_NextPart_000_0035_01C44D7D.EC8F46C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I put a bridging firewall together last winter (with some help) and have it=
 in production in front of a couple windows web and mail servers for going =
on 6 months now. I used Fedora C1 with 2.4.22 kernel and 0.9.6 bridge-utils=
. The bridge has solved a lot of security headaches. I use a modified start=
up script written by David Whitmarsh that has worked really well. http://ww=
w.sparkle-cc.co.uk/firewall/rc.firewall.sh.txt

Now that Fedora C2 has the 2.6 kernel (2.6.5-1.358) I figured I'd try it on=
 a test machine. I loaded the 0.9.6 bridge-utils rpm that came with it, for=
 simplicity, and double checked the networking files to make sure eth0 and =
eth1 were set up correctly without IPs. I then ran these commands in bash a=
nd the bridge came up perfectly.
-------------------------------------
brctl addbr br0
brctl addif br0 eth0
brctl addif br0 eth1
ifconfig eth0 0.0.0.0
ifconfig eth1 0.0.0.0
ifconfig br0 192.168.1.14 up
---------------------------------------
I could see across the bridge from both sides, and thought this is too easy=
. Then I dropped the startup script I've been using in /etc/rc.d and starte=
d running into problems. I found out modules are handled a little different=
ly now (modutils to module-init-tools) so the iptables has to be handled a =
little differently. But what's got me is the errors popping up when trying =
to start the bridge from this script I'm testing with (syntax OK)
--------------------------------------
#!/bin/sh
BR_IP=3D"192.168.1.14"
BR_IFACE=3Dbr0
INET_IFACE=3D"eth1"
LAN_IFACE=3D"eth0"
#
brctl addbr $BR_IFACE
brctl addif $BR_IFACE $INET_IFACE
brctl addif $BR_IFACE $LAN_IFACE
ifconfig $INET_IFACE 0.0.0.0
ifconfig $LAN_IFACE 0.0.0.0
ifconfig $BR_IFACE up
--------------------------------------
which works fine with the 2.4 kernel but errors out with
--------------------------------------
[root@test root]# sh /etc/rc.d/rc.bridge
SIOCSIFADDR: No such device
: unknown interface: No such device
SIOCSIFADDR: No such device
: unknown interface: No such device
 doesn't exist!
 doesn't exist!
: Host name lookup failure
ifconfig: `--help' gives usage information.
--------------------------------------
on this test box. I believe this is a similar problem to the one noted a fe=
w days ago by Harald K=FCthe http://lists.osdl.org/pipermail/bridge/2004-Ju=
ne/000382.html (although I'm using the 0.9.6 bridge-utils) regarding where =
SIOCGIFCONF only lists interfaces that have IP addresses. I tried adding IP=
ADDR=3D0.0.0.0 to ifcfg-eth0 and ifcfg-eth1 but it had no effect. Fedora us=
es glibc so the patch for uClibc wasn't useful. What I don't understand is =
how the same commands can be typed into a shell, but won't work in the scri=
pt?

Pardon my ignorance, as I'm just learning Linux and trying to muddle my way=
 through, but any pointers would be appreciated. I'd also appreciate any su=
ggestions on how to handle the iptables rules in a startup script.

Thank you,
Jim



------=_NextPart_000_0035_01C44D7D.EC8F46C0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1276" name=3DGENERATOR>
<DEFANGED_style_0 </STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I put a bridging firewall together last wi=
nter=20
(with some help) and have it in production in front of a couple windows web=
 and=20
mail servers for going on 6 months now. I used Fedora C1 with 2.4.22 kernel=
 and=20
0.9.6 bridge-utils. The bridge has&nbsp;solved a lot of security headaches.=
 I=20
use a modified startup script written by David Whitmarsh that has worked re=
ally=20
well.&nbsp;<A=20
href=3D"http://www.sparkle-cc.co.uk/firewall/rc.firewall.sh.txt">http://www=
.sparkle-cc.co.uk/firewall/rc.firewall.sh.txt</A></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Now that Fedora C2 has the 2.6 kernel (2.6=
.5-1.358)=20
I figured I'd try it on a test machine. I loaded the 0.9.6 bridge-utils rpm=
 that=20
came with it, for simplicity, and double checked the networking files to ma=
ke=20
sure eth0 and eth1 were set up correctly without IPs. I then ran these comm=
ands=20
in bash and the bridge came up perfectly.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>-------------------------------------</FON=
T></DIV>
<DIV><FONT face=3DArial size=3D2>brctl addbr br0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>brctl addif br0 eth0</FONT></DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2>brctl addif br0 eth1</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>ifconfig eth0 0.0.0.0</FONT></DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2>ifconfig eth1 0.0.0.0</FONT></DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2>ifconfig br0 192.168.1.14 up</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>---------------------------------------</FONT></DIV></DIV>
<DIV><FONT face=3DArial size=3D2>I could see across the bridge from both si=
des, and=20
thought this is too easy. Then I dropped the startup script I've been using=
 in=20
/etc/rc.d and started running into problems. I found out modules are handle=
d a=20
little differently now (modutils to module-init-tools) so the iptables has =
to be=20
handled a little differently. But what's got me is the errors popping up wh=
en=20
trying to start the bridge from&nbsp;this script I'm testing with (syntax=
=20
OK)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>--------------------------------------</FO=
NT></DIV>
<DIV><FONT face=3DArial size=3D2>#!/bin/sh<BR>BR_IP=3D"192.168.1.14"</FONT>=
</DIV>
<DIV><FONT face=3DArial size=3D2>BR_IFACE=3Dbr0</FONT><FONT face=3DArial=20
size=3D2><BR>INET_IFACE=3D"eth1"<BR>LAN_IFACE=3D"eth0"<BR>#<BR>brctl addbr=
=20
$BR_IFACE<BR>brctl addif $BR_IFACE $INET_IFACE<BR>brctl addif $BR_IFACE=20
$LAN_IFACE<BR>ifconfig $INET_IFACE 0.0.0.0<BR>ifconfig $LAN_IFACE=20
0.0.0.0<BR>ifconfig $BR_IFACE up</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>--------------------------------------</FO=
NT></DIV>
<DIV><FONT face=3DArial size=3D2>which works fine with the 2.4 kernel but e=
rrors out=20
with</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>--------------------------------------</FO=
NT></DIV>
<DIV><FONT face=3DArial size=3D2>[root@test root]# sh=20
/etc/rc.d/rc.bridge<BR>SIOCSIFADDR: No such device<BR>: unknown interface: =
No=20
such device<BR>SIOCSIFADDR: No such device<BR>: unknown interface: No such=
=20
device<BR>&nbsp;doesn't exist!<BR>&nbsp;doesn't exist!<BR>: Host name looku=
p=20
failure</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>ifconfig: `--help' gives usage=20
information.</DIV></FONT>
<DIV><FONT face=3DArial size=3D2>--------------------------------------</FO=
NT></DIV>
<DIV><FONT face=3DArial size=3D2>on this test box. I believe this is a simi=
lar=20
problem to the one noted a few days ago by <EM>Harald K=FCthe <A=20
href=3D"http://lists.osdl.org/pipermail/bridge/2004-June/000382.html">http:=
//lists.osdl.org/pipermail/bridge/2004-June/000382.html</A></EM>&nbsp;(alth=
ough=20
I'm using the 0.9.6 bridge-utils) regarding where SIOCGIFCONF only lists=20
interfaces that have IP addresses. I tried adding IPADDR=3D0.0.0.0 to ifcfg=
-eth0=20
and ifcfg-eth1 but it had no effect. Fedora uses glibc so the patch for uCl=
ibc=20
wasn't useful. What I don't understand is how the same commands can be type=
d=20
into a shell, but won't work in the script?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Pardon my ignorance, as I'm just learning =
Linux and=20
trying to muddle my way through, but any pointers would be appreciated. I'd=
 also=20
appreciate any suggestions on how to handle the iptables rules in a startup=
=20
script.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thank you,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Jim</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></DIV></DIV></BODY></HT=
ML>

------=_NextPart_000_0035_01C44D7D.EC8F46C0--
