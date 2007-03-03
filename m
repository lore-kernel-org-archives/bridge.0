Date: Sat, 3 Mar 2007 17:42:22 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20070303064222.GA1805@gondor.apana.org.au>
References: <20070302.151803.74748558.davem@davemloft.net>
	<E1HNMxB-0000MP-00@gondolin.me.apana.org.au>
	<20070302.215905.74747266.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070302.215905.74747266.davem@davemloft.net>
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

On Fri, Mar 02, 2007 at 09:59:05PM -0800, David Miller wrote:
> 
> So it's still a mystery why dhcp is causing bridge devices
> to trigger the network tap paths on Stephen's machine.

If this is the ISC DHCP daemon then perhaps it's because Stephen
didn't specify an interface for it to listen on? By default it'll
enumerate all broadcast interfaces and listen to each one of them.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
