Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nomxyX/nf6tg6i6cYpzqiNmpO6v6wzTTCFLNxhUrHBg=;
 b=Rww5aDsJbQu6V9hwVMpUr3trbIjTtJH8jVP87FvM3n6pJUTwzDLArtmE6F+LdMlIVk
 2aDugPTYUySXjA1Vd5awPuQXx2DF03lDkXLud8TLGg0o5+I+I7MQxbVplsIeKLGqlaUR
 dwliUn3HXldHvX8mpiHgvBTcO1S3psyB6/dV009lDETEsLA4xr2XhrxnpVd0Efrc6e7z
 3Y2HU8KoJ+JzzzUtyELegUpHFduPiZarnd+UbEWGFghmq1nL0pC9XiZ3tkuYqvmr50KQ
 sFwQnpdZbI8UdeJ7SnjjhPPGPc8YI90Jfr5trivk1xCanYTF6YC0p5nN1HgRjyaC8IlS
 WxuA==
Date: Mon, 14 Mar 2022 19:14:04 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220314171404.s2erbwcb36tsmy2o@skbuf>
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-12-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314095231.3486931-12-tobias@waldekranz.com>
Subject: Re: [Bridge] [PATCH v3 net-next 11/14] net: dsa: Handle MST state
	changes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 10:52:28AM +0100, Tobias Waldekranz wrote:
