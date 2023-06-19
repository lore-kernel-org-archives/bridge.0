Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 52AE840990
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 725594091C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1687158917; bh=Cc6aq6UkSRKV+ra7kxJ+VoLT96oDvWLxQyxgW379yRU=;
 h=From:To:Cc:Subject:Date:From;
 b=p6w8NYnrrEAatGjxR3Bgy7VBFbOMPgz7JWeUfMVIMN43oqZOyBu28KQC5h5Csr+M6
 w3b3ySJgOz21lgFRT4yFsjp8YTTaqTJ+Uq99GLpXfrULPF1GHM1+voH6rOiQec2pvy
 0X/7ANm4dzXyerXjXfZDDTeLy6suA6oem1OWX8W0=
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Date: Mon, 19 Jun 2023 09:14:40 +0200
Message-Id: <20230619071444.14625-1-jnixdorf-oss@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 0/3,
	iproute2-next 0/1] bridge: Add a limit on learned FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Johannes Nixdorf <jnixdorf-oss@avm.de>, Vladimir Oltean <vladimir.oltean@nxp.com>, Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Oleksij Rempel <linux@rempel-privat.de>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

Introduce a limit on the amount of learned FDB entries on a bridge,
configured by netlink with a build time default on bridge creation in
the kernel config.

For backwards compatibility the kernel config default is disabling the
limit (0).

Without any limit a malicious actor may OOM a kernel by spamming packets
with changing MAC addresses on their bridge port, so allow the bridge
creator to limit the number of entries.

Currently the manual entries are identified by the bridge flags
BR_FDB_LOCAL or BR_FDB_ADDED_BY_USER, and changes to those flags are
protected under a lock. This means the limit also applies to entries
created with BR_FDB_ADDED_BY_EXT_LEARN but none of the other two,
e.g. ones added by SWITCHDEV_FDB_ADD_TO_BRIDGE.

v1: https://lore.kernel.org/netdev/20230515085046.4457-1-jnixdorf-oss@avm.de/

Changes since v1:
 - Added BR_FDB_ADDED_BY_USER earlier in fdb_add_entry to ensure the
   limit is not applied.
 - Do not initialize fdb_*_entries to 0. (from review)
 - Do not skip decrementing on 0. (from review)
 - Moved the counters to a conditional hole in struct net_bridge to
   avoid growing the struct. (from review, it still grows the struct as
   there are 2 32-bit values)
 - Add IFLA_BR_FDB_CUR_LEARNED_ENTRIES (from review)
 - Fix br_get_size() with the added attributes.
 - Only limit learned entries, rename to
   *_(CUR|MAX)_LEARNED_ENTRIES. (from review)
 - Added a default limit in Kconfig. (deemed acceptable in review
   comments, helps with embedded use-cases where a special purpose kernel
   is built anyways)
 - Added an iproute2 patch for easier testing.

Obsolete v1 review comments:
 - Return better errors to users: Due to limiting the limit to
   automatically created entries, netlink fdb add requests and changing
   bridge ports are never rejected, so they do not yet need a more
   friendly error returned.

net-next:

Johannes Nixdorf (3):
  bridge: Set BR_FDB_ADDED_BY_USER early in fdb_add_entry
  bridge: Add a limit on learned FDB entries
  net: bridge: Add a configurable default FDB learning limit

 include/uapi/linux/if_link.h |  2 +
 net/bridge/Kconfig           | 13 +++++++
 net/bridge/br_device.c       |  2 +
 net/bridge/br_fdb.c          | 73 ++++++++++++++++++++++++++++++++----
 net/bridge/br_netlink.c      | 13 ++++++-
 net/bridge/br_private.h      |  6 +++
 6 files changed, 101 insertions(+), 8 deletions(-)

iproute2-next:

Johannes Nixdorf (1):
  iplink: bridge: Add support for bridge FDB learning limits

 include/uapi/linux/if_link.h |  2 ++
 ip/iplink_bridge.c           | 21 +++++++++++++++++++++
 man/man8/ip-link.8.in        |  9 +++++++++
 3 files changed, 32 insertions(+)

-- 
2.40.1

