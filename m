Return-Path: <pneira@us.es>
Date: Fri, 2 Mar 2012 02:22:08 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20120302012208.GA10185@1984>
References: <1330593434-19275-1-git-send-email-santoshprasadnayak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1330593434-19275-1-git-send-email-santoshprasadnayak@gmail.com>
Subject: Re: [Bridge] [PATCH 2/3] netfilter: potential null derefence.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: santosh nayak <santoshprasadnayak@gmail.com>
Cc: netfilter@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org, shemminger@vyatta.com

On Thu, Mar 01, 2012 at 02:47:14PM +0530, santosh nayak wrote:
> From: Santosh Nayak <santoshprasadnayak@gmail.com>
> 
> I am getting following error.
> " net/bridge/netfilter/ebtables.c:269 ebt_do_table()
>   error: potential null derefence 'cs'"
> 
>     i = cs[sp].n;  // If cs == Null then this will cause problem.
> 
> Signed-off-by: Santosh Nayak <santoshprasadnayak@gmail.com>
> ---
>  net/bridge/netfilter/ebtables.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
> index f3fcbd9..9c0f177 100644
> --- a/net/bridge/netfilter/ebtables.c
> +++ b/net/bridge/netfilter/ebtables.c
> @@ -209,8 +209,10 @@ unsigned int ebt_do_table (unsigned int hook, struct sk_buff *skb,
>  	   smp_processor_id());
>  	if (private->chainstack)
>  		cs = private->chainstack[smp_processor_id()];
> -	else
> +	else {
>  		cs = NULL;

I just noticed we can remove this cs = NULL. No need to resend, I'll
mangle it myself.

> +		goto out;
> +	}
>  	chaininfo = private->hook_entry[hook];
>  	nentries = private->hook_entry[hook]->nentries;
>  	point = (struct ebt_entry *)(private->hook_entry[hook]->data);
> @@ -313,6 +315,7 @@ letscontinue:
>  		read_unlock_bh(&table->lock);
>  		return NF_ACCEPT;
>  	}
> +out:
>  	read_unlock_bh(&table->lock);
>  	return NF_DROP;
>  }
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe netfilter" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
