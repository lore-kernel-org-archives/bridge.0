Date: Thu, 26 May 2005 11:41:01 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Re: Adding same physical port to multiple bridges
Message-ID: <20050526114101.47452a63@dxpl.pdx.osdl.net>
In-Reply-To: <40186412.70109@krellan.com>
References: <40170C13.1070202@nortelnetworks.com>
	<20040128100106.6c52ee20.shemminger@osdl.org>
	<40186412.70109@krellan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Josh Lehan <bridge@krellan.com>
Cc: bridge@osdl.org

On Wed, 28 Jan 2004 17:38:26 -0800
Josh Lehan <bridge@krellan.com> wrote:

> Stephen Hemminger wrote:
> 
> > Probably not. What are you trying to do?  Might to be bridge the
> > physical LAN and do any filtering based on tag using bridge-filtering
> > (ebtables).
> 
> I also have a need to add the same physical port to multiple bridges, 
> but my reason is different.
> 
> I have a block of static IP addresses, but instead of having a separate 
> routing subnet for the gateway, my gateway has been placed on one of my 
> own static IP addresses!  So, I need to have a bridge in order to do 
> proper firewalling, since both filtered and unfiltered traffic must flow 
> on the same subnet.
> 
> Here is my network:
> 
> eth0 = to gateway, raw unfirewalled IP packets
> (IP address is on the same subnet as the rest of my static IP addresses)
>       | br0
> eth1 = to the rest of my machines on my static IP addresses
> 
> eth2 = additional machines on private IP addresses (via NAT)
> (on a completely different subnet, using private IP addresses)
> 
> I have successfully firewalled my other static IP addresses by bridging 
> eth0 and eth1 together into br0.  This works beautifully.  None of my 
> machines have connection problems, and they are being defended by a 
> firewall.
> 
> However, for gaming purposes, I'd like to bridge eth1 and eth2 also 
> together.  This is because non-IP protocols (such as IPX/SPX, used by 
> many games) are not routed across the subnets.
> 
> What would be really neat is if I could filter by protocol:
>      IP on eth1 = bridge to eth0/eth1
> Non-IP on eth1 = bridge to eth1/eth2
> 
> I don't think the current bridging code supports this.
> 
> A workaround would be to find (or write) a simple utility that listens 
> to all non-IP packets coming in on both eth1 and eth2, and blindly 
> echoes the raw packets onto the other interface, so that the two 
> interfaces effectively become bridged with regards to non-IP packets. 
> This would be all done in userspace, so as not to interfere with the 
> kernel bridging code.  Does such a program already exist?
> 

Put them all in one bridge and write filter rules (ebtables) to do what
you want.
