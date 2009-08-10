Date: Mon, 10 Aug 2009 22:32:27 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20090810193227.GA16820@redhat.com>
References: <0199E0D51A61344794750DC57738F58E6D6A6CD7F6@GVW1118EXC.americas.hpqcorp.net>
	<200908080005.32443.arnd@arndb.de>
	<0199E0D51A61344794750DC57738F58E6D6AE99700@GVW1118EXC.americas.hpqcorp.net>
	<200908102104.54527.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908102104.54527.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH] macvlan: add tap device backend
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "ogerlitz@voltaire.com" <ogerlitz@voltaire.com>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "Fischer, Anna" <anna.fischer@hp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, "evb@yahoogroups.com" <evb@yahoogroups.com>, "davem@davemloft.net" <davem@davemloft.net>

On Mon, Aug 10, 2009 at 09:04:54PM +0200, Arnd Bergmann wrote:
> On Monday 10 August 2009, Fischer, Anna wrote:
> > If you compare macvtap with traditional QEMU networking interfaces that
> > are typically used in current bridged setups, then yes, performance will be
> > different. However, I think that this is not necessarily a fair 
> > comparison, and the performance difference does not come from the 
> > bridge being slow, but simply because you have implemented a better
> > solution to connect a virtual interface to a backend device that
> > can be assigned to a VM. There is no reason why you could not do this
> > for a bridge port as well.
> 
> It's not necessarily the bridge itself being slow (though some people
> claim it is) but more the bridge preventing optimizations or making
> them hard.
> 
> You already mentioned hardware filtering by unicast and multicast
> mac addresses, which macvlan already does (for unicast) but which would be
> relatively complex with a bridge due to the way it does MAC address
> learning.
> 
> If we want to do zero copy receives, the hardware will on top of
> this have to choose the receive buffer based on the mac address,
> with the buffer provided by the guest. I think this is not easy
> with macvlan but doable, while I have no idea where you would start
> using the bridge code.
> 
> 	Arnd <><

Similar thing for zero copy sends. You need to know when
the buffers have been consumed to notify userspace,
and this is very hard with a generic bridge in the middle.


-- 
MST
