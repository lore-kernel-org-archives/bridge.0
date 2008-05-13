From: Dylan Hall <dylan@citylink.co.nz>
In-Reply-To: <m3abiua957.fsf@ursa.amorsen.dk>
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>
	<2e59e6970805071916r701987fdx49bab341420ba2d@mail.gmail.com>
	<1210233718.32216.121.camel@gentoo-jocke.transmode.se>
	<2e59e6970805122010v50dcd5al101ae3466b897ad6@mail.gmail.com>
	<m3abiua957.fsf@ursa.amorsen.dk>
Content-Type: multipart/alternative; boundary="=-/9RU5H8yTSAE8HB7olNx"
Date: Wed, 14 May 2008 10:29:53 +1200
Message-Id: <1210717793.5774.10.camel@collymore.citylink.co.nz>
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


--=-/9RU5H8yTSAE8HB7olNx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've only been half following this thread, but is sounds a lot like
you're discussing a problem that has already been solved by Cisco (and I
assume others).

Most Cisco switches will generate a loopback packet (ethertype 0x9000)
at fairly regular intervals.  Both the src and dst mac addresses are set
to the interface mac of the port emitting the packets.  In the event a
loop exists in the network that hasn't been dealt with by (R)STP the
switch will receive the packet back on another of it's interfaces.  In
the event one of the loopback packets does make it back to the switch
the port is error-disabled (I can't remember if it's the sending or
receiving port that is disabled).  This mechanism is independent of
STP. 

UDLD also seems to have a mechanism to detect a port that is looped back
on itself.  Again, independent of STP.

Rather than modifying STP would it not be better to implement something
like the above as a standalone daemon? 

Dylan


On Tue, 2008-05-13 at 10:41 +0200, Benny Amorsen wrote:

> "richardvoigt@gmail.com" <richardvoigt@gmail.com> writes:
> 
> > For example, this topology:
> >
> > br0 - br1 - br2 - br3 - br1
> >
> > There is a loop in br1-br2-br3-br1, so br0 sees its packet come back
> > on the same interface.  If br0 shuts down the interface, it breaks
> > connectivity.  The br0-br1 link is part of a minimal spanning tree so
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

--=-/9RU5H8yTSAE8HB7olNx
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.16.3">
</HEAD>
<BODY>
I've only been half following this thread, but is sounds a lot like you're discussing a problem that has already been solved by Cisco (and I assume others).<BR>
<BR>
Most Cisco switches will generate a loopback packet (ethertype 0x9000) at fairly regular intervals.&nbsp; Both the src and dst mac addresses are set to the interface mac of the port emitting the packets.&nbsp; In the event a loop exists in the network that hasn't been dealt with by (R)STP the switch will receive the packet back on another of it's interfaces.&nbsp; In the event one of the loopback packets does make it back to the switch the port is error-disabled (I can't remember if it's the sending or receiving port that is disabled).&nbsp; This mechanism is independent of STP. <BR>
<BR>
UDLD also seems to have a mechanism to detect a port that is looped back on itself.&nbsp; Again, independent of STP.<BR>
<BR>
Rather than modifying STP would it not be better to implement something like the above as a standalone daemon? <BR>
<BR>
Dylan<BR>
<BR>
<BR>
On Tue, 2008-05-13 at 10:41 +0200, Benny Amorsen wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">&quot;<A HREF="mailto:richardvoigt@gmail.com">richardvoigt@gmail.com</A>&quot; &lt;<A HREF="mailto:richardvoigt@gmail.com">richardvoigt@gmail.com</A>&gt; writes:</FONT>

<FONT COLOR="#000000">&gt; For example, this topology:</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; br0 - br1 - br2 - br3 - br1</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; There is a loop in br1-br2-br3-br1, so br0 sees its packet come back</FONT>
<FONT COLOR="#000000">&gt; on the same interface.  If br0 shuts down the interface, it breaks</FONT>
<FONT COLOR="#000000">&gt; connectivity.  The br0-br1 link is part of a minimal spanning tree so</FONT>
<FONT COLOR="#000000">&gt; STP cannot shut it down.</FONT>

<FONT COLOR="#000000">Since the alternative is to melt due to traffic overload, the switch</FONT>
<FONT COLOR="#000000">sure can shut it down. That breaks connectivity, but only for the</FONT>
<FONT COLOR="#000000">broken segment. Not shutting the interface means everyone gets hurt.</FONT>


<FONT COLOR="#000000">/Benny</FONT>


<FONT COLOR="#000000">_______________________________________________</FONT>
<FONT COLOR="#000000">Bridge mailing list</FONT>
<FONT COLOR="#000000"><A HREF="mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-foundation.org</A></FONT>
<FONT COLOR="#000000"><A HREF="https://lists.linux-foundation.org/mailman/listinfo/bridge">https://lists.linux-foundation.org/mailman/listinfo/bridge</A></FONT>
</PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-/9RU5H8yTSAE8HB7olNx--

