Message-ID: <44A37497.4010108@kingsley.co.za>
Date: Thu, 29 Jun 2006 08:35:03 +0200
From: Etienne Pretorius <etiennep@kingsley.co.za>
MIME-Version: 1.0
References: <00ae01c69abf$5f9ec6f0$20ed150c@SunShine>
In-Reply-To: <00ae01c69abf$5f9ec6f0$20ed150c@SunShine>
Content-Type: multipart/alternative;
	boundary="------------050407010908020609090404"
Subject: Re: [Bridge] Error in Bridge Settings!!
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Kirti S. Bajwa" <kbajwa@tibonline.net>, bridge@lists.osdl.org

This is a multi-part message in MIME format...

--------------050407010908020609090404
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Let me first explain that I have the same problem in my Ethernet bridge=20
setup.

What I have determined, that there is a loop in my network but STP is=20
preventing a packet broacast storm. I have switches instead of hubs but=20
my primary bridge is broadcasting packets somehow, because when I unplug=20
the primary's Ethernet from our internal network then those messages=20
stop appearing. I am in the process of re-setting up that bridge so that=20
*hopefully* I wont be seeing this message in future. I wander if it=20
might be the HUBs you using.... they might be broadcasting any packet to=20
all ports and so your bridge will receive its own packets back to it?=20
Like I said - I have the same problem, but the setup still works and I=20
am trying to remove loops in my network to see if that *really* is the=20
cause to the error message.

Kind Regards
Etienne


