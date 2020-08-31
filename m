Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9NRlvcF3T25DILTKeuqX8E3EYjoQX7UtJSzPYWLJykQ=;
 b=UIPOyV/TX/qTZ5nPyNPqNeLqqpySpB79+88G/c5/mSiypSXVyEgV5pQF598fXK/QcJ
 DVGzd/FB9W5miozlIm/H9n2/0VsiPmGWEBdSsOExlCshpOyY1TThKNK9CksFW4wAL+Xi
 aqNKWIib8mhFuKp/e6q9MRAWnrPPVlscB+O9Q=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 31 Aug 2020 18:08:30 +0300
Message-Id: <20200831150845.1062447-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 00/15] net: bridge: mcast: initial IGMPv3
	support (part 1)
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
This patch-set implements the control plane for initial IGMPv3 support.
Patch 01 arranges the structure better by moving the frequently used
fields together, patches 02 and 03 add support for source lists and group
modes per port group which are dumped. Patch 04 adds support for
group-and-source specific queries required for IGMPv3. Patch 05 factors
out the port group deletion code which is used in a few places, then
patch 06 adds support for group and group-and-source query
retransmissions via a new rexmit timer. Patches 07 and 08 make use of
the already present mdb fill functions when sending notifications so we
can have the full mdb entries' state filled in (with sources, mode etc).
Patch 09 takes care of port group expiration, it switches the group mode
to include and deletes it if there are no sources with active timers.
Patches 10-13 are the core changes which add support for IGMPv3 reports
and handle the source list set operations as per RFC 3376, all IGMPv3
report types with their transitions should be supported after these
patches. I've used RFC 3376 and FRR as a reference implementation. The
source lists are capped at 64 entries, we can remove that limitation at
a later point which would require a better data structure to hold them.
IGMPv3 processing is hidden behind the bridge's multicast_igmp_version
option which must be set to 3 in order to enable it.
Patch 14 improves other querier processing a bit (more about this below).
And finally patch 15 transform the src gc so it can be used with all mcast
objects since now we have multiple timers that can be running and we
need to make sure they have all finished before freeing the objects.
This is part 1, it only adds control plane support and doesn't change
the fast path. A following patch-set will take care of that.

Here're the sets that will come next (in order):
 - Fast path patch-set which adds support for (S, G) mdb entries needed
   for IGMPv3 forwarding, entry add source (kernel, user-space etc)
   needed for IGMPv3 entry management, entry block mode needed for
   IGMPv3 exclude mode. This set will also add iproute2 support for
   manipulating and showing all the new state.
 - Selftests patch-set which will verify all IGMPv3 state transitions
   and forwarding
 - Explicit host tracking patch-set, needed for proper fast leave and
   with it fast leave will be enabled for IGMPv3

Not implemented yet:
 - Host IGMPv3 support (currently we handle only join/leave as before)
 - Proper other querier source timer updates
 - IGMPv3/v2 compat (I have a few rough patches for this one)

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
  net: bridge: mcast: support for IGMPv3 IGMPV3_ALLOW_NEW_SOURCES report
  net: bridge: mcast: support for IGMPV3_MODE_IS_INCLUDE/EXCLUDE report
  net: bridge: mcast: support for IGMPV3_CHANGE_TO_INCLUDE/EXCLUDE
    report
  net: bridge: mcast: support for IGMPV3_BLOCK_OLD_SOURCES report
  net: bridge: mcast: improve v3 query processing
  net: bridge: mcast: destroy all entries via gc

 include/uapi/linux/if_bridge.h |   21 +
 net/bridge/br_mdb.c            |  222 ++++---
 net/bridge/br_multicast.c      | 1058 +++++++++++++++++++++++++++++---
 net/bridge/br_private.h        |   66 +-
 4 files changed, 1186 insertions(+), 181 deletions(-)

-- 
2.25.4

