Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=giNz4IMQJBWP9MPpTNJl9KipRoS+mbRRhgoflH2MLuc=;
 b=baP/p1y6Id5GHg2j6wuQaaDBno0KZNyeB8YQbfZfByrzqp2iDkVPPFJka/xKkwp6Ag
 aGZzfxyIp3KjAIO6i2amosQy9oMzzO6cZ/XpnAfM9XhfGnjrXrhP13cHMDhE/ykRLsp/
 YIo/ILPY1HLFobWrtZZVYTL6oo3MJ08TJFuHddGwRXpuqbkKOM9V2p9UWExW8WF9jpRm
 CtPAXg6WY2PuBM8wCsuZ7Xd79qf9a1eOojUkZNx/D7LLGXsAfVzq397ono6XHCkVj5o0
 h5kIjd8cj3tBVoNtGWXmqzwvgs9JGm3vZqgrfM6V5yHZfjwHMTUmLNsLzVYpaC2UPyh8
 rmeA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 20 Aug 2021 15:42:53 +0300
Message-Id: <20210820124255.1465672-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/2] net: bridge: mcast: add support for
	port/vlan router control
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
This small set adds control over port/vlan mcast router config.
Initially I had added host vlan entry router control via vlan's global
options but that is really unnecessary and we can use a single per-vlan
option to control it both for port/vlan and host/vlan entries. Since
it's all still in net-next we can convert BRIDGE_VLANDB_GOPTS_MCAST_ROUTER
to BRIDGE_VLANDB_ENTRY_MCAST_ROUTER and use it for both. That makes much
more sense and is easier for user-space. Patch 01 prepares the port
router function to be used with port mcast context instead of port and
then patch 02 converts the global vlan mcast router option to per-vlan
mcast router option which directly gives us both host/vlan and port/vlan
mcast router control without any additional changes.

This way we get the following coherent syntax:
 [ port/vlan mcast router]
 $ bridge vlan set vid 100 dev ens20 mcast_router 2

 [ bridge/vlan mcast router ]
 $ bridge vlan set vid 100 dev bridge mcast_router 2
instead of:
 $ bridge vlan set vid 100 dev bridge mcast_router 1 global

The mcast_router should not be regarded as a global option, it controls
the port/vlan and bridge/vlan mcast router behaviour.

This is the last set needed for the initial per-vlan mcast support.
Next patch-sets:
 - iproute2 support
 - selftests

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: mcast: br_multicast_set_port_router takes multicast
    context as argument
  net: bridge: vlan: convert mcast router global opt to per-vlan entry

 include/uapi/linux/if_bridge.h |  2 +-
 net/bridge/br_multicast.c      | 24 ++++++++++++----
 net/bridge/br_netlink.c        |  3 +-
 net/bridge/br_private.h        | 18 +++++++++++-
 net/bridge/br_sysfs_if.c       |  2 +-
 net/bridge/br_vlan.c           |  1 +
 net/bridge/br_vlan_options.c   | 51 ++++++++++++++++++++++------------
 7 files changed, 74 insertions(+), 27 deletions(-)

-- 
2.31.1

