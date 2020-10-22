Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3dm/6UU7gzYtewq70pBYmJhrFBt9p+uK9v/LY5XBQe8=;
 b=WdHQm9X1Ao2rROrM/DL9Ob5ETV5dcmcxbbi05C5ioxMtbjEFPu3amCoERC6BHS5ppC
 jUCpJ54iUYioZDSSbRWoRxCclHJU2JtZBbuzhQKlaoGfRi2P3C3aoYELYkdM3Ek82NIg
 /ql2TOC/FiXWF3ne/NQAZ463k3oht0RbEiVAsKFptqY+29o7VcNwnZHW3zobc8msa2X1
 zO5gOJQMcdg6oEVFJShVA7kglwRFhbHPbFKzO/ozeQPE39n/MLVVx9kgdzBxWcAPTbDC
 +1ZEfeuMQ8ZS2WXFxUtATlwTjKv7PedQHfi0mdzi0cs+G6RgmmJ67hNItyrWmZIM4FVf
 /Txw==
Date: Thu, 22 Oct 2020 12:52:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20201022125220.45c24b30@hermes.local>
In-Reply-To: <20201017184526.2333840-1-vladimir.oltean@nxp.com>
References: <20201017184526.2333840-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH iproute2] bridge: add support for L2
 multicast groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: andrew@lunn.ch, David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vivien.didelot@gmail.com, idosch@idosch.org, jiri@mellanox.com, f.fainelli@gmail.com, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Sat, 17 Oct 2020 21:45:26 +0300
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> Extend the 'bridge mdb' command for the following syntax:
> bridge mdb add dev br0 port swp0 grp 01:02:03:04:05:06 permanent
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  bridge/mdb.c                   | 54 ++++++++++++++++++++++++++--------
>  include/uapi/linux/if_bridge.h |  2 ++
>  2 files changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/bridge/mdb.c b/bridge/mdb.c
> index 4cd7ca762b78..af160250928e 100644
> --- a/bridge/mdb.c
> +++ b/bridge/mdb.c
> @@ -149,6 +149,7 @@ static void print_mdb_entry(FILE *f, int ifindex, const struct br_mdb_entry *e,
>  			    struct nlmsghdr *n, struct rtattr **tb)
>  {
>  	const void *grp, *src;
> +	const char *addr;
>  	SPRINT_BUF(abuf);
>  	const char *dev;
>  	int af;
> @@ -156,9 +157,16 @@ static void print_mdb_entry(FILE *f, int ifindex, const struct br_mdb_entry *e,
>  	if (filter_vlan && e->vid != filter_vlan)
>  		return;
>  
> -	af = e->addr.proto == htons(ETH_P_IP) ? AF_INET : AF_INET6;
> -	grp = af == AF_INET ? (const void *)&e->addr.u.ip4 :
> -			      (const void *)&e->addr.u.ip6;
> +	if (!e->addr.proto) {
> +		af = AF_PACKET;
> +		grp = (const void *)&e->addr.u.mac_addr;
> +	} else if (e->addr.proto == htons(ETH_P_IP)) {
> +		af = AF_INET;
> +		grp = (const void *)&e->addr.u.ip4;
> +	} else {
> +		af = AF_INET6;
> +		grp = (const void *)&e->addr.u.ip6;
> +	}
>  	dev = ll_index_to_name(ifindex);
>  

In C casts of pointer to void are not necessary.
