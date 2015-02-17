Return-Path: <theq@rogers.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048;
	t=1424132446; bh=8RlUH+sZoG+xpWOYfZDRzmBhSI1s3wOYSftc3dOndgE=;
	h=From:To:Subject:Date:From:Subject;
	b=YYSCeBAyRorBd7qO4OpRro82Sct6XwI9XOppXdFkaKjMmxWGFxhYX3LFVOtp21qE7pYXoXn/5lC9EANPlJwYlqpB3XU+0iRSUs0MTzEUS9LyNA8D/XBrFCQ83/ZfWmldV6RIT7BgakUOxaKIudeJZM/yBekoiMPuq+twJdV9qLKBIU2DwS2DjEXfJNEi8lwm7SWNNOPHDuqqJb0BSMC30YbWuv1rw4H/hoPoJ9w25lZRgKyfmmnjFIJKdKIBot5Bv0hee6tqRxCuVsyL+jagTERKE7XoZiXwwN/zZt7CeFrDHzdp3NqC/2+c+T6jhK/Ox/u8saTaTPz0WjYJSoSmIQ==
From: "Q" <theq@rogers.com>
Date: Mon, 16 Feb 2015 19:20:42 -0500
Message-ID: <032801d04a47$9181f110$b485d330$@rogers.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0329_01D04A1D.A8B1DC80"
Content-Language: en-ca
Subject: [Bridge] What is the difference between using a virtual bridge and
	a an ethernet interface used a bdrige
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

------=_NextPart_000_0329_01D04A1D.A8B1DC80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Here is a program that can be used to bridge a virtual process (a router) to
a specific interface

https://github.com/jlgaddis/ioulive86

 

I have tried to use br0 as the interface that I am bridging to but it did
not work

The first router is connecting and, by sniffing BR0 you can see its traffic

The second router does not seem to connect properly and I am wondering why.

 

If I repeat the experiment by bridging the two processes to eth0 I can see
traffic coming from both virtual routers and they can see each other

 

 

What is the fundamental difference between br0 and eth0 in these situations
?

 

Thanks

Q


------=_NextPart_000_0329_01D04A1D.A8B1DC80
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
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
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-CA link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Here is a =
program that can be used to bridge a virtual process (a router) to a =
specific interface<o:p></o:p></p><p class=3DMsoNormal><a =
href=3D"https://github.com/jlgaddis/ioulive86">https://github.com/jlgaddi=
s/ioulive86</a><o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I have tried =
to use br0 as the interface that I am bridging to but it did not =
work<o:p></o:p></p><p class=3DMsoNormal>The first router is connecting =
and, by sniffing BR0 you can see its traffic<o:p></o:p></p><p =
class=3DMsoNormal>The second router does not seem to connect properly =
and I am wondering why.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>If I repeat =
the experiment by bridging the two processes to eth0 I can see traffic =
coming from both virtual routers and they can see each =
other<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>What is the =
fundamental difference between br0 and eth0 in these situations =
?<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Thanks<o:p></o:p></p><p =
class=3DMsoNormal>Q<o:p></o:p></p></div></body></html>
------=_NextPart_000_0329_01D04A1D.A8B1DC80--

