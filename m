Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C524160BB1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03D5C60BA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RCBGhZYnZU96Kob2gAKPBYvz3k+hQiEoMRcPAQAhmY=;
 b=D11c5TkPChvkZRdkO67pgNYiZKiguQuGd4nLy6VxciwN/0HP/JKEMJiohIXgh1d6lZwb1dvmvM4emFKYa4iQqqTnIuJAteiOlqhS7AvDSgPEPweH8N4GuaZEjluSP037fy9a06P0FnXAHMuUP1yFmSJGPwtVY0XLZDARHvmN1CesNQbdXoD7f72KpTuqz9xtUJqrk561kYAnL40l0oTPhYrWVzTWWdXlykMkw4iO1+igf5k1YXY+YGSWAZQX8po5K7Ue/vvtROXydk0Yhe1OHkXmLKdB6qJoKU3J4n9/K9ufwmr7FDQIsmYhRlIeV8GgNCWi9h5o/eilsm0O5SognQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 25 Oct 2022 13:00:22 +0300
Message-Id: <20221025100024.1287157-15-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 14/16] selftests: mlxsw: Add a test
	for EAPOL trap
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

Test that packets with a destination MAC of 01:80:C2:00:00:03 trigger
the "eapol" packet trap.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
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
2.37.3

