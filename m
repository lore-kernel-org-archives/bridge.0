Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDsgPaGQAZTLjsQ3v5s2KKvlDQ1c0mF7+Owo6M92m4E=;
 b=SOlhjmbKRfs1zTc19LqSeOomHOg4KrbuNt/Do6kDXTFyquCZkhB+hzCcGThz4S5NvdCDdMouA2Q+l7rmuf7Agj9rJGyaau3q1ZYsXyXaEup2rRbxm8nrChjXnttucn6lbMM8gDVgBz8XGcDJlW6w2OYw96tEYdFCRc9ONOIscB3nGi/BQgQRMbe5oSzL5uPd0pX8PAF27acQ/vFl2fC57zGxR+kDJx5JkR/HrGPrzUqSOMZoVP3NdPy30OK7VgQUjAvn74NtyfaxKrG7vpP0llfxgCZsiIUVbJvnsB+CYVoN3S6EM/Jq4KOwI6nyWwq2dFR4U3R9KxAcEys4hAVobA==
Message-ID: <52b71034-d35a-75cd-cb7b-e7a1d355b361@nvidia.com>
Date: Sun, 13 Feb 2022 12:13:21 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <73f674075ae5279e3d2fa07d61a0a75bc50790f3.1644659879.git.christophe.jaillet@wanadoo.fr>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <73f674075ae5279e3d2fa07d61a0a75bc50790f3.1644659879.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: Slightly optimize
	br_stp_change_bridge_id()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/02/2022 11:58, Christophe JAILLET wrote:
> ether_addr_equal_64bits() can easy be used in place of ether_addr_equal()
> here.
> Padding in the 'net_bridge_port' structure is already there because it is a
> huge structure and the required fields are not at the end.
> 'oldaddr' is local to the function. So add the required padding
> explicitly and simplify its definition.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is more a POC for me.
> 
> I'm unsure that using ether_addr_equal_64bits() is really useful. The
> speedup should be mostly un-noticeable.
> 
> To make sure that we have the required padding, we either need to waste
> some space or rely on the fact that the address is embedded in a large
> enough structure. (which is the case here)
> 
> So, it looks fragile to me and not future-proof.
> 
> Feed-back highly appreciated to see if such patches are welcome and if I
> should spend some time on it.
> ---

This is slow path, more so as you've noted above the change is fragile and someone
can easily miss it, I appreciate the comments but for this case I'd prefer to
leave the code as-is to keep it obviously correct and avoid future problems.

Thanks,
 Nik

>  net/bridge/br_private.h |  5 +++++
>  net/bridge/br_stp_if.c  | 12 +++++++-----
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 2661dda1a92b..2f78090574c9 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -363,6 +363,11 @@ struct net_bridge_port {
>  	unsigned char			config_pending;
>  	port_id				port_id;
>  	port_id				designated_port;
> +	/*
> +	 * designated_root and designated_bridge must NOT be at the end of the
> +	 * structure because ether_addr_equal_64bits() requires 2 bytes of
> +	 * padding.
> +	 */
>  	bridge_id			designated_root;
>  	bridge_id			designated_bridge;
>  	u32				path_cost;
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 75204d36d7f9..1bf0aaf29e5e 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -221,9 +221,11 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
>  /* called under bridge lock */
>  void br_stp_change_bridge_id(struct net_bridge *br, const unsigned char *addr)
>  {
> -	/* should be aligned on 2 bytes for ether_addr_equal() */
> -	unsigned short oldaddr_aligned[ETH_ALEN >> 1];
> -	unsigned char *oldaddr = (unsigned char *)oldaddr_aligned;
> +	/*
> +	 * should be aligned on 2 bytes and have 2 bytes of padding for
> +	 * ether_addr_equal_64bits()
> +	 */
> +	unsigned char oldaddr[ETH_ALEN + 2] __aligned(2);
>  	struct net_bridge_port *p;
>  	int wasroot;
>  
> @@ -236,10 +238,10 @@ void br_stp_change_bridge_id(struct net_bridge *br, const unsigned char *addr)
>  	eth_hw_addr_set(br->dev, addr);
>  
>  	list_for_each_entry(p, &br->port_list, list) {
> -		if (ether_addr_equal(p->designated_bridge.addr, oldaddr))
> +		if (ether_addr_equal_64bits(p->designated_bridge.addr, oldaddr))
>  			memcpy(p->designated_bridge.addr, addr, ETH_ALEN);
>  
> -		if (ether_addr_equal(p->designated_root.addr, oldaddr))
> +		if (ether_addr_equal_64bits(p->designated_root.addr, oldaddr))
>  			memcpy(p->designated_root.addr, addr, ETH_ALEN);
>  	}
>  

