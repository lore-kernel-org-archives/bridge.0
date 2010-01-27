From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 Jan 2010 22:59:31 +0100
References: <201001271104.20607.arnd@arndb.de>
In-Reply-To: <201001271104.20607.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201001272259.31158.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH 0/3 v3] macvtap driver
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Or Gerlitz <ogerlitz@voltaire.com>

On Wednesday 27 January 2010, Arnd Bergmann wrote:
> There are still known problems, but unless there
> are fundamental concerns, I'd like this to go
> into net-next as an experimental driver,
> fixing up the remaining problems by 2.6.34-rc1.

I should have been more specific here. The one
really annoying problem is a reference counting
problem I introduced in one of the last changes
that prevents you from destroying a device after
it has been used.

Unfortunately, I'm still traveling after LCA,
and haven't had a chance to look into this before
sending out the patches as I had originally
planned. I've also seen crashes that are not
fully reproducible, any bug reports on those
are appreciated.

	Arnd
