Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24EA6409A4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FFAB40932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIE5MC3JDvBtov+GVA64V3kJKYZxPb0Umu2mK4UsGOI=;
 b=FI48v2y7CIgwe+Rk5rIwqGdBVy5oaG6SUsPRNy0jflsPYsjQklCLhVgsJioudE2qhynh9gFtHhE+dZEgBgRV14Cy9eWs1xe0f+dJINtn1ZwuyCnkRbJooqZEXA44C1DvFyCNn2DsTaoqXwgaCKX+xlZZfiDJrj0o8UaJzNVE+Os=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 18 Apr 2023 18:59:02 +0300
Message-Id: <20230418155902.898627-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v2 net] net: bridge: switchdev: don't notify FDB
	entries with "master dynamic"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, "Hans J. Schultz" <netdev@kapio-technology.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

There is a structural problem in switchdev, where the flag bits in
struct switchdev_notifier_fdb_info (added_by_user, is_local etc) only
represent a simplified / denatured view of what's in struct
net_bridge_fdb_entry :: flags (BR_FDB_ADDED_BY_USER, BR_FDB_LOCAL etc).
Each time we want to pass more information about struct
net_bridge_fdb_entry :: flags to struct switchdev_notifier_fdb_info
(here, BR_FDB_STATIC), we find that FDB entries were already notified to
switchdev with no regard to this flag, and thus, switchdev drivers had
no indication whether the notified entries were static or not.

For example, this command:

ip link add br0 type bridge && ip link set swp0 master br0
bridge fdb add dev swp0 00:01:02:03:04:05 master dynamic

has never worked as intended with switchdev. It causes a struct
net_bridge_fdb_entry to be passed to br_switchdev_fdb_notify() which has
a single flag set: BR_FDB_ADDED_BY_USER.

This is further passed to the switchdev notifier chain, where interested
drivers have no choice but to assume this is a static (does not age) and
sticky (does not migrate) FDB entry. So currently, all drivers offload
it to hardware as such, as can be seen below ("offload" is set).

bridge fdb get 00:01:02:03:04:05 dev swp0 master
00:01:02:03:04:05 dev swp0 offload master br0

The software FDB entry expires $ageing_time centiseconds after the
kernel last sees a packet with this MAC SA, and the bridge notifies its
deletion as well, so it eventually disappears from hardware too.

This is a problem, because it is actually desirable to start offloading
"master dynamic" FDB entries correctly - they should expire $ageing_time
centiseconds after the *hardware* port last sees a packet with this
MAC SA - and this is how the current incorrect behavior was discovered.
With an offloaded data plane, it can be expected that software only sees
exception path packets, so an otherwise active dynamic FDB entry would
be aged out by software sooner than it should.

With the change in place, these FDB entries are no longer offloaded:

bridge fdb get 00:01:02:03:04:05 dev swp0 master
00:01:02:03:04:05 dev swp0 master br0

and this also constitutes a better way (assuming a backport to stable
kernels) for user space to determine whether the kernel has the
capability of doing something sane with these or not.

As opposed to "master dynamic" FDB entries, on the current behavior of
which no one currently depends on (which can be deduced from the lack of
kselftests), Ido Schimmel explains that entries with the "extern_learn"
flag (BR_FDB_ADDED_BY_EXT_LEARN) should still be notified to switchdev,
since the spectrum driver listens to them (and this is kind of okay,
because although they are treated identically to "static", they are
expected to not age, and to roam).

Fixes: 6b26b51b1d13 ("net: bridge: Add support for notifying devices about FDB add/del")
Link: https://lore.kernel.org/netdev/20230327115206.jk5q5l753aoelwus@skbuf/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v1->v2: let extern_learn entries still pass through to switchdev
v1 at:
https://lore.kernel.org/netdev/20230410204951.1359485-1-vladimir.oltean@nxp.com/

 net/bridge/br_switchdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index de18e9c1d7a7..ba95c4d74a60 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -148,6 +148,17 @@ br_switchdev_fdb_notify(struct net_bridge *br,
 	if (test_bit(BR_FDB_LOCKED, &fdb->flags))
 		return;
 
+	/* Entries with these flags were created using ndm_state == NUD_REACHABLE,
+	 * ndm_flags == NTF_MASTER( | NTF_STICKY), ext_flags == 0 by something
+	 * equivalent to 'bridge fdb add ... master dynamic (sticky)'.
+	 * Drivers don't know how to deal with these, so don't notify them to
+	 * avoid confusing them.
+	 */
+	if (test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags) &&
+	    !test_bit(BR_FDB_STATIC, &fdb->flags) &&
+	    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
+		return;
+
 	br_switchdev_fdb_populate(br, &item, fdb, NULL);
 
 	switch (type) {
-- 
2.34.1

