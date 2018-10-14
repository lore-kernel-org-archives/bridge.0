Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=UQGklsFOfq1+RN19neasrBuvUC9IIKlnzTSV/BWuPGs=;
	b=F9LOM0FfMenX+R0gygaXgVE57W/Vex+yMbcvxHlWHOBK3RmVunhXOpXy3K1wPIGjPl
	9I15soFijONSAK3gWLSku+8ywPjkQ31OOs7O2xBudonhpDvQHJGiGeAr628ycf53kSQ7
	eDw74LGSOxYAuOWrPS90v7/RNM33H2asvCtEA=
References: <1539487305-12761-1-git-send-email-lirongqing@baidu.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <2badfb2b-0a50-4d18-cdb4-d894b4ef7bec@cumulusnetworks.com>
Date: Sun, 14 Oct 2018 18:33:42 +0300
MIME-Version: 1.0
In-Reply-To: <1539487305-12761-1-git-send-email-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: fix a memory leak in __vlan_add
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Li RongQing <lirongqing@baidu.com>, netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org

On 14/10/2018 06:21, Li RongQing wrote:
> After per-port vlan stats, vlan stats should be released
> when fail to add vlan
> 
> Fixes: 9163a0fc1f0c0 ("net: bridge: add support for per-port vlan stats")
> cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  net/bridge/br_vlan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 9b707234e4ae..e08e269041dd 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -305,6 +305,10 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
>  		if (masterv) {
>  			br_vlan_put_master(masterv);
>  			v->brvlan = NULL;
> +
> +			if (masterv->stats != v->stats && v->stats)
> +				free_percpu(v->stats);
> +			v->stats = NULL;
>  		}
>  	} else {
>  		br_switchdev_port_vlan_del(dev, v->vid);
> 

Hi,
Good catch, but the patch doesn't fix the bug entirely. The problem is that masterv can be
created just for this vlan and the br_vlan_put_master() above can free it, so we can
check a pointer that's not really up-to-date (and thus again leak memory).
You should move the new code above the br_vlan_put_master() call.

Also please tag the proper branch, this is for net-next, and CC all bridge
maintainers (added Roopa).

Thank you,
 Nik
