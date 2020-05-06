Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=/9ah7zhuR4873GSpvZCqmYYEsJCcLFVCYyRiQ4J6Vdk=;
 b=GmeI+UP24kyAPTiBFvucgZ/V4AdmN9uFhZQV85PUDH3V01byOj0XccFF6diF/xZd4E
 +cSoNUycgb8W8kPHInzeAOkcj+nqZPlNvaGrwlGWqFZpY2eMaUa27ZP5I9tqihtthDnx
 6QQKERCXj5PH5svOqIuTE12LsGdy5dfxSTCXg=
References: <20200506061616.18929-1-yanaijie@huawei.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <80b3d01a-1bd5-f5c5-abaa-6f3114683617@cumulusnetworks.com>
Date: Wed, 6 May 2020 12:47:35 +0300
MIME-Version: 1.0
In-Reply-To: <20200506061616.18929-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: return false in
	br_mrp_enabled()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jason Yan <yanaijie@huawei.com>, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/05/2020 09:16, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> net/bridge/br_private.h:1334:8-9: WARNING: return of 0/1 in function
> 'br_mrp_enabled' with return type bool
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  net/bridge/br_private.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index c35647cb138a..78d3a951180d 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1331,7 +1331,7 @@ static inline int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
>  
>  static inline bool br_mrp_enabled(struct net_bridge *br)
>  {
> -	return 0;
> +	return false;
>  }
>  
>  static inline void br_mrp_port_del(struct net_bridge *br,
> 
Fixes: 6536993371fab ("bridge: mrp: Integrate MRP into the bridge")
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