Kirti S. Bajwa wrote:
>
> Hello Bridge List:
>
> =20
>
> Please help a newbie!
>
> =20
>
> I have setup two freshly installed CentOS 4.3 servers and have setup=20
> redundant BRIDGE. My plan is to have the 'redundant' BRIDGE working=20
> and then I will add 'Shorewall' Firewall to these two servers. On both=20
> machines, I have included the following lines in '/etc/rc.local' so=20
> that the BRIDGE will be ACTIVE after BOOT:
>
> =20
>
> /etc/rc.local
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ** # ****Setup**** ****BRIDGE**** (****First**** ****Bridge****)**
>
> ** brctl   addbr       tibbr1**
>
> ** brctl   addif        tibbr1  eth0**
>
> ** brctl   addif        tibbr1  eth1**
>
> ** ifconfig   tibbr1  up**
>
> ** ifconfig   tibbr1  12.21.237.2   netmask   255.255.255.0**
>
> ** brctl   setageing   tibbr1  300**
>
> ** brctl   stp   tibbr1    on**
>
> ** brctl   setbridgeprio   tibbr1   100**
>
> ** brctl   setpathcost  tibbr1  eth0  100**
>
> ** brctl   setpathcost  tibbr1  eth1  100**
>
>  *reboot *
>
> =20
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Similar lines are included in the second server except the bridge name=20
> is 'tibbr2', IP addr is 12.21.237.4 & bridge & path costs are 200.
>
> MAC addresses on each server are as follows:
>
> =20
>
> Server 1:
>
> eth0: 00:80:ad:16:f3:25
>
> eth1: 00:30:1b:38:c6:41
>
> =20
>
> Server 2:
>
> eth0: 00:80:ad:16:e6:43
>
> eth1: 00:30:1b:38:c4:c9
>
> =20
>
> PROBLEM:
>
> -------------
>
> When I boot one of the servers, I get the following errors:
>
> =20
>
> eth1: received packet with own address as source address
>
> eth0: received packet with own address as source address
>
> =20
>
> What are these errors & why they are appearing?
>
> =20
>
> If I no-op (#) the following lines, the error disappear:
>
> =20
>
> **# ifconfig   tibbr1  up**
>
> **# ifconfig   tibbr1  12.21.237.2   netmask   255.255.255.0**
>
> =20
>
> =20
>
> FYI, my current hardware setup is as follows:
>
> =20
>
>                               T1 Line
>
>                                      |
>
>                       Cisco 26XX Router
>
>                                      |
>
>                                  HUB -----=E0 HUB (Current Network)
>
>                                      |
>
>                ----------------------------
>
>                |                  eth0  =20
>              |                  =20
>
>              fw1                                   fw2            =20
>
>                |                  eth1                |
>
>               -----------------------------
>
>                                      |
>
>                                  HUB
>
>                                      |
>
>              (Future: additional Servers)
>
> =20
>
> Please HELP! How can I fix the settings so the above listed PROBLEM is=20
> resolved!!
>
> =20
>
> Kirti
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
>  =20

--------------050407010908020609090404
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Let me first explain that I have the same problem in my Ethernet bridge
setup.<br>
<br>
What I have determined, that there is a loop in my network but STP is
preventing a packet broacast storm. I have switches instead of hubs but
my primary bridge is broadcasting packets somehow, because when I
unplug the primary's Ethernet from our internal network then those
messages stop appearing. I am in the process of re-setting up that
bridge so that *hopefully* I wont be seeing this message in future. I
wander if it might be the HUBs you using.... they might be broadcasting
any packet to all ports and so your bridge will receive its own packets
back to it? Like I said - I have the same problem, but the setup still
works and I am trying to remove loops in my network to see if that
*really* is the cause to the error message.<br>
<pre class="moz-signature" DEFANGED_cols="72">Kind Regards
Etienne</pre>
<br>
Kirti S. Bajwa wrote:
<blockquote cite="mid00ae01c69abf$5f9ec6f0$20ed150c@SunShine"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta name="Generator" content="Microsoft Word 10 (filtered)">
  <DEFANGED_style>
<!--
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
--></DEFANGED_style>
  <div class="Section1">
  <p class="MsoNormal"><font face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;
  font-family:Arial">Hello</span></font><font
 face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:Arial"> </span></font><font
 face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:Arial">Bridge</span></font><font
 face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:Arial"> List:</span></font></p>
  <p class="MsoNormal"><font face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;
font-family:Arial">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;
font-family:Arial">Please help a
newbie!</span></font></p>
  <p class="MsoNormal"><font face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;
font-family:Arial">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">I have setup two freshly installed
CentOS 4.3 servers and have setup
redundant BRIDGE. My plan is to have the &#8216;redundant&#8217; BRIDGE working
and then I will add &#8216;Shorewall&#8217; Firewall to these two servers. On
both machines, I have included the following lines in
&#8216;/etc/rc.local&#8217; so that the BRIDGE will be ACTIVE after BOOT:</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">/etc/rc.local</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">=========</span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><strong><b><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;<font
 color="blue"><span DEFANGED_defanged_style="color:blue"># </span></font></span></font></b></strong><strong><b><font
 color="blue" face="Times New Roman"><span DEFANGED_defanged_style="color:blue">Setup</span></font></b></strong><strong><b><font
 color="blue" face="Times New Roman"><span DEFANGED_defanged_style="color:blue">
  </span></font></b></strong><strong><b><font color="blue"
 face="Times New Roman"><span DEFANGED_defanged_style="color:blue">BRIDGE</span></font></b></strong><strong><b><font
 color="blue" face="Times New Roman"><span DEFANGED_defanged_style="color:blue">
(</span></font></b></strong><font color="red"><span
 DEFANGED_defanged_style="color:red"><strong><b><font face="Times New Roman">First</font></b></strong></span></font><strong><b><font
 color="red" face="Times New Roman"><span DEFANGED_defanged_style="color:red"> </span></font></b></strong><strong><b><font
 color="red" face="Times New Roman"><span DEFANGED_defanged_style="color:red">Bridge</span></font></b></strong><strong><b><font
 color="blue" face="Times New Roman"><span DEFANGED_defanged_style="color:blue">)</span></font></b></strong></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><strong><b><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;<font
 color="blue"><span DEFANGED_defanged_style="color:blue">brctl &nbsp;&nbsp;addbr&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tibbr1</span></font></span></font></b></strong></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><strong><b><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;<font
 color="blue"><span DEFANGED_defanged_style="color:blue">brctl&nbsp;&nbsp; addif&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;tibbr1 &nbsp;eth0</span></font></span></font></b></strong></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><strong><b><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;<font
 color="blue"><span DEFANGED_defanged_style="color:blue">brctl&nbsp;&nbsp; addif&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;tibbr1 &nbsp;eth1</span></font></span></font></b></strong></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><strong><b><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;<font
 color="blue"><span DEFANGED_defanged_style="color:blue">ifconfig&nbsp;&nbsp; tibbr1&nbsp; up</span></font></span></font></b></strong></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><strong><b><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;<font
 color="blue"><span DEFANGED_defanged_style="color:blue">ifconfig&nbsp;&nbsp; tibbr1&nbsp;
12.21.237.2&nbsp;&nbsp;
netmask&nbsp;&nbsp; 255.255.255.0</span></font></span></font></b></strong></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><strong><b><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;<font
 color="blue"><span DEFANGED_defanged_style="color:blue">brctl&nbsp;&nbsp; setageing&nbsp;&nbsp;
tibbr1&nbsp; 300</span></font></span></font></b></strong></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><strong><b><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;<font
 color="blue"><span DEFANGED_defanged_style="color:blue">brctl&nbsp;&nbsp; stp&nbsp;&nbsp; tibbr1&nbsp;&nbsp;&nbsp;
on</span></font></span></font></b></strong></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><strong><b><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;<font
 color="blue"><span DEFANGED_defanged_style="color:blue">brctl&nbsp;&nbsp; setbridgeprio&nbsp;&nbsp;
tibbr1&nbsp;&nbsp; 100</span></font></span></font></b></strong></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><strong><b><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;<font
 color="blue"><span DEFANGED_defanged_style="color:blue">brctl&nbsp;&nbsp; setpathcost&nbsp;
tibbr1&nbsp; eth0&nbsp;
100</span></font></span></font></b></strong></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><strong><b><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;<font
 color="blue"><span DEFANGED_defanged_style="color:blue">brctl&nbsp;&nbsp; setpathcost&nbsp;
tibbr1&nbsp; eth1&nbsp;
100</span></font></span></font></b></strong></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;<b><font
 color="blue"><span DEFANGED_defanged_style="color:blue;
font-weight:bold">reboot</span></font><font
 color="red"><span DEFANGED_defanged_style="color:red"> </span></font></b></span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">=========</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">Similar lines are included in the
second server except the bridge name
is &#8216;tibbr2&#8217;, IP addr is 12.21.237.4 &amp; bridge &amp; path costs are
200.</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">MAC addresses on each server are as
follows:</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">Server 1:</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">eth0: 00:80:ad:16:f3:25</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">eth1: </span></font>00:30:1b:38:c6:41</p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">Server 2:</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">eth0: 00:80:ad:16:e6:43</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">eth1: </span></font>00:30:1b:38:c4:c9</p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">PROBLEM:</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">-------------</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">When I boot one of the servers, I
get the following errors:</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">eth1: received packet with own
address as source address</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">eth0: received packet with own
address as source address</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">What are these errors &amp; why
they are appearing? </span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">If I no-op (#) the following lines,
the error disappear:</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><strong><b><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">#
  <font color="blue"><span DEFANGED_defanged_style="color:blue">ifconfig&nbsp;&nbsp;
tibbr1&nbsp; up</span></font></span></font></b></strong></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><strong><b><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">#
  <font color="blue"><span DEFANGED_defanged_style="color:blue">ifconfig&nbsp;&nbsp;
tibbr1&nbsp; 12.21.237.2&nbsp;&nbsp;
netmask&nbsp;&nbsp; 255.255.255.0</span></font></span></font></b></strong></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">FYI, my current hardware setup is
as follows:</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
T1 Line</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Cisco 26XX Router</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;HUB
-----</span></font><font face="Wingdings"><span
 DEFANGED_defanged_style="font-family:Wingdings">&agrave;</span></font>
HUB (Current Network)</p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
----------------------------</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
eth0&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fw1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fw2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
eth1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-----------------------------</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
HUB</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(Future: additional Servers)</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">Please HELP! How can I fix the
settings so the above listed PROBLEM is
resolved!!</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal"><font face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:
 12.0pt">Kirt</span></font>i</p>
  </div>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Bridge mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bridge@lists.osdl.org">Bridge@lists.osdl.org</a>
<a class="moz-txt-link-freetext" href="https://lists.osdl.org/mailman/listinfo/bridge">https://lists.osdl.org/mailman/listinfo/bridge</a>
  </pre>
</blockquote>
</body>
</html>

--------------050407010908020609090404--
