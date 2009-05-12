Date: Tue, 12 May 2009 08:26:52 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090512082652.2dd6f2f8@nehalam>
In-Reply-To: <1242136934-8108-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1242136934-8108-1-git-send-email-Joakim.Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: relay bridge multicast pkgs if !STP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org, Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

On Tue, 12 May 2009 16:02:14 +0200
Joakim Tjernlund <Joakim.Tjernlund@transmode.se> wrote:

> Currently the bridge drops all STP pkgs when
> STP is off. This makes the bridge relay the Bridge Group
> multicast address, 01:80:c2:00:00:00, when STP is off.
> This allows for loop detection by other bridges doing STP.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> ---
>  net/bridge/br_input.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 30b8877..8197823 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -112,6 +112,17 @@ static inline int is_link_local(const unsigned char *dest)
>  	return ((a[0] ^ b[0]) | (a[1] ^ b[1]) | ((a[2] ^ b[2]) & m)) == 0;
>  }
>  
> +/* Does address match the Bride Group multicast address.
> + * 01:80:c2:00:00:00
> + */
> +static inline int is_bridge_group(const unsigned char *dest)
> +{
> +	__be16 *a = (__be16 *)dest;
> +	static const __be16 *b = (const __be16 *)br_group_address;
> +
> +	return ((a[0] ^ b[0]) | (a[1] ^ b[1]) | (a[2] ^ b[2])) == 0;
> +}
> +
>  /*
>   * Called via br_handle_frame_hook.
>   * Return NULL if skb is handled
> @@ -137,7 +148,8 @@ struct sk_buff *br_handle_frame(struct net_bridge_port *p, struct sk_buff *skb)
>  		if (NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, skb->dev,
>  			    NULL, br_handle_local_finish))
>  			return NULL;	/* frame consumed by filter */
> -		else
> +		/* Relay Bridge Group address is STP is off */
> +		if (!(p->br->stp_enabled == BR_NO_STP && is_bridge_group(dest)))
>  			return skb;	/* continue processing */
>  	}
>  

First, you should have used compare_ether_addr.
Second, it needs to still obey state rules on port, so the return skb
should fall through to the switch statement.

-- 
