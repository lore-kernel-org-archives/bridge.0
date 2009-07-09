Message-ID: <296430.71383.qm@web8805.mail.in.yahoo.com>
Date: Thu, 9 Jul 2009 11:38:08 +0530 (IST)
From: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-436994913-1247119688=:71383"
Subject: [Bridge] Bridge is not forwarding DHCP offer packet to wireless
	interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: shemminger@vyatta.com


--0-436994913-1247119688=:71383
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,
I am facing some very interested problem with the Linux bridge. Let me expl=
ain you the setup first:
wireless STA =A0 =A0 =A0 =A0 =A0 AP =A0 =A0 =A0 Managed switch =A0 =A0 =A0 =
=A0=A0=3D=3D=3D=3D=3D=3D=3D=3D =A0 =A0 =A0 =A0 =A0 =A0=3D=3D=3D=3D =A0 =A0 =
=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D| =A0 =A0 =A0 =A0 =A0 =A0 =A0|______=
_| =A0 =A0 =A0| ___| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0____D=
HCP SERVER| =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =
=A0| =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=3D=3D=3D=
=3D=3D=3D=3D=3D =A0 =A0 =A0 =A0 =A0 =3D=3D=3D=3D =A0 =A0 =A0 =A0=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bridge on AP is=A0
br100 =3D > eth0.100=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 ath0.100
So here in this setup station is sending DHCP Discover to AP which is recei=
ved on ath0.100 interface of bridge and it forwards that request to eth0.10=
0. eth0.100 adds its vlan tag and forward this request to a managed switch =
which can understand vlan tags. then this this switch removed vlan tag and =
forwards this request to DHCP server. DHCP server then replied to it with D=
HCP offer packet. DHCP offer is s Broadcast packet. This offer packet is re=
ceived in eth0.100 but some how it is not forwarded on ath0.100 so that sta=
tion can also get this. I have verified it by using ethereal that DHCP offe=
r packet is coming to eth0.100 interface but it is not received in ath0.100=
. One more thing, this is not happening everytime. This is happening someti=
me only.
So My problem is that like why bridge is not forwarding this DHCP offer pac=
ket to ath0.100 sometime. Can any body help me on this. Do let me know if y=
ou want any other detail about setup.
With Regards=A0
Rahul Bhardwaj=20

=A0=0A=0A=0A      Love Cricket? Check out live scores, photos, video highli=
ghts and more. Click here http://cricket.yahoo.com
--0-436994913-1247119688=:71383
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi All,<div><br></div><div>I am facing some v=
ery interested problem with the Linux bridge. Let me explain you the setup =
first:</div><div><br></div><div>wireless STA &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; AP &nbsp; &nbsp; &nbsp; Managed switch &nbsp; &nbsp; &nbsp; &nbsp;&nbs=
p;</div><div>=3D=3D=3D=3D=3D=3D=3D=3D &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp;=3D=3D=3D=3D &nbsp; &nbsp; &nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</=
div><div>| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|_______| &nbsp;=
 &nbsp; &nbsp;| ___| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; | &nbsp;____DHCP SERVER</div><div>| &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
| &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; | &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div><div>=3D=3D=3D=3D=
=3D=3D=3D=3D &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D=3D=3D=3D &nbsp; &nbsp;
 &nbsp; &nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div><br></div><div=
>Bridge on AP is&nbsp;</div><div><br></div><div>br100 =3D &gt; eth0.100</di=
v><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ath0.100</div=
><div><br></div><div>So here in this setup station is sending DHCP Discover=
 to AP which is received on ath0.100 interface of bridge and it forwards th=
at request to eth0.100. eth0.100 adds its vlan tag and forward this request=
 to a managed switch which can understand vlan tags. then this this switch =
removed vlan tag and forwards this request to DHCP server. DHCP server then=
 replied to it with DHCP offer packet. DHCP offer is s Broadcast packet. Th=
is offer packet is received in eth0.100 but some how it is not forwarded on=
 ath0.100 so that station can also get this. I have verified it by using et=
hereal that DHCP offer packet is coming to eth0.100 interface but it is not=
 received in ath0.100. One more thing, this is not happening everytime. Thi=
s is happening
 sometime only.</div><div><br></div><div>So My problem is that like why bri=
dge is not forwarding this <span>DHCP</span> offer packet to ath0.100 somet=
ime. Can any body help me on this. Do let me know if you want any other det=
ail about setup.</div><div><br></div><div><span class=3D"Apple-style-span" =
style=3D"font-style: italic; ">With Regards&nbsp;</span></div><div><div><em=
><br><span>Rahul</span> Bhardwaj <br></em></div><br><div><em>&nbsp;</em></d=
iv></div></td></tr></table><br>=0A      <!--3--><hr size=3D1></hr> See the =
Web&#39;s breaking stories, chosen by people like you. Check out <a href=3D=
"http://in.rd.yahoo.com/tagline_buzz_1/*http://in.buzz.yahoo.com/" target=
=3D"_blank"> Yahoo! Buzz</a>.
--0-436994913-1247119688=:71383--
