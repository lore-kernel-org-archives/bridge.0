Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8B55D.6F1FCA7C"
Date: Tue, 13 May 2008 17:55:36 -0700
Message-ID: <6724EAC831AA6A4FBB9C93DFAD3A3BDCCBC166@corexchange3.corp.clearwire.com>
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se><2e59e6970805071916r701987fdx49bab341420ba2d@mail.gmail.com><1210233718.32216.121.camel@gentoo-jocke.transmode.se><2e59e6970805122010v50dcd5al101ae3466b897ad6@mail.gmail.com><m3abiua957.fsf@ursa.amorsen.dk><1210717793.5774.10.camel@collymore.citylink.co.nz><2e59e6970805131609q4e93a278gfd1fb094264519d0@mail.gmail.com>
	<1210722963.5774.18.camel@collymore.citylink.co.nz>
From: "Brad Dameron" <Brad.Dameron@clearwire.com>
Subject: Re: [Bridge] STP bug, loop not detetcted
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8B55D.6F1FCA7C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

We run very large layer 2 networks and have had a broadcast storm loop =
take out our network in seconds. Mainly due to someone stopping the =
firewall rules on the box. IPTables is the best cure for this. We stop =
broadcasts out one interface.=20
=20
Brad

________________________________

From: bridge-bounces@lists.linux-foundation.org on behalf of Dylan Hall
Sent: Tue 5/13/2008 4:56 PM
To: bridge@osdl.org
Subject: Re: [Bridge] STP bug, loop not detetcted


If you're going in implement some kind of userland (or I suppose kernel) =
daemon that is interested in detecting either the one special case =
described previously, or the more general case "my layer 2 network has =
melted, protect yourself" it shouldn't matter.  You can implement any =
criteria you like for detecting and preventing loops.=20

The key here is that these special cases are handled by another process =
so your STP can remain standards compliant.=20

Dylan


On Tue, 2008-05-13 at 23:09 +0000, richardvoigt@gmail.com wrote:=20

	On Tue, May 13, 2008 at 10:29 PM, Dylan Hall <dylan@citylink.co.nz> =
wrote:
	>
	>  I've only been half following this thread, but is sounds a lot like =
you're
	> discussing a problem that has already been solved by Cisco (and I =
assume
	> others).
	>
	>  Most Cisco switches will generate a loopback packet (ethertype =
0x9000) at
	> fairly regular intervals.  Both the src and dst mac addresses are set =
to the
	> interface mac of the port emitting the packets.  In the event a loop =
exists
	> in the network that hasn't been dealt with by (R)STP the switch will =
receive
	> the packet back on another of it's interfaces.  In the event one of =
the
=09
	That's the difference, in the case described in this thread the packet
	comes back to the same interface, not another one.
=09
=09
	> loopback packets does make it back to the switch the port is =
error-disabled
	> (I can't remember if it's the sending or receiving port that is =
disabled).
	> This mechanism is independent of STP.
	>
	>  UDLD also seems to have a mechanism to detect a port that is looped =
back on
	> itself.  Again, independent of STP.
	>
	>  Rather than modifying STP would it not be better to implement =
something
	> like the above as a standalone daemon?
	>
	>  Dylan
	>
	>
	>
	>
	>  On Tue, 2008-05-13 at 10:41 +0200, Benny Amorsen wrote:
	>  "richardvoigt@gmail.com" <richardvoigt@gmail.com> writes:
	>
	> > For example, this topology:
	> >
	> > br0 - br1 - br2 - br3 - br1
	> >
	> > There is a loop in br1-br2-br3-br1, so br0 sees its packet come =
back
	> > on the same interface. If br0 shuts down the interface, it breaks
	> > connectivity. The br0-br1 link is part of a minimal spanning tree =
so
	> > STP cannot shut it down.
	>
	> Since the alternative is to melt due to traffic overload, the switch
	> sure can shut it down. That breaks connectivity, but only for the
	> broken segment. Not shutting the interface means everyone gets hurt.
	>
	>
	> /Benny
	>
	>
	> _______________________________________________
	> Bridge mailing list
	> Bridge@lists.linux-foundation.org
	> https://lists.linux-foundation.org/mailman/listinfo/bridge
	>
	>
	> _______________________________________________
	>  Bridge mailing list
	>  Bridge@lists.linux-foundation.org
	>  https://lists.linux-foundation.org/mailman/listinfo/bridge
	>


