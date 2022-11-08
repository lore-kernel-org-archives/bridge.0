Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 99E9E408D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D6893408CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doByyfOdod8TuwyZN+F0d5h/tzFJh1IY+wAhbsHXhV0=;
 b=o0DUck36vGad1FRtEGrOaa/2U+Will2IwFTNijCD7g+Vs/rLMvhAJ3jCKyffyMPkeSjEsNZDGs8zuUrNYAB13knmzhnnfsepyQXP/U2HEyCi7cUONfU1EhV1NL9r5bpgYerV8IJXI8PAO4WubGpIxzoId5+k0Opi6gr1sTThxYnu2kHwH5f8bfFWOjLZAE+z9MiaT33xTmat7f+pKj2F17a2CYmppUHJwyEwqOvRuDsQBxyp34Wcb8HuFHxCSBOFXczwV5gPbSxmmrioEAoPy1AS/QSqrgyoDIPB4AX5m43jrvvMDl00AfWPy8It7ATy5xIgkYRzzYoIMmSAAyTYOA==
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 8 Nov 2022 11:47:18 +0100
Message-ID: <e2ce868a07056d7a06535aa5d8f5767c9a47100f.1667902754.git.petrm@nvidia.com>
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 12/15] selftests: devlink_lib: Split out
	helper
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

Merely checking whether a trap counter incremented or not without
logging a test result is useful on its own. Split this functionality to
a helper which will be used by subsequent patches.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
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
2.35.3

