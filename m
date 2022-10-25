Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD2A960BA9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0AD9C60B8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBOHTW8PIE9V9aZiY0HibJZMUFbqyh9bIF2wNJrx5uk=;
 b=aOemcnlFmWNH4WAAIGEiL2Ckn4tlTAtequ1S1o4amiey4jX7zk+2xBJjOmOfjnANFvm9PiB+Q13YrfLjnqVC8kzns1hHYrxJfJseAawh4NQWTDiRkGe+WQT8KtBP3vbPGxTNtX7UQtS1eqBzbcceeVrsqJFSJyBmSId+WfIH1rWrbz96JQIKPzC9+/txU2RVlbCjkfb2YYHYTnuJfhhb+5H+638YZUtXbWqskJzGF2aG7afsqQiUXKMd2mUw5v3cOl8O7FG2ItvHbqniRzSI8ccXHoYB8Knhijq2ksmSl7CiMSweqmfe1kbCXmenQOjjuAr9PXZe5CsTNFLnzWYt+g==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 25 Oct 2022 13:00:24 +0300
Message-Id: <20221025100024.1287157-17-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 16/16] selftests: mlxsw: Add a test
	for invalid locked bridge port configurations
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

Test that locked bridge port configurations that are not supported by
mlxsw are rejected.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/rtnetlink.sh  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh b/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh
index 04f03ae9d8fb..5e89657857c7 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh
@@ -34,6 +34,7 @@ ALL_TESTS="
 	nexthop_obj_bucket_offload_test
 	nexthop_obj_blackhole_offload_test
 	nexthop_obj_route_offload_test
+	bridge_locked_port_test
 	devlink_reload_test
 "
 NUM_NETIFS=2
@@ -917,6 +918,36 @@ nexthop_obj_route_offload_test()
 	simple_if_fini $swp1 192.0.2.1/24 2001:db8:1::1/64
 }
 
+bridge_locked_port_test()
+{
+	RET=0
+
+	ip link add name br1 up type bridge vlan_filtering 0
+
+	ip link add link $swp1 name $swp1.10 type vlan id 10
+	ip link set dev $swp1.10 master br1
+
+	bridge link set dev $swp1.10 locked on
+	check_fail $? "managed to set locked flag on a VLAN upper"
+
+	ip link set dev $swp1.10 nomaster
+	ip link set dev $swp1 master br1
+
+	bridge link set dev $swp1 locked on
+	check_fail $? "managed to set locked flag on a bridge port that has a VLAN upper"
+
+	ip link del dev $swp1.10
+	bridge link set dev $swp1 locked on
+
+	ip link add link $swp1 name $swp1.10 type vlan id 10
+	check_fail $? "managed to configure a VLAN upper on a locked port"
+
+	log_test "bridge locked port"
+
+	ip link del dev $swp1.10 &> /dev/null
+	ip link del dev br1
+}
+
 devlink_reload_test()
 {
 	# Test that after executing all the above configuration tests, a
-- 
2.37.3

