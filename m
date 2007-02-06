Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C749BA.89B149D7"
Date: Tue, 6 Feb 2007 12:16:32 +0530
Message-ID: <CE677D1BAD605E40B22AE0704FE6DCAE03CCC0E6@blamsg001.corp.satyam.ad>
From: "Suraj_Budha" <Suraj_Buddha@satyam.com>
Subject: [Bridge] Bridge not working for 2.4.21 kernel
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C749BA.89B149D7
Content-Type: multipart/alternative; boundary="----------=_1170744434-1695-521"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1170744434-1695-521
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello All,

=20

Hope someone will address my problem.

I configured my Linux box (2.4.21 kernel) with the
ebtables-brnf-10_vs_2.4.21 patch.

I had installed the bridge-utils package also.

As soon as the I type the following commands, it hangs

#ifconfig eth0 0.0.0.0

#ifconfig eth1 0.0.0.0

#brctl addbr br0

#brctl addif br0 eth0

#brctl addif br0 eth1

#ifconfig br0 up

=20

The following scenario explains my setup:

=20

=20

Thank in advance.

Any help will be highly appreciated.

=20

=20

Regards,

Suraj



DISCLAIMER:
This email (including any attachments) is intended for the sole use of the =
intended recipient/s and may contain material that is CONFIDENTIAL AND PRIV=
ATE COMPANY INFORMATION. Any review or reliance by others or copying or dis=
tribution or forwarding of any or all of the contents in this message is ST=
RICTLY PROHIBITED. If you are not the intended recipient, please contact th=
e sender by email and delete all copies; your cooperation in this regard is=
 appreciated.

------------=_1170744434-1695-521
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html DEFANGED_xmlns:v=3D"urn:schemas-microsoft-com:vml" DEFANGED_xmlns:o=
=3D"urn:schemas-microsoft-com:office:office" DEFANGED_xmlns:w=3D"urn:schema=
s-microsoft-com:office:word" DEFANGED_xmlns=3D"http://www.w3.org/TR/REC-htm=
l40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<DEFANGED_style=20
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
></DEFANGED_style>
<![endif]-->
<DEFANGED_style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</DEFANGED_style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Hello All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Hope someone will address my problem.<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">I configured my Linux box (2.4.21 kernel) with the
ebtables-brnf-10_vs_2.4.21 patch.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">I had installed the bridge-utils package also.<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">As soon as the I type the following commands, it hangs<o=
:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">#ifconfig eth0 0.0.0.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">#ifconfig eth1 0.0.0.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">#brctl addbr br0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">#brctl addif br0 eth0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">#brctl addif br0 eth1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">#ifconfig br0 up<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">The following scenario explains my setup:<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><img width=3D"576" height=3D"336" id=3D"_x0000_i1029"
DEFANGED_src=3D"cid:image002.gif@01C749E6.1F0B52D0"><o:p></o:p></span></fon=
t></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Thank in advance.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Any help will be highly appreciated.<o:p></o:p></span></=
font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Suraj<o:p></o:p></span></font></p>

</div>

<p></p><p>DISCLAIMER:<br>This email (including any attachments) is intended=
 for the sole use of the intended recipient/s and may contain material that=
 is CONFIDENTIAL AND PRIVATE COMPANY INFORMATION. Any review or reliance by=
 others or copying or distribution or forwarding of any or all of the conte=
nts in this message is STRICTLY PROHIBITED. If you are not the intended rec=
ipient, please contact the sender by email and delete all copies; your coop=
eration in this regard is appreciated..</body>

</html>

------------=_1170744434-1695-521--

------_=_NextPart_001_01C749BA.89B149D7
Content-Type: image/gif;
	name="image002.gif"
Content-Transfer-Encoding: base64
Content-ID: <image002.gif@01C749E6.1F0B52D0>
Content-Description: image002.gif
Content-Location: image002.gif
Content-Disposition: inline