------_=_NextPart_001_01C8B55D.6F1FCA7C
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText43559 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>We run very =
large layer 2 networks and have had a broadcast storm loop take out our =
network in seconds. Mainly due to someone stopping the firewall rules on =
the box. IPTables is the best cure for this. We stop broadcasts out one =
interface. </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Brad</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> =
bridge-bounces@lists.linux-foundation.org on behalf of Dylan =
Hall<BR><B>Sent:</B> Tue 5/13/2008 4:56 PM<BR><B>To:</B> =
bridge@osdl.org<BR><B>Subject:</B> Re: [Bridge] STP bug, loop not =
detetcted<BR></FONT><BR></DIV>=0A=
<DIV>If you're going in implement some kind of userland (or I suppose =
kernel) daemon that is interested in detecting either the one special =
case described previously, or the more general case "my layer 2 network =
has melted, protect yourself" it shouldn't matter.&nbsp; You can =
implement any criteria you like for detecting and preventing loops. =
<BR><BR>The key here is that these special cases are handled by another =
process so your STP can remain standards compliant. =
<BR><BR>Dylan<BR><BR><BR>On Tue, 2008-05-13 at 23:09 +0000, =
richardvoigt@gmail.com wrote: =0A=
<BLOCKQUOTE TYPE=3D"CITE"><PRE><FONT color=3D#000000>On Tue, May 13, =
2008 at 10:29 PM, Dylan Hall &lt;<A =
href=3D"mailto:dylan@citylink.co.nz">dylan@citylink.co.nz</A>&gt; =
wrote:</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt;  I've only been half following this thread, =
but is sounds a lot like you're</FONT>=0A=
<FONT color=3D#000000>&gt; discussing a problem that has already been =
solved by Cisco (and I assume</FONT>=0A=
<FONT color=3D#000000>&gt; others).</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt;  Most Cisco switches will generate a loopback =
packet (ethertype 0x9000) at</FONT>=0A=
<FONT color=3D#000000>&gt; fairly regular intervals.  Both the src and =
dst mac addresses are set to the</FONT>=0A=
<FONT color=3D#000000>&gt; interface mac of the port emitting the =
packets.  In the event a loop exists</FONT>=0A=
<FONT color=3D#000000>&gt; in the network that hasn't been dealt with by =
(R)STP the switch will receive</FONT>=0A=
<FONT color=3D#000000>&gt; the packet back on another of it's =
interfaces.  In the event one of the</FONT>=0A=
=0A=
<FONT color=3D#000000>That's the difference, in the case described in =
this thread the packet</FONT>=0A=
<FONT color=3D#000000>comes back to the same interface, not another =
one.</FONT>=0A=
=0A=
=0A=
<FONT color=3D#000000>&gt; loopback packets does make it back to the =
switch the port is error-disabled</FONT>=0A=
<FONT color=3D#000000>&gt; (I can't remember if it's the sending or =
receiving port that is disabled).</FONT>=0A=
<FONT color=3D#000000>&gt; This mechanism is independent of STP.</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt;  UDLD also seems to have a mechanism to =
detect a port that is looped back on</FONT>=0A=
<FONT color=3D#000000>&gt; itself.  Again, independent of STP.</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt;  Rather than modifying STP would it not be =
better to implement something</FONT>=0A=
<FONT color=3D#000000>&gt; like the above as a standalone daemon?</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt;  Dylan</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt;  On Tue, 2008-05-13 at 10:41 +0200, Benny =
Amorsen wrote:</FONT>=0A=
<FONT color=3D#000000>&gt;  "<A =
href=3D"mailto:richardvoigt@gmail.com">richardvoigt@gmail.com</A>" =
&lt;<A =
href=3D"mailto:richardvoigt@gmail.com">richardvoigt@gmail.com</A>&gt; =
writes:</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt; &gt; For example, this topology:</FONT>=0A=
<FONT color=3D#000000>&gt; &gt;</FONT>=0A=
<FONT color=3D#000000>&gt; &gt; br0 - br1 - br2 - br3 - br1</FONT>=0A=
<FONT color=3D#000000>&gt; &gt;</FONT>=0A=
<FONT color=3D#000000>&gt; &gt; There is a loop in br1-br2-br3-br1, so =
br0 sees its packet come back</FONT>=0A=
<FONT color=3D#000000>&gt; &gt; on the same interface. If br0 shuts down =
the interface, it breaks</FONT>=0A=
<FONT color=3D#000000>&gt; &gt; connectivity. The br0-br1 link is part =
of a minimal spanning tree so</FONT>=0A=
<FONT color=3D#000000>&gt; &gt; STP cannot shut it down.</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt; Since the alternative is to melt due to =
traffic overload, the switch</FONT>=0A=
<FONT color=3D#000000>&gt; sure can shut it down. That breaks =
connectivity, but only for the</FONT>=0A=
<FONT color=3D#000000>&gt; broken segment. Not shutting the interface =
means everyone gets hurt.</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt; /Benny</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt; =
_______________________________________________</FONT>=0A=
<FONT color=3D#000000>&gt; Bridge mailing list</FONT>=0A=
<FONT color=3D#000000>&gt; <A =
href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-foun=
dation.org</A></FONT>=0A=
<FONT color=3D#000000>&gt; <A =
href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge">https=
://lists.linux-foundation.org/mailman/listinfo/bridge</A></FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
<FONT color=3D#000000>&gt; =
_______________________________________________</FONT>=0A=
<FONT color=3D#000000>&gt;  Bridge mailing list</FONT>=0A=
<FONT color=3D#000000>&gt;  <A =
href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-foun=
dation.org</A></FONT>=0A=
<FONT color=3D#000000>&gt;  <A =
href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge">https=
://lists.linux-foundation.org/mailman/listinfo/bridge</A></FONT>=0A=
<FONT color=3D#000000>&gt;</FONT>=0A=
</PRE></BLOCKQUOTE></DIV></BODY></HTML>
------_=_NextPart_001_01C8B55D.6F1FCA7C--
