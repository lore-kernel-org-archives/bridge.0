Message-ID: <AD59566A9D83864F871AE2E52503064005072C@aimail.aiinet.priv>
From: "Eble, Dan" <DanE@aiinet.com>
Subject: RE: [Bridge] Re: ebtables target to disable an interface
Date: Mon, 11 Aug 2003 08:22:49 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: 'Bart De Schuymer' <bdschuym@pandora.be>
Cc: bridge@osdl.org

Thanks for the advice.  Still, I would like to avoid using the log to
communicate between the driver and a process.  What do you think of using a
netlink socket to send a message from the bridge driver?  (Once it works, it
could be used for spanning tree control too, as DaveM suggested a while back
for an alternative to ioctl).

The only problem is I'm not very familiar with netlink sockets.  From what I
have heard here, though, it sounds like I have a better chance to make a
netlink socket work properly than to shut down the port from inside the
kernel without causing a panic, deadlock, or memory leak.

> -----Original Message-----
> From: Bart De Schuymer [mailto:bdschuym@pandora.be] 
> Sent: Saturday, August 09, 2003 8:08 AM
> To: Eble, Dan; bridge@osdl.org
> Subject: Re: [Bridge] Re: ebtables target to disable an interface
> 
> 
> On Friday 08 August 2003 15:23, Eble, Dan wrote:
> > Thanks for the suggestion, but it's not the best fit for 
> the system I'm
> > working in.  (Carrying the reasoning further, I could have 
> the kernel log
> > *everything* it does and...)
> >
> > Is there a problem with bringing down the interface from inside?
> 
> I don't know the details by heart, but the code to bring a 
> bridge port down 
> probably expects being called from user context, not from 
> within softirq. 
> That code can probably sleep, which is not allowed inside softirq.
> Problems with removing ports that are the in-port or out-port 
> of currently 
> processed frames will show up too.
> 
> cheers,
> Bart
> 
