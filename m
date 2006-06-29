From: "Kirti S. Bajwa" <kbajwa@tibonline.net>
Date: Thu, 29 Jun 2006 10:34:12 -0400
Message-ID: <00e001c69b89$175eee40$20ed150c@SunShine>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00E1_01C69B67.904D4E40"
In-Reply-To: <44A37497.4010108@kingsley.co.za>
Subject: Re: [Bridge] Error in Bridge Settings!!
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

------=_NextPart_000_00E1_01C69B67.904D4E40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Etienne:

=20

Your response makes sense. In my case, if I enter the script manually, the
message goes away. That's why your response makes sense. Since the process
works, I am going to leave it to that.

=20

Thanks.

=20

Kirti

=20

-----Original Message-----
From: Etienne Pretorius [mailto:etiennep@kingsley.co.za]=20
Sent: Thursday, June 29, 2006 2:35 AM
To: Kirti S. Bajwa; bridge@lists.osdl.org
Subject: Re: [Bridge] Error in Bridge Settings!!

=20

Let me first explain that I have the same problem in my Ethernet bridge
setup.

What I have determined, that there is a loop in my network but STP is
preventing a packet broacast storm. I have switches instead of hubs but my
primary bridge is broadcasting packets somehow, because when I unplug the
primary's Ethernet from our internal network then those messages stop
appearing. I am in the process of re-setting up that bridge so that
*hopefully* I wont be seeing this message in future. I wander if it might be
the HUBs you using.... they might be broadcasting any packet to all ports
and so your bridge will receive its own packets back to it? Like I said - I
have the same problem, but the setup still works and I am trying to remove
loops in my network to see if that *really* is the cause to the error
message.



Kind Regards
Etienne


Kirti S. Bajwa wrote:=20

Hello Bridge List:

=20

Please help a newbie!

=20

I have setup two freshly installed CentOS 4.3 servers and have setup
redundant BRIDGE. My plan is to have the 'redundant' BRIDGE working and then
I will add 'Shorewall' Firewall to these two servers. On both machines, I
have included the following lines in '/etc/rc.local' so that the BRIDGE will
be ACTIVE after BOOT:

=20

/etc/rc.local

=3D=3D=3D=3D=3D=3D=3D=3D=3D

 # Setup BRIDGE (First Bridge)

 brctl   addbr       tibbr1

 brctl   addif        tibbr1  eth0

 brctl   addif        tibbr1  eth1

 ifconfig   tibbr1  up

 ifconfig   tibbr1  12.21.237.2   netmask   255.255.255.0

 brctl   setageing   tibbr1  300

 brctl   stp   tibbr1    on

 brctl   setbridgeprio   tibbr1   100

 brctl   setpathcost  tibbr1  eth0  100

 brctl   setpathcost  tibbr1  eth1  100

 reboot=20

=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D

Similar lines are included in the second server except the bridge name is
'tibbr2', IP addr is 12.21.237.4 & bridge & path costs are 200.

MAC addresses on each server are as follows:

=20

Server 1:

eth0: 00:80:ad:16:f3:25

eth1: 00:30:1b:38:c6:41

=20

Server 2:

eth0: 00:80:ad:16:e6:43

eth1: 00:30:1b:38:c4:c9

=20

PROBLEM:

-------------

When I boot one of the servers, I get the following errors:

=20

eth1: received packet with own address as source address

eth0: received packet with own address as source address

=20

What are these errors & why they are appearing?=20

=20

