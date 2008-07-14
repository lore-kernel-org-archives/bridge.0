Date: Mon, 14 Jul 2008 20:20:08 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20080714122008.GA28651@gondor.apana.org.au>
References: <E1KIMV2-0007Na-00@gondolin.me.apana.org.au>
	<487B4352.6040408@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487B4352.6040408@trash.net>
Subject: Re: [Bridge] bridging with gre tunnel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick McHardy <kaber@trash.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Philip Craig <philipc@snapgear.com>, timo.teras@iki.fi

On Mon, Jul 14, 2008 at 02:15:14PM +0200, Patrick McHardy wrote:
>
> Or use rtnl_link, which was created for this purpose :)

Excellent, now there is even less excuse to bother with the ioctls :)
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
