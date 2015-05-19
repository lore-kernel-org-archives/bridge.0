Return-Path: <pvinod.sarma@freescale.com>
From: Pullabhatla Vinod <pvinod.sarma@freescale.com>
Date: Tue, 19 May 2015 11:14:01 +0000
Message-ID: <BLUPR03MB13643A6C0CE8F49B31B5E67A91C30@BLUPR03MB1364.namprd03.prod.outlook.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR03MB13643A6C0CE8F49B31B5E67A91C30BLUPR03MB1364namp_"
MIME-Version: 1.0
Subject: [Bridge] Linux kernel not supporting STP enablement in NON-ROOT
	namespace
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

--_000_BLUPR03MB13643A6C0CE8F49B31B5E67A91C30BLUPR03MB1364namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi ,
Linux doesn't support multiple namspaces while using STP in bridges . What =
is the actual reason behind supporting only root namespaces for STP support=
 and dropping the BPDU packets for other namespaces. Will there be any issu=
e if I patch the kernel to enable multiple namespace support?
Please hepl me out.

Thanks,
Vinod.


Thanks,
Vinod.


--_000_BLUPR03MB13643A6C0CE8F49B31B5E67A91C30BLUPR03MB1364namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi ,<o:p></o:p></p>
<p class=3D"MsoNormal">Linux doesn&#8217;t support multiple namspaces while=
 using STP in bridges . What is the actual reason behind supporting only ro=
ot namespaces for STP support and dropping the BPDU packets for other names=
paces. Will there be any issue if I patch
 the kernel to enable multiple namespace support? <o:p></o:p></p>
<p class=3D"MsoNormal">Please hepl me out.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Vinod.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Vinod.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BLUPR03MB13643A6C0CE8F49B31B5E67A91C30BLUPR03MB1364namp_--
