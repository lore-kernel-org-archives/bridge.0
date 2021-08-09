Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqemeWm7qmixJcm6scXCyBgUPiNKCCgr7FJUNgLmrMU=;
 b=k+TIdDqC1YhTmo0f1Kiab6Ol/PU4SBXCHM2KmmF+8cPRZucwGp99QgpH+6lyiV7IgeLZ6MmdgMlaM+1KqI+ZQrmLI4ts87W08LOYvR+eQ4DMZTlN1H6oasR1MFfxJIH4lJJcf9EF95EmT6KKw1UXm1xaEwB2AAMNOOsWW3hVIcoueT29B5mmxNA3XLUXX3DzJz0tlI8cVTXNgzgcli2ycjwnNzjhHrORV2EwP7gjxbvTFWHUZbwJlLs6WLBQj1xCg0utBphwpc7iFvs1bpKnu5UiUZ8pVsK0wLxoSdlY24slDhVwILM23pSdQ2qeoCSw4conqruo/MKdNvcHaw2I1g==
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
 <YREcqAdU+6IpT0+w@shredder>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <da3ddeb1-eef1-a755-dfa0-737e32065d67@nvidia.com>
Date: Mon, 9 Aug 2021 18:33:30 +0300
In-Reply-To: <YREcqAdU+6IpT0+w@shredder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
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
To: Ido Schimmel <idosch@idosch.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On 09/08/2021 15:16, Ido Schimmel wrote:
> On Mon, Aug 02, 2021 at 02:17:30AM +0300, Vladimir Oltean wrote:
>> diff --git a/net/bridge/br.c b/net/bridge/br.c
>> index ef743f94254d..bbab9984f24e 100644
>> --- a/net/bridge/br.c
>> +++ b/net/bridge/br.c
>> @@ -166,7 +166,8 @@ static int br_switchdev_event(struct notifier_block *unused,
>>  	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
>>  		fdb_info = ptr;
>>  		err = br_fdb_external_learn_add(br, p, fdb_info->addr,
>> -						fdb_info->vid, false);
>> +						fdb_info->vid,
>> +						fdb_info->is_local, false);
> 
> When 'is_local' was added in commit 2c4eca3ef716 ("net: bridge:
> switchdev: include local flag in FDB notifications") it was not
> initialized in all the call sites that emit
> 'SWITCHDEV_FDB_ADD_TO_BRIDGE' notification, so it can contain garbage.
> 

nice catch

>>  		if (err) {
>>  			err = notifier_from_errno(err);
>>  			break;
> 
> [...]
> 
>> @@ -1281,6 +1292,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>>  
>>  		if (swdev_notify)
>>  			flags |= BIT(BR_FDB_ADDED_BY_USER);
>> +
>> +		if (is_local)
>> +			flags |= BIT(BR_FDB_LOCAL);
> 
> I have at least once selftest where I forgot the 'static' keyword:
> 
> bridge fdb add de:ad:be:ef:13:37 dev $swp1 master extern_learn vlan 1
> 
> This patch breaks the test when run against both the kernel and hardware
> data paths. I don't mind patching these tests, but we might get more
> reports in the future.
> 
> Nik, what do you think?
> 

Ahh, that's unfortunate. The patch's assumption is correct that we must not have fdb->dst == NULL
and the dst to be non-local (i.e. without BR_FDB_LOCAL). Since all solutions break user-space in
a different way and since this patch also already broke it by the check for !p && !NUD_PERMANENT
in __br_fdb_add() which was allowed before that, I think the best course of action is to ignore
NUD_PERMANENT in __br_fdb_add() for extern_learn case and always set BR_FDB_LOCAL in br_fdb_external_learn_add()
when !p. That would allow all prior calls to work and would remove the dst==NULL without BR_FDB_LOCAL
issue. Honestly, I doubt anyone is using extern_learn with bridge device entries, but we cannot assume
anything since this is already a part of the uAPI and we must allow it. Basically we silently
fix the BR_FDB_LOCAL problem so old user syntax and code can continue working.
It is a hack, but I don't see another solution which doesn't break user-space in some way.
Handling NUD_PERMANENT only with !p is equivalent, unfortunately we shouldn't keep the error
since that can break someone who was adding such entries without NUD_PERMANENT flag, but
we can force it in kernel, that should make such scripts succeed. Traffic used to be blackholed
for such entries and now it will be received locally, that will be the only difference.

TBH, I want to keep that error so middle ground would be to handle NUD_PERMANENT only
when used with !p and keep it. :) WDYT ?

Solution which forces BR_FDB_LOCAL for !p calls (completely untested):
diff --git a/net/bridge/br.c b/net/bridge/br.c
index c8ae823aa8e7..d3a32c6813e0 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -166,8 +166,7 @@ static int br_switchdev_event(struct notifier_block *unused,
        case SWITCHDEV_FDB_ADD_TO_BRIDGE:
                fdb_info = ptr;
                err = br_fdb_external_learn_add(br, p, fdb_info->addr,
-                                               fdb_info->vid,
-                                               fdb_info->is_local, false);
+                                               fdb_info->vid, false);
                if (err) {
                        err = notifier_from_errno(err);
                        break;
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index b8e22057f680..4e3b1b66f132 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1255,15 +1255,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
                rcu_read_unlock();
                local_bh_enable();
        } else if (ndm->ndm_flags & NTF_EXT_LEARNED) {
-               if (!p && !(ndm->ndm_state & NUD_PERMANENT)) {
-                       NL_SET_ERR_MSG_MOD(extack,
-                                          "FDB entry towards bridge must be permanent");
-                       return -EINVAL;
-               }
-
-               err = br_fdb_external_learn_add(br, p, addr, vid,
-                                               ndm->ndm_state & NUD_PERMANENT,
-                                               true);
+               err = br_fdb_external_learn_add(br, p, addr, vid, true);
        } else {
                spin_lock_bh(&br->hash_lock);
                err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
@@ -1491,7 +1483,7 @@ void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
 }
 
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
-                             const unsigned char *addr, u16 vid, bool is_local,
+                             const unsigned char *addr, u16 vid,
                              bool swdev_notify)
 {
        struct net_bridge_fdb_entry *fdb;
@@ -1509,7 +1501,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
                if (swdev_notify)
                        flags |= BIT(BR_FDB_ADDED_BY_USER);
 
-               if (is_local)
+               if (!p)
                        flags |= BIT(BR_FDB_LOCAL);
 
                fdb = fdb_create(br, p, addr, vid, flags);
@@ -1538,7 +1530,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
                if (swdev_notify)
                        set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 
-               if (is_local)
+               if (!p)
                        set_bit(BR_FDB_LOCAL, &fdb->flags);
 
                if (modified)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 86969d1bd036..907e5742b392 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -778,7 +778,7 @@ int br_fdb_get(struct sk_buff *skb, struct nlattr *tb[], struct net_device *dev,
 int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
 void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
-                             const unsigned char *addr, u16 vid, bool is_local,
+                             const unsigned char *addr, u16 vid,
                              bool swdev_notify);
 int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
                              const unsigned char *addr, u16 vid,


