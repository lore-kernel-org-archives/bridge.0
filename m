From: "kingz" <jzhang@cienettechnologies.com>
Date: Sun, 21 Nov 2004 18:20:55 -0800
Message-ID: <000f01c4d039$e92759c0$6c01a8c0@kingz>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0010_01C4CFF6.DB0419C0"
Subject: [Bridge] Very strange hotmail login error!
Reply-To: jzhang@cienettechnologies.com
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

------=_NextPart_000_0010_01C4CFF6.DB0419C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,
 
Very sorry for posting my question again, because I want to tell you
more details on my issue, and it is very important for us!
Now I am having trouble in Ethernet bridge and 802.1Q VLAN, I have the
following network:
   Internet
       |
  Gateway ( One UPNP device)
       |
       |    <---------  If insert one Ethernet bridge box in here ,
somethings changes
       |
     H u b    ( one normal hub or switch , no VLAN settings)
      |   \
      |     \
  D-Link  802.1Q VLAN Switches (their uplink port-port 1  connected to
the upper hub are tagged, those ports connected with PCs are untagged).
Our client PCs connect to these VLAN Switches, they access Internet
through that UPNP gateway, It works all OK; Every PC connects to one
untagged port in a 802.1Q VLAN Switch , this untagged port and the
tagged  uplink port (e.g. port 1) make up of one VLAN,  the tagged port
1 is a common uplink port , So from the gateway we can see these VLAN ID
of PCs;  but when I insert one Ethernet bridge box ( one linux box,
kernel 2.4.26, ebtables-brnf-6_vs_2.4.26 patch) between the gateway and
the Hub, somethings changed: 
I was not able to log  in hotmail, maybe also on certain websites. 
For example, I access  www.hotmail.com <http://www.hotmail.com/> , it
loads OK. When I input my account, and hit Login, it goes to a error
page(DNS error or server not found)  after a moment.
Except the above site, maybe also have others, but most sites work fine,
very strange!
I am sure that this Linux Ethernet bridge is only  transparent bridge,
no any Iptables filter and rule. 
If I have no this Ethernet bridge, it works fine, no hotmail login
error.
If I remove the tag for VLAN(just change the port 1 to untagged),  also
with this Linux Ethernet bridge it works all OK, also have no hotmail
login error. Very strange, it as if the issue is on VLAN , tag, or Linux
Ethernet  bridge , I have no idea of it now!
I am stuck here now! 
Any help, comments, hints would be greatly appreciated!
If you need more info on it, please let me know soon!
Thanks!
Note: The UPNP box can act as a universal gateway for these PCs under
it, no matter what their IP are, maybe a dynamic IP, or any fixed IP.
Kingz
 

------=_NextPart_000_0010_01C4CFF6.DB0419C0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html DEFANGED_xmlns:o=3D"urn:schemas-microsoft-com:office:office" DEFANGED=
_xmlns:w=3D"urn:schemas-microsoft-com:office:word" DEFANGED_xmlns=3D"http:/=
/www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link DEFANGED_rel=3D"File-List" DEFANGED_href=3D"cid:filelist.xml@01C4CFF6=
.D7290270">
<!--[if gte mso 9]><DEFANGED_xml>
 <DEFANGED_o:OfficeDocumentSettings>
  <DEFANGED_o:DoNotRelyOnCSS/>
 </DEFANGED_o:OfficeDocumentSettings>
</DEFANGED_xml><![endif]--><!--[if gte mso 9]><DEFANGED_xml>
 <DEFANGED_w:WordDocument>
  <DEFANGED_w:SpellingState>Clean</DEFANGED_w:SpellingState>
  <DEFANGED_w:GrammarState>Clean</DEFANGED_w:GrammarState>
  <DEFANGED_w:DocumentKind>DocumentEmail</DEFANGED_w:DocumentKind>
  <DEFANGED_w:EnvelopeVis/>
  <DEFANGED_w:Compatibility>
   <DEFANGED_w:BreakWrappedTables/>
   <DEFANGED_w:SnapToGridInCell/>
   <DEFANGED_w:WrapTextWithPunct/>
   <DEFANGED_w:UseAsianBreakRules/>
   <DEFANGED_w:UseFELayout/>
  </DEFANGED_w:Compatibility>
  <DEFANGED_w:BrowserLevel>MicrosoftInternetExplorer4</DEFANGED_w:BrowserLe=
vel>
 </DEFANGED_w:WordDocument>
</DEFANGED_xml><![endif]-->
<DEFANGED_style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-alt:SimSun;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 135135232 16 0 262145 0;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 135135232 16 0 262145 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:SimSun;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</DEFANGED_style>
<!--[if gte mso 10]>
<DEFANGED_style=20
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
></DEFANGED_style>
<![endif]-->
</head>

