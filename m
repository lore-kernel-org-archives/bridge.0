Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lG2pvPc4SHgc6L+ln3Njda4OcYlOBObAxxS4WHFU3Us=;
 b=clpfeJtlKoezTjqlV9J1IoR5sz/x3n4+cCE4+E9z+pLIVo6zR88gVfdOKy4Ma0SA2y
 f9v4zjDBl5a37aWPzpZqUYbWYhqw6ZjgfLfvgJHu7wrojE6sv5JQjk1HK7F8hicbWBkP
 KY0VIcBOdy3frS+470Uc236hFzZquUdvPCTr0=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat,  5 Sep 2020 11:23:55 +0300
Message-Id: <20200905082410.2230253-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 00/15] net: bridge: mcast: initial
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
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

Hi all,
This patch-set implements the control plane for initial IGMPv3/MLDv2
support which takes care of include/exclude sets and state transitions
based on the different report types.
Patch 01 arranges the structure better by moving the frequently used
fields together, patches 02 and 03 add support for source lists and group
modes per port group which are dumped. Patch 04 adds support for
group-and-source specific queries required for IGMPv3/MLDv2. Patch 05
factors out the port group deletion code which is used in a few places,
then patch 06 adds support for group and group-and-source query
retransmissions via a new rexmit timer. Patches 07 and 08 make use of
the already present mdb fill functions when sending notifications so we
can have the full mdb entries' state filled in (with sources, mode etc).
Patch 09 takes care of port group expiration, it switches the group mode
to include and deletes it if there are no sources with active timers.
Patches 10-13 are the core changes which add support for IGMPv3/MLDv2
reports and handle the source list set operations as per RFCs 3376 and
3810, all IGMPv3/MLDv2 report types with their transitions should be
supported after these patches. I've used RFCs 3376, 3810 and FRR as a
reference implementation. The source lists are capped at 32 entries, we can
remove that limitation at a later point which would require a better data
structure to hold them. IGMPv3 processing is hidden behind the bridge's
multicast_igmp_version option which must be set to 3 in order to enable it.
MLDv2 processing is hidden behind the bridge's multicast_mld_version
which must be set to 2 in order to enable it.
Patch 14 improves other querier processing a bit (more about this below).
And finally patch 15 transform the src gc so it can be used with all mcast
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

v3: add IPv6/MLDv2 support, most patches are changed
v2:
 patches 02-03: make src lists RCU friendly so they can be traversed
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
  net: bridge: mcast: add support for group source list
  net: bridge: mcast: add support for src list and filter mode dumping
  net: bridge: mcast: add support for group-and-source specific queries
  net: bridge: mcast: factor out port group del
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
 net/bridge/br_multicast.c      | 1289 ++++++++++++++++++++++++++++----
 net/bridge/br_private.h        |   70 +-
 4 files changed, 1415 insertions(+), 221 deletions(-)

-- 
2.25.4

