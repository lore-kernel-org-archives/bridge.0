Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=cb8P6OYWHjV/ERsXQG7+ZktHBZgNQ+1/eq7GKwRZ2ds=;
	b=ZJekOndgGlYomKXFtHM5aDDWNlqf6leBTqxjLtYDaFZQUApwP2mtN88ZYhirmCTco19Elw/B+amXYs4sw8ItXuVra6ShagOhiRncy0oDl4NhERjdA5AI1Bs6iKRtlbUp5wgL8VtLn/9c79V5wfvFcOORKdjH+NhDfaggHgPTWhA=
From: Petr Machata <petrm@mellanox.com>
Message-Id: <cover.1525350809.git.petrm@mellanox.com>
Date: Thu, 03 May 2018 14:43:40 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next mlxsw v2 0/2] bridge: FDB: Notify about
	removal of non-user-added entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: ivecera@redhat.com, f.fainelli@gmail.com, andrew@lunn.ch, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, davem@davemloft.net

Device drivers may generally need to keep in sync with bridge's FDB. In
particular, for its offload of tc mirror action where the mirrored-to
device is a gretap device, mlxsw needs to listen to a number of events,
FDB events among the others. SWITCHDEV_FDB_{ADD,DEL}_TO_DEVICE would be
a natural notification in that case.

However, for removal of FDB entries added due to device activity (as
opposed to explicit addition through "bridge fdb add" or similar), there
are no notifications.

Thus in patch #1, add the "added_by_user" field to switchdev
notifications sent for FDB activity. Adapt drivers to ignore activity on
non-user-added entries, to maintain the current behavior. Specifically
in case of mlxsw, allow mlxsw_sp_span_respin() call for any and all FDB
updates.

In patch #2, change the bridge driver to actually emit notifications for
these FDB entries. Take care not to send notification for bridge
updates that itself originate in SWITCHDEV_FDB_*_TO_BRIDGE events.

Changes from v1 to v2:
- Instead of introducing a new variant of fdb_delete(), add a new
  parameter to the existing function.
- Name the parameter swdev_notify, not notify.

Petr Machata (2):
  switchdev: Add fdb.added_by_user to switchdev notifications
  net: bridge: Notify about !added_by_user FDB entries

 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  4 ++
 drivers/net/ethernet/rocker/rocker_main.c          |  2 +
 include/net/switchdev.h                            |  1 +
 net/bridge/br.c                                    |  4 +-
 net/bridge/br_fdb.c                                | 47 ++++++++++++----------
 net/bridge/br_private.h                            |  6 ++-
 net/bridge/br_switchdev.c                          | 12 ++++--
 net/dsa/slave.c                                    |  5 ++-
 8 files changed, 51 insertions(+), 30 deletions(-)

-- 
2.4.11

