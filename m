Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1716781379
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 250AE81374
MIME-Version: 1.0
Date: Tue, 02 Aug 2022 10:27:19 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20220708085403.sk7znfad3x2mnxeh@skbuf>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
 <20220707152930.1789437-3-netdev@kapio-technology.com>
 <20220708085403.sk7znfad3x2mnxeh@skbuf>
Message-ID: <50bb7ce47f993fb9522476bac69c935e@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 2/6] net: switchdev: add support
 for offloading of fdb locked flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 2022-07-08 10:54, Vladimir Oltean wrote:
>>  };
>> 
>>  /* TODO: ideally DSA ports would have a single dp->link_dp member,
>> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
>> index aa0171d5786d..9f83c835ee62 100644
>> --- a/include/net/switchdev.h
>> +++ b/include/net/switchdev.h
>> @@ -245,6 +245,7 @@ struct switchdev_notifier_fdb_info {
>>  	u16 vid;
>>  	u8 added_by_user:1,
>>  	   is_local:1,
>> +	   is_locked:1,
>>  	   offloaded:1;
>>  };
>> 
>> diff --git a/net/bridge/br.c b/net/bridge/br.c
>> index 96e91d69a9a8..fe0a4741fcda 100644
>> --- a/net/bridge/br.c
>> +++ b/net/bridge/br.c
>> @@ -166,7 +166,8 @@ static int br_switchdev_event(struct 
>> notifier_block *unused,
>>  	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
>>  		fdb_info = ptr;
>>  		err = br_fdb_external_learn_add(br, p, fdb_info->addr,
>> -						fdb_info->vid, false);
>> +						fdb_info->vid, false,
>> +						fdb_info->is_locked);
>>  		if (err) {
>>  			err = notifier_from_errno(err);
>>  			break;
>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>> index ee9064a536ae..32ebb18050b9 100644
>> --- a/net/bridge/br_fdb.c
>> +++ b/net/bridge/br_fdb.c
>> @@ -1136,7 +1136,7 @@ static int __br_fdb_add(struct ndmsg *ndm, 
>> struct net_bridge *br,
>>  					   "FDB entry towards bridge must be permanent");
>>  			return -EINVAL;
>>  		}
>> -		err = br_fdb_external_learn_add(br, p, addr, vid, true);
>> +		err = br_fdb_external_learn_add(br, p, addr, vid, true, false);
>>  	} else {
>>  		spin_lock_bh(&br->hash_lock);
>>  		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
>> @@ -1366,7 +1366,7 @@ void br_fdb_unsync_static(struct net_bridge *br, 
>> struct net_bridge_port *p)
>> 
>>  int br_fdb_external_learn_add(struct net_bridge *br, struct 
>> net_bridge_port *p,
>>  			      const unsigned char *addr, u16 vid,
>> -			      bool swdev_notify)
>> +			      bool swdev_notify, bool locked)
>>  {
>>  	struct net_bridge_fdb_entry *fdb;
>>  	bool modified = false;
>> @@ -1386,6 +1386,9 @@ int br_fdb_external_learn_add(struct net_bridge 
>> *br, struct net_bridge_port *p,
>>  		if (!p)
>>  			flags |= BIT(BR_FDB_LOCAL);
>> 
>> +		if (locked)
>> +			flags |= BIT(BR_FDB_ENTRY_LOCKED);
>> +
>>  		fdb = fdb_create(br, p, addr, vid, flags);
>>  		if (!fdb) {
>>  			err = -ENOMEM;
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index 47a3598d25c8..9082451b4d40 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -811,7 +811,7 @@ int br_fdb_sync_static(struct net_bridge *br, 
>> struct net_bridge_port *p);
>>  void br_fdb_unsync_static(struct net_bridge *br, struct 
>> net_bridge_port *p);
>>  int br_fdb_external_learn_add(struct net_bridge *br, struct 
>> net_bridge_port *p,
>>  			      const unsigned char *addr, u16 vid,
>> -			      bool swdev_notify);
>> +			      bool swdev_notify, bool locked);
>>  int br_fdb_external_learn_del(struct net_bridge *br, struct 
>> net_bridge_port *p,
>>  			      const unsigned char *addr, u16 vid,
>>  			      bool swdev_notify);
>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>> index 8f3d76c751dd..85e566b856e1 100644
>> --- a/net/bridge/br_switchdev.c
>> +++ b/net/bridge/br_switchdev.c
>> @@ -136,6 +136,7 @@ static void br_switchdev_fdb_populate(struct 
>> net_bridge *br,
>>  	item->added_by_user = test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>>  	item->offloaded = test_bit(BR_FDB_OFFLOADED, &fdb->flags);
>>  	item->is_local = test_bit(BR_FDB_LOCAL, &fdb->flags);
>> +	item->is_locked = test_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags);
>>  	item->info.dev = (!p || item->is_local) ? br->dev : p->dev;
>>  	item->info.ctx = ctx;
>>  }
>> diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
>> index d9722e49864b..42f47a94b0f0 100644
>> --- a/net/dsa/dsa_priv.h
>> +++ b/net/dsa/dsa_priv.h
>> @@ -65,6 +65,7 @@ struct dsa_notifier_fdb_info {
>>  	const struct dsa_port *dp;
>>  	const unsigned char *addr;
>>  	u16 vid;
>> +	bool is_locked;
> 
> drop
> 

If this is dropped, the whole scheme will not work as userspace will not 
get notifications of new locked entries from the driver.
