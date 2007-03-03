From: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20070302.151803.74748558.davem@davemloft.net>
Message-Id: <E1HNMxB-0000MP-00@gondolin.me.apana.org.au>
Date: Sat, 03 Mar 2007 16:38:45 +1100
Subject: Re: [Bridge] [RFC 1/2] bridge: avoid ptype_all packet handling
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

David Miller <davem@davemloft.net> wrote:
> 
> I'm tempted to say I must be missing something here, since I can't see
> how this could possible work at all.  The string passed in should
> be interpreted as the ifindex value, and thus trigger a -ENODEV
> return from AF_PACKET's bind() implementation.

This is using packet_bind_spkt which uses a name instead of ifindex.

As you may recall, I've made a patch to convert it to use the new
(actually it's not-so-new anymore) AF_PACKET interface.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
