Date: Thu, 24 Feb 2011 12:04:12 +0800
From: Herbert Xu <herbert@gondor.hengli.com.au>
Message-ID: <20110224040412.GA25488@gondor.apana.org.au>
References: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
	<4D65CD81.4070203@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D65CD81.4070203@zytor.com>
Subject: Re: [Bridge] Multicast snooping fixes and suggestions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@web.de>, "David S. Miller" <davem@davemloft.net>

On Wed, Feb 23, 2011 at 07:16:17PM -0800, H. Peter Anvin wrote:
>
> Are these packets likely to address that situation (or am I just plain
> doing something stupid)?

No these patches deal with IPv6 multicast support in the bridge and
are not related to your problem.

If you're using the bridge for virtualisation and you know that
you don't have a loop in your setup, then one option would be to
disable STP on your bridge.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
