Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Mhag5ovtYN4y+cwgnNecwoiRCVi5N408hmW0RyzBoZc=;
 b=kjXzeUm3TWtsI2fQtlaPCwwXNwLwV82onpuzsedxBmluQrcR7w3lB81348DaxiWvOl
 ECCGz7eN+mv8de3iYNHN9x9ksDTBl8ZiMEmpcObnuNEoFMSjNGFW2wFy/xvum6aN6G1H
 ddZ6oAK1Xe7/Q2IgBaWX3JNAaAvZzBO7Ak4ZuS1ue0ongls2rtBa0p5+nTiR+5DK48w+
 +Zb6fAZQZ3TPlbY2rsZQXmoHJBMu5/+YsbAd1XDm4b6YXvMhj4+dDoltJIw9oBXcQMib
 ZS8fEivwhvfcq7+KvC6RvGq1RlgnlIM1g1Uo/n+K1IrLelR/eQNEr9DG78S8HhSOmD9i
 /AVQ==
Date: Wed, 23 Mar 2022 14:35:34 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220323123534.i2whyau3doq2xdxg@skbuf>
References: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
 <20220317093902.1305816-3-schultz.hans+netdev@gmail.com>
 <86o81whmwv.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86o81whmwv.fsf@gmail.com>
Subject: Re: [Bridge] [PATCH v2 net-next 2/4] net: switchdev: add support
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Wed, Mar 23, 2022 at 01:29:52PM +0100, Hans Schultz wrote:
> On tor, mar 17, 2022 at 10:39, Hans Schultz <schultz.hans@gmail.com> wrote:
> > Used for Mac-auth/MAB feature in the offloaded case.
> >
> > Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> > ---
> >  include/net/switchdev.h | 3 ++-
> >  net/bridge/br.c         | 3 ++-
> >  net/bridge/br_fdb.c     | 7 +++++--
> >  net/bridge/br_private.h | 2 +-
> >  4 files changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> > index 3e424d40fae3..d5d923411f5e 100644
> > --- a/include/net/switchdev.h
> > +++ b/include/net/switchdev.h
> > @@ -229,7 +229,8 @@ struct switchdev_notifier_fdb_info {
> >  	u16 vid;
> >  	u8 added_by_user:1,
> >  	   is_local:1,
> > -	   offloaded:1;
> > +	   offloaded:1,
> > +	   locked:1;
> >  };
> >  
> >  struct switchdev_notifier_port_obj_info {
> > diff --git a/net/bridge/br.c b/net/bridge/br.c
> > index b1dea3febeea..adcdbecbc218 100644
> > --- a/net/bridge/br.c
> > +++ b/net/bridge/br.c
> > @@ -166,7 +166,8 @@ static int br_switchdev_event(struct notifier_block *unused,
> >  	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
> >  		fdb_info = ptr;
> >  		err = br_fdb_external_learn_add(br, p, fdb_info->addr,
> > -						fdb_info->vid, false);
> > +						fdb_info->vid, false,
> > +						fdb_info->locked);
> >  		if (err) {
> >  			err = notifier_from_errno(err);
> >  			break;
> > diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> > index 57ec559a85a7..57aa1955d34d 100644
> > --- a/net/bridge/br_fdb.c
> > +++ b/net/bridge/br_fdb.c
> > @@ -987,7 +987,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
> >  					   "FDB entry towards bridge must be permanent");
> >  			return -EINVAL;
> >  		}
> > -		err = br_fdb_external_learn_add(br, p, addr, vid, true);
> > +		err = br_fdb_external_learn_add(br, p, addr, vid, true,
> >  false);
> 
> Does someone have an idea why there at this point is no option to add a
> dynamic fdb entry?
> 
> The fdb added entries here do not age out, while the ATU entries do
> (after 5 min), resulting in unsynced ATU vs fdb.

I think the expectation is to use br_fdb_external_learn_del() if the
externally learned entry expires. The bridge should not age by itself
FDB entries learned externally.

> >  	} else {
> >  		spin_lock_bh(&br->hash_lock);
> >  		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
> > @@ -1216,7 +1216,7 @@ void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
> >  
> >  int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
> >  			      const unsigned char *addr, u16 vid,
> > -			      bool swdev_notify)
> > +			      bool swdev_notify, bool locked)
> >  {
> >  	struct net_bridge_fdb_entry *fdb;
> >  	bool modified = false;
> > @@ -1236,6 +1236,9 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
> >  		if (!p)
> >  			flags |= BIT(BR_FDB_LOCAL);
> >  
> > +		if (locked)
> > +			flags |= BIT(BR_FDB_ENTRY_LOCKED);
> > +
> >  		fdb = fdb_create(br, p, addr, vid, flags);
> >  		if (!fdb) {
> >  			err = -ENOMEM;
> > diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> > index f5a0b68c4857..3275e33b112f 100644
> > --- a/net/bridge/br_private.h
> > +++ b/net/bridge/br_private.h
> > @@ -790,7 +790,7 @@ int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
> >  void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
> >  int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
> >  			      const unsigned char *addr, u16 vid,
> > -			      bool swdev_notify);
> > +			      bool swdev_notify, bool locked);
> >  int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
> >  			      const unsigned char *addr, u16 vid,
> >  			      bool swdev_notify);
> > -- 
> > 2.30.2
