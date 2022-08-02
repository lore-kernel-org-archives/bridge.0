Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E376940224
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6DB22401DC
MIME-Version: 1.0
Date: Tue, 02 Aug 2022 12:13:47 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20220708085403.sk7znfad3x2mnxeh@skbuf>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
 <20220707152930.1789437-3-netdev@kapio-technology.com>
 <20220708085403.sk7znfad3x2mnxeh@skbuf>
Message-ID: <0d884212b8df03e5cf03c4b2e5ea3e3d@kapio-technology.com>
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

>>  	struct dsa_db db;
>>  };
>> 
>> @@ -131,6 +132,7 @@ struct dsa_switchdev_event_work {
>>  	unsigned char addr[ETH_ALEN];
>>  	u16 vid;
>>  	bool host_addr;
>> +	bool is_locked;
> 
> drop
> 
>>  };
>> 
>>  enum dsa_standalone_event {
>> @@ -232,7 +234,7 @@ int dsa_port_vlan_msti(struct dsa_port *dp,
>>  		       const struct switchdev_vlan_msti *msti);
>>  int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu);
>>  int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
>> -		     u16 vid);
>> +		     u16 vid, bool is_locked);
> 
> drop
> 
>>  int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
>>  		     u16 vid);
>>  int dsa_port_standalone_host_fdb_add(struct dsa_port *dp,
>> diff --git a/net/dsa/port.c b/net/dsa/port.c
>> index 3738f2d40a0b..8bdac9aabe5d 100644
>> --- a/net/dsa/port.c
>> +++ b/net/dsa/port.c
>> @@ -35,6 +35,7 @@ static void dsa_port_notify_bridge_fdb_flush(const 
>> struct dsa_port *dp, u16 vid)
>>  	struct net_device *brport_dev = dsa_port_to_bridge_port(dp);
>>  	struct switchdev_notifier_fdb_info info = {
>>  		.vid = vid,
>> +		.is_locked = false,
> 
> drop
> 
>>  	};
>> 
>>  	/* When the port becomes standalone it has already left the bridge.
>> @@ -950,12 +951,13 @@ int dsa_port_mtu_change(struct dsa_port *dp, int 
>> new_mtu)
>>  }
>> 
>>  int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
>> -		     u16 vid)
>> +		     u16 vid, bool is_locked)
> 
> drop
> 
>>  {
>>  	struct dsa_notifier_fdb_info info = {
>>  		.dp = dp,
>>  		.addr = addr,
>>  		.vid = vid,
>> +		.is_locked = is_locked,
> 
> drop
> 
>>  		.db = {
>>  			.type = DSA_DB_BRIDGE,
>>  			.bridge = *dp->bridge,
>> @@ -979,6 +981,7 @@ int dsa_port_fdb_del(struct dsa_port *dp, const 
>> unsigned char *addr,
>>  		.dp = dp,
>>  		.addr = addr,
>>  		.vid = vid,
>> +		.is_locked = false,
> 
> drop
> 
>>  		.db = {
>>  			.type = DSA_DB_BRIDGE,
>>  			.bridge = *dp->bridge,
>> @@ -999,6 +1002,7 @@ static int dsa_port_host_fdb_add(struct dsa_port 
>> *dp,
>>  		.dp = dp,
>>  		.addr = addr,
>>  		.vid = vid,
>> +		.is_locked = false,
> 
> drop
> 
>>  		.db = db,
>>  	};
>> 
>> @@ -1050,6 +1054,7 @@ static int dsa_port_host_fdb_del(struct dsa_port 
>> *dp,
>>  		.dp = dp,
>>  		.addr = addr,
>>  		.vid = vid,
>> +		.is_locked = false,
> 
> drop
> 
>>  		.db = db,
>>  	};
>> 
>> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
>> index 801a5d445833..905b15e4eab9 100644
>> --- a/net/dsa/slave.c
>> +++ b/net/dsa/slave.c
>> @@ -2784,6 +2784,7 @@ static void 
>> dsa_slave_switchdev_event_work(struct work_struct *work)
>>  		container_of(work, struct dsa_switchdev_event_work, work);
>>  	const unsigned char *addr = switchdev_work->addr;
>>  	struct net_device *dev = switchdev_work->dev;
>> +	bool is_locked = switchdev_work->is_locked;
> 
> drop
> 
>>  	u16 vid = switchdev_work->vid;
>>  	struct dsa_switch *ds;
>>  	struct dsa_port *dp;
>> @@ -2799,7 +2800,7 @@ static void 
>> dsa_slave_switchdev_event_work(struct work_struct *work)
>>  		else if (dp->lag)
>>  			err = dsa_port_lag_fdb_add(dp, addr, vid);
>>  		else
>> -			err = dsa_port_fdb_add(dp, addr, vid);
>> +			err = dsa_port_fdb_add(dp, addr, vid, is_locked);
> 
> drop
> 
>>  		if (err) {
>>  			dev_err(ds->dev,
>>  				"port %d failed to add %pM vid %d to fdb: %d\n",
>> @@ -2907,6 +2908,7 @@ static int dsa_slave_fdb_event(struct net_device 
>> *dev,
>>  	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
>>  	switchdev_work->vid = fdb_info->vid;
>>  	switchdev_work->host_addr = host_addr;
>> +	switchdev_work->is_locked = fdb_info->is_locked;
> 
> drop
> 
>> 
>>  	dsa_schedule_work(&switchdev_work->work);
>> 
>> diff --git a/net/dsa/switch.c b/net/dsa/switch.c
>> index 2b56218fc57c..32b1e7ac6373 100644
>> --- a/net/dsa/switch.c
>> +++ b/net/dsa/switch.c
>> @@ -234,7 +234,7 @@ static int dsa_port_do_mdb_del(struct dsa_port 
>> *dp,
>>  }
>> 
>>  static int dsa_port_do_fdb_add(struct dsa_port *dp, const unsigned 
>> char *addr,
>> -			       u16 vid, struct dsa_db db)
>> +			       u16 vid, bool is_locked, struct dsa_db db)
> 
> drop
> 
>>  {
>>  	struct dsa_switch *ds = dp->ds;
>>  	struct dsa_mac_addr *a;
>> @@ -398,7 +398,7 @@ static int dsa_switch_host_fdb_add(struct 
>> dsa_switch *ds,
>>  	dsa_switch_for_each_port(dp, ds) {
>>  		if (dsa_port_host_address_match(dp, info->dp)) {
>>  			err = dsa_port_do_fdb_add(dp, info->addr, info->vid,
>> -						  info->db);
>> +						  false, info->db);
> 
> drop
> 
>>  			if (err)
>>  				break;
>>  		}
>> @@ -437,7 +437,7 @@ static int dsa_switch_fdb_add(struct dsa_switch 
>> *ds,
>>  	if (!ds->ops->port_fdb_add)
>>  		return -EOPNOTSUPP;
>> 
>> -	return dsa_port_do_fdb_add(dp, info->addr, info->vid, info->db);
>> +	return dsa_port_do_fdb_add(dp, info->addr, info->vid, 
>> info->is_locked, info->db);
> 
> drop
> 
>>  }
>> 
>>  static int dsa_switch_fdb_del(struct dsa_switch *ds,
>> --
>> 2.30.2
>> 

Hi Vladimir and Ido,

I can either ignore locked entries early or late in the dsa/switchdev 
layers.

If I ignore early, I think it should be in br_switchdev_fdb_notify() in 
net/bridge/br_switchdev.c.
If I ignore late, I would think that it should be jut before sending it 
to the driver(s), e.g. in dsa_port_do_fdb_add() in net/dsa/switch.c.

There is of course pros and cons of both options, but if the flag is 
never to be sent to the driver, then it should be ignored early.

If ignored late most of this patch should not be dropped.
