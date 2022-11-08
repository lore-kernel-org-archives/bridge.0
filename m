Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECC0D40894
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED54E4032C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5CjmYMVarafJWwlmM7fhyDRkbO5NPlFuYuaDKhHG/o=;
 b=BaylwctLnhmFA6OXUK36TuvLJJ7gvnOk/7CW2W5dMfC9FrolPXtrfnGXxMoPthn7JoyKIqngTyu8QYEPovbwaV7j+h4Vd+I+fION03I8HdrF0UcfkLBMT7P+r01l2RlUgiNO96ZhuoGLssTElGiADcym41YLZSls9hdZqHNo/h4I3GnXrIdqZUegCtT21QK6yaHfLI6v6gIBGNetsmuibHO6KfuXlYv8wpEfMYeXbshoCD6cGrgNcB8ivPucxvF+3+BaWFr/K1YT1d100A5QTys3ZOvo0SheM4CKgaOc4kITjj9X9+gHqwQwm5ioZ3G8sEBm2Xfh68UkQDaKEudAAA==
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 8 Nov 2022 11:47:07 +0100
Message-ID: <b266dcf6d647684a10984d12f98549f93fd378ab.1667902754.git.petrm@nvidia.com>
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 01/15] bridge: switchdev: Let device
	drivers determine FDB offload indication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, mlxsw@nvidia.com, Jiri Pirko <jiri@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>

From: Ido Schimmel <idosch@nvidia.com>

Currently, FDB entries that are notified to the bridge via
'SWITCHDEV_FDB_ADD_TO_BRIDGE' are always marked as offloaded. With MAB
enabled, this will no longer be universally true. Device drivers will
report locked FDB entries to the bridge to let it know that the
corresponding hosts required authorization, but it does not mean that
these entries are necessarily programmed in the underlying hardware.

Solve this by determining the offload indication based of the
'offloaded' bit in the FDB notification.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
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
2.35.3

