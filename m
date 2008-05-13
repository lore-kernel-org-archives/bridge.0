From: Dylan Hall <dylan@citylink.co.nz>
In-Reply-To: <2e59e6970805131609q4e93a278gfd1fb094264519d0@mail.gmail.com>
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>
	<2e59e6970805071916r701987fdx49bab341420ba2d@mail.gmail.com>
	<1210233718.32216.121.camel@gentoo-jocke.transmode.se>
	<2e59e6970805122010v50dcd5al101ae3466b897ad6@mail.gmail.com>
	<m3abiua957.fsf@ursa.amorsen.dk>
	<1210717793.5774.10.camel@collymore.citylink.co.nz>
	<2e59e6970805131609q4e93a278gfd1fb094264519d0@mail.gmail.com>
Content-Type: multipart/alternative; boundary="=-ojsI7OuqBCQEQFW3ETtr"
Date: Wed, 14 May 2008 11:56:03 +1200
Message-Id: <1210722963.5774.18.camel@collymore.citylink.co.nz>
Mime-Version: 1.0
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


--=-ojsI7OuqBCQEQFW3ETtr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

If you're going in implement some kind of userland (or I suppose kernel)
daemon that is interested in detecting either the one special case
described previously, or the more general case "my layer 2 network has
melted, protect yourself" it shouldn't matter.  You can implement any
criteria you like for detecting and preventing loops. 

The key here is that these special cases are handled by another process
so your STP can remain standards compliant. 

Dylan


On Tue, 2008-05-13 at 23:09 +0000, richardvoigt@gmail.com wrote:

> On Tue, May 13, 2008 at 10:29 PM, Dylan Hall <dylan@citylink.co.nz> wrote:
> >
> >  I've only been half following this thread, but is sounds a lot like you're
> > discussing a problem that has already been solved by Cisco (and I assume
> > others).
> >
> >  Most Cisco switches will generate a loopback packet (ethertype 0x9000) at
> > fairly regular intervals.  Both the src and dst mac addresses are set to the
> > interface mac of the port emitting the packets.  In the event a loop exists
> > in the network that hasn't been dealt with by (R)STP the switch will receive
> > the packet back on another of it's interfaces.  In the event one of the
> 
> That's the difference, in the case described in this thread the packet
> comes back to the same interface, not another one.
> 
> 
> > loopback packets does make it back to the switch the port is error-disabled
> > (I can't remember if it's the sending or receiving port that is disabled).
> > This mechanism is independent of STP.
> >
> >  UDLD also seems to have a mechanism to detect a port that is looped back on
> > itself.  Again, independent of STP.
> >
> >  Rather than modifying STP would it not be better to implement something
> > like the above as a standalone daemon?
> >
> >  Dylan
> >
> >
> >
> >
> >  On Tue, 2008-05-13 at 10:41 +0200, Benny Amorsen wrote:
> >  "richardvoigt@gmail.com" <richardvoigt@gmail.com> writes:
> >
> > > For example, this topology:
> > >
> > > br0 - br1 - br2 - br3 - br1
> > >
> > > There is a loop in br1-br2-br3-br1, so br0 sees its packet come back
> > > on the same interface. If br0 shuts down the interface, it breaks
> > > connectivity. The br0-br1 link is part of a minimal spanning tree so
> > > STP cannot shut it down.
> >
> > Since the alternative is to melt due to traffic overload, the switch
> > sure can shut it down. That breaks connectivity, but only for the
> > broken segment. Not shutting the interface means everyone gets hurt.
> >
> >
> > /Benny
> >
> >
> > _______________________________________________
> > Bridge mailing list
> > Bridge@lists.linux-foundation.org
> > https://lists.linux-foundation.org/mailman/listinfo/bridge
> >
> >
> > _______________________________________________
> >  Bridge mailing list
> >  Bridge@lists.linux-foundation.org
> >  https://lists.linux-foundation.org/mailman/listinfo/bridge
> >

