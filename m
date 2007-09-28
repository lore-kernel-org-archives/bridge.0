From: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <46FBE2DD.76E4.0078.0@novell.com>
Message-Id: <E1Ib8Xj-0006Kl-00@gondolin.me.apana.org.au>
Date: Fri, 28 Sep 2007 13:37:39 +0800
Subject: [Bridge] Re: [PATCH] Module use count must be updated as bridges
	are	created/destroyed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jan Beulich <jbeulich@novell.com>
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Jan Beulich <jbeulich@novell.com> wrote:
>
> So we have an unsolvable problem here then, unless infrastructure gets added
> that allows a module to declare itself as not-implicit-unload-safe, forcing
> modprobe -r to keep its hands off it. Ugly.

Yes I've always wanted to have a separate count that indicates
a module is in use but does not prevent its immediate removal.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
