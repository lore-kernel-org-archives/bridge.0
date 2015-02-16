Return-Path: <theq@rogers.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048;
	t=1424122562; bh=JjQog4wnnFQNrwOmq1EFa0jtaR3bVAHSvoet2NzchNY=;
	h=From:To:References:In-Reply-To:Subject:Date:From:Subject;
	b=sNYuY7n9dHf/4e757eZVQzwsEF2yRntKU3RDeJ7Fb9O00/xSlIaUBRCTzIZbZergVE/ASRpIRBSHpI/oFzmNg0KvuyQmjKka3++v8RFiTp2Y8Md1P2EJrjR6+vkHdLK7rYiQvKGxvgPc8jOBL6MDZVDUhbPK96H+Q3cuvb5aoKjKGMqtE9u//LAAiia61q8iB7gGDoGAAa4ZmvwPTPR8ossf1DOE7tcUF1XS6DdAnMyoNa9MpOzxoFzYqagn/ltRS/ZAqRyVXxL7BFA4sp/C/+TChICxvVnYtkKhDfSu6+SjT3Z9A5643/nQ4CLT2/kXX1c5tZliD1VxhRaGBzaQ0A==
From: "The Q" <theq@rogers.com>
References: 
In-Reply-To: 
Date: Mon, 16 Feb 2015 16:35:58 -0500
Message-ID: <02f601d04a30$8eb33820$ac19a860$@rogers.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_02F7_01D04A06.A5DDCC60"
Content-Language: en-ca
Subject: [Bridge] Sniffing a linux bridge vs sniffing enslaved interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multipart message in MIME format.

------=_NextPart_000_02F7_01D04A06.A5DDCC60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 

Hi all

 

Assume that you have a linux bridge with two interfaces eth0 and eth1
enslaved to this bridge

What is the difference between sniffing the bridge and sniffing its
interfaces?

 

tcpdump -i br0   vs tcpdump -i eth0

 

Thanks

MiniME


------=_NextPart_000_02F7_01D04A06.A5DDCC60
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-CA link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Hi =
all<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Assume that you have a linux bridge with two =
interfaces eth0 and eth1 enslaved to this bridge<o:p></o:p></p><p =
class=3DMsoNormal>What is the difference between sniffing the bridge and =
sniffing its interfaces?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>tcpdump -i =
br0 &nbsp;&nbsp;vs tcpdump &#8211;i eth0<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Thanks<o:p></o:p></p><p =
class=3DMsoNormal>MiniME<o:p></o:p></p></div></body></html>
------=_NextPart_000_02F7_01D04A06.A5DDCC60--

