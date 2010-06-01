From: "Singh, Animesh" <Animesh.Singh@lsi.com>
Date: Tue, 1 Jun 2010 15:08:19 +0530
Message-ID: <B56B1B98C23D084F9E69AFCF8A51D84B0292E01363@inbmail02.lsi.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_B56B1B98C23D084F9E69AFCF8A51D84B0292E01363inbmail02lsic_"
MIME-Version: 1.0
Subject: [Bridge] Multicasting and Bridged networking issue
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@osdl.org" <bridge@osdl.org>

--_000_B56B1B98C23D084F9E69AFCF8A51D84B0292E01363inbmail02lsic_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
    Have been experimenting with bridged networking in order to connect VMs=
 located on separate physical machines. Unicast communication works fine bu=
t multicast traffic in not being forwarded beyond the bridge. Looking at th=
e code am reaching the conclusion that bridge treats multicast traffic in s=
ame way as broadcast, so why the multicast traffic is not flowing beyond th=
e bridge. Also does kernel tunable like mc_forwarding have any significance=
 in this matter? On the later version of linux 2.6.18 and after am finding =
this tunable as read-only (and set to 0). The kernel being used has CONFIG_=
IP_MROUTE enabled but its not running mrouted.


Regards Animesh

--_000_B56B1B98C23D084F9E69AFCF8A51D84B0292E01363inbmail02lsic_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
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
font-family:Arial'>Hi, <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; Have been experimenting with bridged =
networking in order
to connect VMs located on separate physical machines. Unicast communication
works fine but multicast traffic in not being forwarded beyond the bridge. =
Looking
at the code am reaching the conclusion that bridge treats multicast traffic=
 in
same way as broadcast, so why the multicast traffic is not flowing beyond t=
he
bridge. Also does kernel tunable like mc_forwarding have any significance i=
n
this matter? On the later version of linux 2.6.18 and after am finding this
tunable as read-only (and set to 0). The kernel being used has CONFIG_IP_MR=
OUTE
enabled but its not running mrouted. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Regards Animesh<o:p></o:p></span></font></p>

</div>

</body>

</html>

--_000_B56B1B98C23D084F9E69AFCF8A51D84B0292E01363inbmail02lsic_--
