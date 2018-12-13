Return-Path: <ivecera@redhat.com>
References: <cover.1544632917.git.petrm@mellanox.com>
	<b7607ec732292e97f314c1be1d0bea2e6d2affd7.1544632918.git.petrm@mellanox.com>
From: Ivan Vecera <ivecera@redhat.com>
Message-ID: <5d22ffe5-44dc-38bd-98cb-973be2ed4508@redhat.com>
Date: Thu, 13 Dec 2018 07:48:36 +0100
MIME-Version: 1.0
In-Reply-To: <b7607ec732292e97f314c1be1d0bea2e6d2affd7.1544632918.git.petrm@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 1/9] net: ndo_bridge_setlink: Add
	extack
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: Ido Schimmel <idosch@mellanox.com>, "dsa@cumulusnetworks.com" <dsa@cumulusnetworks.com>, Jiri Pirko <jiri@mellanox.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "davem@davemloft.net" <davem@davemloft.net>

On 12. 12. 18 18:02, Petr Machata wrote:
> Drivers may not be able to implement a VLAN addition or reconfiguration.
> In those cases it's desirable to explain to the user that it was
> rejected (and why).
> 
> To that end, add extack argument to ndo_bridge_setlink. Adapt all users
> to that change.
> 
> Following patches will use the new argument in the bridge driver.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Reviewed-by: Ido Schimmel <idosch@mellanox.com>
> ---
> 
> Notes:
>      v2:
>      - In ndo_bridge_setlink(), keep the whole extack declaration on the
>        same line.
> 
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 2 +-
>   drivers/net/ethernet/emulex/benet/be_main.c   | 2 +-
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 4 +++-
>   drivers/net/ethernet/intel/ice/ice_main.c     | 3 ++-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
>   include/linux/netdevice.h                     | 5 +++--
>   net/bridge/br_netlink.c                       | 3 ++-
>   net/bridge/br_private.h                       | 3 ++-
>   net/core/rtnetlink.c                          | 6 ++++--
>   9 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 5d21c14853ac..a9a6d775e083 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -9617,7 +9617,7 @@ static int bnxt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   }
>   
>   static int bnxt_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
> -			       u16 flags)
> +			       u16 flags, struct netlink_ext_ack *extack)
>   {
>   	struct bnxt *bp = netdev_priv(dev);
>   	struct nlattr *attr, *br_spec;
> diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
> index 245abf0d19c0..852f5bfe5f6d 100644
> --- a/drivers/net/ethernet/emulex/benet/be_main.c
> +++ b/drivers/net/ethernet/emulex/benet/be_main.c
> @@ -4955,7 +4955,7 @@ int be_load_fw(struct be_adapter *adapter, u8 *fw_file)
>   }
>   
>   static int be_ndo_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
> -				 u16 flags)
> +				 u16 flags, struct netlink_ext_ack *extack)
>   {
>   	struct be_adapter *adapter = netdev_priv(dev);
>   	struct nlattr *attr, *br_spec;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 6d5b13f69dec..fbb21ac06c98 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -11685,6 +11685,7 @@ static int i40e_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
>    * @dev: the netdev being configured
>    * @nlh: RTNL message
>    * @flags: bridge flags
> + * @extack: netlink extended ack
>    *
>    * Inserts a new hardware bridge if not already created and
>    * enables the bridging mode requested (VEB or VEPA). If the
> @@ -11697,7 +11698,8 @@ static int i40e_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
>    **/
>   static int i40e_ndo_bridge_setlink(struct net_device *dev,
>   				   struct nlmsghdr *nlh,
> -				   u16 flags)
> +				   u16 flags,
> +				   struct netlink_ext_ack *extack)
>   {
>   	struct i40e_netdev_priv *np = netdev_priv(dev);
>   	struct i40e_vsi *vsi = np->vsi;
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index e45e57499d91..f9f0d470412b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3624,6 +3624,7 @@ static int ice_vsi_update_bridge_mode(struct ice_vsi *vsi, u16 bmode)
>    * @dev: the netdev being configured
>    * @nlh: RTNL message
>    * @flags: bridge setlink flags
> + * @extack: netlink extended ack
>    *
>    * Sets the bridge mode (VEB/VEPA) of the switch to which the netdev (VSI) is
>    * hooked up to. Iterates through the PF VSI list and sets the loopback mode (if
> @@ -3632,7 +3633,7 @@ static int ice_vsi_update_bridge_mode(struct ice_vsi *vsi, u16 bmode)
>    */
>   static int
>   ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
> -		   u16 __always_unused flags)
> +		   u16 __always_unused flags, struct netlink_ext_ack *extack)
>   {
>   	struct ice_netdev_priv *np = netdev_priv(dev);
>   	struct ice_pf *pf = np->vsi->back;
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 49a4ea38eb07..f1e40734c975 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9979,7 +9979,8 @@ static int ixgbe_configure_bridge_mode(struct ixgbe_adapter *adapter,
>   }
>   
>   static int ixgbe_ndo_bridge_setlink(struct net_device *dev,
> -				    struct nlmsghdr *nlh, u16 flags)
> +				    struct nlmsghdr *nlh, u16 flags,
> +				    struct netlink_ext_ack *extack)
>   {
>   	struct ixgbe_adapter *adapter = netdev_priv(dev);
>   	struct nlattr *attr, *br_spec;
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index fc6ba71513be..36ca5f50f822 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1165,7 +1165,7 @@ struct dev_ifalias {
>    *	entries to skb and update idx with the number of entries.
>    *
>    * int (*ndo_bridge_setlink)(struct net_device *dev, struct nlmsghdr *nlh,
> - *			     u16 flags)
> + *			     u16 flags, struct netlink_ext_ack *extack)
>    * int (*ndo_bridge_getlink)(struct sk_buff *skb, u32 pid, u32 seq,
>    *			     struct net_device *dev, u32 filter_mask,
>    *			     int nlflags)
> @@ -1390,7 +1390,8 @@ struct net_device_ops {
>   
>   	int			(*ndo_bridge_setlink)(struct net_device *dev,
>   						      struct nlmsghdr *nlh,
> -						      u16 flags);
> +						      u16 flags,
> +						      struct netlink_ext_ack *extack);
>   	int			(*ndo_bridge_getlink)(struct sk_buff *skb,
>   						      u32 pid, u32 seq,
>   						      struct net_device *dev,
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index ff2c10d47529..f9be70b26091 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -850,7 +850,8 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[])
>   }
>   
>   /* Change state and parameters on port. */
> -int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags)
> +int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
> +	       struct netlink_ext_ack *extack)
>   {
>   	struct net_bridge *br = (struct net_bridge *)netdev_priv(dev);
>   	struct nlattr *tb[IFLA_BRPORT_MAX + 1];
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 5719b4d3e466..090dfacdc438 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1138,7 +1138,8 @@ int br_netlink_init(void);
>   void br_netlink_fini(void);
>   void br_ifinfo_notify(int event, const struct net_bridge *br,
>   		      const struct net_bridge_port *port);
> -int br_setlink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags);
> +int br_setlink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags,
> +	       struct netlink_ext_ack *extack);
>   int br_dellink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags);
>   int br_getlink(struct sk_buff *skb, u32 pid, u32 seq, struct net_device *dev,
>   	       u32 filter_mask, int nlflags);
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index c9c0407a7ee0..3b6e551f9e69 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4332,7 +4332,8 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   			goto out;
>   		}
>   
> -		err = br_dev->netdev_ops->ndo_bridge_setlink(dev, nlh, flags);
> +		err = br_dev->netdev_ops->ndo_bridge_setlink(dev, nlh, flags,
> +							     extack);
>   		if (err)
>   			goto out;
>   
> @@ -4344,7 +4345,8 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   			err = -EOPNOTSUPP;
>   		else
>   			err = dev->netdev_ops->ndo_bridge_setlink(dev, nlh,
> -								  flags);
> +								  flags,
> +								  extack);
>   		if (!err) {
>   			flags &= ~BRIDGE_FLAGS_SELF;
>   
> 

Acked-by: Ivan Vecera <ivecera@redhat.com>
