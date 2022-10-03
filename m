Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF65360C26
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A8AB60C24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th8FObEzykbe5usYHZ75+799LggMLqSPlhxMxSx2G5o=;
 b=YMcNt79x6PPHwbfdFdevaN6Ykik13X/URi8+OPRMhWajMZJIQgi2sSAgvOWYVX3Hb2Vb8gRnWxprWDaKglcbM1vf+w6aBlRT0HdyUK+36aSt/K9udDlHRsdd/8XHi9NB4S/H+uXhBrSppSNPg8s5Zc9wfWdvk7v8WYiqfx2EBx7esPc6azlSxHkzKJu3VsjE7F7kPccVUdNSkCDOV1fESauboaJoYZEw+wdiHMdg9mhjWA6JZc/Wvx8RvJ1QdtMgqA0Pl0EYeWDxxJ9KecKVewMERFrp+QwFNVBGiI0BG417nlRbEvdT9rbO++ReaF0sHlt6IRXCnmbUVS129Y90cA==
Date: Mon, 3 Oct 2022 16:40:58 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YzrmaixRZ3k/alPh@shredder>
References: <20220928150256.115248-1-netdev@kapio-technology.com>
 <20220928150256.115248-10-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928150256.115248-10-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v6 net-next 9/9] selftests: forwarding: add
 test of MAC-Auth Bypass to locked port tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Wed, Sep 28, 2022 at 05:02:56PM +0200, Hans Schultz wrote:
> From: "Hans J. Schultz" <netdev@kapio-technology.com>
> 
> Verify that the MAC-Auth mechanism works by adding a FDB entry with the
> locked flag set, denying access until the FDB entry is replaced with a
> FDB entry without the locked flag set.
> 
> Add test of blackhole fdb entries, verifying that there is no forwarding
> to a blackhole entry from any port, and that the blackhole entry can be
> replaced.
> 
> Also add a test that verifies that sticky FDB entries cannot roam (this
> is not needed for now, but should in general be present anyhow for future
> applications).

The sticky selftests are not related to this set and need to be posted
separately.

> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> ---
>  .../net/forwarding/bridge_blackhole_fdb.sh    | 102 +++++++++++++++++
>  .../net/forwarding/bridge_locked_port.sh      | 106 +++++++++++++++++-
>  .../net/forwarding/bridge_sticky_fdb.sh       |  21 +++-
>  tools/testing/selftests/net/forwarding/lib.sh |  18 +++
>  4 files changed, 245 insertions(+), 2 deletions(-)
>  create mode 100755 tools/testing/selftests/net/forwarding/bridge_blackhole_fdb.sh
> 
> diff --git a/tools/testing/selftests/net/forwarding/bridge_blackhole_fdb.sh b/tools/testing/selftests/net/forwarding/bridge_blackhole_fdb.sh
> new file mode 100755
> index 000000000000..54b1a51e1ed6
> --- /dev/null
> +++ b/tools/testing/selftests/net/forwarding/bridge_blackhole_fdb.sh
> @@ -0,0 +1,102 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ALL_TESTS="blackhole_fdb"
> +NUM_NETIFS=4
> +source lib.sh
> +
> +switch_create()
> +{
> +        ip link add dev br0 type bridge
> +
> +        ip link set dev $swp1 master br0
> +        ip link set dev $swp2 master br0
> +
> +        ip link set dev br0 up
> +        ip link set dev $h1 up
> +        ip link set dev $swp1 up
> +        ip link set dev $h2 up
> +        ip link set dev $swp2 up
> +
> +	tc qdisc add dev $swp2 clsact

There are indentation problems in this file. The coding style is to
indent using tabs that are 8 characters deep, not spaces.

> +}

This is not how the selftests are usually constructed. We have
h1_create(), h2_create() and switch_create() and the hosts use VRFs via
simple_if_init(). Look at bridge_locked_port.sh, for example.

> +
> +switch_destroy()
> +{
> +	tc qdisc del dev $swp2 clsact
> +
> +        ip link set dev $swp2 down
> +        ip link set dev $h2 down
> +        ip link set dev $swp1 down
> +        ip link set dev $h1 down
> +
> +        ip link del dev br0
> +}
> +
> +setup_prepare()
> +{
> +        h1=${NETIFS[p1]}
> +        swp1=${NETIFS[p2]}
> +        h2=${NETIFS[p3]}
> +        swp2=${NETIFS[p4]}
> +
> +        switch_create
> +}
> +
> +cleanup()
> +{
> +        pre_cleanup
> +        switch_destroy
> +}
> +
> +# Check that there is no egress with blackhole entry and that blackhole entries can be replaced
> +blackhole_fdb()
> +{
> +        RET=0
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
> +	bridge fdb add `mac_get $h2` dev br0 blackhole
> +	bridge fdb get `mac_get $h2` br br0 | grep -q blackhole
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
> +	bridge fdb get `mac_get $h2` br br0 | grep -q blackhole
> +	check_fail $? "Blackhole entry found after replacement"
> +
> +	$MZ $h1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
> +		-a own -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
> +
> +	tc_check_packets "dev $swp2 egress" 1 2
> +	check_err $? "Packet not seen on egress after replacing blackhole entry"
> +
> +	bridge fdb del `mac_get $h2` dev $swp2 master static
> +	tc filter del dev $swp2 egress protocol ip pref 1 handle 1 flower
> +
> +        log_test "Blackhole FDB entry"
> +}
> +
> +trap cleanup EXIT
> +
> +setup_prepare
> +setup_wait
> +
> +tests_run
> +
> +exit $EXIT_STATUS
> diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
> index 5b02b6b60ce7..59b8b7666eab 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
> @@ -1,7 +1,15 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> -ALL_TESTS="locked_port_ipv4 locked_port_ipv6 locked_port_vlan"
> +ALL_TESTS="
> +	locked_port_ipv4
> +	locked_port_ipv6
> +	locked_port_vlan
> +	locked_port_mab
> +	locked_port_station_move
> +	locked_port_mab_station_move
> +"
> +
>  NUM_NETIFS=4
>  CHECK_TC="no"
>  source lib.sh
> @@ -166,6 +174,102 @@ locked_port_ipv6()
>  	log_test "Locked port ipv6"
>  }
>  
> +locked_port_mab()
> +{
> +	RET=0
> +	check_locked_port_support || return 0
> +
> +	ping_do $h1 192.0.2.2
> +	check_err $? "MAB: Ping did not work before locking port"
> +
> +	bridge link set dev $swp1 locked on
> +	check_port_mab_support $swp1 || return 0

Move this check to the beginning of the test and instead do:

bridge link set dev $swp1 locked on mab on

See the comment at the end regarding check_port_mab_support()

> +
> +	ping_do $h1 192.0.2.2
> +	check_fail $? "MAB: Ping worked on locked port without FDB entry"
> +
> +	bridge fdb show | grep `mac_get $h1` | grep -q "locked"

Use "bridge fdb get" like in the blackhole test instead of dumping the
entire FDB.

> +	check_err $? "MAB: No locked fdb entry after ping on locked port"
> +
> +	bridge fdb replace `mac_get $h1` dev $swp1 master static
> +
> +	ping_do $h1 192.0.2.2
> +	check_err $? "MAB: Ping did not work with fdb entry without locked flag"
> +
> +	bridge fdb del `mac_get $h1` dev $swp1 master
> +	bridge link set dev $swp1 locked off mab off
> +
> +	log_test "Locked port MAB"
> +}
> +
> +# No roaming allowed to a simple locked port