If I no-op (#) the following lines, the error disappear:

=20

# ifconfig   tibbr1  up

# ifconfig   tibbr1  12.21.237.2   netmask   255.255.255.0

=20

=20

FYI, my current hardware setup is as follows:

=20

                              T1 Line

                                     |

                      Cisco 26XX Router

                                     |

                                 HUB -------> HUB (Current Network)

                                     |

               ----------------------------

               |                  eth0                |=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20

             fw1                                   fw2=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20

               |                  eth1                |

              -----------------------------

                                     |

                                 HUB

                                     |

             (Future: additional Servers)

=20

Please HELP! How can I fix the settings so the above listed PROBLEM is
resolved!!

=20

Kirti

=20





  _____=20=20



=20
_______________________________________________
Bridge mailing list
Bridge@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/bridge
=20=20

------=_NextPart_000_00E1_01C69B67.904D4E40
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<DEFANGED_style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";
	color:black;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.EmailStyle19
	{font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</DEFANGED_style>

</head>

<body bgcolor=3Dwhite lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">Etienne:</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">Your response makes sense. In my case,=
 if
I enter the script manually, the message goes away. That&#8217;s why your
response makes sense. Since the process works, I am going to leave it to th=
at.</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">Thanks.</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">Kirti</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial;color:navy">&nbsp;</span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dblack
face=3DTahoma><span DEFANGED_style=3D"font-size:10.0pt;font-family:Tahoma;c=
olor:windowtext">-----Original
Message-----<br>
<b><span DEFANGED_style=3D"font-weight:bold">From:</span></b> Etienne Preto=
rius
[mailto:etiennep@kingsley.co.za] <br>
<b><span DEFANGED_style=3D"font-weight:bold">Sent:</span></b> </span></font=
><font size=3D2 color=3Dblack face=3DTahoma><span DEFANGED_style=3D"font-si=
ze:10.0pt;font-family:Tahoma;
 color:windowtext">Thursday, June 29, 2006</span></font><font size=3D2
color=3Dblack face=3DTahoma><span DEFANGED_style=3D"font-size:10.0pt;font-f=
amily:Tahoma;
color:windowtext"> </span></font><font size=3D2 color=3Dblack face=3DTahoma=
><span
 DEFANGED_style=3D"font-size:10.0pt;font-family:Tahoma;color:windowtext">2:=
35 AM</span></font><font
size=3D2 color=3Dblack face=3DTahoma><span DEFANGED_style=3D"font-size:10.0=
pt;font-family:Tahoma;
color:windowtext"><br>
<b><span DEFANGED_style=3D"font-weight:bold">To:</span></b> Kirti S. Bajwa;
bridge@lists.osdl.org<br>
<b><span DEFANGED_style=3D"font-weight:bold">Subject:</span></b> Re: [Bridg=
e] Error in
Bridge Settings!!</span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">&nbsp;</=
span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">Let me f=
irst explain that
I have the same problem in my Ethernet bridge setup.<br>
<br>
What I have determined, that there is a loop in my network but STP is
preventing a packet broacast storm. I have switches instead of hubs but my
primary bridge is broadcasting packets somehow, because when I unplug the
primary's Ethernet from our internal network then those messages stop
appearing. I am in the process of re-setting up that bridge so that *hopefu=
lly*
I wont be seeing this message in future. I wander if it might be the HUBs y=
ou
using.... they might be broadcasting any packet to all ports and so your br=
idge
will receive its own packets back to it? Like I said - I have the same prob=
lem,
but the setup still works and I am trying to remove loops in my network to =
see
if that *really* is the cause to the error message.<br>
<br>
</span></font></p>

<pre DEFANGED_style=3D"margin-left:.5in"><font size=3D2 color=3Dblack face=
=3D"Courier New"><span
DEFANGED_style=3D"font-size:10.0pt">Kind Regards</span></font></pre><pre DE=
FANGED_style=3D"margin-left:
.5in"><font size=3D2 color=3Dblack face=3D"Courier New"><span DEFANGED_styl=
e=3D"font-size:10.0pt">Etienne</span></font></pre>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt"><br>
Kirti S. Bajwa wrote: </span></font></p>

<div>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dblack
  face=3DArial><span DEFANGED_defanged_style=3D"font-size:10.0pt;&#13;&#10;=
  font-family:Arial"><span
  DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"><DEFANGED_style><!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
p.MsoAutoSig, li.MsoAutoSig, div.MsoAutoSig
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.emailstyle17
	{font-family:Arial;
	color:windowtext;}
span.EmailStyle20
	{font-family:Arial;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
--></DEFANGED_style>Hello</span></span></font><font size=3D2 face=3DArial><=
span
 DEFANGED_defanged_style=3D"font-size:10.0pt;font-family:Arial"><span DEFAN=
GED_style=3D"font-size:
 10.0pt;font-family:Arial"> </span></font><font size=3D2 face=3DArial><span
  DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">Bridge</span></span=
></font><font
size=3D2 face=3DArial><span DEFANGED_defanged_style=3D"font-size:10.0pt;fon=
t-family:Arial"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"> List:</span></span><=
/font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dblack
face=3DArial><span DEFANGED_defanged_style=3D"font-size:10.0pt;&#13;&#10;fo=
nt-family:Arial"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">&nbsp;</span></span><=
/font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dblack
face=3DArial><span DEFANGED_defanged_style=3D"font-size:10.0pt;&#13;&#10;fo=
nt-family:Arial"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">Please help a newbie!=
</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D2 c=
olor=3Dblack
face=3DArial><span DEFANGED_defanged_style=3D"font-size:10.0pt;&#13;&#10;fo=
nt-family:Arial"><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial">&nbsp;</span></span><=
/font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">I have setup two freshly installed Cent=
OS 4.3 servers
and have setup redundant BRIDGE. My plan is to have the &#8216;redundant&#8=
217;
BRIDGE working and then I will add &#8216;Shorewall&#8217; Firewall to these
two servers. On both machines, I have included the following lines in &#821=
6;/etc/rc.local&#8217;
so that the BRIDGE will be ACTIVE after BOOT:</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">/etc/rc.local</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">=3D=3D=3D=3D=3D=3D=3D=3D=3D</span></spa=
n></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><strong><b><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></font></b></strong><stron=
g><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue"># </span></span></font></b></strong></span><s=
trong><b><font
  color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"co=
lor:blue"><span
  DEFANGED_style=3D"color:blue">Setup</span></span></font></b></strong><str=
ong><b><font
 color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"col=
or:blue"><span
 DEFANGED_style=3D"color:blue"> </span></font></b></strong><strong><b><font=
 color=3Dblue
  face=3D"Times New Roman"><span DEFANGED_style=3D"color:blue">BRIDGE</span=
></span></font></b></strong><strong><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue"> (</span></span></font></b></strong><strong><=
b><font
  color=3Dred face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"col=
or:red"><span
  DEFANGED_style=3D"color:red">First</span></span></font></b></strong><stro=
ng><b><font
 color=3Dred face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:red"><span
 DEFANGED_style=3D"color:red"> </span></font></b></strong><strong><b><font =
color=3Dred
  face=3D"Times New Roman"><span DEFANGED_style=3D"color:red">Bridge</span>=
</span></font></b></strong><strong><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue">)</span></span></font></b></strong></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><strong><b><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></font></b></strong><stron=
g><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue">brctl &nbsp;&nbsp;addbr&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tibbr1</span></span></font></b></strong></spa=
n></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><strong><b><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></font></b></strong><stron=
g><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; addif&nbsp;&nbsp;&nbsp;&nbs=
p;
&nbsp;&nbsp;&nbsp;tibbr1 &nbsp;eth0</span></span></font></b></strong></span=
></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><strong><b><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></font></b></strong><stron=
g><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; addif&nbsp;&nbsp;&nbsp;&nbs=
p;
&nbsp;&nbsp;&nbsp;tibbr1 &nbsp;eth1</span></span></font></b></strong></span=
></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><strong><b><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></font></b></strong><stron=
g><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue">ifconfig&nbsp;&nbsp; tibbr1&nbsp; up</span></=
span></font></b></strong></span></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><strong><b><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></font></b></strong><stron=
g><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue">ifconfig&nbsp;&nbsp; tibbr1&nbsp; 12.21.237.2=
&nbsp;&nbsp;
netmask&nbsp;&nbsp; 255.255.255.0</span></span></font></b></strong></span><=
/p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><strong><b><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></font></b></strong><stron=
g><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; setageing&nbsp;&nbsp; tibbr=
1&nbsp; 300</span></span></font></b></strong></span></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><strong><b><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></font></b></strong><stron=
g><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; stp&nbsp;&nbsp; tibbr1&nbsp=
;&nbsp;&nbsp; on</span></span></font></b></strong></span></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><strong><b><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></font></b></strong><stron=
g><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; setbridgeprio&nbsp;&nbsp;
tibbr1&nbsp;&nbsp; 100</span></span></font></b></strong></span></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><strong><b><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></font></b></strong><stron=
g><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; setpathcost&nbsp; tibbr1&nb=
sp; eth0&nbsp;
100</span></span></font></b></strong></span></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><strong><b><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></font></b></strong><stron=
g><b><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue">brctl&nbsp;&nbsp; setpathcost&nbsp; tibbr1&nb=
sp; eth1&nbsp;
100</span></span></font></b></strong></span></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></font><b><font color=3Dbl=
ue><span
DEFANGED_defanged_style=3D"color:blue;&#13;&#10;font-weight:bold"><span DEF=
ANGED_style=3D"color:blue;
font-weight:bold">reboot</span></span></font></b><b><font color=3Dred><span
DEFANGED_defanged_style=3D"color:red"><span DEFANGED_style=3D"color:red;fon=
t-weight:bold"> </span></font></b></p>

</span></span>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">=3D=3D=3D=3D=3D=3D=3D=3D=3D</span></spa=
n></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">Similar lines are included in the secon=
d server except
the bridge name is &#8216;tibbr2&#8217;, IP addr is 12.21.237.4 &amp; bridge
&amp; path costs are 200.</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">MAC addresses on each server are as fol=
lows:</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">Server 1:</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">eth0: 00:80:ad:16:f3:25</span></span></=
font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">eth1: </span></span></font>00:30:1b:38:=
c6:41</p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">Server 2:</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">eth0: 00:80:ad:16:e6:43</span></span></=
font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">eth1: </span></span></font>00:30:1b:38:=
c4:c9</p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">PROBLEM:</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">-------------</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">When I boot one of the servers, I get t=
he following
errors:</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">eth1: received packet with own address =
as source
address</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">eth0: received packet with own address =
as source
address</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">What are these errors &amp; why they ar=
e appearing? </span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">If I no-op (#) the following lines, the=
 error
disappear:</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><strong><b><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt"># </span></font></b></strong><strong><b=
><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue">ifconfig&nbsp;&nbsp; tibbr1&nbsp; up</span></=
span></font></b></strong></span></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in" DEFANGED_defange=
d_style=3D"margin-left:.5in"><strong><b><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span DEFANGED_defanged_sty=
le=3D"font-size:12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt"># </span></font></b></strong><strong><b=
><font
color=3Dblue face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"colo=
r:blue"><span
DEFANGED_style=3D"color:blue">ifconfig&nbsp;&nbsp; tibbr1&nbsp; 12.21.237.2=
&nbsp;&nbsp;
netmask&nbsp;&nbsp; 255.255.255.0</span></span></font></b></strong></span><=
/p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">FYI, my current hardware setup is as fo=
llows:</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
T1 Line</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
|</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Cisco 26XX Router</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;|</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;HUB
-----</span></span></font><font face=3DWingdings><span DEFANGED_defanged_st=
yle=3D"font-family:Wingdings"><span
DEFANGED_style=3D"font-family:Wingdings">&agrave;</span></span></font> HUB =
(Current Network)</p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
|</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
----------------------------</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
eth0&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fw1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fw2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
eth1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;|</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-----------------------------</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
|</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
HUB</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
|</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(Future: additional Servers)</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">Please HELP! How can I fix the settings=
 so the above
listed PROBLEM is resolved!!</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10;12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">&nbsp;</span></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"margin-left:.5in"><font size=3D3 c=
olor=3Dblack
face=3D"Times New Roman"><span DEFANGED_defanged_style=3D"font-size:&#13;&#=
10; 12.0pt"><span
DEFANGED_style=3D"font-size:12.0pt">Kirt</span>i</span></font></p>

</div>

<pre DEFANGED_style=3D"margin-left:.5in" wrap=3D""><font size=3D2 color=3Db=
lack
face=3D"Courier New"><span DEFANGED_style=3D"font-size:10.0pt">&nbsp;</span=
></font></pre><pre
DEFANGED_style=3D"margin-left:.5in;text-align:center"><font size=3D2 color=
=3Dblack
face=3D"Courier New"><span DEFANGED_style=3D"font-size:10.0pt">

<hr size=3D4 width=3D"90%" align=3Dcenter>

</span></font></pre><pre DEFANGED_style=3D"margin-left:.5in"><font size=3D2=
 color=3Dblack
face=3D"Courier New"><span DEFANGED_style=3D"font-size:10.0pt">&nbsp;</span=
></font></pre><pre
DEFANGED_style=3D"margin-left:.5in"><font size=3D2 color=3Dblack face=3D"Co=
urier New"><span
DEFANGED_style=3D"font-size:10.0pt">_______________________________________=
________</span></font></pre><pre
DEFANGED_style=3D"margin-left:.5in"><font size=3D2 color=3Dblack face=3D"Co=
urier New"><span
DEFANGED_style=3D"font-size:10.0pt">Bridge mailing list</span></font></pre>=
<pre
DEFANGED_style=3D"margin-left:.5in"><font size=3D2 color=3Dblack face=3D"Co=
urier New"><span
DEFANGED_style=3D"font-size:10.0pt"><a href=3D"mailto:Bridge@lists.osdl.org=
">Bridge@lists.osdl.org</a></span></font></pre><pre
DEFANGED_style=3D"margin-left:.5in"><font size=3D2 color=3Dblack face=3D"Co=
urier New"><span
DEFANGED_style=3D"font-size:10.0pt"><a
href=3D"https://lists.osdl.org/mailman/listinfo/bridge">https://lists.osdl.=
org/mailman/listinfo/bridge</a></span></font></pre><pre
DEFANGED_style=3D"margin-left:.5in"><font size=3D2 color=3Dblack face=3D"Co=
urier New"><span
DEFANGED_style=3D"font-size:10.0pt">&nbsp; </span></font></pre></div>

</body>

</html>

------=_NextPart_000_00E1_01C69B67.904D4E40--
