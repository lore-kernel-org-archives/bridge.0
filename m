Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FE58812D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9169080E46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq1915Q7YYjDKKWn/Core1xUyC2d9LHv/zrbbXnTQmc=;
 b=AWs1WuNkk+e1epMuOM/DAwQe5x2LY2VqJKxva/YsZUgcwPFmmDGoY0xSwNoi5w3D4NfFAbzMHbPKQrU9e/UOpHfSimt6tNJqHu9UJzRQg2dGPVs2sETuwv5NVoGemReMgT9vI0Ff27oCwRODRoxcoz/JVEZa7X5ipAMUDS3RgpC3KXGO86QFvJ0avcjoSqLjkxhD1OSLf86DH+0FRGbyIT+HMpzlYJJAZs6m3HsrNU0f0lZQ0w35rYeEBuMcca2jI9POCjnLyzkLEoATgqkr1rVgJEmO/Hy7WNMx5cgvhDnmF7uzuE13Jqk7Bz8OScJdSRideT74f1dg8GgU2D8HOQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 25 Oct 2022 13:00:11 +0300
Message-Id: <20221025100024.1287157-4-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 03/16] bridge: switchdev: Let device
	drivers determine FDB offload indication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@kapio-technology.com, razor@blackwall.org, roopa@nvidia.com, Ido Schimmel <idosch@nvidia.com>, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Currently, FDB entries that are notified to the bridge via
'SWITCHDEV_FDB_ADD_TO_BRIDGE' are always marked as offloaded. With MAB
enabled, this will no longer be universally true. Device drivers will
report locked FDB entries to the bridge to let it know that the
corresponding hosts required authorization, but it does not mean that
these entries are necessarily programmed in the underlying hardware.

Solve this by determining the offload indication based of the
'offloaded' bit in the FDB notification.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    Needs auditing to see which device drivers are not setting this bit.

 net/bridge/br.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 96e91d69a9a8..145999b8c355 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -172,7 +172,7 @@ static int br_switchdev_event(struct notifier_block *unused,
 			break;
 		}
 		br_fdb_offloaded_set(br, p, fdb_info->addr,
-				     fdb_info->vid, true);
+				     fdb_info->vid, fdb_info->offloaded);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_BRIDGE:
 		fdb_info = ptr;
-- 
2.37.3

