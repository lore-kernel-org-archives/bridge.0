Return-Path: <DGriffith@xstratazinc.com.au>
From: <DGriffith@xstratazinc.com.au>
Date: Sat, 29 Sep 2012 11:30:20 +1000
Message-ID: <CDE330B71399F9459DAE71EAD87D1A3D090F4878E5@AUKISASRV145.auk.xstrata.int>
Content-Language: en-US
Content-Type: multipart/alternative; 
	boundary="_000_CDE330B71399F9459DAE71EAD87D1A3D090F4878E5AUKISASRV145a_"
MIME-Version: 1.0
Subject: [Bridge] Bridge IGMP snooping causing failures in XP.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--_000_CDE330B71399F9459DAE71EAD87D1A3D090F4878E5AUKISASRV145a_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

I am attempting to narrow down an issue with IGMP snooping with 3.x series =
kernels and XP.

My setup -


-       An XP computer with SP3, on VLAN 800 (but set on an access port, so=
 it's untagged traffic)

-       Linux server 2.6.24 on VLAN 800 (also on an access port /untagged t=
raffic) , broadcasting packets on IP's 239.1.1.1 - 20 to the XP computer.

-       A separate software bridge under linux, hanging off a trunk bridgin=
g VLAN 800 to any other interface / VLAN.

With a software bridge running on 2.6.24, everything works fine. The bridge=
 powers up and starts learning then forwarding... all good.

With a software bridge setup and running on 3.3.4, as soon as the bridge co=
mes up the XP box loses its ability to pick up any multicast traffic. Unica=
st traffic / broadcast traffic still works fine - I can arp / ping computer=
s, web pages open fine, etc.


Things that don't work:


-       A ubiquiti bullet wifi AP, with the latest openWRT beta firmware (m=
ips kernel 3.3.8)

-       A VMware esx4.1 VM running alpinelinux with a X86 3.3 kernel

-       A different network card in the XP machine

-       A couple of other XP machines which are clones of the original in a=
 hardware/software sense

-       Using untagged traffic and separate physical interfaces for the bri=
dge instead of plucking VLAN800 off a trunk interface.

Things that do work :



-       A windows 7 machine with a bridge running on a 2.6 / 3.3 kernel - n=
o problems with multicast traffic.

-       A bullet AP with an older openWRT with a 2.6 kernel - no issues wit=
h the XP machine

-       A ubuntu VM with a 2.6 kernel - no issues with the XP machine.

-       Turning off multicast snooping for the bridge  'solves' the issue.


Wireshark running on the XP machine shows the last multicast packet receive=
d is an IGMP general query from the mac address of the bridge.... Then no m=
ore multicast traffic.


Anyone have any ideas?


Regards,

David


***************************************************************************=
*******
The information contained in this e-mail is confidential and is
intended only for use of the addressee(s).
If you receive this e-mail in error, any use, distribution, or
copying of this e-mail is not permitted. You are requested to
forward unwanted e-mail and address any problems to the
Xstrata ICT Service Desk.

Xstrata ICT Service Desk e-mail: supportcentre@xstrata.com.au
Xstrata ICT Service Desk phone: Australia 1800 500 646
International +61 2 9034 3710
***************************************************************************=
*******


--_000_CDE330B71399F9459DAE71EAD87D1A3D090F4878E5AUKISASRV145a_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 12 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Arial","sans-serif";
	color:windowtext;
	font-weight:normal;
	font-style:normal;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1710103135;
	mso-list-type:hybrid;
	mso-list-template-ids:1075492906 -1295196692 201916419 201916421 201916417=
 201916419 201916421 201916417 201916419 201916421;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Arial","sans-serif";
	mso-fareast-font-family:Calibri;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-AU link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span style=3D'f=
ont-size:10.0pt;font-family:"Arial","sans-serif"'>Hello all,<o:p></o:p></sp=
an></p><p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Ar=
ial","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span s=
tyle=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>I am attempting =
to narrow down an issue with IGMP snooping with 3.x series kernels and XP.<=
o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:10.0pt;f=
ont-family:"Arial","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMso=
Normal><span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>My=
 setup &#8211; <o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'fo=
nt-size:10.0pt;font-family:"Arial","sans-serif"'><o:p>&nbsp;</o:p></span></=
p><p class=3DMsoListParagraph style=3D'text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo1'><![if !supportLists]><span style=3D'font-size:10.0pt;font-family:"=
Arial","sans-serif"'><span style=3D'mso-list:Ignore'>-<span style=3D'font:7=
.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>=
</span><![endif]><span style=3D'font-size:10.0pt;font-family:"Arial","sans-=
serif"'>An XP computer with SP3, on VLAN 800 (but set on an access port, so=
 it&#8217;s untagged traffic)<o:p></o:p></span></p><p class=3DMsoListParagr=
aph style=3D'text-indent:-18.0pt;mso-list:l0 level1 lfo1'><![if !supportLis=
ts]><span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><span=
 style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New Roman"'>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span sty=
le=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Linux server 2.6.2=
4 on VLAN 800 (also on an access port /untagged traffic) , broadcasting pac=
kets on IP&#8217;s 239.1.1.1 &#8211; 20 to the XP computer.<o:p></o:p></spa=
n></p><p class=3DMsoListParagraph style=3D'text-indent:-18.0pt;mso-list:l0 =
level1 lfo1'><![if !supportLists]><span style=3D'font-size:10.0pt;font-fami=
ly:"Arial","sans-serif"'><span style=3D'mso-list:Ignore'>-<span style=3D'fo=
nt:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></s=
pan></span><![endif]><span style=3D'font-size:10.0pt;font-family:"Arial","s=
ans-serif"'>A separate software bridge under linux, hanging off a trunk bri=
dging VLAN 800 to any other interface / VLAN. <o:p></o:p></span></p><p clas=
s=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Arial","sans-ser=
if"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span style=3D'font-s=
ize:10.0pt;font-family:"Arial","sans-serif"'>With a software bridge running=
 on 2.6.24, everything works fine. The bridge powers up and starts learning=
 then forwarding&#8230; all good.<o:p></o:p></span></p><p class=3DMsoNormal=
><span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><o:p>&nb=
sp;</o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:10.0pt;fo=
nt-family:"Arial","sans-serif"'>With a software bridge setup and running on=
 3.3.4, as soon as the bridge comes up the XP box loses its ability to pick=
 up any multicast traffic. Unicast traffic / broadcast traffic still works =
fine &#8211; I can arp / ping computers, web pages open fine, etc.<o:p></o:=
p></span></p><p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-fami=
ly:"Arial","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><=
span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><o:p>&nbsp=
;</o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:10.0pt;font=
-family:"Arial","sans-serif"'>Things that don&#8217;t work:<o:p></o:p></spa=
n></p><p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Ari=
al","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoListParagraph s=
tyle=3D'text-indent:-18.0pt;mso-list:l0 level1 lfo1'><![if !supportLists]><=
span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><span styl=
e=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span style=3D=
'font-size:10.0pt;font-family:"Arial","sans-serif"'>A ubiquiti bullet wifi =
AP, with the latest openWRT beta firmware (mips kernel 3.3.8)<o:p></o:p></s=
pan></p><p class=3DMsoListParagraph style=3D'text-indent:-18.0pt;mso-list:l=
0 level1 lfo1'><![if !supportLists]><span style=3D'font-size:10.0pt;font-fa=
mily:"Arial","sans-serif"'><span style=3D'mso-list:Ignore'>-<span style=3D'=
font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><=
/span></span><![endif]><span style=3D'font-size:10.0pt;font-family:"Arial",=
"sans-serif"'>A VMware esx4.1 VM running alpinelinux with a X86 3.3 kernel<=
o:p></o:p></span></p><p class=3DMsoListParagraph style=3D'text-indent:-18.0=
pt;mso-list:l0 level1 lfo1'><![if !supportLists]><span style=3D'font-size:1=
0.0pt;font-family:"Arial","sans-serif"'><span style=3D'mso-list:Ignore'>-<s=
pan style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; </span></span></span><![endif]><span style=3D'font-size:10.0pt;font-fa=
mily:"Arial","sans-serif"'>A different network card in the XP machine<o:p><=
/o:p></span></p><p class=3DMsoListParagraph style=3D'text-indent:-18.0pt;ms=
o-list:l0 level1 lfo1'><![if !supportLists]><span style=3D'font-size:10.0pt=
;font-family:"Arial","sans-serif"'><span style=3D'mso-list:Ignore'>-<span s=
tyle=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]><span style=3D'font-size:10.0pt;font-family:=
"Arial","sans-serif"'>A couple of other XP machines which are clones of the=
 original in a hardware/software sense <o:p></o:p></span></p><p class=3DMso=
