Return-Path: <Samuel.J.Hasenbosch@boeing.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A88AF81443
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85A1681427
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boeing.com;
 s=boeing-s1912; t=1690947658;
 bh=50Ll3XaXPT0vyhJOWSCNmNihoMoZX7WF3UOmYI6/TDM=;
 h=From:To:CC:Subject:Date:From;
 b=QcP2rmRIXPDH8xbfkMEHJrZEN5FWqQ0FffgJb6u59NvJlvh+45U79tgltiQCJKGib
 ecukLSQXt2TPXCLdZOUrssA8tquA3a1qnw+UPFFQ4Lb5Tc1WYczoN4vqHotrU8KP9C
 lZ9h+0O0jyzGBktRy52TkGuulSYANWhnkdA1jzt6Fhs8X+IpsJM/JEc47mG1sOiQNL
 4yqqRxrSbPPVf/v4RtyCpFzi+rtuS/MzO587XvM0m3sStvtujPlsmwL96gKDwXSna8
 tZetNmGzBj6Pz5U4unZ9ipgr9D2GKx6/ACwxYIqP/uVyglLrYU2yjWFKgUTYZazGhJ
 DDxqsL9HX5CpQ==
From: "Hasenbosch, Samuel J" <Samuel.J.Hasenbosch@boeing.com>
Date: Wed, 2 Aug 2023 03:40:33 +0000
Message-ID: <b1b77fe134e64bfc85394050bd40dff6@boeing.com>
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_b1b77fe134e64bfc85394050bd40dff6boeingcom_"
MIME-Version: 1.0
Subject: Re: [Bridge] [bridge]: STP: no port in blocking state despite a
 loop when in a network namespace
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bugs.a.b@free.fr" <bugs.a.b@free.fr>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "nikolay@nvidia.com" <nikolay@nvidia.com>, "roopa@nvidia.com" <roopa@nvidia.com>

--_000_b1b77fe134e64bfc85394050bd40dff6boeingcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Forwarding related issue:



https://lore.kernel.org/netdev/20230711174934.3871fb61@kernel.org/T/#m4d530=
64313393cdee86f12ef9313523aa734d681


--_000_b1b77fe134e64bfc85394050bd40dff6boeingcom_
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
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
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
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-AU" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Forwarding related issue:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://lore.kernel.org/netdev/2023071117=
4934.3871fb61@kernel.org/T/#m4d53064313393cdee86f12ef9313523aa734d681">http=
s://lore.kernel.org/netdev/20230711174934.3871fb61@kernel.org/T/#m4d5306431=
3393cdee86f12ef9313523aa734d681</a><o:p></o:p></p>
</div>
</body>
</html>

--_000_b1b77fe134e64bfc85394050bd40dff6boeingcom_--

