Date: Fri, 28 Sep 2007 11:11:07 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070928111107.57519b67@freepuppy.rosehill>
In-Reply-To: <E1Ib8Xj-0006Kl-00@gondolin.me.apana.org.au>
References: <46FBE2DD.76E4.0078.0@novell.com>
	<E1Ib8Xj-0006Kl-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] Module use count must be updated as bridges are
 created/destroyed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>

On Fri, 28 Sep 2007 13:37:39 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Jan Beulich <jbeulich@novell.com> wrote:
> >
> > So we have an unsolvable problem here then, unless infrastructure gets added
> > that allows a module to declare itself as not-implicit-unload-safe, forcing
> > modprobe -r to keep its hands off it. Ugly.
> 
> Yes I've always wanted to have a separate count that indicates
> a module is in use but does not prevent its immediate removal.
> 
> Cheers,

It is only the nested removal problem.

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
