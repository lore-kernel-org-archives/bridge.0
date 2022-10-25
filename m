Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76F0640432
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC14940399
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh8zoFLiQpl4kt2kIepqZ27r6waWEN2Vat6/G8zbY0g=;
 b=K0NH/Suut3kx9Yon5195iuyr2knC57NOtD3D6WDq7zxBKEfWMcx2ABxvWi9KPpyzHm9TBpJjk6ogDIC26W4IrHKYMRdLYIOONCAsJTaPQz82Om5Qw5sOPHb7h5qWYOFb52hhlo+/Wa0EhvseH7E97RyW6p1dhi+0rMq4ZGw49LOsukQyuEM0GxGrf4853UyzHXaJUa2A3BErTg135RbzUuU9T08/u9VMmzRXRLHwKa/gGL5zcY8AMKelJEjuzwWgvvaYOk0nIqMVSqx4vw0djHKavNW5QRhhIoDLokf9uPFs8Mfk253jcZsZOKZ0FFaI8BvB8WZUUBZtQ9oXOayZLA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 25 Oct 2022 13:00:21 +0300
Message-Id: <20221025100024.1287157-14-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 13/16] selftests: devlink_lib: Split
	out helper
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

Merely checking whether a trap counter incremented or not without
logging a test result is useful on its own. Split this functionality to
a helper which will be used by subsequent patches.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../selftests/net/forwarding/devlink_lib.sh   | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/devlink_lib.sh b/tools/testing/selftests/net/forwarding/devlink_lib.sh
index 601990c6881b..f1de525cfa55 100644
--- a/tools/testing/selftests/net/forwarding/devlink_lib.sh
+++ b/tools/testing/selftests/net/forwarding/devlink_lib.sh
@@ -503,25 +503,30 @@ devlink_trap_drop_cleanup()
 	tc filter del dev $dev egress protocol $proto pref $pref handle $handle flower
 }
 
-devlink_trap_stats_test()
+devlink_trap_stats_check()
 {
-	local test_name=$1; shift
 	local trap_name=$1; shift
 	local send_one="$@"
 	local t0_packets
 	local t1_packets
 
-	RET=0
-
 	t0_packets=$(devlink_trap_rx_packets_get $trap_name)
 
 	$send_one && sleep 1
 
 	t1_packets=$(devlink_trap_rx_packets_get $trap_name)
 
-	if [[ $t1_packets -eq $t0_packets ]]; then
-		check_err 1 "Trap stats did not increase"
-	fi
+	[[ $t1_packets -ne $t0_packets ]]
+}
+
+devlink_trap_stats_test()
+{
+	local test_name=$1; shift
+
+	RET=0
+
+	devlink_trap_stats_check "$@"
+	check_err $? "Trap stats did not increase"
 
 	log_test "$test_name"
 }
-- 
2.37.3

