Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78F0E418E8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 683934184E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtPFgGKxKZx2Ih8XPr6rK00BO17m4sAboKSqoMuysPc=;
 b=j3jO9JEPiWVG99AbG4RO3rB86jaqZFqH45qMPdCRE1Ma4jdDLh/yeGZhYcJ/kha13aU2LzIFoUwHohLY3wkQB2Onk1MVdgMnSCG897RssDvc43h0RrRoifapgobtBgOOZXgVKxVX+YBdUWQWb2GOSzmmvY0vWt7MxiWfGT/fCEy6qc3WH4Oc6ra3+i7d0T+tpau2FPuyj0iTBqT16GxtIZCi5JJxSdsMumMigIxSI8KJHzY7RqOwafJHeZPCz8s0v16Pu5nreCjEJ6KTHuGTHJZAMQIfgHeuDknNVQJaAb39RvDNmMONFOzAUAYNVcgdkSFTfqKMV9VkjhIvxXPxHA==
Date: Thu, 13 Oct 2022 15:06:07 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y0f/L9IT6dbwlZAg@shredder>
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
> +locked_port_mab()
> +{
> +	RET=0
> +	check_port_mab_support || return 0
> +
> +	ping_do $h1 192.0.2.2
> +	check_err $? "MAB: Ping did not work before locking port"
> +
> +	bridge link set dev $swp1 locked on mab on
> +
> +	ping_do $h1 192.0.2.2
> +	check_fail $? "MAB: Ping worked on mab enabled port without FDB entry"
> +
> +	bridge fdb get `mac_get $h1` vlan 1 dev $swp1 | grep "dev $swp1 vlan 1" | grep -q "locked"
> +	check_err $? "MAB: No locked FDB entry after ping on mab enabled port"
> +
> +	bridge fdb replace `mac_get $h1` dev $swp1 master static
> +
> +	ping_do $h1 192.0.2.2
> +	check_err $? "MAB: Ping did not work with FDB entry without locked flag"
> +
> +	bridge fdb del `mac_get $h1` dev $swp1 master
> +	bridge link set dev $swp1 locked off mab off
> +
> +	log_test "Locked port MAB"
> +}
> +
> +# Check that entries cannot roam from an unlocked port to a locked port.
> +locked_port_station_move()
> +{
> +	local mac=a0:b0:c0:c0:b0:a0
> +
> +	RET=0
> +	check_locked_port_support || return 0
> +
> +	bridge link set dev $swp1 locked on learning on
> +
> +	$MZ $h1 -q -c 5 -d 100msec -t udp -a $mac -b rand
> +	bridge fdb show dev $swp1 | grep -q $mac
> +	check_fail $? "Locked port station move: FDB entry on first injection"
> +
> +	$MZ $h2 -q -c 5 -d 100msec -t udp -a $mac -b rand
> +	bridge fdb get $mac vlan 1 dev $swp2 | grep "dev $swp2 vlan 1" | grep -q "master br0"
> +	check_err $? "Locked port station move: Entry not found on unlocked port"
> +
> +	$MZ $h1 -q -c 5 -d 100msec -t udp -a $mac -b rand
> +	bridge fdb get $mac vlan 1 dev $swp1 | grep "dev $swp1 vlan 1" | grep -q "master br0"
> +	check_fail $? "Locked port station move: entry roamed to locked port"
> +
> +	bridge fdb del $mac vlan 1 dev $swp2 master
> +	bridge link set dev $swp1 locked off learning off
> +
> +	log_test "Locked port station move"
> +}
> +
> +# Roaming to and from a MAB enabled port should work if blackhole flag is not set
> +locked_port_mab_station_move()
> +{
> +	local mac=10:20:30:30:20:10
> +
> +	RET=0
> +	check_port_mab_support || return 0
> +
> +	bridge link set dev $swp1 locked on mab on
> +
> +	$MZ $h1 -q -c 5 -d 100 mesc -t udp -a $mac -b rand
> +	if bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "blackhole"; then
> +		echo "SKIP: Roaming not possible with blackhole flag, skipping test..."
> +		bridge link set dev $swp1 locked off mab off
> +		return $ksft_skip
> +	fi
> +
> +	bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "locked"
> +	check_err $? "MAB station move: no locked entry on first injection"
> +
> +	$MZ $h2 -q -c 5 -d 100msec -t udp -a $mac -b rand
> +	bridge fdb get $mac vlan 1 dev $swp1 | grep "dev $swp1 vlan 1" | grep -q "locked"
> +	check_fail $? "MAB station move: locked entry did not move"
> +
> +	bridge fdb get $mac vlan 1 dev $swp2 | grep "dev $swp2 vlan 1" | grep -q "locked"
> +	check_fail $? "MAB station move: roamed entry to unlocked port had locked flag on"
> +
> +	bridge fdb get $mac vlan 1 dev $swp2 | grep "dev $swp2 vlan 1" | grep -q "master br0"
> +	check_err $? "MAB station move: roamed entry not found"
> +
> +	bridge fdb del $mac vlan 1 dev $swp2 master
> +	bridge link set dev $swp1 locked off mab off
> +
> +	log_test "Locked port MAB station move"
> +}

