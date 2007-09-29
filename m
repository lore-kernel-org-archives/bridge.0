Date: Sat, 29 Sep 2007 08:55:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20070929005513.GB31959@gondor.apana.org.au>
References: <46FBE2DD.76E4.0078.0@novell.com>
	<E1Ib8Xj-0006Kl-00@gondolin.me.apana.org.au>
	<20070928111107.57519b67@freepuppy.rosehill>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070928111107.57519b67@freepuppy.rosehill>
Subject: [Bridge] Re: [PATCH] Module use count must be updated as bridges
	are created/destroyed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>

On Fri, Sep 28, 2007 at 11:11:07AM -0700, Stephen Hemminger wrote:
>
> It is only the nested removal problem.

Well such a count could apply to direct removals too.  In other
words, you could ask modprobe to remove all modules for which
this count is zero.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
