Content-Transfer-Encoding: 7bit
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8E1AE.4242A729"
Date: Wed, 9 Jul 2008 11:25:38 +0100
Message-ID: <89ADFB63BC286B49BC71F1D34A7E38D612D860@EXVS01.aenigmacorp.com>
From: "Geoff Wiener" <gwiener@aenigmacorp.com>
Subject: [Bridge] openBSD Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@linuxfoundation.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8E1AE.4242A729
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear List;

=20

This is my first post to this list, I have tried to find the answer to
this question on my own but have not been able to get anything
definitive.  Please excuse me if this question has been asked before.
The main question is this.  "Is this bridge code the same as what is
implemented in openBSD?"  Can someone point me to some definitive
information about this?

=20

I am involved in Layer 2 firewalls implementation project.  A precedent
exists in the customer organisation for the use of openBSD for this
purpose.  In the most recent implementation the design has a layer 2
loop built in for redundancy which is handled by Cisco PVST.  We
discovered that the bridging software in openBSD 4.3 does not pass Cisco
PVST BPDUs.

=20

My research has lead me to the following:

 =20

http://www.openbsd.org/cgi-bin/man.cgi?query=3Dbridge&apropos=3D0&sektion=
=3D0&
manpath=3DOpenBSD+Current&arch=3Di386&format=3Dhtml

=20

The above link discusses how the bridge works and mentions that the
bridge itself can be configured as a STP bridge, but that it STP can
also be disabled.  Since openBSD bridges use RSTP (Rapid Spanning Tree)
not PVST as required by the customer we elected to disable RSTP on the
bridge.

=20

The next URL is to a message posted this list by user Cameron Schaus, On
Fri, 08 Dec 2006 18:24:07 -0500 which is responded Stephen Hemminger.

=20

http://osdir.com/ml/network.bridge/2006-12/msg00023.html

=20

Cameron describes a scenario in detail which completely describes our
scenario at a very basic level.  In particular he asks of the behaviour
of the bridging has changed from 2.1.15 and 2.1.17 as he noticed that
BPDU's are no longer being passed.  Stephen replied, "The change was
intentional because the bridge follows the 802 spec and doesn't pass
link local multicast frames. If you are running STP on the network, you
need to run STP on the bridge."

=20

Further investigation produced the following thread
=20
https://lists.linux-foundation.org/pipermail/bridge/2007-April/005406.ht
ml
=20
On Mon Apr 23 16:56:14 PDT 2007, Stephen Hemminger comments that it is
more important to allow networking devices other than the bridging
software to manage the topology.   "I think if STP is disabled, the
bridge would be more stable if it just forwarded the spanning tree
packets.  The rationale is that if someone leaves STP off on one bridge,
but there are multiple paths from a bridge that is using spanning tree;
then the bridge that is doing STP will see and break the potentially
disastrous network loop.  Therefore, I suggest the following (probably
not until 2.6.22)", a code sample follows.

=20

We confirmed this in the lab.  The first test consisted of a CentOS 5.1
host running the 2.6.18.8 kernel.  This kernel behaved exactly like
openBSD and blocked PVST BPDUs.  Rather than re-compile a post 2.6.22
kernel for CentOS it was easier to install Ubuntu 8.04 (Hardy Heron) on
the same server and carry out the test again.  The Ubuntu kernel was
2.6.24-19-generic.  In this test the PVST BPDU's were passed correctly
through the Linux host allowing the switch to block one of the links.
The bridge behaved as per our design by allowing PVST BPDUs to pass.
=20

Can someone comment on our findings?  Was a decision made initially to
prevent PVST BPDU's from passing and then a change made to allow it?  I
am not a developer and have not gone through the code.  The above
evidence, and our lab testing, tends to point to this.  I am seeking an
additional, authoritative verification.  Stephen if you are able to
spare a couple of minutes to comment on this we would be grateful for
your thoughts.=20

=20

Thank you for reading, many thanks and best regards - In any case we
love the open source bridge software and thank you all for your efforts.

=20

Geoff Wiener


------_=_NextPart_001_01C8E1AE.4242A729
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:D=3D"DAV:" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sub=3D"http://schemas.microsoft.com/sharepoint/soap/2002/1/alerts/"=
 xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#" =
xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" =
xmlns:mver=3D"http://schemas.openxmlformats.org/markup-compatibility/2006=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns:mrels=3D"http://schemas.openxmlformats.org/package/2006/relationshi=
ps" =
xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/2006/types"=
 =
xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/2006/messag=
es" xmlns:Z=3D"urn:schemas-microsoft-com:" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-GB link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Dear List;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>This is my first post to this list, I have tried to =
find the
answer to this question on my own but have not been able to get anything
definitive. &nbsp;Please excuse me if this question has been asked =
before.&nbsp;
The main question is this.&nbsp; &#8220;Is this bridge code the same as =
what is
implemented in openBSD?&#8221;&nbsp; Can someone point me to some =
definitive information
about this?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I am involved in Layer 2 firewalls implementation =
project.&nbsp;
A precedent exists in the customer organisation for the use of openBSD =
for this
purpose.&nbsp; In the most recent implementation the design has a layer =
2 loop
built in for redundancy which is handled by Cisco PVST.&nbsp; We =
discovered that
the bridging software in openBSD 4.3 does not pass Cisco PVST =
BPDUs.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>My research has lead me to the =
following:<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; <o:p></o:p></p>

