Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C46844.F4545990"
Subject: RE: [Bridge] Bridge support unavailable
Date: Mon, 12 Jul 2004 14:18:03 -0500
Message-ID: <D1BBAADDE65D9646B5F0C6332C038B4EBA75DE@mbgexc.mbgdocs.com>
From: "Bert Hubbs" <bhubbs@mbgdocs.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bruce Ferrell <bferrell@baywinds.org>
Cc: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C46844.F4545990
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

So Linux does not have a "PATH" while booting? I have brctl in the /bin
and the /sbin directory.

I looked at the /etc/init.d/network  script and there is mention of
bridges but no direct call to brctl.

Do you think I would be better of recompiling the Kernel with bridging
built in?

=20

Well... You need to determine what script the error is coming from...=20
Probably /etc/rc.d/init.d/network (or it could be /etc/init.d/network)=20

=20

Bert Hubbs wrote:=20
> " That sounds like you need the full path to brctl in your script."=20
>=20
> What script?=20
>=20
>=20
>=20
> Bert Hubbs=20
> McGlinchey Stafford and=20
> Youngblood & Bendalin, PLLC=20
> 2711 N. Haskell Ave.=20
> Suite 2700, LB 25=20
> Dallas, TX 75204=20
> 214-257-1817 (direct dial)=20
> 469-235-1817 (mobile)=20
> 214-257-1881 (fax)=20
>=20
>=20
> -----Original Message-----=20
> From: Bruce Ferrell [mailto:bferrell@baywinds.org]=20
> Sent: Monday, July 05, 2004 9:41 PM=20
> To: Bert Hubbs=20
> Cc: bridge@lists.osdl.org=20
> Subject: Re: [Bridge] Bridge support unavailable=20
>=20
> That sounds like you need the full path to brctl in your script.=20
>=20
> Which leads me to MY question for the list.  I'm having problem
getting=20
> bridge.o to build correctly on 2.4.25 (linus).  Is this a case where
I'd=20
>=20
> be better off with it built static?=20
>=20
> Bert Hubbs wrote:=20
>=20
>>When I start Linux I get an error:=20
>>=20
>>"Bridge support unavailable: brctl not found".=20
>>=20
>>And then eth0 - 2 load with no problems. After system is up I can=20
>=20
> build=20
>=20
>>the bridge but it does not survive a reboot. Do I need a startup=20
>=20
> script=20
>=20
>>or should it build from the:=20
>>=20
>>/etc/init.d/bridge=20
>>/etc/sysconfig/network-scripts/ifcfg-bro=20
>>/etc/sysconfig/network-scripts/ifcfg-eth0=20
>>/etc/sysconfig/network-scripts/ifcfg-eth1=20
>>/etc/sysconfig/network-scripts/ifcfg-eth2=20
>>=20
>>=20
>>=20
>>I am using Core2=20
>>=20
>>=20
>>=20
>>Bert Hubbs=20
>>McGlinchey Stafford and=20
>>Youngblood & Bendalin, PLLC=20
>>2711 N. Haskell Ave.=20
>>Suite 2700, LB 25=20
>>Dallas, TX 75204=20
>>214-257-1817 (direct dial)=20
>>469-235-1817 (mobile)=20
>>214-257-1881 (fax)=20
>>=20
>>=20
>>=20
>>The information contained in this e-mail message is intended only for=20
>=20
> the personal and confidential use of the recipient(s) named above.
This=20
> message may be an attorney-client communication and/or work product
and=20
> as such is privileged and confidential. If the reader of this message
is=20
> not the intended recipient or an agent responsible for delivering it
to=20
> the intended recipient, you are hereby notified that you have received

> this document in error and that any review, dissemination,
distribution,=20
> or copying of this message is strictly prohibited. If you have
received=20
> this communication in error, please notify us immediately by e-mail,
and=20
> delete the original message.=20
>=20
>>=20
>>=20
>>=20
>
------------------------------------------------------------------------

