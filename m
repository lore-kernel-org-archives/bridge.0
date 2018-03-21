Return-Path: <Viraj.Raiyani@dell.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
	t=1521657674; x=1553193674;
	h=from:to:subject:date:message-id:mime-version;
	bh=UqKxF69N4DP2ebWO2jddn+yWnk9b4qM2LCnW8C+CFOU=;
	b=xMBSTfNs7vtMmSi4hvXvl5qfyN8iZyqhZQ66lCeOVpAnUliGkzZeADGD
	aDqGvh5JroerBPPIsJ19axueHn20ED/TXkDuAQEsA702IodoU8663Yzjm
	4ethrgM/gmjFQBktZnfvw/S4/l106X9u7ANZe4GaU2XXzxl6YSA0vuXPs A=;
From: <Viraj.Raiyani@dell.com>
Date: Wed, 21 Mar 2018 18:41:11 +0000
Message-ID: <71da1614fff84fbf933a4aad5f09c4a3@ausx13mpc112.AMER.DELL.COM>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_71da1614fff84fbf933a4aad5f09c4a3ausx13mpc112AMERDELLCOM_"
MIME-Version: 1.0
Subject: [Bridge] Bridge netlink events for add/del interfaces in debian
	stretch
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--_000_71da1614fff84fbf933a4aad5f09c4a3ausx13mpc112AMERDELLCOM_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dell - Internal Use - Confidential

Hi Everyone,

I recently upgraded my Debian distribution from Jessie to Stretch. I have a=
 code which handles the kernel netlink bridge events for adding/deleting in=
terfaces to bridge. When an interface is removed from bridge in stretch I g=
et a netlink event with RTM_DELLINK for an interface with master as the bri=
dge. However, after delete I also get RTM_NEWLINK additional event with an =
interface and master as the bridge. However, I was not getting this event i=
n Jessie. Is this a known bug or this event is meant for something else ?

Thanks
Viraj


--_000_71da1614fff84fbf933a4aad5f09c4a3ausx13mpc112AMERDELLCOM_
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
<p class=3D"MsoNormal"><b><span style=3D"font-size:9.0pt;font-family:&quot;=
Arial&quot;,sans-serif;color:#AAAAAA">Dell - Internal Use - Confidential
<br>
<br>
</span></b><span style=3D"font-size:12.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal">Hi Everyone,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I recently upgraded my Debian distribution from Jess=
ie to Stretch. I have a code which handles the kernel netlink bridge events=
 for adding/deleting interfaces to bridge. When an interface is removed fro=
m bridge in stretch I get a netlink
 event with RTM_DELLINK for an interface with master as the bridge. However=
, after delete I also get RTM_NEWLINK additional event with an interface an=
d master as the bridge. However, I was not getting this event in Jessie. Is=
 this a known bug or this event
 is meant for something else ? <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks<o:p></o:p></p>
<p class=3D"MsoNormal">Viraj <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_71da1614fff84fbf933a4aad5f09c4a3ausx13mpc112AMERDELLCOM_--
