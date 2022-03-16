Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CxBlO0C502y1jpeWHAj0rnF5IMS/Z4EuROWhss7SnWs=;
 b=JGMB0dsPB1GrxAi6JpNXgtS72jVkFOHljY4TZdBg6Vn985GUp5yWutHNgiB/ymSvVz
 Ns4YRhE+2mtfwFWgMAyS/l1Wv204oLxxxtjNiDBISwvIdmYli7Zxg30TxJf2PSpo5qD7
 KVfluv9AKpsQtstRO6ImY9Nr9cU8pKn2N/kRRgB8eLUCRZIrBIV0PbtUr9LeS64c/qtO
 HrnYfue7by4ulT6m/17L1358uDPQKiQovIzEpGgnQnQvJG0r3hSGEMZWhZEEirlEVsG9
 Y4cN05Y5px1OY1rXeHVqkf5WjSUfemS6aKqRBK4VBmdC3AkobI4kJakUHp7qgQSVthjH
 CuAg==
Date: Wed, 16 Mar 2022 17:59:56 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220316155956.swin6lhz5r4fn5ef@skbuf>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-11-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316150857.2442916-11-tobias@waldekranz.com>
Subject: Re: [Bridge] [PATCH v5 net-next 10/15] net: dsa: Validate hardware
 support for MST
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

On Wed, Mar 16, 2022 at 04:08:52PM +0100, Tobias Waldekranz wrote:
> When joining a bridge where MST is enabled, we validate that the
> proper offloading support is in place, otherwise we fallback to
> software bridging.
> 
> When then mode is changed on a bridge in which we are members, we
> refuse the change if offloading is not supported.
> 
> At the moment we only check for configurable learning, but this will
> be further restricted as we support more MST related switchdev events.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

>  net/dsa/dsa_priv.h |  2 ++
>  net/dsa/port.c     | 22 ++++++++++++++++++++++
>  net/dsa/slave.c    |  6 ++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
> index f20bdd8ea0a8..2aba420696ef 100644
> --- a/net/dsa/dsa_priv.h
> +++ b/net/dsa/dsa_priv.h
> @@ -234,6 +234,8 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
>  			    struct netlink_ext_ack *extack);
>  bool dsa_port_skip_vlan_configuration(struct dsa_port *dp);
>  int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock);
> +int dsa_port_mst_enable(struct dsa_port *dp, bool on,
> +			struct netlink_ext_ack *extack);
>  int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu,
>  			bool targeted_match);
>  int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index 58291df14cdb..02214033cec0 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -321,6 +321,11 @@ static void dsa_port_bridge_destroy(struct dsa_port *dp,
>  	kfree(bridge);
>  }
>  
> +static bool dsa_port_supports_mst(struct dsa_port *dp)
> +{
> +	return dsa_port_can_configure_learning(dp);
> +}
> +
>  int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
>  			 struct netlink_ext_ack *extack)
>  {
> @@ -334,6 +339,9 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
>  	struct net_device *brport_dev;
>  	int err;
>  
> +	if (br_mst_enabled(br) && !dsa_port_supports_mst(dp))
> +		return -EOPNOTSUPP;
> +
>  	/* Here the interface is already bridged. Reflect the current
>  	 * configuration so that drivers can program their chips accordingly.
>  	 */
> @@ -735,6 +743,20 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock)
>  	return 0;
>  }
>  
> +int dsa_port_mst_enable(struct dsa_port *dp, bool on,
> +			struct netlink_ext_ack *extack)
> +{
> +	if (!on)
> +		return 0;
> +
> +	if (!dsa_port_supports_mst(dp)) {
> +		NL_SET_ERR_MSG_MOD(extack, "Hardware does not support MST");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  int dsa_port_pre_bridge_flags(const struct dsa_port *dp,
>  			      struct switchdev_brport_flags flags,
>  			      struct netlink_ext_ack *extack)
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index f9cecda791d5..2e8f62476ce9 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -464,6 +464,12 @@ static int dsa_slave_port_attr_set(struct net_device *dev, const void *ctx,
>  
>  		ret = dsa_port_ageing_time(dp, attr->u.ageing_time);
>  		break;
> +	case SWITCHDEV_ATTR_ID_BRIDGE_MST:
> +		if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
> +			return -EOPNOTSUPP;
> +
> +		ret = dsa_port_mst_enable(dp, attr->u.mst, extack);
> +		break;
>  	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
>  		if (!dsa_port_offloads_bridge_port(dp, attr->orig_dev))
>  			return -EOPNOTSUPP;
> -- 
> 2.25.1
> 

