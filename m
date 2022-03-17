Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/7iAhcR4tM55eEx0OphxTplV89HWokZKexzro1tRyR4=;
 b=B8XIvyZykfMaM6OPqWJsED+v5Dwn3xRPjvNFplB7XHHqcf+b+PsDawQkL/LFEncHXO
 7BsmBBjN6XsztRPgkTlTEVyciryk7kfyMykxuI0t9DoxYnt6rqJSySkzGa499pRV5xQl
 2K0JH+lIFThsnhGGADoEf9LSYYhuI6P0EY+ZAWnVI1Aoj9oMpsxKN0wTqYppiQyz2G8a
 /y+0qKS+hz8wZ9WtRe3aGXVnubOQHNZdyZiZpxwrIKXgeyYwZePhUlo/rH6Yb2RuPjCl
 +aXjTlyMvs9HnFgqVZk8dr50w/0ScT/W1K8nPH8qAzkUX5hAtwUQCGZ6EDlKWyUlrOTI
 htjA==
Date: Thu, 17 Mar 2022 21:27:01 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220317192701.vskynomfmnciv732@skbuf>
References: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
 <20220317093902.1305816-4-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317093902.1305816-4-schultz.hans+netdev@gmail.com>
Subject: Re: [Bridge] [PATCH v2 net-next 3/4] net: dsa: mv88e6xxx:
 mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Thu, Mar 17, 2022 at 10:39:01AM +0100, Hans Schultz wrote:
> +int mv88e6xxx_switchdev_handle_atu_miss_violation(struct mv88e6xxx_chip *chip,
> +						  int port,
> +						  struct mv88e6xxx_atu_entry *entry,
> +						  u16 fid)
> +{
> +	struct switchdev_notifier_fdb_info info = {
> +		.addr = entry->mac,
> +		.vid = 0,
> +		.added_by_user = false,
> +		.is_local = false,
> +		.offloaded = true,
> +		.locked = true,
> +	};
> +	struct mv88e6xxx_fid_search_ctx ctx;
> +	struct netlink_ext_ack *extack;
> +	struct net_device *brport;
> +	struct dsa_port *dp;
> +	int err;
> +
> +	ctx.fid_search = fid;
> +	err = mv88e6xxx_vtu_walk(chip, mv88e6xxx_find_vid_on_matching_fid, &ctx);
> +	if (err < 0)
> +		return err;
> +	if (err == 1)
> +		info.vid = ctx.vid_found;
> +	else
> +		return -ENODATA;
> +
> +	dp = dsa_to_port(chip->ds, port);
> +	brport = dsa_port_to_bridge_port(dp);
> +	if (!brport)
> +		return -ENODEV;

dsa_port_to_bridge_port() must be under rtnl_lock().

On a different CPU rather than the one servicing the interrupt, the
rtnl_lock is held exactly by the user space command that triggers the
deletion of the bridge port.

The interrupt thread runs, calls dsa_port_to_bridge_port(), and finds
a non-NULL brport, because the bridge is still doing something else in
del_nbp(), it hasn't yet reached the netdev_upper_dev_unlink() function
which will trigger dsa_port_bridge_leave() -> dsa_port_bridge_destroy().

So you continue bravely, and you call rtnl_lock() below. This will block
until the "ip" command finishes. When you acquire the rtnl_lock however,
the brport is no longer valid, because you have waited for the user
space command to finish.

Best case, the bridge port deletion command was "ip link set lan0 nomaster".
So "brport" is "lan0", you call SWITCHDEV_FDB_ADD_TO_BRIDGE, the bridge
doesn't recognize it as a bridge port, says "huh, weird" and carries on.

Worst case, "brport" was an offloaded LAG device which was a bridge
port, and when it got destroyed by "ip link del bond0", the bridge port
got destroyed too. So at this stage, you have a use-after-free because
bond0 no longer exists.

> +
> +	rtnl_lock();
> +	err = call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE, brport, &info.info, extack);
> +	if (err)
> +		goto out;
> +	entry->portvec = MV88E6XXX_G1_ATU_DATA_PORT_VECTOR_NO_EGRESS;
> +	err = mv88e6xxx_g1_atu_loadpurge(chip, fid, entry);
> +
> +out:
> +	rtnl_unlock();
> +	return err;
> +}