>=20
>>_______________________________________________=20
>>Bridge mailing list=20
>>Bridge@lists.osdl.org=20
>>http://lists.osdl.org/mailman/listinfo/bridge=20
>=20
>=20
>=20
> The information contained in this e-mail message is intended only for
the personal and confidential use of the recipient(s) named above. This
message may be an attorney-client communication and/or work product and
as such is privileged and confidential. If the reader of this message is
not the intended recipient or an agent responsible for delivering it to
the intended recipient, you are hereby notified that you have received
this document in error and that any review, dissemination, distribution,
or copying of this message is strictly prohibited. If you have received
this communication in error, please notify us immediately by e-mail, and
delete the original message.=20

>=20


The information contained in this e-mail message is intended only for the p=
ersonal and confidential use of the recipient(s) named above. This message =
may be an attorney-client communication and/or work product and as such is =
privileged and confidential. If the reader of this message is not the inten=
ded recipient or an agent responsible for delivering it to the intended rec=
ipient, you are hereby notified that you have received this document in err=
or and that any review, dissemination, distribution, or copying of this mes=
sage is strictly prohibited. If you have received this communication in err=
or, please notify us immediately by e-mail, and delete the original message=
.=20

------_=_NextPart_001_01C46844.F4545990
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">
<title>Re: [Bridge] Bridge support unavailable</title>

<DEFANGED_style>
<!--
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
	{color:blue;
	text-decoration:underline;}
