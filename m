From: Shawn Delaney <sdelaney@juniper.net>
Date: Mon, 22 Mar 2010 11:58:39 -0700
Message-ID: <DBDEC20E6E29304D8AE5EAA493609B3556AE2C7F28@EMBX02-HQ.jnpr.net>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DBDEC20E6E29304D8AE5EAA493609B3556AE2C7F28EMBX02HQjnprn_"
MIME-Version: 1.0
Subject: [Bridge] bridge and ip addresses on enslaved interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

--_000_DBDEC20E6E29304D8AE5EAA493609B3556AE2C7F28EMBX02HQjnprn_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

In the documentation I've seen so far a bridge is created with no IP addres=
s for its enslaved interfaces and optionally with an IP address on the brid=
ge interface. For example, I create a bridge like so:

brctl addbr br0
brctl addif br0 eth0
brctl addif br0 eth1

ifconfig eth0 0.0.0.0
ifconfig eth1 0.0.0.0
ifconfig br0 10.0.0.10 netmask 255.255.0.0


This works fine. However if I do the following:

ifconfig eth0 10.0.0.10 netmask 255.255.0.0
ifconfig eth1 10.1.0.10 netmask 255.255.0.0
ifconfig br0 0.0.0.0

the bridge gets created but I can't ping the IP addresses of the enslaved i=
nterfaces. With the above configuration I am assuming that the enslaved int=
erfaces still behave independently of the bridge, can be assigned IP addres=
ses and participate in routes. My question is whether this is supported and=
 if I should expect it to work. If so, can someone point me to an example?

Thanks.




--_000_DBDEC20E6E29304D8AE5EAA493609B3556AE2C7F28EMBX02HQjnprn_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
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
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>In the documentation I&#8217;ve seen so far a bridge is
created with no IP address for its enslaved interfaces and optionally with =
an
IP address on the bridge interface. For example, I create a bridge like so:=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>brctl addbr br0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>brctl addif br0 eth0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>brctl addif br0 eth1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>ifconfig eth0 0.0.0.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>ifconfig eth1 0.0.0.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>ifconfig br0 10.0.0.10 netmask 255.255.0.0<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>This works fine. However if I do the following:<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>ifconfig eth0 10.0.0.10 netmask 255.255.0.0<o:p></o:p></=
span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>ifconfig eth1 10.1.0.10 netmask 255.255.0.0<o:p></o:p></=
span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>ifconfig br0 0.0.0.0 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>the bridge gets created but I can&#8217;t ping the IP
addresses of the enslaved interfaces. With the above configuration I am
assuming that the enslaved interfaces still behave independently of the bri=
dge,
can be assigned IP addresses and participate in routes. My question is whet=
her this
is supported and if I should expect it to work. If so, can someone point me=
 to
an example?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Thanks.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

--_000_DBDEC20E6E29304D8AE5EAA493609B3556AE2C7F28EMBX02HQjnprn_--
