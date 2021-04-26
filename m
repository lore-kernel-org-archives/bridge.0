Return-Path: <herbert@gondor.apana.org.au>
Date: Mon, 26 Apr 2021 20:48:06 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20210426124806.4zqhtn4wewair4ua@gondor.apana.org.au>
References: <20210425155742.30057-1-ap420073@gmail.com>
 <20210425155742.30057-3-ap420073@gmail.com>
 <ed54816f-2591-d8a7-61d8-63b7f49852c1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed54816f-2591-d8a7-61d8-63b7f49852c1@nvidia.com>
Subject: Re: [Bridge] [PATCH net 2/2] net: bridge: fix lockdep
 multicast_lock false positive splat
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: bridge@lists.linux-foundation.org, cong.wang@bytedance.com, daniel@iogearbox.net, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, dsahern@kernel.org, roopa@nvidia.com, ast@kernel.org, bjorn@kernel.org, vfalico@gmail.com, j.vosburgh@gmail.com, kuba@kernel.org, weiwan@google.com, andriin@fb.com, davem@davemloft.net, Taehee Yoo <ap420073@gmail.com>

On Sun, Apr 25, 2021 at 07:45:27PM +0300, Nikolay Aleksandrov wrote:
>
> Ugh.. that's just very ugly. :) The setup you've described above is by all means invalid, but
> possible unfortunately. The bridge already checks if it's being added as a port to another
> bridge, but not through multiple levels of indirection. These locks are completely unrelated
> as they're in very different contexts (different devices).

Surely we should forbid this? Otherwise what's to stop someone
from creating a loop?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
