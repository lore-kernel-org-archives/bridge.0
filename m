Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 124CB81B3E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8C6081DE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/SjDO6EqNmi5y7XE3sAL8vvCHxfKdZQcflUbJwAoNdk=;
 b=sl6rqalKTORmeCW3cgfxYFWnfEdrE1Ohxuo91EvA9Kk25SNlDc/wPrTo5+U85ov5I0
 J+odxvOcte2fm31vDYc4IEVPsiPVZVFpPgmmoGBTI5Z8Svfe/J5du2qeKHerKelaMVNa
 lH0hJktWHtD7hMiYsXQyOJQ4cTg6VnzzrJjjZHhg9EDWGBrga8T5gtLcjVJxBAOlODLV
 j/jfmI5j82iJZdsYU1+lIqIIEc/a6HUEZaUIx6gdV+u+FBP1ZQcumDWagY0W9BmXHRpl
 88PO9uP5RRvw2YaRLtXvUXBApCl8RWEj4Swvwyp7nzQoA+Gq9L8k9V5ECdfNPawapsrg
 0jzA==
Message-ID: <77af7d2b-d7f4-4df0-294b-14a17300ef8f@blackwall.org>
Date: Wed, 8 Feb 2023 12:49:06 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230208005626.56847-1-yang.lee@linux.alibaba.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230208005626.56847-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH -next] net: bridge: clean up one inconsistent
	indenting
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Yang Li <yang.lee@linux.alibaba.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com

On 2/8/23 02:56, Yang Li wrote:
> ./net/bridge/br_netlink_tunnel.c:317:4-27: code aligned with following code on line 318
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3977
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   net/bridge/br_netlink_tunnel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
> index 17abf092f7ca..eff949bfdd83 100644
> --- a/net/bridge/br_netlink_tunnel.c
> +++ b/net/bridge/br_netlink_tunnel.c
> @@ -315,7 +315,7 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
>   
>   			if (curr_change)
>   				*changed = curr_change;
> -			 __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
> +			__vlan_tunnel_handle_range(p, &v_start, &v_end, v,
>   						    curr_change);
>   		}
>   		if (v_start && v_end)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