ListParagraph style=3D'text-indent:-18.0pt;mso-list:l0 level1 lfo1'><![if !=
supportLists]><span style=3D'font-size:10.0pt;font-family:"Arial","sans-ser=
if"'><span style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]=
><span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Using un=
tagged traffic and separate physical interfaces for the bridge instead of p=
lucking VLAN800 off a trunk interface.<o:p></o:p></span></p><p class=3DMsoN=
ormal><span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><o:=
p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:10.0=
pt;font-family:"Arial","sans-serif"'>Things that do work :<o:p></o:p></span=
></p><p class=3DMsoListParagraph><span style=3D'font-size:10.0pt;font-famil=
y:"Arial","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoListParag=
raph style=3D'text-indent:-18.0pt;mso-list:l0 level1 lfo1'><![if !supportLi=
sts]><span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><spa=
n style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New Roman"'>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span st=
yle=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>A windows 7 machi=
ne with a bridge running on a 2.6 / 3.3 kernel &#8211; no problems with mul=
ticast traffic.<o:p></o:p></span></p><p class=3DMsoListParagraph style=3D't=
ext-indent:-18.0pt;mso-list:l0 level1 lfo1'><![if !supportLists]><span styl=
e=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><span style=3D'mso-=
list:Ignore'>-<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span style=3D'font-siz=
e:10.0pt;font-family:"Arial","sans-serif"'>A bullet AP with an older openWR=
T with a 2.6 kernel &#8211; no issues with the XP machine<o:p></o:p></span>=
</p><p class=3DMsoListParagraph style=3D'text-indent:-18.0pt;mso-list:l0 le=
vel1 lfo1'><![if !supportLists]><span style=3D'font-size:10.0pt;font-family=
:"Arial","sans-serif"'><span style=3D'mso-list:Ignore'>-<span style=3D'font=
:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></spa=
n></span><![endif]><span style=3D'font-size:10.0pt;font-family:"Arial","san=
s-serif"'>A ubuntu VM with a 2.6 kernel &#8211; no issues with the XP machi=
ne.<o:p></o:p></span></p><p class=3DMsoListParagraph style=3D'text-indent:-=
18.0pt;mso-list:l0 level1 lfo1'><![if !supportLists]><span style=3D'font-si=
ze:10.0pt;font-family:"Arial","sans-serif"'><span style=3D'mso-list:Ignore'=
>-<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; </span></span></span><![endif]><span style=3D'font-size:10.0pt;fon=
t-family:"Arial","sans-serif"'>Turning off multicast snooping for the bridg=
e &nbsp;&#8216;solves&#8217; the issue.<o:p></o:p></span></p><p class=3DMso=
ListParagraph><span style=3D'font-size:10.0pt;font-family:"Arial","sans-ser=
if"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span style=3D'font-s=
ize:10.0pt;font-family:"Arial","sans-serif"'>Wireshark running on the XP ma=
chine shows the last multicast packet received is an IGMP general query fro=
m the mac address of the bridge&#8230;. Then no more multicast traffic.<o:p=
></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:10.0pt;font=
-family:"Arial","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNor=
mal><span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><o:p>=
&nbsp;</o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:10.0pt=
;font-family:"Arial","sans-serif"'>Anyone have any ideas?<o:p></o:p></span>=
</p><p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Arial=
","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span styl=
e=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><o:p>&nbsp;</o:p></=
span></p><p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"=
Arial","sans-serif"'>Regards,<o:p></o:p></span></p><p class=3DMsoNormal><sp=
an style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><o:p>&nbsp;<=
/o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-f=
amily:"Arial","sans-serif"'>David<o:p></o:p></span></p><p class=3DMsoNormal=
><span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><o:p>&nb=
sp;</o:p></span></p></div>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:6pt;">*********=
*************************************************************************</=
span></p>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:8pt;">The infor=
mation contained in this e-mail is confidential and is</span></p>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:8pt;">intended =
only for use of the addressee(s).</span></p>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:8pt;">If you re=
ceive this e-mail in error, any use, distribution, or</span></p>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:8pt;">copying o=
f this e-mail is not permitted. You are requested to</span></p>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:8pt;">forward u=
nwanted e-mail and address any problems to the</span></p>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:8pt;">Xstrata I=
CT Service Desk.</span></p>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:8pt;"></span></=
p>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:8pt;">&nbsp;</s=
pan></p>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:8pt;">Xstrata I=
CT Service Desk e-mail: supportcentre@xstrata.com.au</span></p>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:8pt;">Xstrata I=
CT Service Desk phone: Australia 1800 500 646</span></p>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:8pt;">Internati=
onal +61 2 9034 3710</span></p>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:6pt;">*********=
*************************************************************************</=
span></p>
<p><span style=3D"font-family:'Frutiger 45 Light';font-size:6pt;">&nbsp;</s=
pan></p></body></html>

--_000_CDE330B71399F9459DAE71EAD87D1A3D090F4878E5AUKISASRV145a_--
