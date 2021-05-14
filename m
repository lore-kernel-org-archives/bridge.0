Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 14 May 2021 11:52:26 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20210514095226.GE2222@otheros>
References: <20210514073233.2564187-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210514073233.2564187-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: fix
 br_multicast_is_router stub when igmp is disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, davem@davemloft.net, roopa@nvidia.com

On Fri, May 14, 2021 at 10:32:33AM +0300, Nikolay Aleksandrov wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> br_multicast_is_router takes two arguments when bridge IGMP is enabled
> and just one when it's disabled, fix the stub to take two as well.
> 
> Fixes: 1a3065a26807 ("net: bridge: mcast: prepare is-router function for mcast router split")
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> ---
>  net/bridge/br_private.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 53cace4d9487..28f91b111085 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1081,7 +1081,8 @@ static inline void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
>  {
>  }
>  
> -static inline bool br_multicast_is_router(struct net_bridge *br)
> +static inline bool br_multicast_is_router(struct net_bridge *br,
> +					  struct sk_buff *skb)
>  {
>  	return false;
>  }
> -- 
> 2.30.2
> 

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
