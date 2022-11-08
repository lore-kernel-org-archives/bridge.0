Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2776260D6D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E68160D5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opczsBhp0qt6+P5dGe1iYcEVrDktjV1EOsuHM54Wmhc=;
 b=k/D+H0h3/fJzGavrOJjFKUaKLwdC7WiELkuC2OJc7uv2R52WfENuyuotiuzG85PNjyU6lIRrAcCZsSFFSRY7/bh8YkylV+HYfiPpNgbIBTnRzlTZe5MEkO9dLdAKGEM4g/rFI9Pa+rpNQEKP2gN0xSQMd4T/C39tS/l/V2x4Ohe9KD9cNaJvm8ES8oD79wOySJu4pdFAgPZW3gF6JiW6eZ8mt9YGQ0YDlNH7Bn1Wd1dv2Oopl2AuF3/zfJK4BI58tvjHUoBH3XnT2lLwKligqAaly9t23XY7Loezakw8nwPJWA1JqpZEVlRwYHbasRovjUIIO6Z9E9exsvVPSYOCQg==
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 8 Nov 2022 11:47:19 +0100
Message-ID: <389ee318ff1a799d1e94ba1a33ab2ff42bae50fc.1667902754.git.petrm@nvidia.com>
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 13/15] selftests: mlxsw: Add a test for
	EAPOL trap
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

Test that packets with a destination MAC of 01:80:C2:00:00:03 trigger
the "eapol" packet trap.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/devlink_trap_control.sh | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_control.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_control.sh
index d3a891d421ab..64153bbf95df 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_control.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_control.sh
@@ -83,6 +83,7 @@ ALL_TESTS="
 	ptp_general_test
 	flow_action_sample_test
 	flow_action_trap_test
+	eapol_test
 "
 NUM_NETIFS=4
 source $lib_dir/lib.sh
@@ -677,6 +678,27 @@ flow_action_trap_test()
 	tc qdisc del dev $rp1 clsact
 }
 
+eapol_payload_get()
+{
+	local source_mac=$1; shift
+	local p
+
+	p=$(:
+		)"01:80:C2:00:00:03:"$(       : ETH daddr
+		)"$source_mac:"$(             : ETH saddr
+		)"88:8E:"$(                   : ETH type
+		)
+	echo $p
+}
+
+eapol_test()
+{
+	local h1mac=$(mac_get $h1)
+
+	devlink_trap_stats_test "EAPOL" "eapol" $MZ $h1 -c 1 \
+		$(eapol_payload_get $h1mac) -p 100 -q
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.35.3

