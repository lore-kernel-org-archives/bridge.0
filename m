Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb8dEKq60p+PZzFZrVhTAINYAch6mLhTWofWF/N+i1k=;
 b=XM0HnsirQn0ua+13ZBrMtMliH2B3FqrYQcLvjGOlkYfcf/KuOuwFysBlD32PyBFDQuBwLMdBPvKiBpWZcNTHn5vDFgA1FLjW0LjNe5gEcb7KJIWd7+PxrkEXDr4NFs7+GQoxL3w+YS8fSLAXF+tIscpIcP0Qcnw6BKNlYMJFYDTJOQb6ka4/I/FtWltnOkDKwUCpHv+A80Qkd6vo2JPSHTwK07tCEJo3k2h2RuKR/RFKfQno0//PUlDfs7OIJtc5zvYxt9xv7hmvZQXYuKzPueHiYGxxQj3wDmal6O0Ez7mwMOn5KjMhdI80hiCLPJo9Tfe4JZTapmKZdd0OvBaHRg==
Message-ID: <0641aafd-650d-2f9e-1645-946c347677cc@nvidia.com>
Date: Tue, 12 Oct 2021 18:21:56 +0300
Content-Language: en-US
References: <20211012141810.30661-1-acadx0@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20211012141810.30661-1-acadx0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next] net: bridge: make use of helper
 netif_is_bridge_master()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kyungrok Chung <acadx0@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/10/2021 17:18, Kyungrok Chung wrote:
> Make use of netdev helper functions to improve code readability.
> Replace 'dev->priv_flags & IFF_EBRIDGE' with netif_is_bridge_master(dev).
> 
> Signed-off-by: Kyungrok Chung <acadx0@gmail.com>
> ---
>  net/bridge/br.c                 | 4 ++--
>  net/bridge/br_fdb.c             | 6 +++---
>  net/bridge/br_if.c              | 2 +-
>  net/bridge/br_ioctl.c           | 2 +-
>  net/bridge/br_mdb.c             | 4 ++--
>  net/bridge/br_netfilter_hooks.c | 2 +-
>  net/bridge/br_netlink.c         | 4 ++--
>  7 files changed, 12 insertions(+), 12 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
