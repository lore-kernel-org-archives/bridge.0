Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8ymBOaT7fdjda4eQd3+azcQcApZtzF7FNoDVGA8xmc=;
 b=EVa4AugCKT1AnsHqy+6/kSFkV7uqXgzvm6K0gCcmTqmPFu7SZBdzgixIae1cy4vAmJiXYOTHA1GL0P0B878zmq29yUn1F2jn3R75QvvBBdWtUe1HcG62g0QjXSmdhyFHv21D7pcn1K6Y/pcDYxlN/13ZHq1sbtFhqoTZvWH0Mqx1rdKtq27gusI2To9ZCl14h8jBRaL8OjYXOvkKYWC5Rnh9PsVVIX17AYLd7E8vWFI5W92DspvBhYP2gBhWgw96Xt2ZxfPSfnvoNUEeSoOwbDkSuUshTZo8s17E6weT7pnaQM/d2f/cp9oLZWeHiFmSPJZSk6BgDhbfxtnpZpqldg==
References: <20210618100155.101386-1-colin.king@canonical.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <2bf73453-1bd9-3f3a-ecc7-7e0003c886e4@nvidia.com>
Date: Fri, 18 Jun 2021 13:12:32 +0300
In-Reply-To: <20210618100155.101386-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH] net: bridge: remove redundant continue
	statement
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Colin King <colin.king@canonical.com>, Roopa Prabhu <roopa@nvidia.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On 18/06/2021 13:01, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The continue statement at the end of a for-loop has no effect,
> invert the if expression and remove the continue.
> 
> Addresses-Coverity: ("Continue has no effect")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/bridge/br_vlan.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index da3256a3eed0..8789a57af543 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -113,9 +113,7 @@ static void __vlan_add_list(struct net_bridge_vlan *v)
>  	headp = &vg->vlan_list;
>  	list_for_each_prev(hpos, headp) {
>  		vent = list_entry(hpos, struct net_bridge_vlan, vlist);
> -		if (v->vid < vent->vid)
> -			continue;
> -		else
> +		if (v->vid >= vent->vid)
>  			break;
>  	}
>  	list_add_rcu(&v->vlist, hpos);
> 

This should be targeted at net-next. Thanks,
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
