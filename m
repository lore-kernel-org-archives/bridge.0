Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=AiZGBHJWUU+y3IzVaHX84qjtArvYOyCoke2uD9GNBy0=;
	b=Pabjgr/OrPcrfT6fDi1H3CK06QgwCYauBrgoDMuoITyfWOgFMdtjHaPWCNwIO9Kix0
	0/52xiS3vrIeME98HPGDBhKmVQmExeifuxeKteSLg2Vfn4rJ/jz7XafIeGXrdlkgdyAy
	RIOe58LbKSnX318mu5N2vVc3oLhjQtahKRcPI=
References: <20190404115638.28592-1-pablo@netfilter.org>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <952568d9-771f-982c-9a75-5dfc01a461fb@cumulusnetworks.com>
Date: Thu, 4 Apr 2019 15:02:19 +0300
MIME-Version: 1.0
In-Reply-To: <20190404115638.28592-1-pablo@netfilter.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: update multicast stats
 from maybe_deliver()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>, netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, nbd@nbd.name

On 04/04/2019 14:56, Pablo Neira Ayuso wrote:
> Simplify this code by updating bridge multicast stats from
> maybe_deliver().
> 
> Note that commit 6db6f0eae605 ("bridge: multicast to unicast"), in case
> the port flag BR_MULTICAST_TO_UNICAST is set, never updates the previous
> port pointer, therefore it is always going to be different from the
> existing port in this deduplicated list iteration.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  net/bridge/br_forward.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 

This was intentional, the reason I didn't add that call to maybe_deliver() is to avoid
these checks for the standard unicast fast-path.  We need to avoid touching the mcast
cache lines (and checks) when using unicast.

