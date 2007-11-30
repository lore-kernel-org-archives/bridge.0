Date: Fri, 30 Nov 2007 13:31:17 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH (resubmit)][BRIDGE] Properly dereference the
	br_should_route_hook
Message-ID: <20071130023117.GA25692@gondor.apana.org.au>
References: <474C43F4.5080704@openvz.org>
	<20071129130420.GA8487@gondor.apana.org.au>
	<20071129143650.GD32449@linux.vnet.ibm.com>
	<20071129234900.GB23769@gondor.apana.org.au>
	<20071130012501.GJ9059@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071130012501.GJ9059@linux.vnet.ibm.com>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: ego@in.ibm.com, Linux Netdev List <netdev@vger.kernel.org>, bridge@lists.osdl.org, devel@openvz.org, Pavel Emelyanov <xemul@openvz.org>

On Thu, Nov 29, 2007 at 05:25:01PM -0800, Paul E. McKenney wrote:
>
> You have in mind something like the following?
> 
> #define rcu_assign_pointer(p, v) \
> 	({ \
> 		if (!__builtin_constant_p(v) || \
> 		    ((v) != NULL)) \
> 			smp_wmb(); \
> 		(p) = (v); \
> 	})

Yes that's what I was thinking.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