<p class=3DMsoNormal><a
href=3D"http://www.openbsd.org/cgi-bin/man.cgi?query=3Dbridge&amp;apropos=
=3D0&amp;sektion=3D0&amp;manpath=3DOpenBSD+Current&amp;arch=3Di386&amp;fo=
rmat=3Dhtml">http://www.openbsd.org/cgi-bin/man.cgi?query=3Dbridge&amp;ap=
ropos=3D0&amp;sektion=3D0&amp;manpath=3DOpenBSD+Current&amp;arch=3Di386&a=
mp;format=3Dhtml</a><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The above link discusses how the bridge works and =
mentions
that the bridge itself can be configured as a STP bridge, but that it =
STP can
also be disabled.&nbsp; Since openBSD bridges use RSTP (Rapid Spanning =
Tree) not
PVST as required by the customer we elected to disable RSTP on the =
bridge.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The next URL is to a message posted this list by =
user
Cameron Schaus, On Fri, 08 Dec 2006 18:24:07 -0500 which is responded<i> =
</i><em><span
style=3D'font-family:"Calibri","sans-serif";font-style:normal'>Stephen =
Hemminger.</span></em><em><span
lang=3DEN-US =
style=3D'font-family:"Calibri","sans-serif";font-style:normal'><o:p></o:p=
></span></em></p>

<p class=3DMsoNormal><em><span =
style=3D'font-family:"Calibri","sans-serif";
font-style:normal'><o:p>&nbsp;</o:p></span></em></p>

<p class=3DMsoNormal><em><span =
style=3D'font-family:"Calibri","sans-serif";
font-style:normal'><a
href=3D"http://osdir.com/ml/network.bridge/2006-12/msg00023.html">http://=
osdir.com/ml/network.bridge/2006-12/msg00023.html</a><o:p></o:p></span></=
em></p>

<p class=3DMsoNormal><em><span =
style=3D'font-family:"Calibri","sans-serif";
font-style:normal'><o:p>&nbsp;</o:p></span></em></p>

<pre><em><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
font-style:normal'>Cameron describes a scenario in detail which =
completely describes our scenario at a very basic level.&nbsp; In =
particular he asks of the behaviour of the bridging has changed from =
</span></em><i><span
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif"'>2.1.15 and =
2.1.17 </span></i><span
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif"'>as he =
noticed that BPDU&#8217;s are no longer being passed.&nbsp; Stephen =
replied, &#8220;</span>The change was intentional because the bridge =
follows the 802 spec and doesn't pass link local multicast frames. If =
you are running STP on the network, you need to run STP on the =
bridge.<span
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif"'>&#8221;</sp=
an><span
lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif"'><o:p></o:p>=
</span></pre>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<pre><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif"'>Further =
investigation produced the following =
thread<o:p></o:p></span></pre><pre><span
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif"'><o:p>&nbsp;=
</o:p></span></pre><pre><span
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif"'><a
href=3D"https://lists.linux-foundation.org/pipermail/bridge/2007-April/00=
5406.html">https://lists.linux-foundation.org/pipermail/bridge/2007-April=
/005406.html</a><o:p></o:p></span></pre><pre><span
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif"'><o:p>&nbsp;=
</o:p></span></pre><pre><span
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif"'>On Mon Apr =
23 16:56:14 PDT 2007, Stephen Hemminger comments that it is more =
important to allow networking devices other than the bridging software =
to manage the topology.&nbsp; &nbsp;&#8220;</span>I think if STP is =
disabled, the bridge would be more stable if it just forwarded the =
spanning tree packets.&nbsp; The rationale is that if someone leaves STP =
off on one bridge, but there are multiple paths from a bridge that is =
using spanning tree; then the bridge that is doing STP will see and =
break the potentially disastrous network loop.&nbsp; Therefore, I =
suggest the following (probably not until 2.6.22)&#8221;, <span
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif"'>a code =
sample follows.</span><o:p></o:p></pre>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<pre><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif"'>We =
confirmed this in the lab.&nbsp; The first test consisted of a CentOS =
5.1 host running the 2.6.18.8 kernel.&nbsp; This kernel behaved exactly =
like openBSD and blocked PVST BPDUs.&nbsp; Rather than re-compile a post =
2.6.22 kernel for CentOS it was easier to install Ubuntu 8.04 (Hardy =
Heron) on the same server and carry out the test again.&nbsp; The Ubuntu =
kernel was &nbsp;2.6.24-19-generic.&nbsp; In this test the PVST =
BPDU&#8217;s were passed correctly through the Linux host allowing the =
switch to block one of the links.&nbsp; The bridge behaved as per our =
design by allowing PVST BPDUs to pass.<o:p></o:p></span></pre><pre><span
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif"'><o:p>&nbsp;=
</o:p></span></pre>

<p class=3DMsoNormal>Can someone comment on our findings?&nbsp; Was a =
decision
made initially to prevent PVST BPDU&#8217;s from passing and then a =
change made
to allow it?&nbsp; I am not a developer and have not gone through the
code.&nbsp; The above evidence, and our lab testing, tends to point to =
this.&nbsp;
I am seeking an additional, authoritative verification.&nbsp; Stephen if =
you
are able to spare a couple of minutes to comment on this we would be =
grateful
for your thoughts. <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thank you for reading, many thanks and best regards =
&#8211; In
any case we love the open source bridge software and thank you all for =
your
efforts.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Geoff Wiener<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8E1AE.4242A729--