# Check that entries cannot roam from an unlocked port to a locked port.

> +locked_port_station_move()
> +{
> +	local mac=a0:b0:c0:c0:b0:a0
> +
> +	RET=0
> +	check_locked_port_support || return 0
> +
> +	bridge link set dev $swp1 locked on

It is quite pointless to check that an entry cannot roam to a port that
has learning disabled... Need:

bridge link set dev $swp1 locked on learning on

> +
> +	$MZ $h1 -q -t udp -a $mac -b rand
> +	bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "master br0"

bridge fdb get ...

Same in other places

> +	check_fail $? "Locked port station move: FDB entry on first injection"
> +
> +	$MZ $h2 -q -t udp -a $mac -b rand
> +	bridge fdb show dev $swp2 | grep "$mac vlan 1" | grep -q "master br0"
> +	check_err $? "Locked port station move: Entry not found on unlocked port"
> +
> +	$MZ $h1 -q -t udp -a $mac -b rand
> +	bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "master br0"
> +	check_fail $? "Locked port station move: entry roamed to locked port"
> +
> +	bridge link set dev $swp1 locked off

bridge link set dev $swp1 locked off learning off

And need to delete the FDB entry pointing to $swp2

> +
> +	log_test "Locked port station move"
> +}
> +
> +# Roaming to and from a MAB enabled port should work if sticky flag is not set

# Check that entries can roam from a locked port to an unlocked port.

> +locked_port_mab_station_move()
> +{
> +	local mac=10:20:30:30:20:10
> +
> +	RET=0
> +	check_locked_port_support || return 0
> +
> +	bridge link set dev $swp1 locked on
> +
> +	check_port_mab_support $swp1 || return 0

Move to the beginning of the test

> +
> +	$MZ $h1 -q -t udp -a $mac -b rand

# Some device drivers report locked entries to the bridge driver as
# permanent entries that cannot roam. In such cases there is no point in
# checking that locked entries can roam to an unlocked port.

> +	if bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "permanent"; then
> +		echo "SKIP: Roaming not possible with local flag, skipping test..."
> +		bridge link set dev $swp1 locked off mab off
> +		return $ksft_skip
> +	fi
> +
> +	bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "locked"
> +	check_err $? "MAB station move: no locked entry on first injection"
> +
> +	$MZ $h2 -q -t udp -a $mac -b rand
> +	bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "locked"
> +	check_fail $? "MAB station move: locked entry did not move"
> +
> +	bridge fdb show dev $swp2 | grep "$mac vlan 1" | grep -q "locked"
> +	check_fail $? "MAB station move: roamed entry to unlocked port had locked flag on"
> +
> +	bridge fdb show dev $swp2 | grep "$mac vlan 1" | grep -q "master br0"
> +	check_err $? "MAB station move: roamed entry not found"

First check that the entry roamed to $swp2 using "bridge fdb get", then
check that the locked flag is not set on it.

> +
> +	$MZ $h1 -q -t udp -a $mac -b rand
> +	bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep "master br0" | grep -q "locked"
> +	check_fail $? "MAB station move: entry roamed back to locked port"

This was already checked in locked_port_station_move()

> +

Need to delete the FBD entry from $swp2.

> +	bridge link set dev $swp1 locked off mab off
> +
> +	log_test "Locked port MAB station move"
> +}
> +
>  trap cleanup EXIT

[...]

> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 3ffb9d6c0950..642fbf217c20 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -137,6 +137,24 @@ check_locked_port_support()
>  	fi
>  }
>  
> +check_port_mab_support()
> +{
> +	local dev=$1;

Why this helper needs a device, but check_locked_port_support() does
not? Please change this helper to work like check_locked_port_support().

> +
> +	if ! bridge link set dev $dev mab on 2>/dev/null; then
> +		echo "SKIP: iproute2 too old; MacAuth feature not supported."
> +		return $ksft_skip
> +	fi
> +}
