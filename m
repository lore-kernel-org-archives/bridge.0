Return-Path: <toshiaki.makita1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding;
	bh=NZ7+xBEpH+BVW+vouPvAG5Lm1v1TiIrDU9HDR1wmEp0=;
	b=IRA0xkzhaI8i1KuzGXYm71JCCYn4mfatqERonGzpuUMuh6td56TNwhE+lXp7gaw5rh
	1rf+rphOgPuDQafre65Upfg8KvE7HQL7xKWziccHS4tKfWGKTmei9wBA+BwTGRmXs3g/
	0iQEbQk7t12J38Nl6JiRmSNC7whGgxd/v96rpuqPNGrFgRvw+RlxEYlJrfC2Zw2638QA
	ztEWehCX1i6vVjNY9obTaQsiGh1ObKxXkfRnbc5eIj5HoYKHpyyHvGXwDzfvdNPf20ap
	+cS89pNPamfpkLgGRWfQFfUMZxt13lDwEtc/awEPDhoPP+NgIsuFyJYwQlmx29nUPIQT
	48Bg==
Message-ID: <1387787627.1797.10.camel@localhost.localdomain>
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
Date: Mon, 23 Dec 2013 17:33:47 +0900
In-Reply-To: <52B7C5D5.2040202@huawei.com>
References: <52B7C5D5.2040202@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 12/21] bridge: slight optimization of addr
	compare
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ding Tianhong <dingtianhong@huawei.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2013-12-23 at 13:10 +0800, Ding Tianhong wrote:
> Use the recently added and possibly more efficient
> ether_addr_equal_unaligned to instead of memcmp.
> 
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: David Miller <davem@davemloft.net>
> Cc: bridge@lists.linux-foundation.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Wang Weidong <wangweidong1@huawei.com>
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> ---
>  net/bridge/br_stp_if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 656a6f3..04217d1 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -229,7 +229,7 @@ bool br_stp_recalculate_bridge_id(struct net_bridge *br)
>  
>  	list_for_each_entry(p, &br->port_list, list) {
>  		if (addr == br_mac_zero ||
> -		    memcmp(p->dev->dev_addr, addr, ETH_ALEN) < 0)
> +		    !ether_addr_equal_unaligned(p->dev->dev_addr, addr) < 0)
>  			addr = p->dev->dev_addr;
>  
>  	}

We cannot do this change.
!ether_addr_equal() isn't identical to memcmp().
memcmp() can return negative value but ether_addr_equal() cannot.
br_stp_recalculate_bridge_id() is searching the smallest address among
its ports. This change breaks it.

Thanks,
Toshiaki Makita

