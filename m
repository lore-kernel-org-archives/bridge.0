Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1E6JeiiGsGkVww35EcZKNpNrX3ktiIWhgjgkQIwKbA=;
 b=ejGtEjnMADfGM+KcAe0/UcipmyJ4px55yNC5dQKaoGsuFgdFRDX4LOA8MqhXNeeSWx3kMTkduNmkrxfH98kkexHqZQbBZKECkXZNCP39ij4PrU7LtOMgyehwqmNkpOOlQlAtTtMqB2bbHIZIsTJo0d+xpcSQSl6trSiPc8k/zjxRkCu/lDMRSzwQcWEQ5S9CsiBv/hq5xYyLtXcy4CJFQUPkev3nfWwiAFhrI400d2I5RJBGyDz3fZIpsA/nzknzXyiBcPlMKnYqrGcyAR5rtkq11aUyqRQx+pKN3AkxsR/Pg9T1ZwvFEgjyWEl+fljEpedbEyw7XWZ+vEtEpC+yoQ==
Message-ID: <128db0c4-1d7e-27fa-0dae-3567a0913f1d@nvidia.com>
Date: Thu, 28 Oct 2021 19:00:49 +0300
Content-Language: en-US
References: <20211028155835.2134753-1-ivecera@redhat.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20211028155835.2134753-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net v2] net: bridge: fix uninitialized
 variables when BRIDGE_CFM is disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>

On 28/10/2021 18:58, Ivan Vecera wrote:
> Function br_get_link_af_size_filtered() calls br_cfm_{,peer}_mep_count()
> that return a count. When BRIDGE_CFM is not enabled these functions
> simply return -EOPNOTSUPP but do not modify count parameter and
> calling function then works with uninitialized variables.
> Modify these inline functions to return zero in count parameter.
> 
> Fixes: b6d0425b816e ("bridge: cfm: Netlink Notifications.")
> Cc: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  net/bridge/br_private.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 37ca76406f1e..fd5e7e74573c 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1911,11 +1911,13 @@ static inline int br_cfm_status_fill_info(struct sk_buff *skb,
>  
>  static inline int br_cfm_mep_count(struct net_bridge *br, u32 *count)
>  {
> +	*count = 0;
>  	return -EOPNOTSUPP;
>  }
>  
>  static inline int br_cfm_peer_mep_count(struct net_bridge *br, u32 *count)
>  {
> +	*count = 0;
>  	return -EOPNOTSUPP;
>  }
>  #endif
> 

Thank you,
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

