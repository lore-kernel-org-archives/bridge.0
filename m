Return-Path: <fw@strlen.de>
Date: Sat, 31 Aug 2019 10:38:59 +0200
From: Florian Westphal <fw@strlen.de>
Message-ID: <20190831083859.GT20113@breakpoint.cc>
References: <20190831044032.31931-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831044032.31931-1-leonardo@linux.ibm.com>
Subject: Re: [Bridge] [PATCH v5 1/1] net: br_netfiler_hooks: Drops IPv6
 packets if IPv6 module is not loaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leonardo Bras <leonardo@linux.ibm.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

Leonardo Bras <leonardo@linux.ibm.com> wrote:
> A kernel panic can happen if a host has disabled IPv6 on boot and have to
> process guest packets (coming from a bridge) using it's ip6tables.
> 
> IPv6 packets need to be dropped if the IPv6 module is not loaded, and the
> host ip6tables will be used.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
> Changes from v4:
> - Check if the host ip6tables is going to be used before testing 
>   ipv6 module presence 
> - Adds a warning about ipv6 module disabled.
> 
> 
>  net/bridge/br_netfilter_hooks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
> index d3f9592f4ff8..af7800103e51 100644
> --- a/net/bridge/br_netfilter_hooks.c
> +++ b/net/bridge/br_netfilter_hooks.c
> @@ -496,6 +496,10 @@ static unsigned int br_nf_pre_routing(void *priv,
>  		if (!brnet->call_ip6tables &&
>  		    !br_opt_get(br, BROPT_NF_CALL_IP6TABLES))
>  			return NF_ACCEPT;
> +		if (!ipv6_mod_enabled()) {
> +			pr_warn_once("Module ipv6 is disabled, so call_ip6tables is not supported.");
> +			return NF_DROP;
> +		}

pr_warn_once needs a '\n'.  Pablo, can you mangle this locally when
applying?

Patch looks good to me, so:

Acked-by: Florian Westphal <fw@strlen.de>
