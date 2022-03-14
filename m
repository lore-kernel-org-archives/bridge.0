Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=oMG0T9vcdOIb6WRbUJ5vRlSPE5rT2gbTg+vjg6aHM+o=;
 b=Bgv9nNrzSnDKRVZKbeGdd71L3Iiv4FIxcwNstK5Ia4cJNSsOwFWT5l72JNt+brFxig
 W7z2+gRIYUfsxp7M1DzYc/o6h1PaUxviTqtXMwgHnT1iWXPTXT/C+Rm9aFVJ5r+9KKmg
 UmCHq421Xsh/2OE0wRDQ60MwupTZdNx72CUaN+ufqe0ceeJ1z7QlMMVVmO/RpqJh8xIf
 EvdlHIkZsn6wMSzzvK/wjWWR9fuh/AkBBSKXnp7KwdDJ1sUnNEZ12lsBpAWafsxNCAyi
 E3BM3gmFXQ+GmkJ10qAbchg7YS+BdGz/mStPSKaCVEWvbl3eWZ2BK0h6sg/mPjvBL60Y
 ftdg==
Message-ID: <bf9b90a5-63c7-ac9d-385f-cd0c60de7eee@blackwall.org>
Date: Mon, 14 Mar 2022 12:42:18 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-8-tobias@waldekranz.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220314095231.3486931-8-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 net-next 07/14] net: bridge: mst: Add helper
 to map an MSTI to a VID set
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On 14/03/2022 11:52, Tobias Waldekranz wrote:
> br_mst_get_info answers the question: "On this bridge, which VIDs are
> mapped to the given MSTI?"
> 
> This is useful in switchdev drivers, which might have to fan-out
> operations, relating to an MSTI, per VLAN.
> 
> An example: When a port's MST state changes from forwarding to
> blocking, a driver may choose to flush the dynamic FDB entries on that
> port to get faster reconvergence of the network, but this should only
> be done in the VLANs that are managed by the MSTI in question.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/linux/if_bridge.h |  6 ++++++
>  net/bridge/br_mst.c       | 26 ++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index 3aae023a9353..46e6327fef06 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -119,6 +119,7 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
>  		     struct bridge_vlan_info *p_vinfo);
>  int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
>  			 struct bridge_vlan_info *p_vinfo);
> +int br_mst_get_info(struct net_device *dev, u16 msti, unsigned long *vids);
>  #else
>  static inline bool br_vlan_enabled(const struct net_device *dev)
>  {
> @@ -151,6 +152,11 @@ static inline int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
>  {
>  	return -EINVAL;
>  }
> +static inline int br_mst_get_info(struct net_device *dev, u16 msti,
> +				  unsigned long *vids)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #if IS_ENABLED(CONFIG_BRIDGE)
> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
> index 7d16926a3a31..eb18dbd5838f 100644
> --- a/net/bridge/br_mst.c
> +++ b/net/bridge/br_mst.c
> @@ -13,6 +13,32 @@
>  
>  DEFINE_STATIC_KEY_FALSE(br_mst_used);
>  
> +int br_mst_get_info(struct net_device *dev, u16 msti, unsigned long *vids)
> +{
> +	struct net_bridge_vlan_group *vg;
> +	struct net_bridge_vlan *v;
> +	struct net_bridge *br;

const dev, vg, v, br

> +
> +	ASSERT_RTNL();
> +
> +	if (!netif_is_bridge_master(dev))
> +		return -EINVAL;
> +
> +	br = netdev_priv(dev);
> +	if (!br_opt_get(br, BROPT_MST_ENABLED))
> +		return -EINVAL;
> +
> +	vg = br_vlan_group(br);
> +
> +	list_for_each_entry(v, &vg->vlan_list, vlist) {
> +		if (v->msti == msti)
> +			set_bit(v->vid, vids);

__set_bit()

> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(br_mst_get_info);

EXPORT_SYMBOL_GPL

> +
>  static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_vlan *v,
>  				  u8 state)
>  {

