Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=puT3IgmYzTu6AuFh52Q7IDj5+ZEUZuLDjwQ4QyI52W0=;
 b=QgXd0svzMbNIP2g2rA9c9EUijFq9dm/8soUIjK73L/NfXjS4ps3CVSug8zfay+8hHv
 rLgugrG1f/iBupGJBEpfXAvMALWrhin8tGou8GYifVo99aIZsX13g8/DAodWWxghbliR
 5FeXfzsejLgAD5ucGtMKUtCImIJUTlRiAJIuCFn1LsP3IdgAAL1sZ5JrhipoCe8VYbKf
 j67ANWCkbXB4myPbg2ZhWhjCgOOJOgaZSEjrSSe/BAhtpTRvfexagbpwHtaOND1j92oD
 ReFLZ6GjpbT+9rM+gdhV+AGzNiADUksDvG1kI0jtZAp9Gf6fuTscA2NSOySbgnM5JtrP
 nAcw==
Date: Thu, 17 Mar 2022 02:41:17 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220317004117.sudxyvmteipz4y32@skbuf>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-10-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316150857.2442916-10-tobias@waldekranz.com>
Subject: Re: [Bridge] [PATCH v5 net-next 09/15] net: bridge: mst: Add helper
 to query a port's MST state
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

On Wed, Mar 16, 2022 at 04:08:51PM +0100, Tobias Waldekranz wrote:
> This is useful for switchdev drivers who are offloading MST states
> into hardware. As an example, a driver may wish to flush the FDB for a
> port when it transitions from forwarding to blocking - which means
> that the previous state must be discoverable.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

>  include/linux/if_bridge.h |  6 ++++++
>  net/bridge/br_mst.c       | 25 +++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index 4efd5540279a..d62ef428e3aa 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -121,6 +121,7 @@ int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
>  			 struct bridge_vlan_info *p_vinfo);
>  bool br_mst_enabled(const struct net_device *dev);
>  int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids);
> +int br_mst_get_state(const struct net_device *dev, u16 msti, u8 *state);
>  #else
>  static inline bool br_vlan_enabled(const struct net_device *dev)
>  {
> @@ -164,6 +165,11 @@ static inline int br_mst_get_info(const struct net_device *dev, u16 msti,
>  {
>  	return -EINVAL;
>  }
> +static inline int br_mst_get_state(const struct net_device *dev, u16 msti,
> +				   u8 *state)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #if IS_ENABLED(CONFIG_BRIDGE)
> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
> index 830a5746479f..ee680adcee17 100644
> --- a/net/bridge/br_mst.c
> +++ b/net/bridge/br_mst.c
> @@ -48,6 +48,31 @@ int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids)
>  }
>  EXPORT_SYMBOL_GPL(br_mst_get_info);
>  
> +int br_mst_get_state(const struct net_device *dev, u16 msti, u8 *state)
> +{
> +	const struct net_bridge_port *p = NULL;
> +	const struct net_bridge_vlan_group *vg;
> +	const struct net_bridge_vlan *v;
> +
> +	ASSERT_RTNL();
> +
> +	p = br_port_get_check_rtnl(dev);
> +	if (!p || !br_opt_get(p->br, BROPT_MST_ENABLED))
> +		return -EINVAL;
> +
> +	vg = nbp_vlan_group(p);
> +
> +	list_for_each_entry(v, &vg->vlan_list, vlist) {
> +		if (v->brvlan->msti == msti) {
> +			*state = v->state;
> +			return 0;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> +EXPORT_SYMBOL_GPL(br_mst_get_state);
> +
>  static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_vlan *v,
>  				  u8 state)
>  {
> -- 
> 2.25.1
> 

