Message-ID: <20040616221738.29758.qmail@web90108.mail.scd.yahoo.com>
Date: Wed, 16 Jun 2004 15:17:38 -0700 (PDT)
From: Derek Smalls <dsmalls321@yahoo.com>
Subject: RE: [Bridge] Bridging between user processes 
In-Reply-To: <C060DFCD9697A842B3189B458524FDC205D2D3@AIMAIL1.ai.aiinet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Thanks! I was afraid this was the reason ... :(

I actually tried writing an application that would
open /dev/tap4 as a file and do a select() on it. The
select() timed out when I tried pinging over the
bridge, but I guess I'll have to go back and debug it,
I must have missed something. 


--- "Eble, Dan" <DanE@aiinet.com> wrote:
> The bridge is designed to do the opposite of what
> you are trying to do.  It
> takes incoming frames and copies them out other
> interfaces.  You want to
> take outgoing frames and copy them into other
> interfaces.
> 
> I have not played with tun/tap myself, but the
> kernel documentation in
> Documentation/networking/tuntap.txt seems to
> indicate that you need a
> program to listen on two opened /dev/net/tun devices
> and copy the frames
> from one to the other.
> 
> > -----Original Message-----
> > From: Derek Smalls [mailto:dsmalls321@yahoo.com] 
> > Sent: Wednesday, June 16, 2004 12:04 AM
> > To: bridge@lists.osdl.org
> > Subject: [Bridge] Bridging between user processes 
> > 
> > 
> > Hi, 
> > 
> > What is the easiest way to bridge between two
> > user-space processes that talk directly to
> Ethernet
> > interfaces? 
> > 
> > I have two applications that write/read Ethernet
> > frames to/from Linux Ethernet ports (e.g. eth0).
> The
> > applications can successfully talk to each other
> when
> > they run on two machines connected over Ethernet.
> I
> > would like to be able to test them on a single
> machine
> > without employing the physical network. Would TAP
> +
> > bridging do the job? 
> > 
> > If so, what am I doing wrong?  Linux 2.4.20, root
> > user. I set up tap interfaces like this: 
> > 
> > >tunctl tap4 
> > >ifconfig tap4 4.4.4.4 promisc up 
> > >tunctl tap5 
> > >ifconfig tap5 5.5.5.5 promisc up 
> > 
> > I then set up the bridge and add the tap
> interfaces to
> > it: 
> > 
> > >brctl addbr tapbr 
> > >brctl setfd tapbr 0 
> > >brctl sethello tapbr 0 
> > >brctl stp tapbr off 
> > >ifconfig tapbr 7.7.7.7 netmask 255.255.255.0 up
> > >brctl addif tapbr tap4 
> > >brctl addif tapbr tap5 
> > 
> > I then do a ping over tap4: 
> > >ping -I tap4 8.8.8.8 
> > 
> > and tcpdump on tap5: 
> > >tcpdump -i tap5 
> > 
> > and see nothing. Shouldn't I see the ping requests
> on
> > tap5 now? 
> > 
> > BTW, if I enable STP on the bridge I start seeing
> the
> > STP frames on tap5. 
> > 
> > Thanks! 
> > 
> > Derek 
> > 
> > 
> > 
> > 
> > 		
> > __________________________________
> > Do you Yahoo!?
> > New and Improved Yahoo! Mail - Send 10MB messages!
> > http://promotions.yahoo.com/new_mail 
> > 
> 


=====



		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
