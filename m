From: "kingz" <jzhang@cienettechnologies.com>
Date: Thu, 18 Nov 2004 23:08:04 -0800
Message-ID: <003101c4ce06$8696ec60$6c01a8c0@kingz>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0032_01C4CDC3.7873AC60"
Subject: [Bridge] Hotmail login error with bridge
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

------=_NextPart_000_0032_01C4CDC3.7873AC60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,
 
I am having trouble in Ethernet bridge and 802.1Q VLAN, I have the
following network:
 
   Internet
       |
       |
  Gateway ( UPNP device)
       |
       |
     H u b    ( one normal hub or switch , no VLAN)
      |   \
      |    \
      |     \
   Some 802.1Q VLAN Switches ( their uplink port is tagged)
 
Our PCs connect with these VLAN Switches, they access Internet through
the UPNP gateway, It works fine, from the gateway, we can see these VLAN
ID of PCs;  but when I insert one Ethernet bridge box ( one linux box,
kernel 2.4.26, ebtables-brnf-6_vs_2.4.26 patch) between the gateway and
the Hub, some changed: 
i was not able to log  in hotmail. 
 For exemple, with hotmail, the https transaction was done, but a basic
error message 
 prompt on navigator (DNS error or server not found).
Except the above, others  work fine, very strange!
If have no this Ethernet bridge, it works fine, but the Ethernet bridge
is only transparent bridge.
The UPNP box can act as a universal gateway for these PCs under it, no
matter what their IP are, maybe a dynamic IP, or any fixed IP.
 
That's my trouble, could you give me your idea? Thank you very much!
If you need more info on it, please let me know soon!
 
Thank you very much!
 
Kingz
 

------=_NextPart_000_0032_01C4CDC3.7873AC60
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
<link DEFANGED_rel=3D"File-List" DEFANGED_href=3D"cid:filelist.xml@01C4CDC3=
.74F2C300">
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
	{font-family:&#23435;&#20307;;
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-alt:SimSun;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 135135232 16 0 262145 0;}
@font-face
	{font-family:"\@&#23435;&#20307;";
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
	mso-fareast-font-family:&#23435;&#20307;;}
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
span.grame
	{mso-style-name:grame;}
span.spelle
	{mso-style-name:spelle;}
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

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial">Hi All,<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial">I am having
trouble in Ethernet bridge and 802.1Q VLAN, I have the following network:<o=
:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp; </span>Internet<o:p></o:p>=
</span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span>|<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span>|<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>Gateway </span></font><sp=
an class=3DGramE><span
class=3Dgrame>( UPNP</span></span><font size=3D2 face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial"> device)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span>|<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span>|<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>H u b<s=
pan
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span></span></font=
><span
class=3DGramE><span class=3Dgrame>( one</span></span><font size=3D2 face=3D=
Arial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"> normal hub or switch=
 , no VLAN)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>|=
<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp; </span>\<o:p></o:p></span>=
</font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>|=
<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span>\<o:p></o:p><=
/span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>|=
<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>\<o:p><=
/o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;&nbsp; </span>Some 802.1Q VLAN Sw=
itches </span></font><span
class=3DGramE><span class=3Dgrame>( their</span></span><font size=3D2 face=
=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"> uplink port is tagge=
d)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial">Our PCs
connect with these VLAN Switches, they access Internet through the UPNP
gateway, It works fine, from the gateway, we can see these VLAN ID of PCs;<=
span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>but when I insert one Eth=
ernet bridge
box ( one <span class=3DSpellE><span class=3Dspelle>linux</span></span> box=
, kernel
2.4.26, ebtables-brnf-6_vs_2.4.26 patch) between the gateway and the Hub, s=
ome
changed:</span></font><span class=3DMsoHyperlink><u><font color=3D"#990099"=
><span
DEFANGED_style=3D"color:#990099;mso-ansi-language:EN"> <span lang=3DEN><o:p=
></o:p></span></span></font></u></span></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><span
class=3DSpellE><span class=3DGramE><span class=3Dgrame><font size=3D3
face=3D"Times New Roman"><span DEFANGED_style=3D"font-size:12.0pt">i</span>=
</font></span></span></span><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"> was not
able to log<span DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>in hotma=
il. <o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;</span>For <span class=3DSpellE><=
span
class=3Dspelle>exemple</span></span>, with hotmail, the https transaction w=
as
done, but a basic error message <o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp;</span></span></font><span class=
=3DGramE><span
class=3Dgrame>prompt</span></span><font size=3D2 face=3DArial><span DEFANGE=
D_style=3D"font-size:
10.0pt;font-family:Arial"> on navigator (DNS error or server not found).<o:=
p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial">Except the
above, </span></font><span class=3DGramE><span class=3Dgrame>others<span
DEFANGED_style=3D"mso-spacerun:yes">&nbsp; </span>work</span></span><font s=
ize=3D2
face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"> f=
ine, very
strange!<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial">If have no
this Ethernet bridge, it works fine, but the Ethernet bridge is only
transparent bridge.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial">The UPNP box
can act as a universal gateway for these PCs under it, no matter what their=
 IP
are, maybe a dynamic IP, or any fixed IP.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial">That&#8217;s my </span></font><span
class=3DGramE><span class=3Dgrame>trouble,</span></span><font size=3D2 face=
=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"> could you give me yo=
ur idea? Thank
you very much!<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial">If you need
more info on it, please let me know soon!<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial">Thank you
very much!<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><font
size=3D2 face=3DArial><span DEFANGED_style=3D"font-size:10.0pt;font-family:=
Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"mso-margin-top-alt:auto;mso-margin=
-bottom-alt:auto"><span
class=3DSpellE><font size=3D2 face=3DArial><span DEFANGED_style=3D"font-siz=
e:10.0pt;font-family:
Arial">Kingz</span></font></span><font size=3D2 face=3DArial><span
DEFANGED_style=3D"font-size:10.0pt;font-family:Arial"><o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0032_01C4CDC3.7873AC60--
