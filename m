Date: Thu, 29 Nov 2007 23:45:22 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH][BRIDGE] Lost call to br_fdb_fini() in br_init() error path
Message-ID: <20071129124522.GD30420@gondor.apana.org.au>
References: <474C2C2E.7050001@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474C2C2E.7050001@openvz.org>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pavel Emelyanov <xemul@openvz.org>
Cc: Linux Netdev List <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, devel@openvz.org

On Tue, Nov 27, 2007 at 05:39:42PM +0300, Pavel Emelyanov wrote:
> In case the br_netfilter_init() (or any subsequent call) 
> fails, the br_fdb_fini() must be called to free the allocated
> in br_fdb_init() br_fdb_cache kmem cache.
> 
> Signed-off-by: Pavel Emelyanov <xemul@openvz.org>

Patch applied to net-2.6.  Thanks Pavel!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
