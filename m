Return-Path: <herbert@gondor.apana.org.au>
Date: Tue, 4 Dec 2012 09:38:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20121204013838.GA31329@gondor.apana.org.au>
References: <1354545363-11953-1-git-send-email-amwang@redhat.com>
	<20121203075316.0b1da39d@nehalam.linuxnetplumber.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121203075316.0b1da39d@nehalam.linuxnetplumber.net>
Subject: Re: [Bridge] [PATCH net-next] bridge: implement multicast fast leave
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Cong Wang <amwang@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Mon, Dec 03, 2012 at 07:53:16AM -0800, Stephen Hemminger wrote:
> On Mon,  3 Dec 2012 22:36:03 +0800
> Cong Wang <amwang@redhat.com> wrote:
> 
> > Fast leave allows bridge to immediately stops the multicast
> > traffic on the port receives IGMP Leave when IGMP snooping is enabled,
> > no timeouts are observed.
> > 
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: Stephen Hemminger <shemminger@vyatta.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Signed-off-by: Cong Wang <amwang@redhat.com>
> 
> I like the feature, and it looks like an oversight in the initial design.
> Why is this not the default, adding more options obscures it.

If the port has a bridge on it then you're toast.  I think this
should be a per-port option.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
