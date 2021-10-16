Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRRU9DkAx1sHIJ3WLpRQZB7LbZN0ArSSkzpxjncPtn0=;
 b=gX05H2BZpNOxoZ28d8pzfoXyLiq3YHb7BqtCtoxdDXILTZsGznE5Pk1upFwCzS1uzfff7LPHLqC9D71Mi6sR/4Btwx5xzZHuOFSf92Ho+QbegfF6bedWSZTrBpD4CvasgzS/2hzHlTUrKmFdPihvMiTpgHw3EtCXLpN1vw5up0QiseJZ4QWzYMsgrgQT6oNoZNxNzW3S5KRqpZoMKCbfTcv7tBmtIu3DVe90BKkEskfA3YTMPuXoRpasdl0R9oBEWiU7Ra0vCWsfw4ACNBVAvXRGaszftQjw0+7tWWU3+KXKR0144Dodbxgmm3lZdKNscth4N9kv7E+ieN3gTfKsVw==
Message-ID: <75a38832-b638-a95a-7ba7-f144cd05d978@nvidia.com>
Date: Sat, 16 Oct 2021 14:56:00 +0300
Content-Language: en-US
References: <20211016112137.18858-1-acadx0@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20211016112137.18858-1-acadx0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v3 net-next] net: make use of helper
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

On 16/10/2021 14:21, Kyungrok Chung wrote:
> Make use of netdev helper functions to improve code readability.
> Replace 'dev->priv_flags & IFF_EBRIDGE' with netif_is_bridge_master(dev).
> 
> Signed-off-by: Kyungrok Chung <acadx0@gmail.com>
> ---
> 
> v1->v2:
>   - Apply fixes to batman-adv, core too.
> 
> v2->v3:
>   - Fix wrong logic.
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

LGTM,
Reviewed-by: Nikolay Aleksandrov <nikolay@nvidia.com>

