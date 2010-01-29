From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 29 Jan 2010 20:49:52 +0100
References: <201001271104.20607.arnd@arndb.de>
	<201001282118.09164.arnd@arndb.de>
	<20100129112141.GA6548@redhat.com>
In-Reply-To: <20100129112141.GA6548@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001292049.52308.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH 3/3] net: macvtap driver
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Or Gerlitz <ogerlitz@voltaire.com>, David Miller <davem@davemloft.net>

On Friday 29 January 2010, Michael S. Tsirkin wrote:
> > That may well be, I haven't tried vlan. What do you think it should do
> > then?
> 
> Look at eth_type for a more complete packet parsing.

ok. I initially called that but it crashed because the skb was not initialized
properly at that point. I'll have a look.

> > > > +/*
> > > > + * provide compatibility with generic tun/tap interface
> > > > + */
> > > > +static long macvtap_ioctl(struct file *file, unsigned int cmd,
> > > > +                   unsigned long arg)
> > > > +{
> > > 
> > > All of these seem to be stubs, and tun has many more that you didn't
> > > stub out. So, why do you bother to support any ioctls at all?
> > 
> > Again, minimum features to get things going. qemu fails to open
> > the device if these ioctls are not implemented, but any of the
> > more advanced features are left out.
> 
> This is strange, could be application bug.  E.g. send buf size is
> relatively new and apps should handle failure gracefully.  IMO,
> returning success and ignoring the value is not a good idea.  How about
> we just fix qemu?  What about other apps?

Ok, I'll go through the ioctls again and make sure they behave correctly
they way you said. I haven't tried against against anything but qemu and
cat.

	Arnd
