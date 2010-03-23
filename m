From: Matt Mackall <mpm@selenic.com>
In-Reply-To: <4BA84607.7030304@redhat.com>
References: <20100322082059.4967.63492.sendpatchset@localhost.localdomain>
	<20100322082112.4967.5504.sendpatchset@localhost.localdomain>
	<1269297307.3552.23.camel@calx>  <4BA82186.3010204@redhat.com>
	<1269318470.3552.54.camel@calx>  <4BA84607.7030304@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Mar 2010 23:51:01 -0500
Message-ID: <1269319861.3552.87.camel@calx>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC Patch 2/3] bridge: make bridge support netpoll
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: Jay Vosburgh <fubar@us.ibm.com>, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Andy Gospodarek <gospo@redhat.com>, bonding-devel@lists.sourceforge.net

On Tue, 2010-03-23 at 12:39 +0800, Cong Wang wrote:
> Matt Mackall wrote:
> > On Tue, 2010-03-23 at 10:03 +0800, Cong Wang wrote:
> >> Matt Mackall wrote:
> >>> On Mon, 2010-03-22 at 04:17 -0400, Amerigo Wang wrote:
> >>>> Based on the previous patch, make bridge support netpoll by:
> >>>>
> >>>> 1) implement the 4 methods to support netpoll for bridge;
> >>>>
> >>>> 2) modify netpoll during forwarding packets in bridge;
> >>>>
> >>>> 3) disable netpoll support of bridge when a netpoll-unabled device
> >>>>    is added to bridge;
> >>> Not sure if this is the right thing to do. Shouldn't we simply enable
> >>> polling on all devices that support it and warn about the others (aka
> >>> best effort)?
> >>>
> >> I don't think it's a good idea, because we check if a device
> >> supports netpoll by checking if it has ndo_poll_controller method.
> > 
> > Uh, what? If we have 5 devices on a bridge and 4 support netpoll, then
> > shouldn't we just send netconsole messages to those 4 devices? Isn't
> > this much better than simply refusing to work?
> > 
> 
> How could you let the bridge know netpoll is not sent to
> the one that doesn't support netpoll during setup? This will
> be complex, I am afraid.

I thought I saw a simple loop over bridge devices at poll time in your
patch. So it should be a simple matter of skipping unsupported devices
in that loop.

But Dave thinks there a bigger problems here, so I recommend first
figuring out the architecture issues, then we can get back to the policy
issues.

-- 
http://selenic.com : development and support for Mercurial and Linux


