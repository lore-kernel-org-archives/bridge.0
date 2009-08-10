Date: Mon, 10 Aug 2009 16:42:29 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20090810134229.GA10036@redhat.com>
References: <1249595428-21594-1-git-send-email-arnd@arndb.de>
	<200908092042.24686.arnd@arndb.de>
	<20090810085003.GA3654@redhat.com>
	<200908101529.46285.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908101529.46285.arnd@arndb.de>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Fischer,
	Anna" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Or Gerlitz <ogerlitz@voltaire.com>, Edge Virtual Bridging <evb@yahoogroups.com>

On Mon, Aug 10, 2009 at 03:29:46PM +0200, Arnd Bergmann wrote:
> On Monday 10 August 2009, Michael S. Tsirkin wrote:
> > 
> > > Would it be enough to check the dev_queue_xmit() return
> > > code for NETDEV_TX_BUSY?
> > > 
> > > How would I get notified when it gets free again?
> > 
> > You can do this by creating a socket. Look at how tun does
> > this now.
> 
> Hmm, I was hoping to be able to avoid this, because I can
> interact more directly with the outbound physical interface
> using dev_queue_xmit() instead of netif_rx_ni().

Yea, that's what tun does. socket just notifies you when
packets are freed.

> I'll have a look. Thanks,
> 
> 	Arnd <><
