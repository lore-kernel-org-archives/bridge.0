Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2NAw2IL+9UQ8hjV0lH7nPLMMbQL4XA9AgK+HUCn4Vg=;
 b=Nor+EEXWve0RDJsd7DzVKtdAF2wXEW4twGvy/q3GU/ucSojfGJw0WgU8ZyL+QIZuLHRx0RIvFxQtOJEl4cmkbgqnJSyKM84r6qvc5GJO/KIr1WiMzcBbwXltimYFm1KZlF6MH7ZiHf0KgJKSxW1V8T+WXXqyP/gptNKc5ClVxk3o9ad5lXLrAazSFXwNzI0ruWkdDt1KGN0AJ7rJz4AAhcxohEViqb/ksCZyfJI7w1zSqMqHUdRy9eiJTMN+IOUf8XkHhJI80NHyUuwNyZLINYzGAz0/Hhw6JGVcBy/dfjDwSFA4IyCd/LVsbVILOGGzZ6RPUavXOLRx6DLp0GzbKw==
References: <20210512231941.19211-1-linus.luessing@c0d3.blue>
 <20210512231941.19211-12-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <44fa04ee-752a-34b9-d5d1-e6264aa859c1@nvidia.com>
Date: Thu, 13 May 2021 14:39:17 +0300
In-Reply-To: <20210512231941.19211-12-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v3 11/11] net: bridge: mcast: export
 multicast router presence adjacent to a port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>

On 13/05/2021 02:19, Linus Lüssing wrote:
> To properly support routable multicast addresses in batman-adv in a
> group-aware way, a batman-adv node needs to know if it serves multicast
> routers.
> 
> This adds a function to the bridge to export this so that batman-adv
> can then make full use of the Multicast Router Discovery capability of
> the bridge.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  include/linux/if_bridge.h |  8 ++++++
>  net/bridge/br_multicast.c | 55 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>


