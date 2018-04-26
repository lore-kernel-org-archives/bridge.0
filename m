Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=LQXvoaWX6SJLs2mk9kFCibfRcvenXN8zfjl3SOS++QA=;
	b=STU7awJikdQVHHaFQiyRowEgbgHnAfU3m2zsUz13xR8T/L1jKsXSPurr7DzrJ+JPlF
	H/giFqXl2ZSR3wEsimUDyuIJ+xz795Wel2mO4CXa6Z/ASWvFsc7M/UyZEtw0RmtIMr0T
	E9QR0ridil+Nvt3z11uQLeR0Np3fdkyMOKeqg=
References: <20180426090637.25262-1-idosch@mellanox.com>
	<20180426090637.25262-7-idosch@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <1e3e120f-821a-2d99-b720-0585ce9c1803@cumulusnetworks.com>
Date: Thu, 26 Apr 2018 13:50:12 +0300
MIME-Version: 1.0
In-Reply-To: <20180426090637.25262-7-idosch@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 6/6] mlxsw: spectrum_span: Allow
 bridge for gretap mirror
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@mellanox.com, jiri@mellanox.com, mlxsw@mellanox.com, davem@davemloft.net

On 26/04/18 12:06, Ido Schimmel wrote:
> From: Petr Machata <petrm@mellanox.com>
> 
> When handling mirroring to a gretap or ip6gretap netdevice in mlxsw, the
> underlay address (i.e. the remote address of the tunnel) may be routed
> to a bridge.
> 
> In that case, look up the resolved neighbor Ethernet address in that
> bridge's FDB. Then configure the offload to direct the mirrored traffic
> to that port, possibly with tagging.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> ---
>   .../net/ethernet/mellanox/mlxsw/spectrum_span.c    | 102 +++++++++++++++++++--
>   .../net/ethernet/mellanox/mlxsw/spectrum_span.h    |   1 +
>   2 files changed, 97 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
> index 65a77708ff61..92fb81839852 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
> @@ -32,6 +32,7 @@
>    * POSSIBILITY OF SUCH DAMAGE.
>    */
>   
> +#include <linux/if_bridge.h>
>   #include <linux/list.h>
>   #include <net/arp.h>
>   #include <net/gre.h>
> @@ -39,8 +40,9 @@
>   #include <net/ip6_tunnel.h>
>   
>   #include "spectrum.h"
> -#include "spectrum_span.h"
>   #include "spectrum_ipip.h"
> +#include "spectrum_span.h"
> +#include "spectrum_switchdev.h"
>   
>   int mlxsw_sp_span_init(struct mlxsw_sp *mlxsw_sp)
>   {
> @@ -167,6 +169,79 @@ mlxsw_sp_span_entry_unoffloadable(struct mlxsw_sp_span_parms *sparmsp)
>   	return 0;
>   }
>   
> +static struct net_device *
> +mlxsw_sp_span_entry_bridge_8021q(const struct net_device *br_dev,
> +				 unsigned char *dmac,
> +				 u16 *p_vid)
> +{
> +	struct net_bridge_vlan_group *vg = br_vlan_group_rtnl(br_dev);
> +	u16 pvid = br_vlan_group_pvid(vg);
> +	struct net_device *edev = NULL;
> +	struct net_bridge_vlan *v;
> +

Hi,
These structures are not really exported anywhere outside of br_private.h
Instead of passing them around and risking someone else actually trying to
dereference an incomplete type, why don't you add just 2 new helpers -
br_vlan_pvid(netdevice) and br_vlan_info(netdevice, vid, *bridge_vlan_info)

br_vlan_info can return the exported and already available type "bridge_vlan_info"
(defined in uapi/linux/if_bridge.h) into the bridge_vlan_info arg
and br_vlan_pvid is obvious - return the current dev pvid if available.

Another bonus you'll avoid dealing with the bridge's vlan internals.

> +	if (pvid)
> +		edev = br_fdb_find_port_hold(br_dev, dmac, pvid);
> +	if (!edev)
> +		return NULL;
> +
> +	/* RTNL prevents edev from being removed. */
> +	dev_put(edev);

Minor point here - since this is always called in rtnl, the dev_hold/put dance isn't needed,
unless you plan to use the fdb_find_port_hold outside of rtnl of course. In case that is
not planned why don't you do br_fdb_find_port_rtnl() instead with RCU inside (thus not blocking
learning) and ASSERT_RTNL() to avoid some complexity ?

Thanks,
  Nik

