Return-Path: <pablo@gnumonks.org>
Date: Thu, 4 Apr 2019 14:21:55 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190404122155.grjs6beng6ubt5gr@salvia>
References: <20190404115638.28592-1-pablo@netfilter.org>
	<952568d9-771f-982c-9a75-5dfc01a461fb@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <952568d9-771f-982c-9a75-5dfc01a461fb@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: update multicast stats
 from maybe_deliver()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, nbd@nbd.name

On Thu, Apr 04, 2019 at 03:02:19PM +0300, Nikolay Aleksandrov wrote:
> On 04/04/2019 14:56, Pablo Neira Ayuso wrote:
> > Simplify this code by updating bridge multicast stats from
> > maybe_deliver().
> > 
> > Note that commit 6db6f0eae605 ("bridge: multicast to unicast"), in case
> > the port flag BR_MULTICAST_TO_UNICAST is set, never updates the previous
> > port pointer, therefore it is always going to be different from the
> > existing port in this deduplicated list iteration.
> > 
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> >  net/bridge/br_forward.c | 15 ++++-----------
> >  1 file changed, 4 insertions(+), 11 deletions(-)

This is removing two branches, it is less code to maintain and easier
to read than:

        if (prev == p)

> This was intentional, the reason I didn't add that call to maybe_deliver() is to avoid
> these checks for the standard unicast fast-path.  We need to avoid touching the mcast
> cache lines (and checks) when using unicast.

maybe_deliver() is called from br_flood() and br_multicast_flood(),
not the standard unicast fast-path.

Thanks.
