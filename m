Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=x8QyrHOQ86A2Wf5VmZ2PpuabL/YdULtFV/cb4teKRi4=;
	b=P8rPgZpf3BUWQmllkEjzkOqHxnNl3FlVKG4nfQ+nhQqgfv6mOGFUnw5uvTqfUfzTkl
	hgDPv/7STqAfnx97PvODgQaBHWfndKLoO0c4maA6bD1L12y0Kykc1ZPKQaPRVPgGWlQ+
	LDe4suOQ/z27wsmqblYgNJ5KonD/QkzzoT0TM=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 28 Jun 2016 16:57:04 +0200
Message-Id: <1467125826-11980-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2 0/2] net: bridge: add support for
	IGMP/MLD stats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Hi all,
This patchset adds support for the new IFLA_STATS_LINK_XSTATS_SLAVE
attribute which can be used with RTM_GETSTATS in order to export per-slave
statistics. It works by passing the attribute to the linkxstats callback
and if the callback user supports it - it should dump that slave's stats.
This is much more scalable and permits us to request only a single port's
statistics instead of dumping everything every time.
The second patch adds support for per-port IGMP/MLD statistics and uses
the new API to export them for the bridge and its ports. The stats are
made in a very lightweight manner, the normal fast-path is not affected
at all and the flood paths (br_flood/br_multicast_flood) are only affected
if the packet is IGMP and the IGMP stats have been enabled using cache-hot
data for the check.

v2: Patch 01 is new, patch 02 has been reworked to use the new API, also
in addition counters for IGMP/MLD parse errors have been added and members
are added for per-port multicast traffic stats. The multicast counting has
been slightly optimized (moved the br_multicast_count inside the IPv4/6
IGMP functions after the checks for IGMP traffic) to avoid one conditional
that was on all of the multicast traffic path (both IGMP and other).

Thank you,
 Nik

Nikolay Aleksandrov (2):
  net: rtnetlink: add support for the IFLA_STATS_LINK_XSTATS_SLAVE
    attribute
  net: bridge: add support for IGMP/MLD stats and export them via
    netlink

 include/net/rtnetlink.h        |   5 +-
 include/uapi/linux/if_bridge.h |  26 +++++
 include/uapi/linux/if_link.h   |   2 +
 net/bridge/br_device.c         |  10 +-
 net/bridge/br_forward.c        |  13 ++-
 net/bridge/br_if.c             |   9 +-
 net/bridge/br_input.c          |   3 +
 net/bridge/br_multicast.c      | 217 ++++++++++++++++++++++++++++++++++++++---
 net/bridge/br_netlink.c        | 148 ++++++++++++++++++++++------
 net/bridge/br_private.h        |  41 +++++++-
 net/bridge/br_sysfs_br.c       |  25 +++++
 net/core/rtnetlink.c           |  50 +++++++++-
 12 files changed, 497 insertions(+), 52 deletions(-)

-- 
2.1.4

