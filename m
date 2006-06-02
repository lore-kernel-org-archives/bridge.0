Date: Fri, 2 Jun 2006 10:03:36 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060602100336.4a349c38@localhost.localdomain>
In-Reply-To: <a9a0929d0605311740r70cf412cg1a84cda30e7bf70@mail.gmail.com>
References: <a9a0929d0605221737r17af6c16sd32d5f6717d274c0@mail.gmail.com>
	<20060523110624.2984f2d5@localhost.localdomain>
	<a9a0929d0605231816u28c5515ay19b2527d60724cef@mail.gmail.com>
	<4473BBE5.3050802@osdl.org>
	<a9a0929d0605311740r70cf412cg1a84cda30e7bf70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Problem bridging frames with bridge and real interface
 MTU > 1527
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Mark Zipp <mark.r.zipp@gmail.com>
Cc: bridge@osdl.org

On Thu, 1 Jun 2006 10:10:28 +0930
"Mark Zipp" <mark.r.zipp@gmail.com> wrote:

> Hi Stephen,
> 
> 
> On 24/05/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> <snip>
> 
> > > Thanks for your help,
> > > Mark.
> > The problem (as I remember it) was often with ip_conntrack. It
> > reassembles fragmented
> > IP packets to look at them, then didn't fragment on output.
> >
> 
> Strange thing was that even after I was able to successfully do 2024
> byte pings through the bridge, with and without iptables connection
> tracking rules in place, I still encountered the problem with the
> oversized IP/GRE traffic that I'm trying to capture. What I think is
> also interesting is that even though when I set the MTUs on the
> ethernet interfaces and the bridge to 1527, not only does it all work,
> the bridge is also forwarding frames that have a 1528 byte MTU (IP +
> GRE + original 1500 byte IP packet), which I think should make the
> bridge drop the frames as too large, yet setting the MTU 1528 on the
> bridge and interfaces makes it fail.
> 
> Maybe it is the different ways IP connection tracking treats ICMP /
> Ping traffice verses IP/GRE traffic that is causing the issue.
> 
> I've got some more testing to do again, this time around I'll try the
> 2024 byte MTU on the bridge, and a blind iptables permit all to and
> from the bridge interfaces, which should hopefully eliminate ip
> connection tracking from the equation, therefore identifying it as the
> cause.
> 
> Thanks for your time,
> Mark.

You may want to either add some debug tracing or just try capturing packets
to see the resulting traffic.  I suspect connection tracking may be the
culprit since it often does higher layer filtering.
