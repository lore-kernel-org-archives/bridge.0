Date: Fri, 15 Dec 2006 17:04:29 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
Message-ID: <20061215160429.GC12679@xi.wantstofly.org>
References: <200610301527.15018.dim@openvz.org>
	<20061030072837.51177183@localhost.localdomain>
	<20061215131908.GC11579@xi.wantstofly.org>
	<20061215075236.321e6a07@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215075236.321e6a07@localhost.localdomain>
Subject: Re: [Bridge] Bridge & it's MAC address question
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Dmitry Mishin <dim@openvz.org>, netdev@vger.kernel.org, bridge@osdl.org

[ dropped subscriber-only openvz.org list ]

On Fri, Dec 15, 2006 at 07:52:36AM -0800, Stephen Hemminger wrote:

> > > The bridge physical address is the minimum of all the attached devices.
> > > This is done because the STP standard requires it.  You can reset it
> > > to be the same as any of the attached devices. This will not cause a
> > > problem unless using STP.
> > 
> > You can in fact use any MAC address.  The STP standard recommends using
> > the minimum address, as that is deterministic, and so it doesn't depend
> > on the order in which you enslave subdevices.
> 
> So should restriction be lifted?

We should definitely allow users to override the MAC address of a
bridge interface.


> Please update wiki page FAQ, or I'll do it

Please do.
