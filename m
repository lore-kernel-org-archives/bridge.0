Return-Path: <pneira@us.es>
Date: Thu, 1 Mar 2012 11:23:41 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20120301102341.GC6488@1984>
References: <1330593466-19317-1-git-send-email-santoshprasadnayak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1330593466-19317-1-git-send-email-santoshprasadnayak@gmail.com>
Subject: Re: [Bridge] [PATCH 3/3] netfilter: Remove redundant code.
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

On Thu, Mar 01, 2012 at 02:47:46PM +0530, santosh nayak wrote:
> From: Santosh Nayak <santoshprasadnayak@gmail.com>
> 
> Remove the redundant code.
> 
> Signed-off-by: Santosh Nayak <santoshprasadnayak@gmail.com>
> ---
>  net/bridge/netfilter/ebtables.c |   18 ++++++------------
>  1 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
> index 9c0f177..1efc234 100644
> --- a/net/bridge/netfilter/ebtables.c
> +++ b/net/bridge/netfilter/ebtables.c
> @@ -226,10 +226,8 @@ unsigned int ebt_do_table (unsigned int hook, struct sk_buff *skb,
>  
>  		if (EBT_MATCH_ITERATE(point, ebt_do_match, skb, &acpar) != 0)
>  			goto letscontinue;
> -		if (acpar.hotdrop) {
> -			read_unlock_bh(&table->lock);
> -			return NF_DROP;
> -		}
> +		if (acpar.hotdrop)
> +			goto out;

This is really broken! there's no "out" label in ebt_do_table as in
the previous patch!
