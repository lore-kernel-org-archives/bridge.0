Mime-Version: 1.0
Message-Id: <969A8B08-19EE-445B-AAFB-2A9D8D3D5CE7@mpsnet.net.mx>
Content-Type: multipart/alternative; boundary="Apple-Mail-8-236710307"
From: Omar Armas <oarmas@mpsnet.net.mx>
Date: Wed, 24 Jan 2007 14:19:14 -0600
Subject: [Bridge] problem bridging
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

This is a multi-part message in MIME format...

--Apple-Mail-8-236710307
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed
Content-Disposition: inline

Hi, I did a bridge with kernel 2.4.34 and two intel e1000 network cards.

I setup the bridge with:

     /usr/sbin/brctl addbr br0
     /usr/sbin/brctl addif br0 eth0
     /usr/sbin/brctl addif br0 eth1
     /sbin/ifconfig eth0 0.0.0.0 promisc
     /sbin/ifconfig eth1 0.0.0.0 promisc
     /sbin/ifconfig br0 up

My configuration is:

router
|
Bridge
|
LAN


but my problem is that it always passes all traffic, no matter if I  
set FOWARD iptables chain to DROP:
iptables -P FORWARD DROP

When I do this the all traffic and protocols continue passing.
Any idea why?


Omar Armas
Oficina: +52 55 56044655
Movil: 04455 1867 8953
oarmas@mpsnet.net.mx




--Apple-Mail-8-236710307
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1
Content-Disposition: inline

<HTML><BODY DEFANGED_style=3D"word-wrap: break-word; -khtml-nbsp-mode: spac=
e; -khtml-line-break: after-white-space; "><DIV>Hi, I did a bridge with ker=
nel 2.4.34 and two intel e1000 network cards.</DIV><DIV><BR class=3D"khtml-=
block-placeholder"></DIV><DIV>I setup the bridge with:</DIV><DIV><BR class=
=3D"khtml-block-placeholder"></DIV><DIV>=A0=A0 =A0/usr/sbin/brctl addbr br0=
</DIV><DIV>=A0 =A0 /usr/sbin/brctl addif br0 eth0</DIV><DIV>=A0 =A0 /usr/sb=
in/brctl addif br0 eth1</DIV><DIV>=A0 =A0 /sbin/ifconfig eth0 0.0.0.0 promi=
sc</DIV><DIV>=A0 =A0 /sbin/ifconfig eth1 0.0.0.0 promisc</DIV><DIV>=A0 =A0 =
/sbin/ifconfig br0 up</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV=
><DIV>My configuration is:</DIV><DIV><BR class=3D"khtml-block-placeholder">=
</DIV><DIV>router</DIV><DIV>|</DIV><DIV>Bridge</DIV><DIV>|</DIV><DIV>LAN</D=
IV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV><BR class=3D"khtml=
-block-placeholder"></DIV><DIV>but my problem is that it always passes all =
traffic, no matter if I set FOWARD iptables chain to DROP:</DIV><DIV>iptabl=
es -P FORWARD DROP</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><D=
IV>When I do this the all traffic and protocols continue passing.</DIV><DIV=
>Any idea why?</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><BR><D=
IV> <SPAN class=3D"Apple-style-span" DEFANGED_style=3D"border-collapse: sep=
arate; border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica=
; font-size: 12px; font-style: normal; font-variant: normal; font-weight: n=
ormal; letter-spacing: normal; line-height: normal; text-align: auto; -khtm=
l-text-decorations-in-effect: none; text-indent: 0px; -apple-text-size-adju=
st: auto; text-transform: none; orphans: 2; white-space: normal; widows: 2;=
 word-spacing: 0px; "><SPAN class=3D"Apple-style-span" DEFANGED_style=3D"bo=
rder-collapse: separate; border-spacing: 0px 0px; color: rgb(0, 0, 0); font=
-family: Helvetica; font-size: 12px; font-style: normal; font-variant: norm=
al; font-weight: normal; letter-spacing: normal; line-height: normal; text-=
align: auto; -khtml-text-decorations-in-effect: none; text-indent: 0px; -ap=
ple-text-size-adjust: auto; text-transform: none; orphans: 2; white-space: =
normal; widows: 2; word-spacing: 0px; "><DIV>Omar Armas</DIV><DIV>Oficina: =
+52 55 56044655</DIV><DIV>Movil: 04455 1867 8953</DIV><DIV><A href=3D"mailt=
o:oarmas@mpsnet.net.mx">oarmas@mpsnet.net.mx</A></DIV><DIV><BR class=3D"kht=
ml-block-placeholder"></DIV><BR class=3D"Apple-interchange-newline"></SPAN>=
</SPAN> </DIV><BR></BODY></HTML>
--Apple-Mail-8-236710307--
