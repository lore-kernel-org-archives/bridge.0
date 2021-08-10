Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FwHr25
 vlNTA1qSgWCXpq5c5oS2rISuP06w9MQl5CjFg=; b=B9AhNV7LA/M5WPYItG6GYX
 42r8HI3De58FWC7IWog4S1XKmSrAIj6F1bUP8U0xsRqCNkrOZhiAHmcCGgeecM4O
 MotfRwhCd8ofe23M8ac2yzfsg4HqIuSQfW3PcQc8AuV5McYTjBoncOPsF1S99ZRg
 StnuBAstWmy6oiR1gkT5Pw6lgS+6MzaOpUcHhadhDvL6XfKPj0FPcYnEK3vZpary
 U0UbyyYN9iWNLgjG9ar4zinfw+0/wxxjHP3FqZnmeNYKiRTYwAvLyNPrg9qoH1kt
 B9aoyEMrMHWbs8f/I3pXZ8BCAQ0zhk2Slu0B2+ROH6R5OAmfTyk8RAwlcqZqrJrQ
 ==
Date: Tue, 10 Aug 2021 09:40:15 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YRIfT6vLL16hr+7p@shredder>
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
 <YREcqAdU+6IpT0+w@shredder>
 <da3ddeb1-eef1-a755-dfa0-737e32065d67@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da3ddeb1-eef1-a755-dfa0-737e32065d67@nvidia.com>
Subject: Re: [Bridge] [PATCH net] net: bridge: validate the NUD_PERMANENT
 bit when adding an extern_learn FDB entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Aug 09, 2021 at 06:33:30PM +0300, Nikolay Aleksandrov wrote:
> TBH, I want to keep that error so middle ground would be to handle NUD_PERMANENT only
> when used with !p and keep it. :) WDYT ?

Yes, works for me

> 
> Solution which forces BR_FDB_LOCAL for !p calls (completely untested):

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index c8ae823aa8e7..d3a32c6813e0 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -166,8 +166,7 @@ static int br_switchdev_event(struct notifier_block *unused,
>         case SWITCHDEV_FDB_ADD_TO_BRIDGE:
>                 fdb_info = ptr;
>                 err = br_fdb_external_learn_add(br, p, fdb_info->addr,
> -                                               fdb_info->vid,
> -                                               fdb_info->is_local, false);
> +                                               fdb_info->vid, false);
>                 if (err) {
>                         err = notifier_from_errno(err);
>                         break;
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index b8e22057f680..4e3b1b66f132 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1255,15 +1255,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
>                 rcu_read_unlock();
>                 local_bh_enable();
>         } else if (ndm->ndm_flags & NTF_EXT_LEARNED) {
> -               if (!p && !(ndm->ndm_state & NUD_PERMANENT)) {
> -                       NL_SET_ERR_MSG_MOD(extack,
> -                                          "FDB entry towards bridge must be permanent");
> -                       return -EINVAL;
> -               }
> -
> -               err = br_fdb_external_learn_add(br, p, addr, vid,
> -                                               ndm->ndm_state & NUD_PERMANENT,
> -                                               true);
> +               err = br_fdb_external_learn_add(br, p, addr, vid, true);
>         } else {
>                 spin_lock_bh(&br->hash_lock);
>                 err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
> @@ -1491,7 +1483,7 @@ void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
>  }
>  
>  int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
> -                             const unsigned char *addr, u16 vid, bool is_local,
> +                             const unsigned char *addr, u16 vid,
>                               bool swdev_notify)
>  {
>         struct net_bridge_fdb_entry *fdb;
> @@ -1509,7 +1501,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>                 if (swdev_notify)
>                         flags |= BIT(BR_FDB_ADDED_BY_USER);
>  
> -               if (is_local)
> +               if (!p)
>                         flags |= BIT(BR_FDB_LOCAL);
>  
>                 fdb = fdb_create(br, p, addr, vid, flags);
> @@ -1538,7 +1530,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>                 if (swdev_notify)
>                         set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>  
> -               if (is_local)
> +               if (!p)
>                         set_bit(BR_FDB_LOCAL, &fdb->flags);
>  
>                 if (modified)
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 86969d1bd036..907e5742b392 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -778,7 +778,7 @@ int br_fdb_get(struct sk_buff *skb, struct nlattr *tb[], struct net_device *dev,
>  int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
>  void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
>  int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
> -                             const unsigned char *addr, u16 vid, bool is_local,
> +                             const unsigned char *addr, u16 vid,
>                               bool swdev_notify);
>  int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
>                               const unsigned char *addr, u16 vid,
> 
> 
