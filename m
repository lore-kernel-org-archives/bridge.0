Return-Path: <herbert@gondor.apana.org.au>
Date: Fri, 22 May 2015 11:17:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20150522031735.GB30043@gondor.apana.org.au>
References: <1432256161-4425-1-git-send-email-linus.luessing@c0d3.blue>
	<CAHA+R7M+F88KsAJy-fGkSjUXxgBNifdML0E3r8jrQqXafZMUpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHA+R7M+F88KsAJy-fGkSjUXxgBNifdML0E3r8jrQqXafZMUpA@mail.gmail.com>
Subject: Re: [Bridge] [PATCH net-next] bridge: allow setting hash_max +
 multicast_router if interface is down
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <cwang@twopensource.com>
Cc: netdev <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

On Thu, May 21, 2015 at 08:11:32PM -0700, Cong Wang wrote:
>
> For me it looks like we do use p->rlist in BH context, but I could easily
> miss something here.

Because the caller disables BH for us.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
