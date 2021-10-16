Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUniiJ6OeGLbG1wAJSEpLFfBJJ74i9fSehgCxYgN2+c=;
 b=PIz5G9by3kgNh9tIF0M/s2JcFADqltX4LJG0oWIGr8/5GDWdHrNFIUCrU5+zXW5Us/tm1HLryTOCwWC/CTYy4e4xm/hEHNy9R8nx7PgF4JzTvvH3S5oTeOXJoO7VWGpNzWbHaNv0qjA3yNVj6AigQ4OLp8y0Ar4NcrOa6ANWhEd+PoEmupckkQD+i9QLy0ngXgwOTWMIX10P+GhXRHCeR7UT2EB+FyZFGqdHnkqaP8r5dh/KnsG/NKYEpVI3rBSjOONogJlcoIZlpS8lXHuwJzKlB5B0M7eCqXCguMcLoeKEeFIBBY387j+puUvQvY6W7UEjYOihk0DITXqkmnVTRA==
Message-ID: <badf4e55-ddeb-cfdd-4162-b8b9ae3fed04@nvidia.com>
Date: Sat, 16 Oct 2021 13:56:26 +0300
Content-Language: en-US
References: <20211016050439.2592877-1-acadx0@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20211016050439.2592877-1-acadx0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v2 net-next] net: make use of helper
 netif_is_bridge_master()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kyungrok Chung <acadx0@gmail.com>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org

On 16/10/2021 08:04, Kyungrok Chung wrote:
> Make use of netdev helper functions to improve code readability.
> Replace 'dev->priv_flags & IFF_EBRIDGE' with netif_is_bridge_master(dev).
> 
> Signed-off-by: Kyungrok Chung <acadx0@gmail.com>
> ---
> 
> v1->v2:
>   - Apply fixes to batman-adv, core too.
> 
>  net/batman-adv/multicast.c      | 2 +-
>  net/bridge/br.c                 | 4 ++--
>  net/bridge/br_fdb.c             | 6 +++---
>  net/bridge/br_if.c              | 2 +-
>  net/bridge/br_ioctl.c           | 2 +-
>  net/bridge/br_mdb.c             | 4 ++--
>  net/bridge/br_netfilter_hooks.c | 2 +-
>  net/bridge/br_netlink.c         | 4 ++--
>  net/core/rtnetlink.c            | 2 +-
>  9 files changed, 14 insertions(+), 14 deletions(-)
> 
[snip]
>  	err = br_afspec(br, p, afspec, RTM_DELLINK, &changed, NULL);
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 2dc1b209ba91..d3676666a529 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4384,7 +4384,7 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  					continue;
>  
>  				if (br_dev != netdev_master_upper_dev_get(dev) &&
> -				    !(dev->priv_flags & IFF_EBRIDGE))
> +				    netif_is_bridge_master(dev))
>  					continue;
>  				cops = ops;
>  			}
> 

This looks wrong, the original check is if it's _not_ a bridge master.
