Subject: Re: [Bridge] Bridge performance problem
From: Joubert Berger <joubert@berger-family.org>
In-Reply-To: <20040826091553.5b691020@dell_ss3.pdx.osdl.net>
References: <1093490432.23223.86.camel@localhost.localdomain>
	<20040826091553.5b691020@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1093577817.23223.122.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Thu, 26 Aug 2004 23:36:57 -0400
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

On Thu, 2004-08-26 at 12:15, Stephen Hemminger wrote:
> On Wed, 25 Aug 2004 23:20:32 -0400
> Joubert Berger <joubert@berger-family.org> wrote:
> > 
> > When I run the TCP_CRR test, for the first setup I get around 2200
> > connections per second, but in the second configuration I are getting
> > around 700-800 connections per second.  Why am I getting this big of a
> > difference?
> 
> Because you have to process the packet twice on the bridge.
> What hardware are you using?  

A single Xeon 2.4G CPU.  Two Intel cards (82545EM Gigabit Ethernet
Controller) -- one onboard and another in an X-PCI slot.  Don't remember
the memory off the top of my head.

> If you use NIC's that have NAPI latency
> will be worse (but better throughput).  If you use NIC's that have
> to copy every packet (like 8139) then it will be worse as well.
> 

Sure that I understand.  But, taking such a big hit I just don't
understand.  That is what is puzzling...

BTW, can you enable NAPI dynamically on the driver?  Or is this a
compile time only option?

> > I am running Redhat kernel 2.4.20-30.9 (RH9).  I also changed the
> > txqueuelen on the two bridge interfaces to 50000.
> 
> Increasing queuelen shouldn't do anything but make the problem worse. 
> If the queue is building up, then your performance is already shot.
> If you use a 2.6 based kernel (like Fedora Core 2 or Suse 9.1) the
> numbers might be better.
> 

Would you mind explaining what the txqueuelen does?  Or point me to a
location I can read about it?  More about wanting to know what it does
than anything else.

> > Anyone have any idea why I am seeing such a big difference in the
> > TCP_CRR test?  The introduction of the Linux bridge cause me some real
> > performance problems.
> > 
> > --joubert
> 
> What is the ping time?
> 

Ping times are in the .250-.300ms area.  

Just to see what a switch would do, I replace the Linux Bridge with a
Cisco switch and there the ping times were in the .150ms range.

I have a few other data points.  I am using e1000 driver for the Intel
NICs.  I found some references to poor performance with the e1000 driver
dealing with DITR (Dynamic Interrupt Throttle Rate)
http://www.ussg.iu.edu/hypermail/linux/kernel/0405.3/0707.html
Not sure if this is an issue.  Don't know what DITR is.  More research
needed.

Another interesting item that I saw is that the two e1000 boards are on
the same IRQ.  Somewhere I read that sharing IRQ is support in the Linux
kernel, but that there might be problems with sharing IRQs and NICs. 
More research is needed.

Finally, just to see if it was a software issue or hardware issue, I
kept the OS/software the same and install on a new machine.  New
machine/different NICS.  In this case I saw much improved performance. 
Whereas before I was taking a 45% hit, on this new hardware I was taking
a 17% hit.  This make me think I have a hardware problem.  

I then went back to the original hardware with the two e1000 NICs and
replaced them with two different cards.  And again I saw better
numbers.  This leads me to think that I am having some problem with the
NICs.

A lot of this is just a little more background information to paint a
better picture of what I have tried.  

Any other insight into this would be greatly appreciated.  Sometimes
pointing out the obvious helps clear the picture when you have been knee
deep in it :-)

--joubert