--=-ojsI7OuqBCQEQFW3ETtr
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.16.3">
</HEAD>
<BODY>
If you're going in implement some kind of userland (or I suppose kernel) daemon that is interested in detecting either the one special case described previously, or the more general case &quot;my layer 2 network has melted, protect yourself&quot; it shouldn't matter.&nbsp; You can implement any criteria you like for detecting and preventing loops. <BR>
<BR>
The key here is that these special cases are handled by another process so your STP can remain standards compliant. <BR>
<BR>
Dylan<BR>
<BR>
<BR>
On Tue, 2008-05-13 at 23:09 +0000, richardvoigt@gmail.com wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">On Tue, May 13, 2008 at 10:29 PM, Dylan Hall &lt;<A HREF="mailto:dylan@citylink.co.nz">dylan@citylink.co.nz</A>&gt; wrote:</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;  I've only been half following this thread, but is sounds a lot like you're</FONT>
<FONT COLOR="#000000">&gt; discussing a problem that has already been solved by Cisco (and I assume</FONT>
<FONT COLOR="#000000">&gt; others).</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;  Most Cisco switches will generate a loopback packet (ethertype 0x9000) at</FONT>
<FONT COLOR="#000000">&gt; fairly regular intervals.  Both the src and dst mac addresses are set to the</FONT>
<FONT COLOR="#000000">&gt; interface mac of the port emitting the packets.  In the event a loop exists</FONT>
<FONT COLOR="#000000">&gt; in the network that hasn't been dealt with by (R)STP the switch will receive</FONT>
<FONT COLOR="#000000">&gt; the packet back on another of it's interfaces.  In the event one of the</FONT>

<FONT COLOR="#000000">That's the difference, in the case described in this thread the packet</FONT>
<FONT COLOR="#000000">comes back to the same interface, not another one.</FONT>


<FONT COLOR="#000000">&gt; loopback packets does make it back to the switch the port is error-disabled</FONT>
<FONT COLOR="#000000">&gt; (I can't remember if it's the sending or receiving port that is disabled).</FONT>
<FONT COLOR="#000000">&gt; This mechanism is independent of STP.</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;  UDLD also seems to have a mechanism to detect a port that is looped back on</FONT>
<FONT COLOR="#000000">&gt; itself.  Again, independent of STP.</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;  Rather than modifying STP would it not be better to implement something</FONT>
<FONT COLOR="#000000">&gt; like the above as a standalone daemon?</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;  Dylan</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;  On Tue, 2008-05-13 at 10:41 +0200, Benny Amorsen wrote:</FONT>
<FONT COLOR="#000000">&gt;  &quot;<A HREF="mailto:richardvoigt@gmail.com">richardvoigt@gmail.com</A>&quot; &lt;<A HREF="mailto:richardvoigt@gmail.com">richardvoigt@gmail.com</A>&gt; writes:</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; &gt; For example, this topology:</FONT>
<FONT COLOR="#000000">&gt; &gt;</FONT>
<FONT COLOR="#000000">&gt; &gt; br0 - br1 - br2 - br3 - br1</FONT>
<FONT COLOR="#000000">&gt; &gt;</FONT>
<FONT COLOR="#000000">&gt; &gt; There is a loop in br1-br2-br3-br1, so br0 sees its packet come back</FONT>
<FONT COLOR="#000000">&gt; &gt; on the same interface. If br0 shuts down the interface, it breaks</FONT>
<FONT COLOR="#000000">&gt; &gt; connectivity. The br0-br1 link is part of a minimal spanning tree so</FONT>
<FONT COLOR="#000000">&gt; &gt; STP cannot shut it down.</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; Since the alternative is to melt due to traffic overload, the switch</FONT>
<FONT COLOR="#000000">&gt; sure can shut it down. That breaks connectivity, but only for the</FONT>
<FONT COLOR="#000000">&gt; broken segment. Not shutting the interface means everyone gets hurt.</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; /Benny</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; _______________________________________________</FONT>
<FONT COLOR="#000000">&gt; Bridge mailing list</FONT>
<FONT COLOR="#000000">&gt; <A HREF="mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-foundation.org</A></FONT>
<FONT COLOR="#000000">&gt; <A HREF="https://lists.linux-foundation.org/mailman/listinfo/bridge">https://lists.linux-foundation.org/mailman/listinfo/bridge</A></FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; _______________________________________________</FONT>
<FONT COLOR="#000000">&gt;  Bridge mailing list</FONT>
<FONT COLOR="#000000">&gt;  <A HREF="mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-foundation.org</A></FONT>
<FONT COLOR="#000000">&gt;  <A HREF="https://lists.linux-foundation.org/mailman/listinfo/bridge">https://lists.linux-foundation.org/mailman/listinfo/bridge</A></FONT>
<FONT COLOR="#000000">&gt;</FONT>
</PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-ojsI7OuqBCQEQFW3ETtr--

