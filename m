Return-Path: <herbert@gondor.apana.org.au>
Date: Tue, 4 Dec 2012 15:07:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20121204070732.GA32550@gondor.apana.org.au>
References: <1354545363-11953-1-git-send-email-amwang@redhat.com>
	<20121203075316.0b1da39d@nehalam.linuxnetplumber.net>
	<20121204013838.GA31329@gondor.apana.org.au>
	<1354604692.15167.7.camel@cr0>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1354604692.15167.7.camel@cr0>
Subject: Re: [Bridge] [PATCH net-next] bridge: implement multicast fast leave
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Tue, Dec 04, 2012 at 03:04:52PM +0800, Cong Wang wrote:
>
> Per-port sounds better than per-bridge. And I will make it enabled by
> default.

IMHO the default should be off.  Suddenly losing your subscription
because someone else on the same port unsubscribed is a lot more
annoying than getting a few minutes of unwanted multicast data.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
