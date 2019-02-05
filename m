Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ISjGueC4Bcor3RsrLG9HVCIaVkDQGy5UfhMO1aFtVKI=;
	b=E8p5+Z5aO1Cbb0ZInfI7to5kLL285Yw3lx/qq5N7ozZHMk9Rl0xj1csLT3QFeFZbxF
	Sd6PPtq2bsfFyUhRgau7Xa3iJLUZMQH1yBEPk5nRZvJOcHDQT6yEk09FA/x11WKgFCWk
	hFwJqsBULNGMZ4mAlgrStLTYAojWuCKV70AkAv1anPfw0s4aOnS0xXmXz4g6SkI/n4Ut
	2bdys8v8haSe9vdWHqYY6EXaTn95sc6rVCvT6arDnieLN9zd7up38lPePvzF2DbrPeIb
	9usuRkHZilKcDpDDMAP+jWtmVzX19Af09z3VIMdCrCZVL+bkt3bSfpBFQaUxpkrmA1lk
	evOw==
References: <20190205221311.18476-1-f.fainelli@gmail.com>
	<20190205221311.18476-11-f.fainelli@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <32de3be2-7e6a-f34e-9e04-3e3d39989317@gmail.com>
Date: Tue, 5 Feb 2019 14:18:03 -0800
MIME-Version: 1.0
In-Reply-To: <20190205221311.18476-11-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 10/12] staging: fsl-dpaa2: ethsw:
 Implement ndo_get_port_parent_id()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, Ido Schimmel <idosch@mellanox.com>, "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>, "David S. Miller" <davem@davemloft.net>

On 2/5/19 2:13 PM, Florian Fainelli wrote:
> ethsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
> of switchdev_ops eventually, ease that migration by implementing a
> ndo_get_port_parent_id() function which returns what
> switchdev_port_attr_get() would do.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> index daabaceeea52..622f32377b91 100644
> --- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> +++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> @@ -505,6 +505,17 @@ static netdev_tx_t port_dropframe(struct sk_buff *skb,
>  	return NETDEV_TX_OK;
>  }
>  
> +static int swdev_get_port_parent_id(struct net_device *dev,
> +				    struct netdev_phys_item_id *ppid)
> +{
> +	struct ethsw_port_priv *port_priv = netdev_priv(dev);
> +
> +	ppid->id_len = 1;
> +	ppid->id[0] = port_priv->ethsw_data->dev_id;
> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops ethsw_port_ops = {
>  	.ndo_open		= port_open,
>  	.ndo_stop		= port_stop,
> @@ -515,6 +526,7 @@ static const struct net_device_ops ethsw_port_ops = {
>  	.ndo_get_offload_stats	= port_get_offload_stats,
>  
>  	.ndo_start_xmit		= port_dropframe,
> +	.ndo_get_port_parent_id	= swdev_get_port_parent_id,
>  };
>  
>  static void ethsw_links_state_update(struct ethsw_core *ethsw)
> @@ -634,10 +646,6 @@ static int swdev_port_attr_get(struct net_device *netdev,
>  	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
>  
>  	switch (attr->id) {
> -	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
> -		attr->u.ppid.id_len = 1;
> -		attr->u.ppid.id[0] = port_priv->ethsw_data->dev_id;
> -		break;
>  	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
>  		attr->u.brport_flags =
>  			(port_priv->ethsw_data->learning ? BR_LEARNING : 0) |
> @@ -1434,7 +1442,6 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
>  	SET_NETDEV_DEV(port_netdev, dev);
>  	port_netdev->netdev_ops = &ethsw_port_ops;
>  	port_netdev->ethtool_ops = &ethsw_port_ethtool_ops;
> -	port_netdev->switchdev_ops = &ethsw_port_switchdev_ops;

This hunk should not be removed, I will respin a new version after
getting feedback.
-- 
Florian
