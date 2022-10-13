Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F78D82BC0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 637C782B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgDfEzaNmyHruhoccynN8yZwGtMgHcR59fqlAen+gP4=;
 b=rQfpTnvBGwAzpPtoThM4SKADp0CosgJiwouIorhjJFHWUBmfVtkeAY7UWNW5iSavFS1iz6foJrFqiyp/8fBtjkHwmMIg7J+CgM6xvZJOYQiAE5O6bvio6nEw0k3Ex6HTWng/KNI9L/E9N5i9W2CCQrsKbWTrryMJdRrNLLkLwvRxfBkHw2JYCqiSbYv+MXmk2VdoP1F5NpWJsJIBOOIGylxRF5ZcqP1454ptYmeJlzQ76+uK781VAabD24cKfJ8Y1XF3nx55zk6YZ1bdAK/8HtlEyQIMmJZcEq1NOwnHfSGVwAZGuKNWfUchidrq9LiInLobeZ1RRvX8V4EMtnjNUQ==
Date: Thu, 13 Oct 2022 15:16:32 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y0gBoLRNHRQeI1PH@shredder>
References: <20221009174052.1927483-1-netdev@kapio-technology.com>
 <20221009174052.1927483-10-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009174052.1927483-10-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v7 net-next 9/9] selftests: forwarding: add
 test of MAC-Auth Bypass to locked port tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Sun, Oct 09, 2022 at 07:40:52PM +0200, Hans J. Schultz wrote:
> +++ b/tools/testing/selftests/net/forwarding/bridge_blackhole_fdb.sh
> @@ -0,0 +1,134 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ALL_TESTS="blackhole_fdb"
> +NUM_NETIFS=4
> +source tc_common.sh
> +source lib.sh
> +
> +h1_create()
> +{
> +	simple_if_init $h1 192.0.2.1/24 2001:db8:1::1/64
> +	vlan_create $h1 100 v$h1 198.51.100.1/24
> +}
> +
> +h1_destroy()
> +{
> +	vlan_destroy $h1 100
> +	simple_if_fini $h1 192.0.2.1/24 2001:db8:1::1/64
> +}
> +
> +h2_create()
> +{
> +	simple_if_init $h2 192.0.2.2/24 2001:db8:1::2/64
> +	vlan_create $h2 100 v$h2 198.51.100.2/24
> +}
> +
> +h2_destroy()
> +{
> +	vlan_destroy $h2 100
> +	simple_if_fini $h2 192.0.2.2/24 2001:db8:1::2/64
> +}

There is unnecessary configuration here. Can be simplified:

diff --git a/tools/testing/selftests/net/forwarding/bridge_blackhole_fdb.sh b/tools/testing/selftests/net/forwarding/bridge_blackhole_fdb.sh
index 77d166180bc4..cc2145ea1968 100755
--- a/tools/testing/selftests/net/forwarding/bridge_blackhole_fdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_blackhole_fdb.sh
@@ -8,26 +8,22 @@ source lib.sh
 
 h1_create()
 {
-	simple_if_init $h1 192.0.2.1/24 2001:db8:1::1/64
-	vlan_create $h1 100 v$h1 198.51.100.1/24
+	simple_if_init $h1 192.0.2.1/24
 }
 
 h1_destroy()
 {
-	vlan_destroy $h1 100
-	simple_if_fini $h1 192.0.2.1/24 2001:db8:1::1/64
+	simple_if_fini $h1 192.0.2.1/24
 }
 
 h2_create()
 {
-	simple_if_init $h2 192.0.2.2/24 2001:db8:1::2/64
-	vlan_create $h2 100 v$h2 198.51.100.2/24
+	simple_if_init $h2 192.0.2.2/24
 }
 
 h2_destroy()
 {
-	vlan_destroy $h2 100
-	simple_if_fini $h2 192.0.2.2/24 2001:db8:1::2/64
+	simple_if_fini $h2 192.0.2.2/24
 }
 
 switch_create()

> +
> +switch_create()
> +{
> +	ip link add dev br0 type bridge vlan_filtering 1
> +
> +	ip link set dev $swp1 master br0
> +	ip link set dev $swp2 master br0
> +
> +	ip link set dev br0 up
> +	ip link set dev $swp1 up
> +	ip link set dev $swp2 up
> +
> +	tc qdisc add dev $swp2 clsact
> +}
> +
> +switch_destroy()
> +{
> +	tc qdisc del dev $swp2 clsact
> +
> +	ip link set dev $swp2 down
> +	ip link set dev $swp1 down
> +
> +	ip link del dev br0
> +}
> +
> +setup_prepare()
> +{
> +	h1=${NETIFS[p1]}
> +	swp1=${NETIFS[p2]}
> +	h2=${NETIFS[p3]}
> +	swp2=${NETIFS[p4]}
> +
> +	vrf_prepare
> +
> +	h1_create
> +	h2_create
> +
> +	switch_create
> +}
> +
> +cleanup()
> +{
> +	pre_cleanup
> +
> +	switch_destroy
> +
> +	h2_destroy
> +	h1_destroy
> +
> +	vrf_cleanup
> +}
> +
> +# Check that there is no egress with blackhole entry and that blackhole entries can be replaced

Wrap this to 80 columns:

# Check that there is no egress with blackhole entry and that blackhole entries
# can be replaced.

> +blackhole_fdb()
> +{
> +	RET=0
> +
> +	check_blackhole_fdb_support || return 0
> +
> +	tc filter add dev $swp2 egress protocol ip pref 1 handle 1 flower \
> +		dst_ip 192.0.2.2 ip_proto udp dst_port 12345 action pass
> +
> +	$MZ $h1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
> +		-a own -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
> +
> +	tc_check_packets "dev $swp2 egress" 1 1
> +	check_err $? "Packet not seen on egress before adding blackhole entry"
> +
> +	bridge fdb replace `mac_get $h2` dev br0 blackhole

vlan 1

> +	bridge fdb get `mac_get $h2` br br0 | grep -q blackhole

vlan 1

> +	check_err $? "Blackhole entry not found"
> +
> +	$MZ $h1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
> +		-a own -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
> +
> +	tc_check_packets "dev $swp2 egress" 1 1
> +	check_err $? "Packet seen on egress after adding blackhole entry"
> +
> +	# Check blackhole entries can be replaced.
> +	bridge fdb replace `mac_get $h2` dev $swp2 master static

vlan 1

> +	bridge fdb get `mac_get $h2` br br0 | grep -q blackhole

vlan 1

> +	check_fail $? "Blackhole entry found after replacement"
> +
> +	$MZ $h1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
> +		-a own -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
> +
> +	tc_check_packets "dev $swp2 egress" 1 2
> +	check_err $? "Packet not seen on egress after replacing blackhole entry"
> +
> +	bridge fdb del `mac_get $h2` dev $swp2 master static

vlan 1

> +	tc filter del dev $swp2 egress protocol ip pref 1 handle 1 flower
> +
> +	log_test "Blackhole FDB entry"
> +}

Tested with veth pairs. Looks OK to me.
