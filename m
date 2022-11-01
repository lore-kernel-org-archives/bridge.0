Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 584B5401BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABE58401BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+fpNdg86H63LzNAjDIC2UDssoWhJLvg0rPjknYqB1s=;
 b=NtRQzL3WnTBCI15XPjP44SyAoBw5o6GPrAfVqTqAyGuTNIe3qLe2IVIm+N8Vfy8BXtOjvB6lH7tQBYCqudrWy3L8IqG0XRNSZr7bg61Udp2/SLV9pTt20Jl2Sbp/ElgkCcCb0J4FONf4+lSIf+0KtGMPSJd1M1XvVFl8yrFMnEtfyhj6mTIGfAxl9D0DpxAvWIm3vofRrkHstv+PvVh88of+esiPhExFucgEqNzBa3Shvt8/0NhmuFFqRapjmscGc12NBSMhK4ER2OxGm6Z8j5tUHlJp7DTRbYfdJRZ7F1h+szAwtZsUGP14v8MvyrF1y61hvAdudReXFnxp5Sx6Pw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue,  1 Nov 2022 20:57:53 +0200
Message-Id: <20221101185753.2120691-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net] bridge: Fix flushing of dynamic FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

The following commands should result in all the dynamic FDB entries
being flushed, but instead all the non-local (non-permanent) entries are
flushed:

 # bridge fdb add 00:aa:bb:cc:dd:ee dev dummy1 master static
 # bridge fdb add 00:11:22:33:44:55 dev dummy1 master dynamic
 # ip link set dev br0 type bridge fdb_flush
 # bridge fdb show brport dummy1
 00:00:00:00:00:01 master br0 permanent
 33:33:00:00:00:01 self permanent
 01:00:5e:00:00:01 self permanent

This is because br_fdb_flush() works with FDB flags and not the
corresponding enumerator values. Fix by passing the FDB flag instead.

After the fix:

 # bridge fdb add 00:aa:bb:cc:dd:ee dev dummy1 master static
 # bridge fdb add 00:11:22:33:44:55 dev dummy1 master dynamic
 # ip link set dev br0 type bridge fdb_flush
 # bridge fdb show brport dummy1
 00:aa:bb:cc:dd:ee master br0 static
 00:00:00:00:00:01 master br0 permanent
 33:33:00:00:00:01 self permanent
 01:00:5e:00:00:01 self permanent

Fixes: 1f78ee14eeac ("net: bridge: fdb: add support for fine-grained flushing")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_netlink.c  | 2 +-
 net/bridge/br_sysfs_br.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 5aeb3646e74c..d087fd4c784a 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1332,7 +1332,7 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 
 	if (data[IFLA_BR_FDB_FLUSH]) {
 		struct net_bridge_fdb_flush_desc desc = {
-			.flags_mask = BR_FDB_STATIC
+			.flags_mask = BIT(BR_FDB_STATIC)
 		};
 
 		br_fdb_flush(br, &desc);
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 612e367fff20..ea733542244c 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -345,7 +345,7 @@ static int set_flush(struct net_bridge *br, unsigned long val,
 		     struct netlink_ext_ack *extack)
 {
 	struct net_bridge_fdb_flush_desc desc = {
-		.flags_mask = BR_FDB_STATIC
+		.flags_mask = BIT(BR_FDB_STATIC)
 	};
 
 	br_fdb_flush(br, &desc);
-- 
2.37.3

