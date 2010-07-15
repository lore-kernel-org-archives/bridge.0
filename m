Date: Thu, 15 Jul 2010 12:21:44 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100715122144.0f2cf5cf@nehalam>
In-Reply-To: <1279219653-12791-1-git-send-email-segooon@gmail.com>
References: <1279219653-12791-1-git-send-email-segooon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 7/8] net: bridge: fix sign bug
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kulikov Vasiliy <segooon@gmail.com>
Cc: YOSHIFUJI, Eric Dumazet <eric.dumazet@gmail.com>, Hideaki <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, Herbert Xu <herbert@gondor.hengli.com.au>, "David S. Miller" <davem@davemloft.net>

On Thu, 15 Jul 2010 22:47:33 +0400
Kulikov Vasiliy <segooon@gmail.com> wrote:

> ipv6_skip_exthdr() can return error code that is below zero.
> 'offset' is unsigned, so it makes no sense.
> ipv6_skip_exthdr() returns 'int' so we can painlessly change type of
> offset to int.
> 
> Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
> ---
>  net/bridge/br_multicast.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 27ae946..85afcda 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1435,7 +1435,7 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
>  	struct icmp6hdr *icmp6h;
>  	u8 nexthdr;
>  	unsigned len;
> -	unsigned offset;
> +	int offset;
>  	int err;
>  
>  	if (!pskb_may_pull(skb, sizeof(*ip6h)))

Acked-by: Stephen Hemminger <shemminger@vyatta.com>

-- 