<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" DEFANGED_style=3D"tab-i=
nterval:.5in">

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D4 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
14.0pt">Hi All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
14.0pt"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
14.0pt">Very sorry for posting my question again, because I want to tell you
more details on my issue, and it is very important for us!<o:p></o:p></span=
></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
>Now I am having
trouble in Ethernet bridge and 802.1Q VLAN, I have the following network:<o=
:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp; </span>Internet<o:p></o:p>=
</span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span>|<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>Gateway ( One UPNP device=
)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>|<=
o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span>|<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span>&lt;<span cla=
ss=3DGramE>---------<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>If</span> insert one Ethe=
rnet bridge box
in here , <span class=3DSpellE>somethings</span> changes<o:p></o:p></span><=
/font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span>|<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>H u b<s=
pan
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span><span class=
=3DGramE>( one</span>
normal hub or switch , no VLAN settings)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>|=
<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp; </span>\<o:p></o:p></span>=
</font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>|=
<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>\<o:p><=
/o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>D-<span class=3DGramE>Lin=
k<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>802.1Q</span> VLAN Switch=
es (their
uplink port&#8212;port 1<span DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </=
span>connected
to the upper hub are tagged, those ports connected with PCs are untagged).<=
o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
>Our client PCs
connect to these VLAN Switches, they access Internet through that UPNP gate=
way,
It works all OK; Every PC connects to one untagged port in a 802.1Q VLAN Sw=
itch
, this untagged port and the tagged<span DEFANGED_style=3D"mso-spacerun:yes=
">&nbsp;
</span>uplink port (e.g. port 1) make up of one VLAN,<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>the tagged port 1 is a co=
mmon uplink
port , So from the gateway we can see these VLAN ID of PCs;<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>but when I insert one Eth=
ernet bridge
box ( one <span class=3DSpellE>linux</span> box, kernel 2.4.26, ebtables-br=
nf-6_vs_2.4.26
patch) between the gateway and the Hub, <span class=3DSpellE>somethings</sp=
an>
changed:</span></font><span class=3DMsoHyperlink><u><font size=3D4 color=3D=
"#990099"><span
DEFANGED_style=3D"font-size:14.0pt;color:#990099;mso-ansi-language:EN"> </s=
pan></font></u></span><span
class=3DMsoHyperlink><u><font color=3D"#990099"><span lang=3D"EN" DEFANGED_=
style=3D"color:#990099;
mso-ansi-language:EN"><o:p></o:p></span></font></u></span></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
>I was not able to <span
class=3DGramE>log<span DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>in=
</span> hotmail,
maybe also on certain websites. </span></font><o:p></o:p></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
>For example, I <span
class=3DGramE>access<span DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span=
></span><a
href=3D"http://www.hotmail.com/">www.hotmail.com</a>, it loads OK. When I i=
nput
my account, and hit Login, it goes to a error <span class=3DGramE>page(</sp=
an>DNS
error or server not found)<span DEFANGED_style=3D"mso-spacerun:yes">&nbsp; =
</span>after a
moment.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
>Except the above
site, maybe also have others, but most sites work fine, very strange!<o:p><=
/o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
>I am sure that
this Linux Ethernet bridge is <span class=3DGramE>only<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>transparent</span> bridge=
, no any <span
class=3DSpellE>Iptables</span> filter and rule. <o:p></o:p></span></font></=
p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
>If I have no this
Ethernet bridge, it works fine, no hotmail login error.<o:p></o:p></span></=
font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
>If I remove the
tag for <span class=3DGramE>VLAN(</span>just change the port 1 to untagged)=
,<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>also with this Linux Ethe=
rnet bridge it
works all OK, also have no hotmail login error. Very strange, it as if the
issue is on <span class=3DGramE>VLAN ,</span> tag, or Linux Ethernet<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>bridge , I have no idea o=
f it now!<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
>I am stuck here
now! <o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
>Any help,
comments, hints would be greatly appreciated!<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
>If you need more
info on it, please let me know soon!<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
>Thanks!<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D4 face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:14.0pt"=
>Note: The UPNP box
can act as a universal gateway for these PCs under it, no matter what their=
 IP
are, maybe a dynamic IP, or any fixed IP.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><span
class=3DSpellE><font size=3D4 face=3D"Times New Roman"><span DEFANGED_style=
=3D"font-size:14.0pt">Kingz</span></font></span><font
size=3D4><span DEFANGED_style=3D"font-size:14.0pt"><o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D4 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
14.0pt"><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0010_01C4CFF6.DB0419C0--
