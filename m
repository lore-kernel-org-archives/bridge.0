Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rsXnOvd5nwBThD2qTg9D1pYE4X40JBYkDShPIF1srm0=;
 b=AuWU0dI8dq+Am1E5pw+6CORB6nijQMNR5dkWuKAcGZOilRKprNir0VkqxJGMJsJniP
 SMz3WfKNtQzQK03zbaRkGVGQFeI0FpCwG0YIlzCs2tlcJ5YnBDwrrtJcrndqJu/KUlZV
 0CEAx/HfVOIwn8WOr1EPnpOUGyVAvUS3yrG873SuxG0UMYGBqKTV0YGIS/9AvFVVL1h4
 ZATIIMEAn/teDTyn9+2uTH24RCY5GUs9mmXkeHwavtsgMdQvjXemrPxP0LmriDMldGJH
 wba/rZ7bbwVOtkfyneUtm2EPl2PscriY8HesZtwgeQCGs8BweoNz6dGsYH2Amubuoa12
 gxcw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 25 Nov 2021 16:08:57 +0200
Message-Id: <20211125140858.3639139-10-razor@blackwall.org>
In-Reply-To: <20211125140858.3639139-1-razor@blackwall.org>
References: <20211125140858.3639139-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 09/10] selftests: net: bridge: add vlan
	mcast_router tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Add tests for the new per-port/vlan mcast_router option, verify that
unknown multicast packets are flooded only to router ports.

TEST: Port vlan 10 option mcast_router default value                [ OK ]
TEST: Port vlan 10 mcast_router option changed to 2                 [ OK ]
TEST: Flood unknown vlan multicast packets to router port only      [ OK ]

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../net/forwarding/bridge_vlan_mcast.sh       | 54 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index fbc7f5045b26..898a70f4d226 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -3,7 +3,8 @@
 
 ALL_TESTS="vlmc_control_test vlmc_querier_test vlmc_igmp_mld_version_test \
 	   vlmc_last_member_test vlmc_startup_query_test vlmc_membership_test \
-	   vlmc_querier_intvl_test vlmc_query_intvl_test vlmc_query_response_intvl_test"
+	   vlmc_querier_intvl_test vlmc_query_intvl_test vlmc_query_response_intvl_test \
+	   vlmc_router_port_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -471,6 +472,57 @@ vlmc_query_response_intvl_test()
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 1000
 }
 
+vlmc_router_port_test()
+{
+	RET=0
+	local goutput=`bridge -j -d vlan show`
+	echo -n $goutput |
+		jq -e ".[] | select(.ifname == \"$swp1\" and \
+				    .vlans[].vlan == 10)" &>/dev/null
+	check_err $? "Could not find port vlan 10's options"
+
+	echo -n $goutput |
+		jq -e ".[] | select(.ifname == \"$swp1\" and \
+				    .vlans[].vlan == 10 and \
+				    .vlans[].mcast_router == 1)" &>/dev/null
+	check_err $? "Wrong default port mcast_router option value"
+	log_test "Port vlan 10 option mcast_router default value"
+
+	RET=0
+	bridge vlan set vid 10 dev $swp1 mcast_router 2
+	check_err $? "Could not set port vlan 10's mcast_router option"
+	log_test "Port vlan 10 mcast_router option changed to 2"
+
+	RET=0
+	tc filter add dev $swp1 egress pref 10 prot 802.1Q \
+		flower vlan_id 10 vlan_ethtype ipv4 dst_ip 239.1.1.1 ip_proto udp action pass
+	tc filter add dev $swp2 egress pref 10 prot 802.1Q \
+		flower vlan_id 10 vlan_ethtype ipv4 dst_ip 239.1.1.1 ip_proto udp action pass
+	bridge vlan set vid 10 dev $swp2 mcast_router 0
+	# we need to enable querier and disable query response interval to
+	# make sure packets are flooded only to router ports
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_querier 1 \
+					      mcast_query_response_interval 0
+	bridge vlan add vid 10 dev br0 self
+	sleep 1
+	mausezahn br0 -Q 10 -c 10 -p 128 -b 01:00:5e:01:01:01 -B 239.1.1.1 \
+			-t udp "dp=1024" &>/dev/null
+	local swp1_tcstats=$(tc_rule_stats_get $swp1 10 egress)
+	if [[ $swp1_tcstats != 10 ]]; then
+		check_err 1 "Wrong number of vlan 10 multicast packets flooded"
+	fi
+	local swp2_tcstats=$(tc_rule_stats_get $swp2 10 egress)
+	check_err $swp2_tcstats "Vlan 10 multicast packets flooded to non-router port"
+	log_test "Flood unknown vlan multicast packets to router port only"
+
+	tc filter del dev $swp2 egress pref 10
+	tc filter del dev $swp1 egress pref 10
+	bridge vlan del vid 10 dev br0 self
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 1000
+	bridge vlan set vid 10 dev $swp2 mcast_router 1
+	bridge vlan set vid 10 dev $swp1 mcast_router 1
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.31.1

