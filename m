Return-Path: <simon.horman@corigine.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC263415DD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDE4A4159C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5431h7tNgILKX6a9//swea+hULDSePDtpNj0HhZQJI=;
 b=p62OobRNoHFv+uRZIVZzpqf1Uq97sZ1imjf1xbzY5neT5ZxaHchcLQbqyvvItog/i1epAw3p0M2WZCA4fZhNVAkFrsCAoQwEcSiiKNYWfokY6FeyBJpJzx0+Q5vNJEQtJ8tClekwuLmTLX4izK3hqHD8T5r2uHKE7v+eAp8Ia14=
Date: Sun, 29 Jan 2023 19:39:41 +0100
From: Simon Horman <simon.horman@corigine.com>
Message-ID: <Y9a9bTU3edwDRW6N@corigine.com>
References: <c1a88f471a8aa6d780dde690e76b73ba15618b6d.1675010984.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1a88f471a8aa6d780dde690e76b73ba15618b6d.1675010984.git.leon@kernel.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v2] netlink: provide an ability to set
 default extack message
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>

On Sun, Jan 29, 2023 at 06:51:37PM +0200, Leon Romanovsky wrote:
> In netdev common pattern, extack pointer is forwarded to the drivers
> to be filled with error message. However, the caller can easily
> overwrite the filled message.
> 
> Instead of adding multiple "if (!extack->_msg)" checks before any
> NL_SET_ERR_MSG() call, which appears after call to the driver, let's
> add new macro to common code.
> 
> [1] https://lore.kernel.org/all/Y9Irgrgf3uxOjwUm@unreal
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

