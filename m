content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C41068.455EFA30"
Date: Mon, 22 Mar 2004 15:49:09 -0800
Message-ID: <9CDD2895B84A1C48B8FD80F9820E9C32048582BC@svlexc07.corp.netapp.com>
From: "Feierfeil, Jeff" <firefly@netapp.com>
Subject: [Bridge] br_add_bridge: Package not installed
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C41068.455EFA30
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am having a tough time simply getting the bridging to work with
RedHat.  Any help would be greatly appreciated.
=20
[root@redman root]# brctl addbr br0
br_add_bridge: Package not installed
=20
[root@redman temp]# uname -a
Linux redman 2.4.21-9.0.1.EL #1 Mon Feb 9 22:44:14 EST 2004 i686 i686
i386 GNU/Linux
=20
[root@redman root]# rpm -q --all 'kernel*'
kernel-2.4.21-9.0.1.EL
kernel-source-2.4.21-9.0.1.EL
kernel-pcmcia-cs-3.1.31-13
kernel-utils-2.4-8.37.1
=20
[root@redman temp]# rpm -q --all 'bridge*'
bridge-utils-0.9.6-1
=20
=20
[root@redman root]# brctl
commands:
addbr  <bridge> add bridge
addif  <bridge> <device> add interface to bridge
delbr <bridge> delete bridge
delif <bridge> <device> delete interface from bridge
show show a list of bridges
showmacs <bridge> show a list of mac addrs
showstp <bridge> show bridge stp info
setageing <bridge> <time> set ageing time
setbridgeprio <bridge> <prio> set bridge priority
setfd <bridge> <time> set bridge forward delay
setgcint <bridge> <time> set garbage collection interval
sethello <bridge> <time> set hello time
setmaxage <bridge> <time> set max message age
setpathcost <bridge> <port> <cost> set path cost
setportprio <bridge> <port> <prio> set port priority
stp <bridge> <state> turn stp on/off
[root@redman root]#
thanks........
=20
Jeff Feierfeil - Sales Engineer GE
Network Appliance, Inc.
firefly@netapp.com
Office: (248) 263-3239
Cell: (248) 514-1248
=20

------_=_NextPart_001_01C41068.455EFA30
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Message</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D296164423-22032004>I am havi=
ng a tough=20
time simply getting the bridging to work with RedHat.&nbsp; Any help would =
be=20
greatly appreciated.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D296164423-22032004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT><SPAN class=3D296164423-22032004><FONT face=3DArial size=3D2>[ro=
ot@redman=20
root]# brctl addbr br0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>br_add_bridge: Package not installed</FONT=
></DIV>
<DIV><FONT face=3DArial size=3D2></FONT><FONT face=3DArial=20
size=3D2></FONT></FONT><FONT><FONT face=3DArial size=3D2></FONT></FONT>&nbs=
p;</DIV>
<DIV><FONT><FONT face=3DArial size=3D2>[root@redman temp]# uname -a</FONT><=
/DIV>
<DIV><FONT face=3DArial size=3D2>Linux redman 2.4.21-9.0.1.EL #1 Mon Feb 9 =
22:44:14=20
EST 2004 i686 i686 i386 GNU/Linux</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>[root@redman root]# rpm -q --all=20
'kernel*'</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>kernel-2.4.21-9.0.1.EL</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>kernel-source-2.4.21-9.0.1.EL</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>kernel-pcmcia-cs-3.1.31-13</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>kernel-utils-2.4-8.37.1</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>[root@redman temp]# rpm -q --all=20
'bridge*'</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>bridge-utils-0.9.6-1</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></FONT><PRE>[root@redma=
n root]# brctl</PRE><PRE>commands:</PRE><PRE>addbr&nbsp;<SPAN class=3D29616=
4423-22032004>&nbsp;</SPAN>&lt;bridge&gt; add bridge</PRE><PRE>addif&nbsp;<=
SPAN class=3D296164423-22032004>&nbsp;</SPAN>&lt;bridge&gt; &lt;device&gt; =
add interface to bridge</PRE><PRE>delbr &lt;bridge&gt; delete bridge</PRE><=
PRE>delif &lt;bridge&gt; &lt;device&gt; delete interface from bridge</PRE><=
PRE>show show a list of bridges</PRE><PRE>showmacs &lt;bridge&gt; show a li=
st of mac addrs</PRE><PRE>showstp &lt;bridge&gt; show bridge stp info</PRE>=
<PRE>setageing &lt;bridge&gt; &lt;time&gt; set ageing time</PRE><PRE>setbri=
dgeprio &lt;bridge&gt; &lt;prio&gt; set bridge priority</PRE><PRE>setfd &lt=
;bridge&gt; &lt;time&gt; set bridge forward delay</PRE><PRE>setgcint &lt;br=
idge&gt; &lt;time&gt; set garbage collection interval</PRE><PRE>sethello &l=
t;bridge&gt; &lt;time&gt; set hello time</PRE><PRE>setmaxage &lt;bridge&gt;=
 &lt;time&gt; set max message age</PRE><PRE>setpathcost &lt;bridge&gt; &lt;=
port&gt; &lt;cost&gt; set path cost</PRE><PRE>setportprio &lt;bridge&gt; &l=
t;port&gt; &lt;prio&gt; set port priority</PRE><PRE>stp &lt;bridge&gt; &lt;=
state&gt; turn stp on/off</PRE><PRE>[root@redman root]#</PRE><FONT>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D296164423-22032004>thanks........</SPAN></FONT></SPAN></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Jeff Feierfeil - Sales Engine=
er=20
GE<BR>Network Appliance, Inc.<BR><A=20
href=3D"mailto:firefly@netapp.com">firefly@netapp.com</A><BR>Office: (248)=
=20
263-3239<BR>Cell: (248) 514-1248</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>
=00
------_=_NextPart_001_01C41068.455EFA30--