> Add the usual trampoline functionality from the generic DSA layer down
> to the drivers for MST state changes.
> 
> When a state changes to disabled/blocking/listening, make sure to fast
> age any dynamic entries in the affected VLANs (those controlled by the
> MSTI in question).
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/net/dsa.h  |  3 +++
>  net/dsa/dsa_priv.h |  2 ++
>  net/dsa/port.c     | 67 +++++++++++++++++++++++++++++++++++++++++++---
>  net/dsa/slave.c    |  6 +++++
>  4 files changed, 74 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 1ddaa2cc5842..a171e7cdb3fe 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -945,7 +945,10 @@ struct dsa_switch_ops {
>  				     struct dsa_bridge bridge);
>  	void	(*port_stp_state_set)(struct dsa_switch *ds, int port,
>  				      u8 state);
> +	int	(*port_mst_state_set)(struct dsa_switch *ds, int port,
> +				      const struct switchdev_mst_state *state);
>  	void	(*port_fast_age)(struct dsa_switch *ds, int port);
> +	void	(*port_vlan_fast_age)(struct dsa_switch *ds, int port, u16 vid);
>  	int	(*port_pre_bridge_flags)(struct dsa_switch *ds, int port,
>  					 struct switchdev_brport_flags flags,
>  					 struct netlink_ext_ack *extack);
> diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
> index d90b4cf0c9d2..2ae8996cf7c8 100644
> --- a/net/dsa/dsa_priv.h
> +++ b/net/dsa/dsa_priv.h
> @@ -215,6 +215,8 @@ static inline struct net_device *dsa_master_find_slave(struct net_device *dev,
>  void dsa_port_set_tag_protocol(struct dsa_port *cpu_dp,
>  			       const struct dsa_device_ops *tag_ops);
>  int dsa_port_set_state(struct dsa_port *dp, u8 state, bool do_fast_age);
> +int dsa_port_set_mst_state(struct dsa_port *dp,
> +			   const struct switchdev_mst_state *state);
>  int dsa_port_enable_rt(struct dsa_port *dp, struct phy_device *phy);
>  int dsa_port_enable(struct dsa_port *dp, struct phy_device *phy);
>  void dsa_port_disable_rt(struct dsa_port *dp);
> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index f6a822d854cc..223681e03321 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -30,12 +30,11 @@ static int dsa_port_notify(const struct dsa_port *dp, unsigned long e, void *v)
>  	return dsa_tree_notify(dp->ds->dst, e, v);
>  }
>  
> -static void dsa_port_notify_bridge_fdb_flush(const struct dsa_port *dp)
> +static void dsa_port_notify_bridge_fdb_flush(const struct dsa_port *dp, u16 vid)
>  {
>  	struct net_device *brport_dev = dsa_port_to_bridge_port(dp);
>  	struct switchdev_notifier_fdb_info info = {
> -		/* flush all VLANs */
> -		.vid = 0,
> +		.vid = vid,
>  	};
>  
>  	/* When the port becomes standalone it has already left the bridge.
> @@ -57,7 +56,39 @@ static void dsa_port_fast_age(const struct dsa_port *dp)
>  
>  	ds->ops->port_fast_age(ds, dp->index);
>  
> -	dsa_port_notify_bridge_fdb_flush(dp);

Could you please migrate the "flush all VLANs" comment here?

> +	dsa_port_notify_bridge_fdb_flush(dp, 0);
> +}
> +
> +static void dsa_port_vlan_fast_age(const struct dsa_port *dp, u16 vid)
> +{
> +	struct dsa_switch *ds = dp->ds;
> +
> +	if (!ds->ops->port_vlan_fast_age)
> +		return;
> +
> +	ds->ops->port_vlan_fast_age(ds, dp->index, vid);
> +
> +	dsa_port_notify_bridge_fdb_flush(dp, vid);
> +}
> +
> +static void dsa_port_msti_fast_age(const struct dsa_port *dp, u16 msti)
> +{
> +	unsigned long *vids;
> +	int vid;
> +
> +	vids = bitmap_zalloc(VLAN_N_VID, 0);
> +	if (!vids)
> +		return;

As discussed, I think you can/should use DECLARE_BITMAP().

> +
> +	if (br_mst_get_info(dsa_port_bridge_dev_get(dp), msti, vids))
> +		goto out_free;
> +
> +	for_each_set_bit(vid, vids, VLAN_N_VID) {
> +		dsa_port_vlan_fast_age(dp, vid);

This has an error propagation path to user space, since just user space
sets it via IFLA_BRIDGE_MST_ENTRY_STATE, does it not?
So could we actually propagate an error all the way from
ds->ops->port_vlan_fast_age to the mstpd daemon?

> +	}
> +
> +out_free:
> +	kfree(vids);
>  }
>  
>  static bool dsa_port_can_configure_learning(struct dsa_port *dp)
> @@ -118,6 +149,32 @@ static void dsa_port_set_state_now(struct dsa_port *dp, u8 state,
>  		pr_err("DSA: failed to set STP state %u (%d)\n", state, err);
>  }
>  
> +int dsa_port_set_mst_state(struct dsa_port *dp,
> +			   const struct switchdev_mst_state *state)
> +{
> +	struct dsa_switch *ds = dp->ds;
> +	int err;
> +
> +	if (!ds->ops->port_mst_state_set)
> +		return -EOPNOTSUPP;
> +
> +	err = ds->ops->port_mst_state_set(ds, dp->index, state);
> +	if (err)
> +		return err;
> +
> +	if (dp->learning) {
> +		switch (state->state) {
> +		case BR_STATE_DISABLED:
> +		case BR_STATE_BLOCKING:
> +		case BR_STATE_LISTENING:
> +			dsa_port_msti_fast_age(dp, state->msti);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  int dsa_port_enable_rt(struct dsa_port *dp, struct phy_device *phy)
>  {
>  	struct dsa_switch *ds = dp->ds;
> @@ -748,6 +805,8 @@ int dsa_port_mst_enable(struct dsa_port *dp, bool on,
>  		return 0;
>  
>  	if (!(ds->ops->vlan_msti_set &&
> +	      ds->ops->port_mst_state_set &&
> +	      ds->ops->port_vlan_fast_age &&
>  	      dsa_port_can_configure_learning(dp))) {
>  		NL_SET_ERR_MSG_MOD(extack, "Hardware does not support MST");
>  		return -EINVAL;
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index cd2c57de9592..106b177ad1eb 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -450,6 +450,12 @@ static int dsa_slave_port_attr_set(struct net_device *dev, const void *ctx,
>  
>  		ret = dsa_port_set_state(dp, attr->u.stp_state, true);
>  		break;
> +	case SWITCHDEV_ATTR_ID_PORT_MST_STATE:
> +		if (!dsa_port_offloads_bridge_port(dp, attr->orig_dev))
> +			return -EOPNOTSUPP;
> +
> +		ret = dsa_port_set_mst_state(dp, &attr->u.mst_state);
> +		break;
>  	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
>  		if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
>  			return -EOPNOTSUPP;
> -- 
> 2.25.1
> 

