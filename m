Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C70F415C2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63F92415AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iuUWp9TRDjV8xfxvCWucHl38XhVPl+OOiSPhV3nTBNU=;
 b=P1KgjzNMzTbU02Xdz1jhSzqkjg+/Ua9ZFGv2do6fIZsZHHbzn0SJAI7GJWkOVK7lQ6
 r6tgeY6+6cc1y5N3JSaLXF4u6vgo38QWnEK1/yC5LcyY8j+XMshtbWTOkphK6N/frYV1
 KewycUy7CV0QtMIzvflQrnNWwBEVWb17wHMeluD01ar2fPCSdM6uhQ1Dub06c358ESh5
 pfa850qzPD3mtK5431jZXZvxvnp/Lr5T1CHYH/udwJs24gfVVmGC93WeOaWnrmveTQGZ
 AoDNUdI05wizpG/NPB/VnqhtKrtouINsOD/HQUU0x1TrrIckJxO59IlWHrtnRGNOEe5E
 SKxw==
Date: Mon, 27 Jun 2022 19:06:34 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220627160634.wylbknsbsafvs3ij@skbuf>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-3-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524152144.40527-3-schultz.hans+netdev@gmail.com>
Subject: Re: [Bridge] [PATCH V3 net-next 2/4] net: switchdev: add support
 for offloading of fdb locked flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 05:21:42PM +0200, Hans Schultz wrote:
> Used for Mac-auth/MAB feature in the offloaded case.
> 
> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> ---
>  include/net/dsa.h       | 6 ++++++
>  include/net/switchdev.h | 3 ++-
>  net/bridge/br.c         | 3 ++-
>  net/bridge/br_fdb.c     | 7 +++++--
>  net/bridge/br_private.h | 2 +-
>  5 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 14f07275852b..a5a843b2d67d 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -330,6 +330,12 @@ struct dsa_port {
>  	/* List of VLANs that CPU and DSA ports are members of. */
>  	struct mutex		vlans_lock;
>  	struct list_head	vlans;
> +
> +	/* List and maintenance of locked ATU entries */
> +	struct mutex		locked_entries_list_lock;
> +	struct list_head	atu_locked_entries_list;
> +	atomic_t		atu_locked_entry_cnt;
> +	struct delayed_work	atu_work;

DSA is not Marvell only, so please remove these from struct dsa_port and
place them somewhere like struct mv88e6xxx_port. Also, the change has
nothing to do in a patch with the "net: switchdev: " prefix.

>  };
>  
>  /* TODO: ideally DSA ports would have a single dp->link_dp member,
> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index aa0171d5786d..62f4f7c9c7c2 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -245,7 +245,8 @@ struct switchdev_notifier_fdb_info {
>  	u16 vid;
>  	u8 added_by_user:1,
>  	   is_local:1,
> -	   offloaded:1;
> +	   offloaded:1,
> +	   locked:1;

As mentioned by Ido, please update br_switchdev_fdb_populate() as part
of this change, in the bridge->switchdev direction. We should add a
comment near struct switchdev_notifier_fdb_info stating just that,
so that people don't forget.

>  };
>  
>  struct switchdev_notifier_port_obj_info {
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 96e91d69a9a8..12933388a5a4 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -166,7 +166,8 @@ static int br_switchdev_event(struct notifier_block *unused,
>  	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
>  		fdb_info = ptr;
>  		err = br_fdb_external_learn_add(br, p, fdb_info->addr,
> -						fdb_info->vid, false);
> +						fdb_info->vid, false,
> +						fdb_info->locked);
>  		if (err) {
>  			err = notifier_from_errno(err);
>  			break;
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 6b83e2d6435d..92469547283a 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1135,7 +1135,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
>  					   "FDB entry towards bridge must be permanent");
>  			return -EINVAL;
>  		}
> -		err = br_fdb_external_learn_add(br, p, addr, vid, true);
> +		err = br_fdb_external_learn_add(br, p, addr, vid, true, false);
>  	} else {
>  		spin_lock_bh(&br->hash_lock);
>  		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
> @@ -1365,7 +1365,7 @@ void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
>  
>  int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  			      const unsigned char *addr, u16 vid,
> -			      bool swdev_notify)
> +			      bool swdev_notify, bool locked)
>  {
>  	struct net_bridge_fdb_entry *fdb;
>  	bool modified = false;
> @@ -1385,6 +1385,9 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  		if (!p)
>  			flags |= BIT(BR_FDB_LOCAL);
>  
> +		if (locked)
> +			flags |= BIT(BR_FDB_ENTRY_LOCKED);
> +
>  		fdb = fdb_create(br, p, addr, vid, flags);
>  		if (!fdb) {
>  			err = -ENOMEM;
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index be17c99efe65..88913e6a59e1 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -815,7 +815,7 @@ int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
>  void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
>  int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  			      const unsigned char *addr, u16 vid,
> -			      bool swdev_notify);
> +			      bool swdev_notify, bool locked);
>  int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
>  			      const unsigned char *addr, u16 vid,
>  			      bool swdev_notify);
> -- 
> 2.30.2
> 