> +
> +	vg = br_port_vlan_group_rtnl(edev);
> +	v = br_vlan_find(vg, pvid);
> +	if (!v)
> +		return NULL;
> +	if (!(br_vlan_flags(v) & BRIDGE_VLAN_INFO_UNTAGGED))
> +		*p_vid = pvid;
> +	return edev;
> +}
> +
> +static struct net_device *
> +mlxsw_sp_span_entry_bridge_8021d(const struct net_device *br_dev,
> +				 unsigned char *dmac)
> +{
> +	struct net_device *edev = br_fdb_find_port_hold(br_dev, dmac, 0);
> +
> +	/* RTNL prevents edev from being removed. */
> +	dev_put(edev);
> +
> +	return edev;
> +}
> +
> +static struct net_device *
> +mlxsw_sp_span_entry_bridge(const struct net_device *br_dev,
> +			   unsigned char dmac[ETH_ALEN],
> +			   u16 *p_vid)
> +{
> +	struct mlxsw_sp_bridge_port *bridge_port;
> +	enum mlxsw_reg_spms_state spms_state;
> +	struct mlxsw_sp_port *port;
> +	struct net_device *dev;
> +	u8 stp_state;
> +
> +	if (br_vlan_enabled(br_dev))
> +		dev = mlxsw_sp_span_entry_bridge_8021q(br_dev, dmac, p_vid);
> +	else
> +		dev = mlxsw_sp_span_entry_bridge_8021d(br_dev, dmac);
> +	if (!dev)
> +		return NULL;
> +
> +	port = mlxsw_sp_port_dev_lower_find(dev);
> +	if (!port)
> +		return NULL;
> +
> +	bridge_port = mlxsw_sp_bridge_port_find(port->mlxsw_sp->bridge, dev);
> +	if (!bridge_port)
> +		return NULL;
> +
> +	stp_state = mlxsw_sp_bridge_port_stp_state(bridge_port);
> +	spms_state = mlxsw_sp_stp_spms_state(stp_state);
> +	if (spms_state != MLXSW_REG_SPMS_STATE_FORWARDING)
> +		return NULL;
> +
> +	return dev;
> +}
> +
>   static __maybe_unused int
>   mlxsw_sp_span_entry_tunnel_parms_common(struct net_device *l3edev,
>   					union mlxsw_sp_l3addr saddr,
> @@ -177,13 +252,22 @@ mlxsw_sp_span_entry_tunnel_parms_common(struct net_device *l3edev,
>   					struct mlxsw_sp_span_parms *sparmsp)
>   {
>   	unsigned char dmac[ETH_ALEN];
> +	u16 vid = 0;
>   
>   	if (mlxsw_sp_l3addr_is_zero(gw))
>   		gw = daddr;
>   
> -	if (!l3edev || !mlxsw_sp_port_dev_check(l3edev) ||
> -	    mlxsw_sp_span_dmac(tbl, &gw, l3edev, dmac))
> -		return mlxsw_sp_span_entry_unoffloadable(sparmsp);
> +	if (!l3edev || mlxsw_sp_span_dmac(tbl, &gw, l3edev, dmac))
> +		goto unoffloadable;
> +
> +	if (netif_is_bridge_master(l3edev)) {
> +		l3edev = mlxsw_sp_span_entry_bridge(l3edev, dmac, &vid);
> +		if (!l3edev)
> +			goto unoffloadable;
> +	}
> +
> +	if (!mlxsw_sp_port_dev_check(l3edev))
> +		goto unoffloadable;
>   
>   	sparmsp->dest_port = netdev_priv(l3edev);
>   	sparmsp->ttl = ttl;
> @@ -191,7 +275,11 @@ mlxsw_sp_span_entry_tunnel_parms_common(struct net_device *l3edev,
>   	memcpy(sparmsp->smac, l3edev->dev_addr, ETH_ALEN);
>   	sparmsp->saddr = saddr;
>   	sparmsp->daddr = daddr;
> +	sparmsp->vid = vid;
>   	return 0;
> +
> +unoffloadable:
> +	return mlxsw_sp_span_entry_unoffloadable(sparmsp);
>   }
>   
>   #if IS_ENABLED(CONFIG_NET_IPGRE)
> @@ -268,9 +356,10 @@ mlxsw_sp_span_entry_gretap4_configure(struct mlxsw_sp_span_entry *span_entry,
>   	/* Create a new port analayzer entry for local_port. */
>   	mlxsw_reg_mpat_pack(mpat_pl, pa_id, local_port, true,
>   			    MLXSW_REG_MPAT_SPAN_TYPE_REMOTE_ETH_L3);
> +	mlxsw_reg_mpat_eth_rspan_pack(mpat_pl, sparms.vid);
>   	mlxsw_reg_mpat_eth_rspan_l2_pack(mpat_pl,
>   				    MLXSW_REG_MPAT_ETH_RSPAN_VERSION_NO_HEADER,
> -				    sparms.dmac, false);
> +				    sparms.dmac, !!sparms.vid);
>   	mlxsw_reg_mpat_eth_rspan_l3_ipv4_pack(mpat_pl,
>   					      sparms.ttl, sparms.smac,
>   					      be32_to_cpu(sparms.saddr.addr4),
> @@ -368,9 +457,10 @@ mlxsw_sp_span_entry_gretap6_configure(struct mlxsw_sp_span_entry *span_entry,
>   	/* Create a new port analayzer entry for local_port. */
>   	mlxsw_reg_mpat_pack(mpat_pl, pa_id, local_port, true,
>   			    MLXSW_REG_MPAT_SPAN_TYPE_REMOTE_ETH_L3);
> +	mlxsw_reg_mpat_eth_rspan_pack(mpat_pl, sparms.vid);
>   	mlxsw_reg_mpat_eth_rspan_l2_pack(mpat_pl,
>   				    MLXSW_REG_MPAT_ETH_RSPAN_VERSION_NO_HEADER,
> -				    sparms.dmac, false);
> +				    sparms.dmac, !!sparms.vid);
>   	mlxsw_reg_mpat_eth_rspan_l3_ipv6_pack(mpat_pl, sparms.ttl, sparms.smac,
>   					      sparms.saddr.addr6,
>   					      sparms.daddr.addr6);
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h
> index 4b87ec20e658..14a6de904db1 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h
> @@ -63,6 +63,7 @@ struct mlxsw_sp_span_parms {
>   	unsigned char smac[ETH_ALEN];
>   	union mlxsw_sp_l3addr daddr;
>   	union mlxsw_sp_l3addr saddr;
> +	u16 vid;
>   };
>   
>   struct mlxsw_sp_span_entry_ops;
> 

