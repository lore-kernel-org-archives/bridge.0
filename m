Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C253415FD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B501415FF
From: "Hans J. Schultz" <netdev@kapio-technology.com>
Date: Sat, 18 Mar 2023 15:10:10 +0100
Message-Id: <20230318141010.513424-7-netdev@kapio-technology.com>
In-Reply-To: <20230318141010.513424-1-netdev@kapio-technology.com>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 net-next 6/6] selftests: forwarding: add dynamic
	FDB test
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "Hans J. Schultz" <netdev@kapio-technology.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>

Test FDB ageing of user entry created by

bridge fdb replace ADDR dev <DEV> master dynamic

Use LOW_AGEING_TIME variable in forwarding.config to set a low ageing time.
Beware, DSA might not accept the ageing time you want. Check the
age_time_coeff value for your driver.

Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
---
 .../net/forwarding/bridge_locked_port.sh      | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
index dc92d32464f6..dbc7017fd45d 100755
--- a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
@@ -14,6 +14,7 @@ ALL_TESTS="
 NUM_NETIFS=4
 CHECK_TC="no"
 source lib.sh
+source tc_common.sh
 
 h1_create()
 {
@@ -319,6 +320,41 @@ locked_port_mab_flush()
 	log_test "Locked port MAB FDB flush"
 }
 
+# Test of dynamic FDB entries.
+locked_port_dyn_fdb()
+{
+	local mac=00:01:02:03:04:05
+	local ageing_time
+
+	RET=0
+	ageing_time=$(bridge_ageing_time_get br0)
+	tc qdisc add dev $swp2 clsact
+	ip link set dev br0 type bridge ageing_time $LOW_AGEING_TIME
+	bridge link set dev $swp1 learning on locked on
+
+	bridge fdb replace $mac dev $swp1 master dynamic
+	tc filter add dev $swp2 egress protocol ip pref 1 handle 1 flower \
+		dst_ip 192.0.2.2 ip_proto udp dst_port 12345 action pass
+
+	$MZ $swp1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
+		-a $mac -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
+	tc_check_packets "dev $swp2 egress" 1 1
+	check_err $? "Packet not seen on egress after adding dynamic FDB"
+
+	sleep $((LOW_AGEING_TIME / 100 + 10))
+
+	$MZ $swp1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
+		-a $mac -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
+	tc_check_packets "dev $swp2 egress" 1 1
+	check_fail $? "Dynamic FDB entry did not age out"
+
+	ip link set dev br0 type bridge ageing_time $ageing_time
+	bridge link set dev $swp1 learning off locked off
+	tc qdisc del dev $swp2 clsact
+
+	log_test "Locked port dyn FDB"
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.34.1