R0lGODlhQAJQAXcAMSH+GlNvZnR3YXJlOiBNaWNyb3NvZnQgT2ZmaWNlACH5
BAEAAAAALBgAJADKAf0AhQAAAAAAAAkJCQQEBAwMDBISEg0NDRUVFRQUFBMT
ExAQEA8PDwMDAx0dHR8fHxEREQoKChkZGSwsLDMzMyYmJjExMTAwMCIiIisr
K1hYWH9/f3BwcGBgYI+Pj7+/v6enp9/f3////wECAwECAwECAwECAwECAwEC
AwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwEC
AwECAwECAwECAwECAwECAwECAwECAwECAwECAwb/QEFgSCwaj8ikcslsOp/Q
qHRKrVqv2Kx2y+16l4CweBwOhM7otHrNbrvf8Lh8Tq/b7/i8fs/v+/+AgYJt
GWSGZYOJiouMjY6PkJGSk3YZAYdkZpSbnJ2en6ChooGFmGOao6mqq6ytrq9q
lqZiqLC2t7i5urtrpbMAtbzCw8TFxqSXv8HHzM3Oz8O+s8vQ1dbX2JSyytnO
RSGa1H1E4HLibOdo5Gnr7O3g6Xbx3aLSpvP0trVDi6j8gP/c+GN3Zh+6gvkS
bpuWkNgyfHiCQSQoEI7BcuoyqrnYEJs9TBM7jqIWsk7JgxXphKP4TSNCkdcW
3oOpK92+gPAknsOZsyc5/3/r2pnh2WalS5cc3d0cyG+pUpqRPh46CZXTzoEY
s2K1yZFpV43/4l0kijHpS6zlgqI1SrXqHZkg3ep7g/boy7tFkYKlmFVvSnd9
99oNnDMsXyN45TKSaqitYkg2AQ82izKtZbx17+78uxEzOspf15B9DAjuVNKu
HibWKpqvXaaX+2ZmXbk2S9edV4e2jfoP40y9W+02Srvs56Nhkw6lPVu25NaC
c6/1rPlscEGmG1/fzr079l+IvIsfTz5OduDl06sn//vU+vfwg593H7++fZrt
xQj5wr+///8ABijggAQWaGAUA4Cn4IIMNujgNA9GKOGEFEaYTIUYUnhhhhx2
6P8hhB+GKOKIGpJo4okPboiiiCqu6OKLLb4o44wp0mijiTHeKGGOOva4o49A
BgmMkERaWKSRRyapjJJMkshjk0c+CSUtU1YpZZVYKnhllj1uCaWXXNIIZphk
jkmmi2YmmeaZJ67J5pRuvjlinELSKaeHdt5JZJ56Yshnl336+GeggBKq46A3
Impog4ouCqOjYurZKKRLUlqmpTJOmimmaHKapaaeniJpqG2SaqWpOI6KKour
Mgmqqa+uGGuos7b6o60f1poqrh3qyuuCvloaLKu/ZjhssSAiW+GxuSq7rLOC
Qjshs3hKe6u1NlL7ZozactjtpY1hm20mQ4hbhorf+kn/brquomtupLSU+y4R
Q5ahKjDymmsEle8+ioS+R9Qr5yX/ivsvu8oeqDCAAm+78MNeNNxvqfgWMe++
CE97rsUAW5xxsRvSe7G7d14ocseZTNwpuQCHW3JjHxfZYsy80nymzYyqDB7O
q/L86b06gxQ0ij7//PLQQiM9p9JTAc20vU+HWDSWU1caNdRXe5s11ttuLbHX
GntddbJXj82p2a46/TTamNpJgAQTxC333HTXbffdeOctd4IUD1whBXoHLvjg
dwtANNjqUmgACK8c0HfXFCLgwSsTPI74tRIu3vjhR0soOeWxsk2pnZq74viu
fkc+uSuVo3455hGW3srprrNp/+fqrUwQ+uthTyg7K7Qv3bnnuLPSupO89545
46ZznjrxoFuePLAV/r5K8MQ+Dz3r0k+vZfXMi4YTYgV901JLq7WRgPOQT1j8
U+qgj9j5Qo2mhu7de0927OHzJhF1mLGfGtZXu5tVqADvyw1uiOMcv7zheMLT
H4NI1z/xKbA4DcSNGwhYQHBJCIF0+Z8DM0hCNuCvgxJMmu8q2BnlHEaDEOFg
BNv3wQQSxIUj3MwD85fCpimOhbcBYANJMgcZztB2FbJhdHBoHc6YcHc93Bn4
6LJEBRoGOnEwotTU5iAQ/oU4IoRH+saYBghmL4r7e5D1rFidFhoHi3DQ4haH
9yAv5v+liYRZDgM1+EQeopFr/KNiRmaznNjwkQ1yrBYd66hEzxDSOESUgxnn
+Md7TNGJAVHNSiKZRfYhkUKNDEwmW7NJOMLhhMirpAqXJ8ggwlEcMfQj1Q4Y
StUQRoi4XMMkm6XKVQayebI81YQ+xzoo9jJlP9wcCrlkJ2LmLphopKAyl2k0
90WPmn+UJjBTqb0IOdN40IyiNmfnSQMOM5SgQOURj/k1BxngAx6IpzznSc96
2vOe+MynPBUQziY1swP6DKhAB3pPCvQzhXlCAAAUytCFOrShEH2oRCNK0Yla
tKHl9KDnLsrRinq0oyDF6EH1J7oocVFpJYVUSmV2UqSt1FD/Lw1STGMKJJoG
yqbRWiTTcKpTlLZ0aDztqU+FClR2IjNrMxWbUY+K1J8GLag0jFpStwbVqErV
qTqrqjmbStSnkooBhAurWPXWgAqM9ax445uO3obWuDnAAm2Nq1zn9ta4Gu5v
c81rWy8AN736dW4PyJNjEoI9Gq1RPbts0Dfvw4b8AEs8hZ3RYdOjzgctlrGx
ECxkfTTZ8iSWQZfFLBocq6XN9qiz5Knsg9B5n/lM0LQ6Qu14Prug0Io2BKTd
GWxvJFvxqFaxrLWPax/rncjKqLfeoa2CbCva3HKjuJwFImVvd9vGarYoo3mH
Re4YkUco9LTS1W788HGEVppyFMoF/48dN5JdAZ73lnEQLyucy5AQWlAlgxVf
fufw3dhKt3z3Vclg4rtfRfyWQesNcPzkUWAMtmK4pbUve+UxiAbDob+8/a8Y
J2ySQ5o3Fen9RYI5/BwB+4EyqqDvTKhokJJYeMCDwLCNUFtIhLjYw05EL3Ur
0uI7vBjGo4Cwbll8Q/iVzyts5Il4f9wGGRtWwzWOzU/IUpehRBnAQKkfk+MQ
4lmMuMiDZK9TbPwVJWcXFiqOiyBh08atgDEcV3TwltfgZMlCuTq7EXMmkyMd
MI7wEQde0JerGBo3nwXOftaNLYT83JSw5b62zOBa0EfGQNT5uHd+Y55dU2VO
t7Ewc3ZDl/9NMegm7hHAeXTgpLUbalIYa7uaBsypO/1pHTbi0i+isandyF08
kjDR8AX0ju/4aFkrutZ/BnKKr/vF6fj608VpTqUBgWsX6RrVogy2CJmolfF1
YtSYKHW3kRMdVZv7vQ9+tXmdHWdgR/vPrUZDtVd0bWhj+5XkZklTKhNvXdJJ
3HmGc5vP/e4SroLR9f1MUEDtE0QfuScNt3KWxeyIeaNosuSTuLcVLr/k6KQs
lJZvI8B9iEFnnOENf3jEV67l8Yo8yOrujnFzreEONyKM3x52dUfLbO7M3No1
n0O/s/0JkhuCuZhN82mgC14+uDcQ5Cs6nZDOWISvWObRtY/RyUD/9dbG3OdZ
r0+gFxTc+lhdzVhvutgr1HXhfn07P6d30JM79bLH5+xLT7t/tc52u8NH6dph
+t7FrvOd47bncA97fLY+hrab/e3XifvF596dsYPH8XdHfOQVDx/GiwHzf4d8
cCR/IuRWvvA7x3vg9Z5hvqvO8GkAPHpYP2PKc8fyvwD9e1Q/e7CrffF9h/1o
Rd8b0pvI9LdHfXV5Tx/aP9n15xT+GWTffN8PfvF1l/7h/bTb2kN/e8KnPi26
/3zCJ1H7zB+/4Fu/9tdLX/zhcb6dtZ7992t+9Jx/j+fDoPv1wB8Y5Dd/5gdK
6Hd/xZd/67F/C+V3u0d8qGF8JIJ824F7/7PQf+qRfmWgARq4gRzYgR74gSAY
giI4giRYgiaogRDAWRtwgizYgi74gjBYghHAdhwQgzZ4gziYgyeIAVpDMEPi
g0D4g0IYhEQ4hEZYhEh4hEqYhEwoU0v4hE0YhVA4hVJYhVQohOpihVp4hVvY
hVz4hU24VGI4hmRYhmZ4hmiYhmq4hmzYhm74hnAYh3I4h3RYh3Z4h3iYh3q4
h3zYh374h4AYiII4iIRYiIZ4iIiYiIq4iIzYiI74iJAYiZI4iZRYiZZ4iZiY
iZq4iZzYiZ74iaAYiqI4iqRYiqZ4iqiYiqq4iqzYiq74irAYi7I4i7RYi8fk
hbgIhrqYi7y4i/++2IvA+ItGyIoGsII6eIzImIzKuIzM2IwaEAFa1UsSqH1Q
oYCWOI3UCBMU+InYmI0dYY2V2I3emBDb6IniOI70AI6UeI7omA3l2Ins2I7X
oI6TiHGUJnS80Wv6qGy3MHQgFo2qVG8m4RhPh13FUJDPQI+SKJCwNm0N6WPG
EGnW8I6cyJDrtgcEGZHo1gwKGYn1ZmUcR2acRmUbJpIftxQep3ArB3EtpBNj
tmAueRMCYRhEUZMtNmcUuYnXtnCvxBZbcRwgJ3BgwW4DRpSJwZPM4Rc1KR0o
IXHUMRYqt2UdCYkfWZQvZG8XxEC0xhz3iGwod5Uod3KT4WkXVHC+ppX/g5CT
mliV6TMcJUaWAaeU8WUZ0uaVMHSX+UZiznaWudQHU/mIbHlLblmWTwmWsjFK
26VHyraXY9mYfYlHtAaV/IgHapmJgUlEwPaTWLSVQXls8MVnybaXmalyYfZs
u1aYS3RqfvCXjmiP5bVkDjdlDoddE8eSYpRlexYZR2mTTkmatnmbClaSFLeS
93ZvIJkIlYmJ8SgchFke8caajbicrIBz6vGcAFlJ0jmdXemcCJkH0MmI2SmP
zpCclxie4skM37mI5nmexkCe12h77NkN6amIpuePDklh3TWQKLlJsoloKKYH
cxYS7hmOc9ed42CfEoafZPlrRnagiWCg85mI/531n4oAEUxGoQkKbdx2nyZW
YXUwoOv4XxjqoeZAohzKa/bGmSdaog/6oa3omvw5nC0poyw5mxBHP5x0nHom
kg3qSpkhmc1JmjoKkyoppMKJZR96nX80oZLBmDcql6c5cKaZkoLZpMmWlKmG
apyUZHEGctDhZ0jppXQQoYjIpKrWlWbRpTamZ+62mVZ5pvKlmZj5RkG6YGaZ
pS43mpNZRkqKRmZql7UBFHQ6XoQpk/z2poAaqINamldGRvt2pyTxSBrqosQo
omCpm5B5bKDxXk4KQHW5m20JSfmIpRikQ5GmoqfUp1HEpHqaR4nWbnxpHYWU
o1bZqlu6pr0GS8Tmbv82GqW86pun9KIiGpu5eRDj0xSzqRY2SqUUJ5uQhqy1
qRTeZmuCSWXQCq3GRqPKapuPOgcgWo/wqaDxaQtkeojriWPj+o+VWqEGmq6c
UK6GeK7uqgvfupDhOq8JKaz4Wo2q2kPyuq/kqq8AKxL16pGWGpHHunDmo6y9
Cnzr2g0SyZmdmoD9mkL1ORIMxkZ5Warfl4oXKwo3tmmouqLXUbBUebCFoV9G
NqRmFq1HZqhNCW+utJGpJbAKRquswWpSOmtMeaiLOm6feR8mC5goG2wbJpFD
VKcburPG+rNG61k2i2/HwbMLeqyKiqiXMaeGRLLJ97BXq7FIm6aFuqALpJq2
s0p0jAWvhfinWyuUmumjUVqaTptq1IpzCFoNQ9ua4bVnKkulsLmy1kpi0tpj
ucqmdwsNakuI/zqwxeS1jJsPiTuIi/u4q5C30XmvlDsMkSuIk5u5Oua4njuP
URu6E1mxEtS5pFt0o5u6CWm6+oO6rPuuqxu76Om63gO7tDsJmxuIuJu7kWC5
4Im5vss9oDu8xQC8i8hWf7W8zNu8zvu80ItWd8WKwVi9wmi92Hu92pu91uss
QQAAOw==

------_=_NextPart_001_01C749BA.89B149D7--
