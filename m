Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wPcMQBvMi4L81CqXqUNlL27DFtJJ6AUlR/ZpxbIsss0=;
 b=d9dH+MgL/izcQtHIuCFBChiqwBlYNEApffYHF+cLXlOytooAGXYMxtjmA20xwvdEkB
 lusAqKqxHmUi59bUm2kcQUXp6oTBfC45O61JXeWJ7KAKNF2ErwcpkwBO73DchKAkBRot
 zXIxH15FOSngpnEBaEWzasfNfb+8zt1oEMte8caWGtKtjVjCRXpWgJFjlc09Kas3zYt9
 WfN/Rb8574+kfRuebMYntF2awBevyY+httkbxKrlLaqUiwSdQ3KOBon8tcqGM77A0A8/
 SSldHu6xC/rZBwtmqj1OQu0Te7m+1i4cOqzzu5CXWSSCZb4xysXtVqgREfR8Qi4a7Q0y
 vgrQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 20 Jan 2021 16:51:49 +0200
Message-Id: <20210120145203.1109140-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 00/14] net: bridge: multicast: add initial
	EHT support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
This set adds explicit host tracking support for IGMPv3/MLDv2. The
already present per-port fast leave flag is used to enable it since that
is the primary goal of EHT, to track a group and its S,Gs usage per-host
and when left without any interested hosts delete them before the standard
timers. The EHT code is pretty self-contained and not enabled by default.
There is no new uAPI added, all of the functionality is currently hidden
behind the fast leave flag. In the future that will change (more below).
The host tracking uses two new sets per port group: one having an entry for
each host which contains that host's view of the group (source list and
filter mode), and one set which contains an entry for each source having
an internal set which contains an entry for each host that has reported
an interest for that source. RB trees are used for all sets so they're
compact when not used and fast when we need to do lookups.
To illustrate it:
 [ bridge port group ]
  ` [ host set (rb) ]
   ` [ host entry with a list of sources and filter mode ]
  ` [ source set (rb) ]
   ` [ source entry ]
    ` [ source host set (rb) ]
     ` [ source host entry with a timer ]

The number of tracked sources per host is limited to the maximum total
number of S,G entries per port group - PG_SRC_ENT_LIMIT (currently 32).
The number of hosts is unlimited, I think the argument that a local
attacker can exhaust the memory/cause high CPU usage can be applied to
fdb entries as well which are unlimited. In the future if needed we can
add an option to limit these, but I don't think it's necessary for a
start. All of the new sets are protected by the bridge's multicast lock.
I'm pretty sure we'll be changing the cases and improving the
convergence time in the future, but this seems like a good start.

I'll post self-tests as a separate patch-set.

Patch breakdown:
 patch 1 -  4: minor cleanups and preparations for EHT
 patch      5: adds the new structures which will be used in the
               following patches
 patch      6: adds support to create, destroy and lookup host entries
 patch      7: adds support to create, delete and lokup source set entries
 patch      8: adds a host "delete" function which is just a host's
               source list flush since that would automatically delete
               the host
 patch 9 - 10: add support for handling all IGMPv3/MLDv2 report types
               more information can be found in the individual patches
 patch     11: optmizes a specific TO_INCLUDE use-case with host timeouts
 patch     12: handles per-host filter mode changing (include <-> exclude)
 patch     13: pulls out block group deletion since now it can be
               deleted in both filter modes
 patch     14: marks deletions done due to fast leave

Future plans:
 - export host information
 - add an option to reduce queries
 - add an option to limit the number of host entries
 - tune more fast leave cases for quicker convergence

By the way I think this is the first open-source EHT implementation, I
couldn't find any while researching it. :)

Thanks,
 Nik


Nikolay Aleksandrov (14):
  net: bridge: multicast: rename src_size to addr_size
  net: bridge: multicast: pass host src address to IGMPv3/MLDv2
    functions
  net: bridge: multicast: __grp_src_block_incl can modify pg
  net: bridge: multicast: calculate idx position without changing ptr
  net: bridge: multicast: add EHT structures and definitions
  net: bridge: multicast: add EHT host handling functions
  net: bridge: multicast: add EHT source set handling functions
  net: bridge: multicast: add EHT host delete function
  net: bridge: multicast: add EHT allow/block handling
  net: bridge: multicast: add EHT include and exclude handling
  net: bridge: multicast: optimize TO_INCLUDE EHT timeouts
  net: bridge: multicast: add EHT host filter_mode handling
  net: bridge: multicast: handle block pg delete for all cases
  net: bridge: multicast: mark IGMPv3/MLDv2 fast-leave deletes

 net/bridge/Makefile               |   2 +-
 net/bridge/br_multicast.c         | 254 +++++----
 net/bridge/br_multicast_eht.c     | 856 ++++++++++++++++++++++++++++++
 net/bridge/br_private.h           |   6 +
 net/bridge/br_private_mcast_eht.h |  65 +++
 5 files changed, 1093 insertions(+), 90 deletions(-)
 create mode 100644 net/bridge/br_multicast_eht.c
 create mode 100644 net/bridge/br_private_mcast_eht.h

-- 
2.29.2

