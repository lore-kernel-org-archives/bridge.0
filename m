Return-Path: <Viraj.Raiyani@dell.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
	t=1508949664; x=1540485664;
	h=from:to:subject:date:message-id:mime-version;
	bh=J3OTLmlP547UzunnT0W8znfe4+yFzdlpQCatJCLrIE0=;
	b=Hies2OQClnH9ZTdA0UUyFkVkfPrK5MZ6l2rTm30jyh7F7dY+SF5p7MWK
	lF/nNkL19HFF5EXMv4YuJpHai3VF2Dj8rKQxtEVdjcAb4T1DJxUxnvIEa
	nKD4LaUYLrh3vit4H6rehVVd+/GEvIeg1o92cqRKkzTCuLQE6MOvm7Whz k=;
From: <Viraj.Raiyani@dell.com>
Date: Wed, 25 Oct 2017 16:47:18 +0000
Message-ID: <1508950038625.54184@Dell.com>
Content-Language: en-US
Content-Type: multipart/alternative; boundary="_000_150895003862554184Dellcom_"
MIME-Version: 1.0
Subject: [Bridge] Linux Bridge Static FDB move
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--_000_150895003862554184Dellcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,


Is it possible to program the FDB entry in Linux Bridge which is static, no=
n-local and doesn't move to new interface when the same source MAC packet c=
omes on a different interface in the same bridge  ?


I tried programming the MAC as permanent that prevents the moving of MAC to=
 a new interface in the same bridge, however it treats the MAC as local and=
 doesn't do the forwarding ?


Thanks,

Viraj

--_000_150895003862554184Dellcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none"><!-- p { margin-top: 0px; m=
argin-bottom: 0px; }--></style>
</head>
<body dir=3D"ltr" style=3D"font-size:12pt;color:#000000;background-color:#F=
FFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi Everyone,<br>
</p>
<p><br>
</p>
<p>Is it possible to program the FDB entry in Linux Bridge which is static,=
 non-local and doesn't move to new interface&nbsp;when the same source&nbsp=
;MAC packet comes on a different interface&nbsp;in the same bridge&nbsp;&nb=
sp;?<br>
</p>
<p><br>
</p>
<p>I tried&nbsp;programming the MAC as permanent that prevents&nbsp;the mov=
ing of MAC to a new interface in the same bridge, however it treats the MAC=
 as local and doesn't do the forwarding ?<br>
</p>
<p><br>
</p>
<p>Thanks,<br>
</p>
<p>Viraj&nbsp;<br>
</p>
</body>
</html>

--_000_150895003862554184Dellcom_--
