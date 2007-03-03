Date: Sat, 3 Mar 2007 13:30:58 +0100
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20070303123058.GA5357@one.firstfloor.org>
References: <45E6802C.2090708@linux-foundation.org>
	<20070228.233034.74746721.davem@davemloft.net>
	<p733b4ncbui.fsf@bingen.suse.de>
	<20070302.202211.21926049.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070302.202211.21926049.davem@davemloft.net>
Subject: Re: [Bridge] [PATCH] bridge: avoid ptype_all packet handling
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, greearb@candelatech.com, andi@firstfloor.org, bridge@linux-foundation.org

On Fri, Mar 02, 2007 at 08:22:11PM -0800, David Miller wrote:
> From: Andi Kleen <andi@firstfloor.org>
> Date: 03 Mar 2007 03:14:29 +0100
> 
> > That's pretty common with many x86 server boards because 
> > they come with two NICs by default but must people only
> > plug the cable into one. However the distro installers
> > run DHCP on all.
> 
> Nope, that's not what I've seen them do, instead they run dhcp on
> interfaces that report a link being present.

I've seen otherwise.

And that's also bad. It means that when the user moves the machine
and happens to plug the Ethernet into the other port network
will be a notwork until the configuration is manually changed.
Similar when the cable is not plugged in yet at install time.
All not good.

Allowing low overhead DHCP is useful imho. The main problem
with running it always is that it will use more power because
it will IFF_UP the interface. But longer term that can be only
properly solved by real idle network power management I think.

-Andi
