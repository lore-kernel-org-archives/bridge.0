Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kn1V/a7lSLDzQFi1bqZeW57NNH5/fE9VhyK0T42qHtE=;
 b=DSP+orqI+eqetas8oKauP3pWelp2xx6icw5nOidWAbF2ZOfLDRbo5IeMjvBq/l5tpO
 0QNwCX9vMErt9bRRt1nAkA0nXNGuGUk0S++VLT8TrvPt8DYErW/6+AliZDyJy6pglFx4
 IryIskSpEr6fqnhpD3ZhqpPG09HS9ZxqcC6Ts=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon,  7 Sep 2020 12:56:04 +0300
Message-Id: <20200907095619.11216-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 00/15] net: bridge: mcast: initial
	IGMPv3/MLDv2 support (part 1)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

Hi all,
This patch-set implements the control plane for initial IGMPv3/MLDv2
support which takes care of include/exclude sets and state transitions
based on the different report types.
Patch 01 arranges the structure better by moving the frequently used
fields together, patch 02 factors out the port group deletion code which is
used in a few places. Patches 03 and 04 add support for source lists and
group modes per port group which are dumped. Patch 05 adds support for
group-and-source specific queries required for IGMPv3/MLDv2. Then patch 06
adds support for group and group-and-source query retransmissions via a new
rexmit timer. Patches 07 and 08 make use of the already present mdb fill
functions when sending notifications so we can have the full mdb entries'
state filled in (with sources, mode etc). Patch 09 takes care of port group
expiration, it switches the group mode to include and deletes it if there
are no sources with active timers. Patches 10-13 are the core changes which
add support for IGMPv3/MLDv2 reports and handle the source list set
operations as per RFCs 3376 and 3810, all IGMPv3/MLDv2 report types with
their transitions should be supported after these patches. I've used RFCs
3376, 3810 and FRR as a reference implementation. The source lists are
capped at 32 entries, we can remove that limitation at a later point which
would require a better data structure to hold them. IGMPv3 processing is
hidden behind the bridge's multicast_igmp_version option which must be set
to 3 in order to enable it. MLDv2 processing is hidden behind the bridge's
multicast_mld_version which must be set to 2 in order to enable it.
Patch 14 improves other querier processing a bit (more about this below).
And finally patch 15 transforms the src gc so it can be used with all mcast
objects since now we have multiple timers that can be running and we
need to make sure they have all finished before freeing the objects.
This is part 1, it only adds control plane support and doesn't change
the fast path. A following patch-set will take care of that.

Here're the sets that will come next (in order):
 - Fast path patch-set which adds support for (S, G) mdb entries needed
   for IGMPv3/MLDv2 forwarding, entry add source (kernel, user-space etc)
   needed for IGMPv3/MLDv2 entry management, entry block mode needed for
   IGMPv3/MLDv2 exclude mode. This set will also add iproute2 support for
   manipulating and showing all the new state.
 - Selftests patches which will verify all state transitions and forwarding
 - Explicit host tracking patch-set, needed for proper fast leave and
   with it fast leave will be enabled for IGMPv3/MLDv2

Not implemented yet:
 - Host IGMPv3/MLDv2 filter support (currently we handle only join/leave
   as before)
 - Proper other querier source timer and value updates
 - IGMPv3/v2 MLDv2/v1 compat (I have a few rough patches for this one)

v4: move old patch 05 to 02 (group del patch), before src lists
    patch 02: set pg's fast leave flag when deleting due to fast leave
    patch 03: now can use the new port del function
              add igmpv2/mldv1 bool which are set when the entry is
              added in those modes (later will be passed as update_timer)
    patch 10: rename update_timer to igmpv2_mldv1 and use the passed
              value from br_multicast_add_group's callers
v3: add IPv6/MLDv2 support, most patches are changed
v2:
 patches 03-04: make src lists RCU friendly so they can be traversed
                when dumping, reduce limit to a more conservative 32
                src group entries for a start
 patches 11-13: remove helper and directly do bitops
 patch      15: force mcast gc on bridge port del to make sure port
                group timers have finished before freeing the port

Thanks,
 Nik


Nikolay Aleksandrov (15):
  net: bridge: mdb: arrange internal structs so fast-path fields are
    close
  net: bridge: mcast: factor out port group del
  net: bridge: mcast: add support for group source list
  net: bridge: mcast: add support for src list and filter mode dumping
  net: bridge: mcast: add support for group-and-source specific queries
  net: bridge: mcast: add support for group query retransmit
  net: bridge: mdb: push notifications in __br_mdb_add/del
  net: bridge: mdb: use mdb and port entries in notifications
  net: bridge: mcast: delete expired port groups without srcs
  net: bridge: mcast: support for IGMPv3/MLDv2 ALLOW_NEW_SOURCES report
  net: bridge: mcast: support for IGMPV3/MLDv2 MODE_IS_INCLUDE/EXCLUDE
    report
  net: bridge: mcast: support for IGMPV3/MLDv2 CHANGE_TO_INCLUDE/EXCLUDE
    report
  net: bridge: mcast: support for IGMPV3/MLDv2 BLOCK_OLD_SOURCES report
  net: bridge: mcast: improve IGMPv3/MLDv2 query processing
  net: bridge: mcast: destroy all entries via gc

 include/uapi/linux/if_bridge.h |   21 +
 net/bridge/br_mdb.c            |  256 +++++--
 net/bridge/br_multicast.c      | 1290 ++++++++++++++++++++++++++++----
 net/bridge/br_private.h        |   70 +-
 4 files changed, 1415 insertions(+), 222 deletions(-)

-- 
2.25.4

