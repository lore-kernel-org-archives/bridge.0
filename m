Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=H0nknxMHezOvYCsNqm3RZDRFJz+VXWQYJZtH3Zk/57k=;
 b=ZbMebK+la9jrpPCHWvD3tQQxGQ4KzQZg2fxez0hesY7cRQoFosiRqCeEjOt6GnU0Yi
 +keXpYbNgjeTelQZrOwfk8RtCsWcCQSmhT0yK6DttJ6dylS/8sdtXb271fYLg5xG4gd7
 M/eG4A8n9mpTOeJ8rMDVx9oEZ5oJUVJKRRULKVcmg/L6fM4rIPPeIrfRevA0Nqz5am6V
 Rz7sdM9PrlUAIlQrsDHxyrr3Yx1lv4u73Qw0GnPaJp7N/EmajnHunod0MYov8qxh4fZZ
 otYuPHC8Ed9v5aqhRmiJcQreTsZnCht2VnUcPRhUhlmNCd6ah90nPlipbQEbX7+aaQPx
 X81A==
Date: Thu, 17 Mar 2022 02:42:29 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220317004229.dub2qoinhur76co7@skbuf>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-9-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316150857.2442916-9-tobias@waldekranz.com>
Subject: Re: [Bridge] [PATCH v5 net-next 08/15] net: bridge: mst: Add helper
 to check if MST is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 04:08:50PM +0100, Tobias Waldekranz wrote:
> This is useful for switchdev drivers that might want to refuse to join
> a bridge where MST is enabled, if the hardware can't support it.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

>  include/linux/if_bridge.h | 6 ++++++
>  net/bridge/br_mst.c       | 9 +++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index 1cf0cc46d90d..4efd5540279a 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -119,6 +119,7 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
>  		     struct bridge_vlan_info *p_vinfo);
>  int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
>  			 struct bridge_vlan_info *p_vinfo);
> +bool br_mst_enabled(const struct net_device *dev);
>  int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids);
>  #else
>  static inline bool br_vlan_enabled(const struct net_device *dev)
> @@ -153,6 +154,11 @@ static inline int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
>  	return -EINVAL;
>  }
>  
> +static inline bool br_mst_enabled(const struct net_device *dev)
> +{
> +	return false;
> +}
> +
>  static inline int br_mst_get_info(const struct net_device *dev, u16 msti,
>  				  unsigned long *vids)
>  {
> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
> index 00b36e629224..830a5746479f 100644
> --- a/net/bridge/br_mst.c
> +++ b/net/bridge/br_mst.c
> @@ -13,6 +13,15 @@
>  
>  DEFINE_STATIC_KEY_FALSE(br_mst_used);
>  
> +bool br_mst_enabled(const struct net_device *dev)
> +{
> +	if (!netif_is_bridge_master(dev))
> +		return false;
> +
> +	return br_opt_get(netdev_priv(dev), BROPT_MST_ENABLED);
> +}
> +EXPORT_SYMBOL_GPL(br_mst_enabled);
> +
>  int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids)
>  {
>  	const struct net_bridge_vlan_group *vg;
> -- 
> 2.25.1
> 
