Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2936560A6D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FB316066D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1693914590; bh=KyKR2i+DGj/6JbddwGXrO2TV0yqaQ4X+XFsdxioIsO4=;
 h=From:Subject:Date:To:Cc:From;
 b=Il/S80Jk4rxGPM8D/O5EE86iJVccCG0FzuVlQrvkksGAejUEqu/5fh+XecO6rUulR
 u7G4ZbPvMzSn5XgEhal0ubPb8BT2ZhW+w1DciDw2OV9n3ExY45ldpEAm1bSfSvfwx+
 cqRKH4L1LeRsgnNwC8fryg7WyqmoU2CqUVBTjENY=
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Date: Tue, 05 Sep 2023 13:47:17 +0200
Message-Id: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next v3 0/6] bridge: Add a limit on learned FDB
	entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Johannes Nixdorf <jnixdorf-oss@avm.de>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Introduce a limit on the amount of learned FDB entries on a bridge,
configured by netlink with a build time default on bridge creation in
the kernel config.

For backwards compatibility the kernel config default is disabling the
limit (0).

Without any limit a malicious actor may OOM a kernel by spamming packets
with changing MAC addresses on their bridge port, so allow the bridge
creator to limit the number of entries.

Currently the manual entries are identified by the bridge flags
BR_FDB_LOCAL or BR_FDB_ADDED_BY_USER, atomically bundled under the new
flag BR_FDB_DYNAMIC_LEARNED. This means the limit also applies to
entries created with BR_FDB_ADDED_BY_EXT_LEARN but none of BR_FDB_LOCAL
or BR_FDB_ADDED_BY_USER, e.g. ones added by SWITCHDEV_FDB_ADD_TO_BRIDGE.

Changes since v2:
 - Fixed the flags for fdb_create in fdb_add_entry to use
   BIT(...). Previously we passed garbage. (from review)
 - Set strict_start_type for br_policy. (from review)
 - Split out the combined accounting and limit patch, and the netlink
   patch from the combined patch in v2. (from review)
 - Count atomically, remove the newly introduced lock. (from review)
 - Added the new attributes to br_policy. (from review)
 - Added a selftest for the new feature. (from review)

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

iproute2-next v3: https://lore.kernel.org/netdev/20230905-fdb_limit-v3-1-34bb124556d8@avm.de/

v2: https://lore.kernel.org/netdev/20230619071444.14625-1-jnixdorf-oss@avm.de/
v1: https://lore.kernel.org/netdev/20230515085046.4457-1-jnixdorf-oss@avm.de/

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
Johannes Nixdorf (6):
      net: bridge: Set BR_FDB_ADDED_BY_USER early in fdb_add_entry
      net: bridge: Set strict_start_type for br_policy
      net: bridge: Track and limit dynamically learned FDB entries
      net: bridge: Add netlink knobs for number / max learned FDB entries
      net: bridge: Add a configurable default FDB learning limit
      selftests: forwarding: bridge_fdb_learning_limit: Add a new selftest

 include/uapi/linux/if_link.h                       |   2 +
 net/bridge/Kconfig                                 |  13 +
 net/bridge/br_device.c                             |   2 +
 net/bridge/br_fdb.c                                |  40 ++-
 net/bridge/br_netlink.c                            |  16 +-
 net/bridge/br_private.h                            |   4 +
 .../net/forwarding/bridge_fdb_learning_limit.sh    | 283 +++++++++++++++++++++
 7 files changed, 354 insertions(+), 6 deletions(-)
---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230904-fdb_limit-fae5bbf16c88

Best regards,
-- 
Johannes Nixdorf <jnixdorf-oss@avm.de>

