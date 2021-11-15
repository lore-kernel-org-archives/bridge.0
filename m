Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n67kbimtp8MtHB3A7c08WI1fauMy5KMJ0MyxZBnmcSk=;
 b=g6fylaDzBWMy5+PsYsX4Qxj5ZyqsdlTErr/qegMEjeYrEuBpbrUZ5WOQKGyu7eSC5vV7hfV94mqWvRTXJG/7XyAXHId5d0MNCW0Mtq0oshQyoBxlVF8FBFJj0ITc6uOGoJRnQXg+0+hosGNMPakLGqSTuzd7C/dm8tOLgiMm0hehGU4vhucU5Pyk29K4CInAHQJ8JTYk5qugisg2fLbCkH98JREEyqqTwee9Qt8GGToBKKbc+9O5LpwogLfeze/T/ugoUMk85k4LFFamIGNvLTB6CosnxS+6TJ7a1YAtIaB0smg6JLRWW3hT4IbiuRURTbLJyuYO3Ttjh5XqA/pzqg==
Message-ID: <ee7c8d05-93bf-3cc8-781f-2d6302778b3f@nvidia.com>
Date: Mon, 15 Nov 2021 14:57:58 +0200
Content-Language: en-US
References: <00c39d09c8df7ad0673bf2043f6566d6ef08b789.1636916479.git.christophe.jaillet@wanadoo.fr>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <00c39d09c8df7ad0673bf2043f6566d6ef08b789.1636916479.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH] net: bridge: Slightly optimize 'find_portno()'
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, roopa@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On 14/11/2021 21:02, Christophe JAILLET wrote:
> The 'inuse' bitmap is local to this function. So we can use the
> non-atomic '__set_bit()' to save a few cycles.
> 
> While at it, also remove some useless {}.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  net/bridge/br_if.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index c1183fef1f21..64b2d4fb50f5 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -397,10 +397,10 @@ static int find_portno(struct net_bridge *br)
>  	if (!inuse)
>  		return -ENOMEM;
>  
> -	set_bit(0, inuse);	/* zero is reserved */
> -	list_for_each_entry(p, &br->port_list, list) {
> -		set_bit(p->port_no, inuse);
> -	}
> +	__set_bit(0, inuse);	/* zero is reserved */
> +	list_for_each_entry(p, &br->port_list, list)
> +		__set_bit(p->port_no, inuse);
> +
>  	index = find_first_zero_bit(inuse, BR_MAX_PORTS);
>  	bitmap_free(inuse);
>  
> 

This should be targeted at net-next.
The patch itself looks ok, TBH it's a slow path so speed
doesn't really matter but it's a straight-forward change.

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
