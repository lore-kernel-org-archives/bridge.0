Date: Thu, 21 Dec 2006 07:51:18 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061221075118.6b056c59@localhost.localdomain>
In-Reply-To: <BAY104-F34EBCDBB00CF06D58C0126FDCE0@phx.gbl>
References: <20061220143209.7b83d097@dxpl.pdx.osdl.net>
	<BAY104-F34EBCDBB00CF06D58C0126FDCE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] Monitor the status of two ethernet interface
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jie Chen <cj70286@hotmail.com>
Cc: bridge@lists.osdl.org

On Thu, 21 Dec 2006 13:50:31 +0000
"Jie Chen" <cj70286@hotmail.com> wrote:

> Thank you, Stephen.
> 
> 
> I'm reading the codes. The software uses ioctl a lot. I'm new to ioctl, is 
> it an interface between register values of the ethernet card and user 
> application?
> 
> 
> We use ioctl to add a bridge, add an interface to the bridge, which ioctl 
> file do we use for that? I greped the whole file system of my linux box, I 
> found some ioctl files, but when I try to match the cases (The second 
> parameter such as SIOCSIFBR, SIOCBRADDBR) it handles, it seems none of those 
> files match our cases.

Download bridge-utilities source code:
	http://sourceforge.net/project/showfiles.php?group_id=26089
And look at libbridge code there.

> 
> Another question I had is about my understanding on ioctl. Since I think 
> ioctl is just to set physical register values of ethernet cards, once it's 
> set, all the functions should be automatic, when packets come, the bridge 
> automatically routes, is Kernel involved in those functions?

The architecture is more like:

      Applications      | brctl |
                        +-------+
user                        |
----------------------------|-----------------
kernel                      |
              +----------------+
              |   Bridge       |
              |   driver       |
              +----------------+
                |              |
        +--------+            +--------+
        |Ethernet|            |Ethernet|
        | Driver |            | Driver |
        +--|-----+            +----|---+
-----------|-----------------------|---------
physical
         LAN1                     LAN2                            


> About STP, seems like everything is set by a function br_set, and eventually 
> by ioctl. Is there any daemon to maintain STP?

No. But the long term plan is to do STP in userspace with a daemon
since that allows for more flexibility

> 
> Thanks again for your valuable time.
> Jie
> 
> >From: Stephen Hemminger <shemminger@osdl.org>
> >To: "Jie Chen" <cj70286@hotmail.com>
> >CC: bridge@lists.osdl.org
> >Subject: Re: [Bridge] Monitor the status of two ethernet interface
> >Date: Wed, 20 Dec 2006 14:32:09 -0800
> >
> >On Wed, 20 Dec 2006 21:26:18 +0000
> >"Jie Chen" <cj70286@hotmail.com> wrote:
> >
> > > Hi everybody,
> > >
> > > Just have myself added into the maillist. I have a few linux boxes with
> > > Kernel 2.6.9. Each box has 2 ethernet interfaces, one 3COM, one Intel. I
> > > connected one with Power Line Modem, and one with Wifi Modem. They form 
> >a
> > > nice network with bridge. I have a few questions here.
> > >
> > > Suppose I have two path from box A to box D, which path will packets go
> > > through? If I want to monitor the condition (throughput) of each 
> >interface,
> > > and pick the better one, how do I do it? If I want to use both 
> >interfaces to
> > > transfer data, how do I do it?
> >
> >With STP it will choose the "least cost" which is determined by the port
> >cost variable. In 2.6, it automatically sets the cost based on link speed. 
> >but
> >then you can change it later with brctl
> >
> > >
> > > Thanks in advance for your answers,
> > > cj
> > >
> > > _________________________________________________________________
> > > Type your favorite song.  Get a customized station.  Try MSN Radio 
> >powered
> > > by Pandora. http://radio.msn.com/?icid=T002MSN03A07001
> > >
> 
> _________________________________________________________________
> Get FREE Web site and company branded e-mail from Microsoft Office Live 
> http://clk.atdmt.com/MRT/go/mcrssaub0050001411mrt/direct/01/
> 