p
	{margin-right:0in;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</DEFANGED_style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p><font size=3D2 face=3D"Times New Roman"><span DEFANGED_style=3D"font-siz=
e:10.0pt"><!-- Converted from text/plain format -->So
Linux does not have a &#8220;PATH&#8221; while booting? I have brctl in the
/bin and the /sbin directory.</span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span DEFANGED_style=3D"font-siz=
e:10.0pt">I looked
at the /etc/init.d/network&nbsp; script and there is mention of bridges but=
 no
direct call to brctl.</span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span DEFANGED_style=3D"font-siz=
e:10.0pt">Do you
think I would be better of recompiling the Kernel with bridging built in?</=
span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span DEFANGED_style=3D"font-siz=
e:10.0pt">&nbsp;</span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span DEFANGED_style=3D"font-siz=
e:10.0pt">Well...
You need to determine what script the error is coming from... </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">Probably /etc/rc.d=
/init.d/network
(or it could be /etc/init.d/network)</span></font> </p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span DEFANGED=
_style=3D"font-size:
12.0pt">&nbsp;</span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span DEFANGED_style=3D"font-siz=
e:10.0pt">Bert
 Hubbs</span></font><font size=3D2><span DEFANGED_style=3D"font-size:10.0pt=
"> wrote:</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; &quot; That s=
ounds like you
need the full path to brctl in your script.&quot;</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; What script?<=
/span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><font size=3D2><span
 DEFANGED_style=3D"font-size:10.0pt">Bert Hubbs</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; McGlinchey St=
afford and</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; Youngblood &a=
mp; Bendalin,
PLLC</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; 2711 N. Haske=
ll Ave.</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; Suite 2700, L=
B 25</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; Dallas, TX 75=
204</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; 214-257-1817 =
(direct dial)</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; 469-235-1817 =
(mobile)</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; 214-257-1881 =
(fax)</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; -----Original=
 Message-----</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; From: </span>=
</font><font
 size=3D2><span DEFANGED_style=3D"font-size:10.0pt">Bruce Ferrell</span></f=
ont><font size=3D2><span
DEFANGED_style=3D"font-size:10.0pt"> [<a href=3D"mailto:bferrell@baywinds.o=
rg">mailto:bferrell@baywinds.org</a>]
</span></font><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; Sent: Monday,=
 July 05, 2004
9:41 PM</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; To: </span></=
font><font
 size=3D2><span DEFANGED_style=3D"font-size:10.0pt">Bert Hubbs</span></font=
> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; Cc: </span></=
font><font
 size=3D2><span DEFANGED_style=3D"font-size:10.0pt">bridge@lists.osdl.org</=
span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; Subject: Re: =
[Bridge] Bridge </span></font><font
 size=3D2><span DEFANGED_style=3D"font-size:10.0pt">support</span></font><f=
ont size=3D2><span
DEFANGED_style=3D"font-size:10.0pt"> unavailable</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; That sounds l=
ike you need the
full path to brctl in your script.</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; Which leads m=
e to MY question
for the list.&nbsp; I'm having problem getting </span></font><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; bridge.o to b=
uild correctly on
2.4.25 (linus).&nbsp; Is this a case where I'd</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; be better off=
 with it built
static?</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><font size=3D2><span
 DEFANGED_style=3D"font-size:10.0pt">Bert Hubbs</span></font><font size=3D2=
><span
DEFANGED_style=3D"font-size:10.0pt"> wrote:</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;When I sta=
rt Linux I get an
error:</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;&quot;Brid=
ge </span></font><font
 size=3D2><span DEFANGED_style=3D"font-size:10.0pt">support</span></font><f=
ont size=3D2><span
DEFANGED_style=3D"font-size:10.0pt"> unavailable: brctl not found&quot;. </=
span></font><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;And then e=
th0 - 2 load with
no problems. After system is up I can</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; build</span><=
/font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;the bridge=
 but it does not
survive a reboot. Do I need a startup</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; script</span>=
</font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;or should =
it build from
the:</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;/etc/init.=
d/bridge</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;/etc/sysco=
nfig/network-scripts/ifcfg-bro</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;/etc/sysco=
nfig/network-scripts/ifcfg-eth0</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;/etc/sysco=
nfig/network-scripts/ifcfg-eth1</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;/etc/sysco=
nfig/network-scripts/ifcfg-eth2</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;I am using=
 Core2 </span></font><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont><font size=3D2><span
 DEFANGED_style=3D"font-size:10.0pt">Bert Hubbs</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;McGlinchey=
 Stafford and</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;Youngblood=
 &amp; Bendalin,
PLLC</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;2711 N. Ha=
skell Ave.</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;Suite 2700=
, LB 25</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;Dallas, TX=
 75204</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;214-257-18=
17 (direct dial)</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;469-235-18=
17 (mobile)</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;214-257-18=
81 (fax)</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;The inform=
ation contained
in this e-mail message is intended only for</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; the personal =
and confidential
use of the recipient(s) named above. This</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; message may b=
e an
attorney-client communication and/or work product and</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; as such is pr=
ivileged and
confidential. If the reader of this message is</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; not the inten=
ded recipient or
an agent responsible for delivering it to</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; the intended =
recipient, you
are hereby notified that you have received</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; this document=
 in error and
that any review, dissemination, distribution,</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; or copying of=
 this message is
strictly prohibited. If you have received</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; this communic=
ation in error,
please notify us immediately by e-mail, and</span></font> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; delete the or=
iginal message. </span></font><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;</span></f=
ont> <br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;
------------------------------------------------------------------------</s=
pan></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;__________=
_____________________________________</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;Bridge mai=
ling list</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;Bridge@lis=
ts.osdl.org</span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt;&gt;<a
href=3D"http://lists.osdl.org/mailman/listinfo/bridge">http://lists.osdl.or=
g/mailman/listinfo/bridge</a></span></font>
<br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; </span></font=
><br>
<font size=3D2><span DEFANGED_style=3D"font-size:10.0pt">&gt; The informati=
on contained in
this e-mail message is intended only for the personal and confidential use =
of
the recipient(s) named above. This message may be an attorney-client
communication and/or work product and as such is privileged and confidentia=
l.
If the reader of this message is not the intended recipient or an agent
responsible for delivering it to the intended recipient, you are hereby
notified that you have received this document in error and that any review,
dissemination, distribution, or copying of this message is strictly prohibi=
ted.
If you have received this communication in error, please notify us immediat=
ely
by e-mail, and delete the original message. </span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span DEFANGED_style=3D"font-siz=
e:10.0pt">&gt; </span></font></p>

</div>

<br>The information contained in this e-mail message is intended only for t=
he personal and confidential use of the recipient(s) named above. This mess=
age may be an attorney-client communication and/or work product and as such=
 is privileged and confidential. If the reader of this message is not the i=
ntended recipient or an agent responsible for delivering it to the intended=
 recipient, you are hereby notified that you have received this document in=
 error and that any review, dissemination, distribution, or copying of this=
 message is strictly prohibited. If you have received this communication in=
 error, please notify us immediately by e-mail, and delete the original mes=
sage. </body>

</html>

------_=_NextPart_001_01C46844.F4545990--