Looks OK to me. I made some change to make sure we are using "bridge fdb
get" in a consistent manner instead of relying on iproute2 dump output
too much. Please consider including them in the next version.

FYI, I ran your version and mine with veth pairs and both are OK.

diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
index fbe558f25e44..f0bc0bcbc246 100755
--- a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
@@ -187,7 +187,7 @@ locked_port_mab()
 	ping_do $h1 192.0.2.2
 	check_fail $? "MAB: Ping worked on mab enabled port without FDB entry"
 
-	bridge fdb get `mac_get $h1` vlan 1 dev $swp1 | grep "dev $swp1 vlan 1" | grep -q "locked"
+	bridge fdb get `mac_get $h1` br br0 vlan 1 | grep "dev $swp1" | grep -q "locked"
 	check_err $? "MAB: No locked FDB entry after ping on mab enabled port"
 
 	bridge fdb replace `mac_get $h1` dev $swp1 master static
@@ -212,15 +212,15 @@ locked_port_station_move()
 	bridge link set dev $swp1 locked on learning on
 
 	$MZ $h1 -q -c 5 -d 100msec -t udp -a $mac -b rand
-	bridge fdb show dev $swp1 | grep -q $mac
+	bridge fdb get $mac br br0 vlan 1 &> /dev/null
 	check_fail $? "Locked port station move: FDB entry on first injection"
 
 	$MZ $h2 -q -c 5 -d 100msec -t udp -a $mac -b rand
-	bridge fdb get $mac vlan 1 dev $swp2 | grep "dev $swp2 vlan 1" | grep -q "master br0"
+	bridge fdb get $mac br br0 vlan 1 | grep -q "dev $swp2"
 	check_err $? "Locked port station move: Entry not found on unlocked port"
 
 	$MZ $h1 -q -c 5 -d 100msec -t udp -a $mac -b rand
-	bridge fdb get $mac vlan 1 dev $swp1 | grep "dev $swp1 vlan 1" | grep -q "master br0"
+	bridge fdb get $mac br br0 vlan 1 | grep -q "dev $swp1"
 	check_fail $? "Locked port station move: entry roamed to locked port"
 
 	bridge fdb del $mac vlan 1 dev $swp2 master
@@ -229,7 +229,8 @@ locked_port_station_move()
 	log_test "Locked port station move"
 }
 
-# Roaming to and from a MAB enabled port should work if blackhole flag is not set
+# Check that entries can roam from a locked port if blackhole FDB flag is not
+# set.
 locked_port_mab_station_move()
 {
 	local mac=10:20:30:30:20:10
@@ -246,19 +247,16 @@ locked_port_mab_station_move()
 		return $ksft_skip
 	fi
 
-	bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "locked"
+	bridge fdb get $mac br br0 vlan 1 | grep "dev $swp1" | grep -q "locked"
 	check_err $? "MAB station move: no locked entry on first injection"
 
 	$MZ $h2 -q -c 5 -d 100msec -t udp -a $mac -b rand
-	bridge fdb get $mac vlan 1 dev $swp1 | grep "dev $swp1 vlan 1" | grep -q "locked"
-	check_fail $? "MAB station move: locked entry did not move"
+	bridge fdb get $mac br br0 vlan 1 | grep -q "dev $swp2"
+	check_err $? "MAB station move: roamed entry not found"
 
-	bridge fdb get $mac vlan 1 dev $swp2 | grep "dev $swp2 vlan 1" | grep -q "locked"
+	bridge fdb get $mac br br0 vlan 1 | grep -q "locked"
 	check_fail $? "MAB station move: roamed entry to unlocked port had locked flag on"
 
-	bridge fdb get $mac vlan 1 dev $swp2 | grep "dev $swp2 vlan 1" | grep -q "master br0"
-	check_err $? "MAB station move: roamed entry not found"
-
 	bridge fdb del $mac vlan 1 dev $swp2 master
 	bridge link set dev $swp1 locked off mab off
