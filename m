Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Skan/9haOw1yp4ZL7g1+wuX0wpwF9bHwir6Z+uEd3kQ=;
	b=VGfZSWc7ccMp+Web2EIRe2IXmVsy1P+1TNhm3c0OubUhBvyXgOieuPAK+aDmmU/xCM
	+KzRT4bpJ/voJQ7zm0LjYuD07swLFYTGajjcS/YKS/rjRD60+knIHPX0IwUgZRnMVmFx
	JkbMiTWUxIAerPlj+aYOUux7cbmPVxqVHjzRw=
References: <20181205154958.20262-1-idosch@mellanox.com>
	<20181205154958.20262-5-idosch@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <f7b854f6-265b-2a1e-cbc7-e577344df2d7@cumulusnetworks.com>
Date: Wed, 5 Dec 2018 18:00:16 +0200
MIME-Version: 1.0
In-Reply-To: <20181205154958.20262-5-idosch@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 04/12] bridge: Add
	br_fdb_clear_offload()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: mlxsw <mlxsw@mellanox.com>, Petr Machata <petrm@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "davem@davemloft.net" <davem@davemloft.net>

On 05/12/2018 17:50, Ido Schimmel wrote:
> From: Petr Machata <petrm@mellanox.com>
> 
> When a driver unoffloads all FDB entries en bloc, it's inefficient to
> send the switchdev notification one by one. Add a helper that unsets the
> offload flag on FDB entries on a given bridge port and VLAN.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> ---
>  include/linux/if_bridge.h |  6 ++++++
>  net/bridge/br_fdb.c       | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index ef7c3d376b21..627b788ba0ff 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -119,6 +119,7 @@ static inline int br_vlan_get_info(const struct net_device *dev, u16 vid,
>  struct net_device *br_fdb_find_port(const struct net_device *br_dev,
>  				    const unsigned char *addr,
>  				    __u16 vid);
> +void br_fdb_clear_offload(const struct net_device *dev, u16 vid);
>  bool br_port_flag_is_set(const struct net_device *dev, unsigned long flag);
>  #else
>  static inline struct net_device *
> @@ -128,6 +129,11 @@ br_fdb_find_port(const struct net_device *br_dev,
>  {
>  	return NULL;
>  }
> +
> +static inline void br_fdb_clear_offload(const struct net_device *dev, u16 vid)
> +{
> +}
> +
>  static inline bool
>  br_port_flag_is_set(const struct net_device *dev, unsigned long flag)
>  {
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index e56ba3912a90..38b1d0dd0529 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1164,3 +1164,23 @@ void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port *p,
>  
>  	spin_unlock_bh(&br->hash_lock);
>  }
> +
> +void br_fdb_clear_offload(const struct net_device *dev, u16 vid)
> +{
> +	struct net_bridge_fdb_entry *f;
> +	struct net_bridge_port *p;
> +
> +	ASSERT_RTNL();
> +
> +	p = br_port_get_rtnl(dev);
> +	if (!p)
> +		return;
> +
> +	spin_lock_bh(&p->br->hash_lock);
> +	hlist_for_each_entry(f, &p->br->fdb_list, fdb_node) {
> +		if (f->dst == p && f->key.vlan_id == vid)
> +			f->offloaded = 0;
> +	}
> +	spin_unlock_bh(&p->br->hash_lock);
> +}
> +EXPORT_SYMBOL_GPL(br_fdb_clear_offload);
> 

Looks good.

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

