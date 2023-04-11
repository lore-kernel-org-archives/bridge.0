Return-Path: <jesse.brandeburg@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82CF060BDD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B81460BCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1681227062; x=1712763062;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bAaYQaQ7dwZjMlSC68BdO6Q1/kZtqsZyzuUQvoXst4s=;
 b=ZAGaUYvTPODXm+EY1vRhOMMwdrg54QdtAUYKvXs8Zf2SrENjheqMSkbM
 3yzPy2JmQcLK4kA3Zs19QWP6BEJ2WYpNRaxrLhVDcWUZQhggSnuQ1b5am
 fDlE7fOuMD7S//qnliD4I3v9UUiGN6E/K7bPk+Qw6idrDfJr+pMfGQ3d3
 g47Xo8/5U1yzbtTkhpBkYu7QZHLB6hi1mHDFKF7Dvji1kulouUGw1z0Rs
 4gJW0YZEs048QUZVqoC8W5xBw3J87sdIw6oO3G24KsZJO6zYAT1bcsnGr
 eNU5kqWDotkI8G1DJ8Xjc2npIbAL34IEJgQmep+xhkUyKpVyTYKSIBC8l Q==;
Message-ID: <260c2921-44e1-466b-0bfb-05006e6ad4c1@intel.com>
Date: Tue, 11 Apr 2023 08:30:51 -0700
Content-Language: en-US
References: <20230410204951.1359485-1-vladimir.oltean@nxp.com>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20230410204951.1359485-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] net: bridge: switchdev: don't notify FDB
 entries with "master dynamic"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Arkadi Sharshevsky <arkadis@mellanox.com>, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>, Eric Dumazet <edumazet@google.com>, "Hans J. Schultz" <netdev@kapio-technology.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 4/10/2023 1:49 PM, Vladimir Oltean wrote:
> There is a structural problem in switchdev, where the flag bits in
> struct switchdev_notifier_fdb_info (added_by_user, is_local etc) only
> represent a simplified / denatured view of what's in struct
> net_bridge_fdb_entry :: flags (BR_FDB_ADDED_BY_USER, BR_FDB_LOCAL etc).
> Each time we want to pass more information about struct
> net_bridge_fdb_entry :: flags to struct switchdev_notifier_fdb_info
> (here, BR_FDB_STATIC), we find that FDB entries were already notified to
> switchdev with no regard to this flag, and thus, switchdev drivers had
> no indication whether the notified entries were static or not.
> 
> For example, this command:
> 
> ip link add br0 type bridge && ip link set swp0 master br0
> bridge fdb add dev swp0 00:01:02:03:04:05 master dynamic
> 
> causes a struct net_bridge_fdb_entry to be passed to
> br_switchdev_fdb_notify() which has a single flag set:
> BR_FDB_ADDED_BY_USER.
> 
> This is further passed to the switchdev notifier chain, where interested
> drivers have no choice but to assume this is a static FDB entry.
> So currently, all drivers offload it to hardware as such.
> 
> bridge fdb get 00:01:02:03:04:05 dev swp0 master
> 00:01:02:03:04:05 dev swp0 offload master br0
> 
> The software FDB entry expires after the $ageing_time and the bridge
> notifies its deletion as well, so it eventually disappears from hardware
> too.
> 
> This is a problem, because it is actually desirable to start offloading
> "master dynamic" FDB entries correctly, and this is how the current
> incorrect behavior was discovered.
> 
> To see why the current behavior of "here's a static FDB entry when you
> asked for a dynamic one" is incorrect, it is possible to imagine a
> scenario like below, where this decision could lead to packet loss:
> 
> Step 1: management prepares FDB entries like this:
> 
> bridge fdb add dev swp0 ${MAC_A} master dynamic
> bridge fdb add dev swp2 ${MAC_B} master dynamic
> 
>         br0
>       /  |  \
>      /   |   \
>   swp0  swp1  swp2
>    |           |
>    A           B
> 
> Step 2: station A migrates to swp1 (assume that swp0's link doesn't flap
> during that time so that the port isn't flushed, for example station A
> was behind an intermediary switch):
> 
>         br0
>       /  |  \
>      /   |   \
>   swp0  swp1  swp2
>    |     |     |
>          A     B
> 
> Whenever A wants to ping B, its packets will be autonomously forwarded
> by the switch (because ${MAC_B} is known). So the software will never
> see packets from ${MAC_A} as source address, and will never know it
> needs to invalidate the dynamic FDB entry towards swp0. As for the
> hardware FDB entry, that's static, it doesn't move when the station
> roams.
> 
> So when B wants to reply to A's pings, the switch will forward those
> replies to swp0 until the software bridge ages out its dynamic entry,
> and that can cause connectivity loss for up to 5 minutes after roaming.
> 
> With a correctly offloaded dynamic FDB entry, the switch would update
> its entry for ${MAC_A} to be towards swp1 as soon as it sees packets
> from it (no need for CPU intervention).
> 
> Looking at tools/testing/selftests/net/forwarding/, there is no valid
> use of the "bridge fdb add ... master dynamic" command there, so I am
> fairly confident that no one used to rely on this behavior.
> 
> With the change in place, these FDB entries are no longer offloaded:
> 
> bridge fdb get 00:01:02:03:04:05 dev swp0 master
> 00:01:02:03:04:05 dev swp0 master br0
> 
> and this also constitutes a better way (assuming a backport to stable
> kernels) for user space to determine whether the switchdev driver did
> actually act upon the dynamic FDB entry or not.
> 
> Fixes: 6b26b51b1d13 ("net: bridge: Add support for notifying devices about FDB add/del")
> Link: https://lore.kernel.org/netdev/20230327115206.jk5q5l753aoelwus@skbuf/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Looks fine to me, but I'd like to see other switchdev experts reply.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


