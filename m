Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 743B9403AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ADD4E400D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1690458245; x=1691063045;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Pd52QAOVtNNbgDqHYQEjCrAzdyOOjihPSFq0M5Ik4Y=;
 b=Bbak6hOsd1TyATRGYe05W+0/rKMMCiOckHsDdv6SyfQ0uqHMfd3rafUSrblXXzZoyK
 FHmSWmyL7uuFub/fafa5s6Gam61mZI3IzRKmsHFU0ZiMqKVeVGtqm5DR7DqF7JXKTXUF
 aH+mx/OTorlYbaLSNJgaozLQQOD+gkVjFPJryET2EKavzdFF74BjnpzS0aMo5Q7aO3++
 DfWTnOH1fDDHf/iOk1+Vek4v6aZDcu8EJJ/ZEiXBsQtUnj/6LXvYIGvW1+7cYa3iH/aX
 NNhAbdaKjxHA33v71NGTz73iWZdfrmjAVdhuUqBoLHqsSK82OhCjmn5onGqGbvwAQWUf
 PGXQ==
Message-ID: <bd9e39da-088c-976e-982e-f5e2d4f4528b@blackwall.org>
Date: Thu, 27 Jul 2023 14:44:03 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230726143141.11704-1-yuehaibing@huawei.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230726143141.11704-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: Remove unused declaration
 br_multicast_set_hash_max()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: YueHaibing <yuehaibing@huawei.com>, roopa@nvidia.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On 7/26/23 17:31, YueHaibing wrote:
> Since commit 19e3a9c90c53 ("net: bridge: convert multicast to generic rhashtable")
> this is not used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   net/bridge/br_private.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 51e4ca54b537..a1f4acfa6994 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -974,7 +974,6 @@ int br_multicast_set_vlan_router(struct net_bridge_vlan *v, u8 mcast_router);
>   int br_multicast_toggle(struct net_bridge *br, unsigned long val,
>   			struct netlink_ext_ack *extack);
>   int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val);
> -int br_multicast_set_hash_max(struct net_bridge *br, unsigned long val);
>   int br_multicast_set_igmp_version(struct net_bridge_mcast *brmctx,
>   				  unsigned long val);
>   #if IS_ENABLED(CONFIG_IPV6)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

