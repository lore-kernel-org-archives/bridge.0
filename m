Date: Mon, 22 Aug 2011 15:59:29 +0200
From: David Lamparter <equinox@diac24.net>
Message-ID: <20110822135929.GA611458@jupiter.n2.diac24.net>
References: <CAF5U64CJTWDn8E9+XVLFsdaSbiu-4Rd9XmxZq7ReziRNZviO6Q@mail.gmail.com>
	<20110812154545.79d8313f@nehalam.ftrdhcpuser.net>
	<CAF5U64B_fb2tFMLHmK+zw3n6gmq+bYDyFnXhLE0ayssK5m+THA@mail.gmail.com>
	<20110815150501.3a6cc432@nehalam.ftrdhcpuser.net>
	<CAEJpZP0fOydMMbgquAud7dfwcO28BXAMzAwnMjSZO6TvEjxgpQ@mail.gmail.com>
	<20110818081019.4b9bb79e@nehalam.ftrdhcpuser.net>
	<CAEJpZP2FGhPmTi0+eS+QRhj4y+aqfQHnEUrjmOOLHUay1SuAKg@mail.gmail.com>
	<20110818093941.5ebf716b@nehalam.ftrdhcpuser.net>
	<20110819022731.GC180151@jupiter.n2.diac24.net>
	<20110819135810.1a529ab2@nehalam.ftrdhcpuser.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110819135810.1a529ab2@nehalam.ftrdhcpuser.net>
Subject: Re: [Bridge] [RFC] bridge: add netfilter hook for forwarding 802.1D
 group addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@linux-foundation.org, Ed Swierk <eswierk@bigswitch.com>, Nick Carter <ncarter100@gmail.com>, netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, David Miller <davem@davemloft.net>, David Lamparter <equinox@diac24.net>

On Fri, Aug 19, 2011 at 01:58:10PM -0700, Stephen Hemminger wrote:
> The IEEE standard expects that link local multicast packets will not
> be forwarded by a bridge. But there are cases like 802.1X which may
> require that packets be forwarded. For maximum flexibilty implement
> this via netfilter.
> 
> The netfilter chain is slightly different from other chains in that
> if packet is ACCEPTED by the chain, it means it should be forwarded.
> And if the packet verdict result is DROP, the packet is processed
> as a local packet.

Exactly this functionality already exists by way of the BROUTING chain
in the broute table. Currently, link-local packets are hardcodedly
treated as local before they even reach that chain. Nick's patch, in
conjunction with BROUTING, provides exactly what you're trying to do.

Now, without bridge netfilter, your patch becomes rather useless while
Nick's patch still allows per-group (and therefore per-protocol)
control.

Further, Nick's patch is considerably less intrusive.

I would therefore ask for Nick's patch to be merged.


-David


P.S.: this whole issue is starting to get rather annoying
