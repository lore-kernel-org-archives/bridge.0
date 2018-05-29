Return-Path: <ilias.apalodimas@linaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=6A4jPOBfkSk4b1uv5IRwNl1iBXCKdZlfriEzVCP/OTE=;
	b=g6Ls10E9BkvsWt75aPaw1xSy5Elz3NzJh6+VFqdRh32z/4X11XiXIwOlbfyAQsHKeG
	uXNy9jPkr06hOw4taGFyuOBBwXUn13MI7gULCOHX7MK5YJtHd1EzYnks9bhLL1VXpuAL
	1mu5tWoOD09vKY++9tOXL8rC8Vixz5Lgu/eIE=
Date: Tue, 29 May 2018 13:25:43 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Message-ID: <20180529102543.GA1883@apalos>
References: <cover.1527503302.git.petrm@mellanox.com>
	<708f594ac6cef4a63a6f6a28759098c4d7922976.1527503302.git.petrm@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <708f594ac6cef4a63a6f6a28759098c4d7922976.1527503302.git.petrm@mellanox.com>
Subject: Re: [Bridge] [PATCH net-next v2 3/7] rocker: rocker_main: Ignore
 bridge VLAN events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>
Cc: devel@driverdev.osuosl.org, f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, davem@davemloft.net

Hi Petr, 

On Mon, May 28, 2018 at 12:50:09PM +0200, Petr Machata wrote:
> Ignore VLAN events where the orig_dev is the bridge device itself.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> ---
>  drivers/net/ethernet/rocker/rocker_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
> index e73e4fe..aeafdb9 100644
> --- a/drivers/net/ethernet/rocker/rocker_main.c
> +++ b/drivers/net/ethernet/rocker/rocker_main.c
> @@ -1632,6 +1632,9 @@ rocker_world_port_obj_vlan_add(struct rocker_port *rocker_port,
>  {
>  	struct rocker_world_ops *wops = rocker_port->rocker->wops;
>  
> +	if (netif_is_bridge_master(vlan->obj.orig_dev))
> +		return -EOPNOTSUPP;
> +
What will happen to the "bridge vlan add dev br0 vid X pvid untagged self" when
the lower level (the driver) returns -EOPNOTSUPP? Will it avoid adding a vlan on
the bridge ?

>  	if (!wops->port_obj_vlan_add)
>  		return -EOPNOTSUPP;
>  
> @@ -1647,6 +1650,9 @@ rocker_world_port_obj_vlan_del(struct rocker_port *rocker_port,
>  {
>  	struct rocker_world_ops *wops = rocker_port->rocker->wops;
>  
> +	if (netif_is_bridge_master(vlan->obj.orig_dev))
> +		return -EOPNOTSUPP;
> +
>  	if (!wops->port_obj_vlan_del)
>  		return -EOPNOTSUPP;
>  	return wops->port_obj_vlan_del(rocker_port, vlan);
> -- 
> 2.4.11
> 
