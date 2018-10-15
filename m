Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=PrRxukJZ3KqPtLWyZmdZIxyMfLfgQZ/KZWSiK+gKL0A=;
	b=Pu68NfPhUKq+bTLKygPuObBGLWuptV1736GAmN69SCXq0tR9sH32nSXElBVgEUrdsJ
	Y/qyKyklt6IxMOJ42dD+Lr/Qac4xDMsCvmdLkx/fP3ROxHRNo9staRto+q9C6vZ1IixT
	lqN2zIieQss1DRdkRqY6rNc+Nr6yF09nhMl9M=
References: <1539601231-32755-1-git-send-email-lirongqing@baidu.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <822fcc88-a8d5-f27e-88c1-32a55a6f9b0e@cumulusnetworks.com>
Date: Mon, 15 Oct 2018 14:13:38 +0300
MIME-Version: 1.0
In-Reply-To: <1539601231-32755-1-git-send-email-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH][net-next][v2] net: bridge: fix a possible
 memory leak in __vlan_add
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Li RongQing <lirongqing@baidu.com>, netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

On 15/10/2018 14:00, Li RongQing wrote:
> After per-port vlan stats, vlan stats should be released
> when fail to add vlan
> 
> Fixes: 9163a0fc1f0c0 ("net: bridge: add support for per-port vlan stats")
> CC: bridge@lists.linux-foundation.org
> cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> CC: Roopa Prabhu <roopa@cumulusnetworks.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  net/bridge/br_vlan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 9b707234e4ae..8c9297a01947 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -303,6 +303,10 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
>  	if (p) {
>  		__vlan_vid_del(dev, br, v->vid);
>  		if (masterv) {
> +			if (v->stats && masterv->stats != v->stats)
> +				free_percpu(v->stats);
> +			v->stats = NULL;
> +
>  			br_vlan_put_master(masterv);
>  			v->brvlan = NULL;
>  		}
> 

Thanks,
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

