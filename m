Date: Thu, 12 May 2011 18:06:21 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Message-ID: <20110512160621.GA6588@rere.qmqm.pl>
References: <20110507114803.0D80A13A6B@rere.qmqm.pl>
	<20110509.120811.246541047.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20110509.120811.246541047.davem@davemloft.net>
Subject: Re: [Bridge] [RFC PATCH] net: fold dev_disable_lro() into
 netdev_fix_features()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: pekkas@netcore.fi, eric.dumazet@gmail.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jmorris@namei.org, bhutchings@solarflare.com, kuznet@ms2.inr.ac.ru, therbert@google.com

On Mon, May 09, 2011 at 12:08:11PM -0700, David Miller wrote:
> From: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
> Date: Sat,  7 May 2011 13:48:02 +0200 (CEST)
> > This moves checks that device is forwarding from bridge, IPv4 and IPv6
> > code into netdev_fix_features(). As a side effect, after device is no l=
onger
> > forwarding it gets LRO back. This also means that user is not allowed to
> > enable LRO after device is put to forwarding mode.
> We need to keep the check in the protocols because we don't want to
> be testing protocol specific device state in generic code like
> net/core/dev.c

I modified it to use priv_flags that mirror the protocol-internal state.
Patch follows.

Best Regards,
Micha=B3 Miros=B3aw
