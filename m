Return-Path: <herbert@gondor.apana.org.au>
Date: Fri, 22 May 2015 11:12:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20150522031200.GA30043@gondor.apana.org.au>
References: <1432256161-4425-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1432256161-4425-1-git-send-email-linus.luessing@c0d3.blue>
Subject: Re: [Bridge] [PATCH net-next] bridge: allow setting hash_max +
 multicast_router if interface is down
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Fri, May 22, 2015 at 02:56:01AM +0200, Linus L=FCssing wrote:
> Network managers like netifd (used in OpenWRT for instance) try to
> configure interface options after creation but before setting the
> interface up.
>=20
> Unfortunately the sysfs / bridge currently only allows to configure the
> hash_max and multicast_router options when the bridge interface is up.
> But since br_multicast_init() doesn't start any timers and only sets
> default values and initializes timers it should be save to reconfigure
> the default values after that, before things actually get active after
> the bridge is set up.
>=20
> With this patch hash_max and multicast_router attributes can be
> changed even if the according bridge (port) is down, just like other
> other bridge (port) attributes allow too.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
