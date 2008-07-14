From: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <487B11D9.7090800@snapgear.com>
Message-Id: <E1KIMV2-0007Na-00@gondolin.me.apana.org.au>
Date: Mon, 14 Jul 2008 19:45:48 +0800
Subject: Re: [Bridge] bridging with gre tunnel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Philip Craig <philipc@snapgear.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, timo.teras@iki.fi

Philip Craig <philipc@snapgear.com> wrote:
> 
> Actually, this change doesn't really belong in GRE either, because
> that forces you to choose between ethernet encapsulation and not.
> It could be a new device that sits on top of GRE and simply does
> ethernet encapsulation then passes it to the raw GRE device.
> That's a lot of infrastructure for something so simple though,
> and I don't think people will want to use both devices at once.

What's the problem with using Ethernet encapsulation on such a
GRE device? If you're referring to the fact that user-space uses
the encapsulation type to determine whether a device is a tunnel,
then we should fix those tools instead.

Rather than trying to resuscitate the ioctl interface, please
create a new extensible netlink interface and make ip(8) use it
where available.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
