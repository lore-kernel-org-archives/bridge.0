Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C8F99410C1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 530DF409E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qydGxQSqpZ6GetVPeC2IuOqyVuL9vwfb0MkvjQX6/g=;
 b=t2FHPb3/P0xuvz4ENKTVu9EvOnvjwZ6nOFux7hdyD3HXjO85+haQoWAYWtVbvvFx8n8r3FX+9Ck2o0WxEfDdKHsIUgaXAS0tZRGI7pq64bEbRFro8264/gB9fHP64KBqGHHPEiiPNfiOmRvxG0TmHAY2nvEHRA68RsDxLpu1WgbEMY8h1okJTi4k/HnI4dfGCzGDMg4CbxSuqoJdjz5GJKpQ4FnGYzvFrh+DwvOIbSbWmjauKsb+DL1HIY3q5pHXqZuW77+1FIEyvVDklebJgQ4Wm2ZfwzOgE/GalFQc2Y56FV/O8MM/P8ogQRiFgZIf0dFlDybRvDvx9S2EHPbXsw==
Date: Sat, 27 Aug 2022 21:21:50 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YwpgvkojEdytzCAB@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-7-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826114538.705433-7-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v5 net-next 6/6] selftests: forwarding: add
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
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Fri, Aug 26, 2022 at 01:45:38PM +0200, Hans Schultz wrote:
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
> @@ -166,6 +174,103 @@ locked_port_ipv6()
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
> +	bridge link set dev $swp1 learning on

"locked on learning on" is counter intuitive and IMO very much a
misconfiguration that we should have disallowed when the "locked" option
was introduced. It is my understanding that the only reason we are even
talking about it is because mv88e6xxx needs it for MAB for some reason.
Please avoid leaking this implementation detail to user space and
instead use the "MAB" flag to enable learning if you need it in
mv88e6xxx.

> +	if ! bridge link set dev $swp1 mab on 2>/dev/null; then
> +		echo "SKIP: iproute2 too old; MacAuth feature not supported."
> +		return $ksft_skip
> +	fi

Please add a similar function to check_locked_port_support() and invoke
it next to it.

> +
> +	ping_do $h1 192.0.2.2
> +	check_fail $? "MAB: Ping worked on locked port without FDB entry"
> +
> +	bridge fdb show | grep `mac_get $h1` | grep -q "locked"
> +	check_err $? "MAB: No locked fdb entry after ping on locked port"
> +
> +	bridge fdb replace `mac_get $h1` dev $swp1 master static
> +
> +	ping_do $h1 192.0.2.2
> +	check_err $? "MAB: Ping did not work with fdb entry without locked flag"
> +
> +	bridge fdb del `mac_get $h1` dev $swp1 master

Missing:

bridge link set dev $swp1 mab off

> +	bridge link set dev $swp1 learning off

Can be removed assuming we get rid of "learning on" above.

> +	bridge link set dev $swp1 locked off
> +
> +	log_test "Locked port MAB"
> +}
> +
> +# No roaming allowed to a simple locked port
> +locked_port_station_move()
> +{
> +	local mac=a0:b0:c0:c0:b0:a0
> +
> +	RET=0
> +	check_locked_port_support || return 0
> +
> +	bridge link set dev $swp1 locked on
> +	bridge link set dev $swp1 learning on

Same comment as above. 

> +
> +	$MZ $h1 -q -t udp -a $mac -b rand
> +	bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0"
> +	check_fail $? "Locked port station move: FDB entry on first injection"
> +
> +	$MZ $h2 -q -t udp -a $mac -b rand
> +	bridge fdb show dev $swp2 | grep -q "$mac vlan 1 master br0"
> +	check_err $? "Locked port station move: Entry not found on unlocked port"

Looks like this is going to fail with offloaded data path as according
to fdb_print_flags() in iproute2 both the "extern_learn" and "offload"
flags will be printed before "master".

I suggest using "bridge fdb get" instead (didn't test, might need small
tweaks, but you will figure it):

bridge fdb get $mac br br0 vlan 1 master 2> /dev/null | grep -q "$swp2"

Same in other places where "bridge fdb show" is used.

> +
> +	$MZ $h1 -q -t udp -a $mac -b rand
> +	bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0"
> +	check_fail $? "Locked port station move: entry roamed to locked port"

Missing:

bridge link set dev $swp1 locked off
bridge fdb del $mac dev $swp1 master vlan 1

> +
> +	log_test "Locked port station move"
> +}
> +
> +# Roaming to and from a MAB enabled port should work if sticky flag is not set
> +locked_port_mab_station_move()
> +{
> +	local mac=10:20:30:30:20:10
> +
> +	RET=0
> +	check_locked_port_support || return 0
> +
> +	bridge link set dev $swp1 locked on
> +	bridge link set dev $swp1 learning on

Same comment as above.

> +	if ! bridge link set dev $swp1 mab on 2>/dev/null; then

Same comment as above.

> +		echo "SKIP: iproute2 too old; MacAuth feature not supported."
> +		return $ksft_skip
> +	fi
> +
> +	$MZ $h1 -q -t udp -a $mac -b rand
> +	if bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0" | grep -q sticky; then

Will need to change to "permanent" instead of "sticky".

> +		echo "SKIP: Roaming not possible with sticky flag, run sticky flag roaming test"
> +		return $ksft_skip

Missing cleanup before the return.

> +	fi
> +
> +	bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0 locked"
> +	check_err $? "MAB station move: no locked entry on first injection"
> +
> +	$MZ $h2 -q -t udp -a $mac -b rand
> +	bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0 locked"
> +	check_fail $? "MAB station move: locked entry did not move"
> +
> +	bridge fdb show dev $swp2 | grep -q "$mac vlan 1 master br0"

Need to check that it does not roam with the "locked" flag set.

> +	check_err $? "MAB station move: roamed entry not found"
> +
> +	$MZ $h1 -q -t udp -a $mac -b rand
> +	bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0 locked"
> +	check_err $? "MAB station move: entry did not roam back to locked port"

This will need to change to "check_fail" assuming we don't allow roaming
from an authorized port to an unauthorized port, which I believe makes
sense.

> +

Missing cleanup.

> +	log_test "Locked port MAB station move"
> +}
> +
>  trap cleanup EXIT
>  
>  setup_prepare
