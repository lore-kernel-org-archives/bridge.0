Message-ID: <BAY104-F7B1FCF1393A67E989467FFDB80@phx.gbl>
In-Reply-To: <20070104130316.1147e9b6@freekitty>
From: "Jie Chen" <cj70286@hotmail.com>
Date: Thu, 04 Jan 2007 21:20:40 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: Re: [Bridge] Monitor the status of two ethernet interface
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org
Cc: bridge@lists.osdl.org

Just to make my question clearer, I don't use wireless card, I use regular 
ethernet card, and then plugged in wifi modem.


I have tested the case of 4 linux boxes with one wireless modem on each box. 
I can check which is root bridge and the rest the designated bridge. I did 
it with 4 linux boxes together. I haven't done the scenario I asked. In 
order to make box A and C talk, packets from A to B have to be sent out to C 
through the same ethernet port. So my question is will B deliver the packet 
through the same port as it received?

Thanks,
Jie


>From: Stephen Hemminger <shemminger@osdl.org>
>To: "Jie Chen" <cj70286@hotmail.com>
>CC: cam@schaus.ca, bridge@lists.osdl.org
>Subject: Re: [Bridge] Monitor the status of two ethernet interface
>Date: Thu, 4 Jan 2007 13:03:16 -0800
>
>On Thu, 04 Jan 2007 20:39:12 +0000
>"Jie Chen" <cj70286@hotmail.com> wrote:
>
> > Hi all,
> >
> > I hope everybody had a great holiday.
> >
> > I got a question in applying ethernet bridge in Linux boxes. The 
>scenario
> > I'm trying to simulate is like this:  I have 3 linux boxes in total,
> > everyone has 2 ethernet ports, one port is connected to Power line 
>modem,
> > and the other to wifi modem. The power line modem failed, so it's the 
>same
> > as I have just one port for each. I put them apart, Box A is in one end, 
>and
> > Box C is in another end, and Box B in the middle, so that Box A can talk 
>to
> > B but not C. Box B can talk to A and C. Box C and talk to B but not A. 
>Now I
> > set bridge on, the question is am I able to let A and C talk?
> >
> > The reason I have this question is according to bridge, B get packets 
>from A
> > on one port, and suppose to deliver to C from the other port, but the 
>other
> > port didn't work. So I would think the packets can't be delivered from A 
>to
> > C, is that the case?
> >
> > Thanks a lot,
> > Jie
> >
> >
>
>True bridging to Wifi won't usually work see the 
>http://linux-net.osdl.org/index.php/Bridge
>
>The problem is that internally Wifi is not a Bus network like Ethernet, but
>is really point-to-point from host to access point.
>
>
>--
>Stephen Hemminger <shemminger@osdl.org>

_________________________________________________________________
Your Hotmail address already works to sign into Windows Live Messenger! Get 
it now 
http://clk.atdmt.com/MSN/go/msnnkwme0020000001msn/direct/01/?href=http://get.live.com/messenger/overview

