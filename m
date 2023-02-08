Return-Path: <simon.horman@corigine.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8475140157
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65D1E400F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJDGOrESqVw7O/6115CebnbOEq+KHWZ2tAT8wWIZs98=;
 b=MUnl4PP0gqu/BA3PB29P88G+CZcVmSWMUn2mt7Flzn83LslcVhpCS8J/kTOUvWKu/scVvgn1OMNIX7IVOEPQTbM7NFstW4oOitZGxxYzmF/ddC0Hd9gTse/NwLfGZgvqMURS5Y3VkxviM4IG8kFfBYuhL1h4c3VoATO2JgsiUNg=
Date: Wed, 8 Feb 2023 14:04:10 +0100
From: Simon Horman <simon.horman@corigine.com>
Message-ID: <Y+OdyiQpz7lIBfh3@corigine.com>
References: <20230208005626.56847-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208005626.56847-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
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
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Wed, Feb 08, 2023 at 08:56:26AM +0800, Yang Li wrote:
> ./net/bridge/br_netlink_tunnel.c:317:4-27: code aligned with following code on line 318
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3977
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

As you may need to respin this:

Assuming this is targeting net-next, which seems likely to me,
the subject should denote that. Something like this:

[PATCH net-next] net: bridge: clean up one inconsistent indenting

> ---
>  net/bridge/br_netlink_tunnel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
> index 17abf092f7ca..eff949bfdd83 100644
> --- a/net/bridge/br_netlink_tunnel.c
> +++ b/net/bridge/br_netlink_tunnel.c
> @@ -315,7 +315,7 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
>  
>  			if (curr_change)
>  				*changed = curr_change;
> -			 __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
> +			__vlan_tunnel_handle_range(p, &v_start, &v_end, v,
>  						    curr_change);

I think you also need to adjust the line immediately above.

>  		}
>  		if (v_start && v_end)
> -- 
> 2.20.1.7.g153144c
> 
