Date: Thu, 1 Sep 2011 09:07:41 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20110901090741.4ce49e76@nehalam.ftrdhcpuser.net>
In-Reply-To: <1314883778-2706-1-git-send-email-jpirko@redhat.com>
References: <1314883778-2706-1-git-send-email-jpirko@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [patch net-next-2.6] br: remove redundant check and
	init
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jpirko@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, eric.dumazet@gmail.com

On Thu,  1 Sep 2011 15:29:38 +0200
Jiri Pirko <jpirko@redhat.com> wrote:

> Since these checks and initialization are done in
> dev_ethtool_get_settings called later on, remove this redundancy.
> 
> Signed-off-by: Jiri Pirko <jpirko@redhat.com>
> ---
>  net/bridge/br_if.c |   24 +++++++++++-------------
>  1 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index 2cdf007..b365bba 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -33,20 +33,18 @@
>   */
>  static int port_cost(struct net_device *dev)
>  {
> -	if (dev->ethtool_ops && dev->ethtool_ops->get_settings) {
> -		struct ethtool_cmd ecmd = { .cmd = ETHTOOL_GSET, };
> -
> -		if (!dev_ethtool_get_settings(dev, &ecmd)) {
> -			switch (ethtool_cmd_speed(&ecmd)) {
> -			case SPEED_10000:
> -				return 2;
> -			case SPEED_1000:
> -				return 4;
> -			case SPEED_100:
> -				return 19;
> -			case SPEED_10:
> -				return 100;
> -			}
> +	struct ethtool_cmd ecmd;
> +
> +	if (!dev_ethtool_get_settings(dev, &ecmd)) {
> +		switch (ethtool_cmd_speed(&ecmd)) {
> +		case SPEED_10000:
> +			return 2;
> +		case SPEED_1000:
> +			return 4;
> +		case SPEED_100:
> +			return 19;
> +		case SPEED_10:
> +			return 100;
>  		}
>  	}
>  

Yeah, this code predates when ethtool was sane about ops

Acked-by: Stephen Hemminger <shemminger@vyatta.com>
