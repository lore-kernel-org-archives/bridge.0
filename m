Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C907EC.B1B7E372"
Date: Tue, 26 Aug 2008 19:29:12 -0700
Message-ID: <FB2A2D2F36FC264282887DD51732C0200160D2D8@magmsg03.ad.magnumsemi.com>
From: "Suresh Bhaskaran" <Suresh.Bhaskaran@magnumsemi.com>
Subject: [Bridge] Socket Buffer bridging of Ethernet frames
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, Stephen Hemminger <shemminger@linux-foundation.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C907EC.B1B7E372
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I am requesting a sanity check on my "driver-level" bridging approach in
this e-mail.  Please let me know if you see any "gotcha's" in this
approach.

=20

Problem:

*	I have a single physical ethernet device on my embedded linux
target, and I want to bridge packets to/from a device across on the
other side of a shared memory, that also processes ethernet data.
*	For a variety of reasons, I can't use the "brctl addbr" utility
(I've tried!), so I'm implementing the bridging functionality for this
specific case, at the driver level.

=20

My approach:

*	Modify the existing ethernet driver by adding some additional
code:
*	Whenever I receive a packet on the physical ethernet:

	*	Just before sending the skb to the network interface
(netif_rx(skb)), also push the packet to shmem.

*	Whenever I send a packet to the physical ethernet:

	*	Before pushing the packet to the physical ethernet
device, also push the packet to shared memory.

*	When I receive a packet from the "shared memory" device:

	*	Build up two copies of an skb
	*	Get the handle to the network device by doing a
dev_get_by_name("eth0")
	*	Push one up to the netif (netif_rx(skb))
	*	Push the other (identical) skb to the physical ethernet
device.
	*	dev_put("eth0") when I'm done.

*	I use netif_stop_queue() and netif_wake_queue() for flow control
to the network interface, but for shmem congestion, I just drop packets
(for now), since I don't have "easy" queue api's for flow control
handy..

=20

Some questions/concerns I have:

=20

*	is there something in the skb that has "directionality"?

	*	That is, if I take and skb that is intended to go to the
network interface (e.g. netif_rx(skb)), and "push" it down to physical
device, will something get usynchronized?
	*	Or, if I get an skb from the system (from the
hard_start_xmit()), can I "push" it up again to the netif, or will some
"directionality" thing in the skb make things go out of whack?
	*	Also, if I push all these additional created skb's up to
the interface, or down, is there some "count" between the system netif
and the physical device that may get out of whack, and out of sync?

*	Also, is there something like a "man" pages for the above api's,
and also skb questions? (other than the source code)?  I wasn't to find
a good man page on the above by few minutes "google"

=20

In any case, I'm already partially along this approach, but I sure could
use any advance warning of potential issues and workarounds!

=20

Thanks again.

=20

Suresh Bhaskaran

=20


------_=_NextPart_001_01C907EC.B1B7E372
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:124468319;
	mso-list-type:hybrid;
	mso-list-template-ids:-1984378760 67698689 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1
	{mso-list-id:185294753;
	mso-list-type:hybrid;
	mso-list-template-ids:-1072797180 67698689 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2
	{mso-list-id:598682829;
	mso-list-type:hybrid;
	mso-list-template-ids:-134083424 67698689 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>I am requesting a sanity check on my &#8220;driver-level&#8221;
bridging approach in this e-mail.&nbsp; Please let me know if you see =
any
&#8220;gotcha&#8217;s&#8221; in this =
approach.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Problem:<o:p></o:p></span></font></p>

<ul style=3D'margin-top:0in' type=3Ddisc>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1'><font size=3D3
     face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>I have a =
single
     physical ethernet device on my embedded linux target, and I want to =
bridge
     packets to/from a device across on the other side of a shared =
memory, that
     also processes ethernet data.<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1'><font size=3D3
     face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>For a =
variety of
     reasons, I can&#8217;t use the &#8220;brctl addbr&#8221; utility
     (I&#8217;ve tried!), so I&#8217;m implementing the bridging =
functionality
     for this specific case, at the driver =
level.<o:p></o:p></span></font></li>
</ul>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>My approach:<o:p></o:p></span></font></p>

<ul style=3D'margin-top:0in' type=3Ddisc>
 <li class=3DMsoNormal style=3D'mso-list:l1 level1 lfo2'><font size=3D3
     face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Modify =
the existing
     ethernet driver by adding some additional =
code:<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l1 level1 lfo2'><font size=3D3
     face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Whenever =
I receive a
     packet on the physical ethernet:<o:p></o:p></span></font></li>
 <ul style=3D'margin-top:0in' type=3Dcircle>
  <li class=3DMsoNormal style=3D'mso-list:l1 level2 lfo2'><font size=3D3
      face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Just =
before sending
      the skb to the network interface (netif_rx(skb)), also push the =
packet to
      shmem.<o:p></o:p></span></font></li>
 </ul>
 <li class=3DMsoNormal style=3D'mso-list:l1 level1 lfo2'><font size=3D3
     face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Whenever =
I send a
     packet to the physical ethernet:<o:p></o:p></span></font></li>
 <ul style=3D'margin-top:0in' type=3Dcircle>
  <li class=3DMsoNormal style=3D'mso-list:l1 level2 lfo2'><font size=3D3
      face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Before =
pushing the
      packet to the physical ethernet device, also push the packet to =
shared
      memory.<o:p></o:p></span></font></li>
 </ul>
 <li class=3DMsoNormal style=3D'mso-list:l1 level1 lfo2'><font size=3D3
     face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>When I =
receive a
     packet from the &#8220;shared memory&#8221; =
device:<o:p></o:p></span></font></li>
 <ul style=3D'margin-top:0in' type=3Dcircle>
  <li class=3DMsoNormal style=3D'mso-list:l1 level2 lfo2'><font size=3D3
      face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Build up =
two copies
      of an skb<o:p></o:p></span></font></li>
  <li class=3DMsoNormal style=3D'mso-list:l1 level2 lfo2'><font size=3D3
      face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Get the =
handle to
      the network device by doing a =
dev_get_by_name(&#8220;eth0&#8221;)<o:p></o:p></span></font></li>
  <li class=3DMsoNormal style=3D'mso-list:l1 level2 lfo2'><font size=3D3
      face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Push one =
up to the
      netif (netif_rx(skb))<o:p></o:p></span></font></li>
  <li class=3DMsoNormal style=3D'mso-list:l1 level2 lfo2'><font size=3D3
      face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Push the =
other
      (identical) skb to the physical ethernet =
device.<o:p></o:p></span></font></li>
  <li class=3DMsoNormal style=3D'mso-list:l1 level2 lfo2'><font size=3D3
      face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>dev_put(&#8220;eth0&#8221;)
      when I&#8217;m done.<o:p></o:p></span></font></li>
 </ul>
 <li class=3DMsoNormal style=3D'mso-list:l1 level1 lfo2'><font size=3D3
     face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>I use
     netif_stop_queue() and netif_wake_queue() for flow control to the =
network interface,
     but for shmem congestion, I just drop packets (for now), since I
     don&#8217;t have &#8220;easy&#8221; queue api&#8217;s for flow =
control handy..<o:p></o:p></span></font></li>
</ul>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Some questions/concerns I have:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<ul style=3D'margin-top:0in' type=3Ddisc>
 <li class=3DMsoNormal style=3D'mso-list:l2 level1 lfo3'><font size=3D3
     face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>is there =
something
     in the skb that has =
&#8220;directionality&#8221;?<o:p></o:p></span></font></li>
 <ul style=3D'margin-top:0in' type=3Dcircle>
  <li class=3DMsoNormal style=3D'mso-list:l2 level2 lfo3'><font size=3D3
      face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>That is, =
if I take
      and skb that is intended to go to the network interface (e.g.
      netif_rx(skb)), and &#8220;push&#8221; it down to physical device, =
will
      something get usynchronized?<o:p></o:p></span></font></li>
  <li class=3DMsoNormal style=3D'mso-list:l2 level2 lfo3'><font size=3D3
      face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Or, if I =
get an skb
      from the system (from the hard_start_xmit()), can I =
&#8220;push&#8221; it
      up again to the netif, or will some &#8220;directionality&#8221; =
thing in
      the skb make things go out of whack?<o:p></o:p></span></font></li>
  <li class=3DMsoNormal style=3D'mso-list:l2 level2 lfo3'><font size=3D3
      face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Also, if =
I push all
      these additional created skb&#8217;s up to the interface, or down, =
is
      there some &#8220;count&#8221; between the system netif and the =
physical
      device that may get out of whack, and out of =
sync?<o:p></o:p></span></font></li>
 </ul>
 <li class=3DMsoNormal style=3D'mso-list:l2 level1 lfo3'><font size=3D3
     face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Also, is =
there
     something like a &#8220;man&#8221; pages for the above api&#8217;s, =
and
     also skb questions? (other than the source code)?&nbsp; I =
wasn&#8217;t to find
     a good man page on the above by few minutes =
&#8220;google&#8221;<o:p></o:p></span></font></li>
</ul>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>In any case, I&#8217;m already partially along this approach, =
but I sure
could use any advance warning of potential issues and =
workarounds!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Thanks again.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Suresh Bhaskaran<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C907EC.B1B7E372--
