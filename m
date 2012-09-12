Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:from:to:cc:in-reply-to:references:content-type:date
	:message-id:mime-version:x-mailer:content-transfer-encoding;
	bh=EyrIdwt1TvbwYFsrV3I62ZC5t4uhD399e6GS7RQutRc=;
	b=m4mxFOIk9l5d1dfG8NIcQjrk/n68gO5EERbpwgqa4QT2CJo99RKrqUBjz18ROELzGv
	b7fInr2LSbeSQw6410Q8Z4pZCAmyJZDGiYQzdlYzctcbIDmd6f9aTypgP+XE4b0Qgglh
	TccjbZ4H2JCOX1ww4wkdV4r4L9gaY/3V+/Hmx1wDqSW5AnCS23vaNTk41+KpbsOIkmgW
	xiBkW9xX7yY5xN0uDsnoyIzshSPRf5h4M7fDjC7SLPUyTRdjLNbxm9gIMuZn+RFsiRiz
	5nUTVrfkZZKe60xkKU0i4UVZAoaOylCa8zQJXLVQHu+xJJv7QwFEunJOUXMY6omAnsiO
	0qOA==
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <1347435973.2456.23.camel@joe2Laptop>
References: <20120912045120.9E1A76F446@smtp.hushmail.com>
	<1347435973.2456.23.camel@joe2Laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 Sep 2012 10:07:25 +0200
Message-ID: <1347437245.13103.697.camel@edumazet-glaptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] netfilter/iptables: Fix log-level processing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joe Perches <joe@perches.com>
Cc: auto75914331@hushmail.com, netfilter@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Bart De Schuymer <bart.de.schuymer@pandora.be>, netfilter-devel@vger.kernel.org, Stephen Hemminger <shemminger@vyatta.com>, Patrick McHardy <kaber@trash.net>, Pablo Neira Ayuso <pablo@netfilter.org>

On Wed, 2012-09-12 at 00:46 -0700, Joe Perches wrote:
> auto75914331@hushmail.com reports that iptables does not correctly
> output the KERN_<level>.
> 
> $IPTABLES -A RULE_0_in  -j LOG  --log-level notice --log-prefix "DENY  in: "
> 
> result with linux 3.6-rc5
> Sep 12 06:37:29 xxxxx kernel: <5>DENY  in: IN=eth0 OUT= MAC=.......
> 
> result with linux 3.5.3 and older:
> Sep  9 10:43:01 xxxxx kernel: DENY  in: IN=eth0 OUT= MAC......
> 
> commit 04d2c8c83d0
> ("printk: convert the format for KERN_<LEVEL> to a 2 byte pattern")
> updated the syslog header style but did not update netfilter uses.
> 
> Do so.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> cc: auto75914331@hushmail.com
> ---
>  net/bridge/netfilter/ebt_log.c |    4 ++--
>  net/netfilter/xt_LOG.c         |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/netfilter/ebt_log.c b/net/bridge/netfilter/ebt_log.c
> index f88ee53..cb46d2f 100644
> --- a/net/bridge/netfilter/ebt_log.c
> +++ b/net/bridge/netfilter/ebt_log.c
> @@ -80,8 +80,8 @@ ebt_log_packet(u_int8_t pf, unsigned int hooknum,
>  	unsigned int bitmask;
>  
>  	spin_lock_bh(&ebt_log_lock);
> -	printk("<%c>%s IN=%s OUT=%s MAC source = %pM MAC dest = %pM proto = 0x%04x",
> -	       '0' + loginfo->u.log.level, prefix,
> +	printk("%c%c%s IN=%s OUT=%s MAC source = %pM MAC dest = %pM proto = 0x%04x",
> +	       KERN_SOH_ASCII, '0' + loginfo->u.log.level, prefix,
>  	       in ? in->name : "", out ? out->name : "",
>  	       eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest,
>  	       ntohs(eth_hdr(skb)->h_proto));
> diff --git a/net/netfilter/xt_LOG.c b/net/netfilter/xt_LOG.c
> index ff5f75f..bdc5352 100644
> --- a/net/netfilter/xt_LOG.c
> +++ b/net/netfilter/xt_LOG.c
> @@ -436,8 +436,8 @@ log_packet_common(struct sbuff *m,
>  		  const struct nf_loginfo *loginfo,
>  		  const char *prefix)
>  {
> -	sb_add(m, "<%d>%sIN=%s OUT=%s ", loginfo->u.log.level,
> -	       prefix,
> +	sb_add(m, "%c%c%sIN=%s OUT=%s ",
> +	       KERN_SOH_ASCII, '0' + loginfo->u.log.level, prefix,
>  	       in ? in->name : "",
>  	       out ? out->name : "");
>  #ifdef CONFIG_BRIDGE_NETFILTER
> 

would be better to avoid the %c

->

 sb_add(m, KERN_SOH "%c%sIN=%s OUT=%s ",
	'0' + loginfo->u.log.level, prefix,


