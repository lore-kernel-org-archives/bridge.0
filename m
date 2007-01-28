Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C74275.BB7E8286"
Date: Sat, 27 Jan 2007 16:46:22 -0800
Message-ID: <EBDEAF27DD61EA40A5DF1D15EAD9735389515E@krkexchange4.corp.clearwire.com>
References: <1169857805.28708.1.camel@linux-2n2q.site>
	<20070126210947.75c55177@localhost.localdomain>
From: "Brad Dameron" <Brad.Dameron@clearwire.com>
Subject: Re: [Bridge] Clear a mac from table?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C74275.BB7E8286
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This is true. But here is a scenario we are seeing. Here is our setup first.
=20
Customer is on Vlan4 which is bridged to VLAN10. Both vlan's are on the sam=
e switch. If data is streaming in on vlan10 to the vlan4 bridge, then we sw=
itch the customer to vlan10, the streaming data will continue on to the bri=
dge server and the customer will not be able to transfer data until that st=
ream dies or if the timer just happens to be expiring for that MAC. So we n=
eed to clear the mac. I did a brctl setageing 3 to set the timer lower. But=
 what effect could this have when I have some 50k to 100k mac's known by th=
e bridging server?
=20
Thanks,
Brad Dameron
Clearw're
Network Engineer TierII
=20

________________________________

From: Stephen Hemminger [mailto:shemminger@linux-foundation.org]
Sent: Fri 1/26/2007 9:09 PM
To: Brad Dameron
Cc: bridge@lists.osdl.org
Subject: Re: [Bridge] Clear a mac from table?



On Fri, 26 Jan 2007 16:30:05 -0800
Brad Dameron <brad.dameron@clearwire.com> wrote:

>
> Anyone know of a way to clear a mac from the bridge hash table instead
> of waiting for it to expire? This would be handy with pushing people
> between vlans that are on the same switch.

No API exists but the first transmit (gratuitous ARP?) would
move the entry.



------_=_NextPart_001_01C74275.BB7E8286
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>

<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7638.1">
<TITLE>Re: [Bridge] Clear a mac from table?</TITLE>
</HEAD>
<BODY>
<DIV id=3DidOWAReplyText62911 dir=3Dltr>
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>This is true. Bu=
t here is a=20
scenario we are seeing. Here is our setup first.</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Customer is on Vlan4 which is br=
idged to=20
VLAN10. Both vlan's are on the same switch. If data is streaming in on vlan=
10 to=20
the vlan4 bridge, then we switch the customer to vlan10, the streaming data=
 will=20
continue on to the bridge server&nbsp;and the customer will not be able to=
=20
transfer data until that stream dies or if the timer just happens to be exp=
iring=20
for that MAC. So we need to clear the mac. I did a brctl setageing 3 to set=
 the=20
timer lower. But what effect could this have when I have some 50k to 100k m=
ac's=20
known by the bridging server?</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Brad Dameron</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Clearw're</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Network Engineer TierII</FONT></=
DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></DIV>
<DIV dir=3Dltr><BR>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> Stephen Hemminger=20
[mailto:shemminger@linux-foundation.org]<BR><B>Sent:</B> Fri 1/26/2007 9:09=
=20
PM<BR><B>To:</B> Brad Dameron<BR><B>Cc:</B>=20
bridge@lists.osdl.org<BR><B>Subject:</B> Re: [Bridge] Clear a mac from=20
table?<BR></FONT><BR></DIV>
<DIV>
<P><FONT size=3D2>On Fri, 26 Jan 2007 16:30:05 -0800<BR>Brad Dameron=20
&lt;brad.dameron@clearwire.com&gt; wrote:<BR><BR>&gt;<BR>&gt; Anyone know o=
f a=20
way to clear a mac from the bridge hash table instead<BR>&gt; of waiting fo=
r it=20
to expire? This would be handy with pushing people<BR>&gt; between vlans th=
at=20
are on the same switch.<BR><BR>No API exists but the first transmit (gratui=
tous=20
ARP?) would<BR>move the entry.<BR></FONT></P></DIV>

</BODY>
</HTML>
------_=_NextPart_001_01C74275.BB7E8286--
