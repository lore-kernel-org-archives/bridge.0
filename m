From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 14 Dec 2009 13:00:36 +0100
References: <1259862720-28432-1-git-send-email-arnd@arndb.de>
	<1259862720-28432-3-git-send-email-arnd@arndb.de>
	<20091212084112.GA8948@gondor.apana.org.au>
In-Reply-To: <20091212084112.GA8948@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200912141300.37063.arnd@arndb.de>
Subject: Re: [Bridge] [RFC] macvlan: add tap device backend
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Edge Virtual Bridging <evb@yahoogroups.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Fischer,
	Anna" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Or Gerlitz <ogerlitz@voltaire.com>, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org

On Saturday 12 December 2009, Herbert Xu wrote:
> On Thu, Dec 03, 2009 at 06:52:00PM +0100, Arnd Bergmann wrote:
> > This is a second prototype of a new interface into the network
> > stack, to eventually replace tun/tap and the bridge driver
> > in certain virtual machine setups. The code has changed
> > significantly, but the goals still remain.
> 
> The idea looks pretty sound to me.

Thanks!

> > I'm posting this mainly to solicit feedback. Not sure how
> > chances for integration into 2.6.33 are, given that the merge
> > window is opening already.
> 
> It's way too late for 2.6.33.  But the earlier this becomes ready
> then the earlier it can go into linux-next.

Right. Since the code is basically working (I have two known bugs
I'm still working on) and people want to test it, what is the
best path? I could
a) keep my git tree for myself,
b) have it added to linux-next,
c) prepare a combined patch for net-next.git, or
d) have it added to drivers/staging

	Arnd

