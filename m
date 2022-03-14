Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=A7EqDn+Rvpx8UXeNB7ju/W8rAWMhJLZzf0YL/c7EbsM=;
 b=R9FlibjV7YbRYHtNtmZ8gtRoaI/OqgLDDsvIOf3Nna/kMrJKoO2Diw1xJYXOdFMzNe
 eVfypM8Up5u0iHhizU6sIocI0SNbPJbzdQv8Ij8W7wpXkCKeh84v4GmDoVgvHii5FWT3
 GdN6qq+nsKIYd0xgNHR41sr8NQUoSMz6Tofd9TsZXuGYp/bqCEt20UZK70YOM0qaL3lu
 Woy8tXCsY4dC5ScaFoePtavo0uiax78Jfoat3ahD9sOSepgUJZvvsZbvxT7XDlZ8xAwI
 kWe/+9uPXcsL9avWiyXaxxwl40n29bgAFDocnLoaPo5x2IvO5vKoO9+6CMwmWW3l+ouS
 ozMQ==
Message-ID: <ace79051-0f73-8e04-5ac6-6098ffb15acd@blackwall.org>
Date: Mon, 14 Mar 2022 12:43:10 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-9-tobias@waldekranz.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220314095231.3486931-9-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 net-next 08/14] net: bridge: mst: Add helper
 to check if MST is enabled
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
> This is useful for switchdev drivers that might want to refuse to join
> a bridge where MST is enabled, if the hardware can't support it.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/linux/if_bridge.h | 5 +++++
>  net/bridge/br_mst.c       | 9 +++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index 46e6327fef06..5dbab0a280a6 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -119,6 +119,7 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
>  		     struct bridge_vlan_info *p_vinfo);
>  int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
>  			 struct bridge_vlan_info *p_vinfo);
> +bool br_mst_enabled(struct net_device *dev);
>  int br_mst_get_info(struct net_device *dev, u16 msti, unsigned long *vids);
>  #else
>  static inline bool br_vlan_enabled(const struct net_device *dev)
> @@ -152,6 +153,10 @@ static inline int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
>  {
>  	return -EINVAL;
>  }
> +static inline bool br_mst_enabled(struct net_device *dev)
> +{
> +	return false;
> +}
>  static inline int br_mst_get_info(struct net_device *dev, u16 msti,
>  				  unsigned long *vids)
>  {
> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
> index eb18dbd5838f..e5ab2ce451c2 100644
> --- a/net/bridge/br_mst.c
> +++ b/net/bridge/br_mst.c
> @@ -13,6 +13,15 @@
>  
>  DEFINE_STATIC_KEY_FALSE(br_mst_used);
>  
> +bool br_mst_enabled(struct net_device *dev)

const dev

> +{
> +	if (!netif_is_bridge_master(dev))
> +		return false;
> +
> +	return br_opt_get(netdev_priv(dev), BROPT_MST_ENABLED);
> +}
> +EXPORT_SYMBOL(br_mst_enabled);

EXPORT_SYMBOL_GPL

> +
>  int br_mst_get_info(struct net_device *dev, u16 msti, unsigned long *vids)
>  {
>  	struct net_bridge_vlan_group *vg;

