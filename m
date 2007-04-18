Message-ID: <4625BE2C.1030801@sw.ru>
Date: Wed, 18 Apr 2007 10:43:56 +0400
From: Pavel Emelianov <xemul@sw.ru>
MIME-Version: 1.0
References: <4624B44A.9040509@sw.ru>	<20070417.123135.56861973.davem@davemloft.net>	<4625263D.1000709@linux-foundation.org>	<20070417.130929.59470175.davem@davemloft.net>
	<20070417133723.00031f82@mini>
In-Reply-To: <20070417133723.00031f82@mini>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [BRIDGE] Unaligned access on IA64 when comparing
	ethernet addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>, devel@openvz.org, bridge@lists.osdl.org

[snip]

> --- linux-2.6.orig/net/bridge/br_private.h	2007-04-17
> 13:26:48.000000000 -0700 +++ linux-2.6/net/bridge/br_private.h
> 2007-04-17 13:30:29.000000000 -0700 @@ -36,7 +36,7 @@
>  {
>  	unsigned char	prio[2];
>  	unsigned char	addr[6];
> -};
> +} __attribute__((aligned(8)));

Why "8"? Mustn't it be "16"? Address is to be 2-bytes aligned...

>  struct mac_addr
>  {
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

