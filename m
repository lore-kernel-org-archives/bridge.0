Return-Path: <davem@davemloft.net>
Date: Wed, 05 Dec 2018 20:12:37 -0800 (PST)
Message-Id: <20181205.201237.1129051335930444731.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181205154958.20262-2-idosch@mellanox.com>
References: <20181205154958.20262-1-idosch@mellanox.com>
	<20181205154958.20262-2-idosch@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 01/12] vxlan: Add a function to init
 switchdev_notifier_vxlan_fdb_info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@mellanox.com
Cc: mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com, petrm@mellanox.com

From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 5 Dec 2018 15:50:23 +0000

> +static struct switchdev_notifier_vxlan_fdb_info
> +vxlan_fdb_switchdev_notifier_info(const struct vxlan_dev *vxlan,
> +				  const struct vxlan_fdb *fdb,
> +				  const struct vxlan_rdst *rd)
> +{
> +	struct switchdev_notifier_vxlan_fdb_info fdb_info = {
> +		.info.dev = vxlan->dev,
> +		.remote_ip = rd->remote_ip,
> +		.remote_port = rd->remote_port,
> +		.remote_vni = rd->remote_vni,
> +		.remote_ifindex = rd->remote_ifindex,
> +		.vni = fdb->vni,
> +		.offloaded = rd->offloaded,
> +		.added_by_user = fdb->flags & NTF_VXLAN_ADDED_BY_USER,
> +	};
> +
> +	memcpy(fdb_info.eth_addr, fdb->eth_addr, ETH_ALEN);
> +	return fdb_info;
> +}

Never return a structure by value from a function.  Do you have any idea
how the compiler implement this?

In the one call site in vxlan.c after this patch is applied, _two_
switchdev_notifier_cxlan_fdb_info objects are allocated on the stack.

vxlan_fdb_swtich_dev_notifier_info() fills in the first one, and
then the caller copies that into the second one.

A huge waste.

Please just pass "&info" as an argument.
