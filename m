Message-ID: <737340.98464.qm@web8805.mail.in.yahoo.com>
Date: Wed, 2 Sep 2009 23:54:45 +0530 (IST)
From: rahul bhardwaj <rahul.bhardwaj@yahoo.co.in>
In-Reply-To: <258261.97611.qm@web8808.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1529428206-1251915885=:98464"
Subject: [Bridge] Bridge is not forwarding packet on correct vlan port <Help
	Needed>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Stephen Hemminger <shemminger@vyatta.com>

--0-1529428206-1251915885=:98464
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi=0AAll,=0A=0AI=0Aam facing one very strange problem with bridge in our wi=
reless Access Point.=0ALet me explain you my setup first. I have two Linux =
bridge br114 and br113 in=0Amy AP. Both the bridge have two vlan interfaces=
 under it, one Ethernet vlan=0Aiface (eth1.xx) and another one is radio vla=
n interface (ath0.xx). So now both=0Athe bridge will look like this=0A=0A=
=A0=0A=0Abr113=0A=A0=3D > eth1.113 + eth0.113=0A=0Abr114=0A=A0=3D > eth1.11=
4 + eth0.114=0A=0A=A0=0A=0AI=0Ahave connected two wireless stations with th=
is AP. Two stations (STA113 and STA114)=0Aare connected to br113. Now I am =
pinging to their respective DHCP server from=0Aall the three stations. This=
 is all about setup.=A0=0A=0A=A0=0A=0AAfter=0Asome time, ping from STA113 a=
nd STA114 stops for their respective DHCP server.=0AI have checked the ARP =
table and found that it has a valid entry so I think the=0Aproblem lies in =
bridge code. I think bridge is only dropping the packet and not=0Aforwardin=
g it to proper interface. At this time I have put some message in=0Abr_forw=
ard.c and found that it is putting the packet on same interface, I mean eth=
0.113=0Ato eth0.113, due to this should_deliver is falling and packet is ge=
tting=0Adropped. =0A=0A=A0=0A=0ACan=0Asomebody explain me something about t=
his behavior? I mean where I should look into=0Acode to solve this issue. I=
 am expecting some help on this because I am stuck=0Aon this. One more very=
 important thing, it happens when I am having two=0Abridges, things works f=
ine with single bridge. I mean it happen only when I=0Ahave both the bridge=
 br113 and br114. If I have only br113 then things are=0Aworking fine. =0A=
=0A=A0=0A=0AThanks=0Aand Regards,=0A=0A=A0=0A=0ARahul=0ABhardwaj=0A=0A=A0=
=0A=0A=0A      Love Cricket? Check out live scores, photos, video highlight=
s and more. Click here http://cricket.yahoo.com
--0-1529428206-1251915885=:98464
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><p class=3D"MsoNormal"><span style=3D"font-si=
ze:10.0pt;font-family:Arial;color:black">Hi=0AAll,<o:p></o:p></span></p>=0A=
=0A<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Arial=
;color:black">I=0Aam facing one very strange problem with bridge in our wir=
eless Access Point.=0ALet me explain you my setup first. I have two Linux b=
ridge br114 and br113 in=0Amy AP. Both the bridge have two vlan interfaces =
under it, one Ethernet vlan=0Aiface (eth1.xx) and another one is radio vlan=
 interface (ath0.xx). So now both=0Athe bridge will look like this<o:p></o:=
p></span></p>=0A=0A<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;f=
ont-family:Arial;color:black"><o:p>&nbsp;</o:p></span></p>=0A=0A<p class=3D=
"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Arial;color:black">=
br113=0A&nbsp;=3D &gt; eth1.113 + eth0.113<o:p></o:p></span></p>=0A=0A<p cl=
ass=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Arial;color:b=
lack">br114=0A&nbsp;=3D &gt; eth1.114 + eth0.114<o:p></o:p></span></p>=0A=
=0A<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Arial=
;color:black"><o:p>&nbsp;</o:p></span></p>=0A=0A<p class=3D"MsoNormal"><spa=
n style=3D"font-size:10.0pt;font-family:Arial;color:black">I=0Ahave connect=
ed two wireless stations with this AP. Two stations (STA113 and STA114)=0Aa=
re connected to br113. Now I am pinging to their respective DHCP server fro=
m=0Aall the three stations. This is all about setup.&nbsp;<o:p></o:p></span=
></p>=0A=0A<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-fami=
ly:Arial;color:black"><o:p>&nbsp;</o:p></span></p>=0A=0A<p class=3D"MsoNorm=
al"><span style=3D"font-size:10.0pt;font-family:Arial;color:black">After=0A=
some time, ping from STA113 and STA114 stops for their respective DHCP serv=
er.=0AI have checked the ARP table and found that it has a valid entry so I=
 think the=0Aproblem lies in bridge code. I think bridge is only dropping t=
he packet and not=0Aforwarding it to proper interface. At this time I have =
put some message in=0Abr_forward.c and found that it is putting the packet =
on same interface, I mean eth0.113=0Ato eth0.113, due to this should_delive=
r is falling and packet is getting=0Adropped. <o:p></o:p></span></p>=0A=0A<=
p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Arial;col=
or:black"><o:p>&nbsp;</o:p></span></p>=0A=0A<p class=3D"MsoNormal"><span st=
yle=3D"font-size:10.0pt;font-family:Arial;color:black">Can=0Asomebody expla=
in me something about this behavior? I mean where I should look into=0Acode=
 to solve this issue. I am expecting some help on this because I am stuck=
=0Aon this. One more very important thing, it happens when I am having two=
=0Abridges, things works fine with single bridge. I mean it happen only whe=
n I=0Ahave both the bridge br113 and br114. If I have only br113 then thing=
s are=0Aworking fine. <o:p></o:p></span></p>=0A=0A<p class=3D"MsoNormal"><s=
pan style=3D"font-size:10.0pt;font-family:Arial;color:black"><o:p>&nbsp;</o=
:p></span></p>=0A=0A<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;=
font-family:Arial;color:black">Thanks=0Aand Regards,<o:p></o:p></span></p>=
=0A=0A<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Ar=
ial;color:black"><o:p>&nbsp;</o:p></span></p>=0A=0A<p class=3D"MsoNormal"><=
span style=3D"font-size:10.0pt;font-family:Arial;color:black">Rahul=0ABhard=
waj<o:p></o:p></span></p>=0A=0A<p class=3D"MsoNormal"><span style=3D"font-s=
ize:10.0pt;font-family:Arial"><o:p>&nbsp;</o:p></span></p></td></tr></table=
><br>=0A      <!--3--><hr size=3D1></hr> See the Web&#39;s breaking stories=
, chosen by people like you. Check out <a href=3D"http://in.rd.yahoo.com/ta=
gline_buzz_1/*http://in.buzz.yahoo.com/" target=3D"_blank"> Yahoo! Buzz</a>=
.
--0-1529428206-1251915885=:98464--
