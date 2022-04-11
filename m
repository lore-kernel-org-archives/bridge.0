Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me/DTbVXSoG9I1ySybG/TGZIhn1pLx4AssvjQjthykA=;
 b=Et9FvgNdek52Enh4mbIUXsdfJYPKvnsocpOkDjVepmNHcCA+a7kmwrd1R6iHS5QYITl1o6RH6tZGYcjd2dYLlgQAmFF4V7Rwc/ImiLdhlMIa13vfF1rpcpOT7/j+p37NVu5sf6OOb29Y7QYR3yHXvGHfgF3+IOZX23O/tMt274E=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 11 Apr 2022 20:21:29 +0000
Message-ID: <20220411202128.n4dafks4mnkbzr2k@skbuf>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-8-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-8-troglobit@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD442BD49C678D4FA5239A49D0B4FA49@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH RFC net-next 07/13] selftests: forwarding: new
 test, verify bridge flood flags
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joachim Wiberg <troglobit@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Apr 11, 2022 at 03:38:31PM +0200, Joachim Wiberg wrote:
> Test per-port flood control flags of unknown BUM traffic by injecting
> bc/uc/mc on one bridge port and verifying it being forwarded to both
> the bridge itself and another regular bridge port.
>=20
> Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
> ---
>  .../testing/selftests/net/forwarding/Makefile |   3 +-
>  .../selftests/net/forwarding/bridge_flood.sh  | 170 ++++++++++++++++++
>  2 files changed, 172 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/net/forwarding/bridge_flood.s=
h
>=20
> diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/test=
ing/selftests/net/forwarding/Makefile
> index ae80c2aef577..873fa61d1ee1 100644
> --- a/tools/testing/selftests/net/forwarding/Makefile
> +++ b/tools/testing/selftests/net/forwarding/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
> =20
> -TEST_PROGS =3D bridge_igmp.sh \
> +TEST_PROGS =3D bridge_flood.sh \
> +	bridge_igmp.sh \
>  	bridge_locked_port.sh \
>  	bridge_mdb.sh \
>  	bridge_port_isolation.sh \
> diff --git a/tools/testing/selftests/net/forwarding/bridge_flood.sh b/too=
ls/testing/selftests/net/forwarding/bridge_flood.sh
> new file mode 100755
> index 000000000000..1966c960d705
> --- /dev/null
> +++ b/tools/testing/selftests/net/forwarding/bridge_flood.sh
> @@ -0,0 +1,170 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Verify per-port flood control flags of unknown BUM traffic.
> +#
> +#                     br0
> +#                    /   \
> +#                  h1     h2

I think the picture is slightly inaccurate. From it I understand that h1
and h2 are bridge ports, but they are stations attached to the real
bridge ports, swp1 and swp2. Maybe it would be good to draw all interfaces.

> +#
> +# We inject bc/uc/mc on h1, toggle the three flood flags for
> +# both br0 and h2, then verify that traffic is flooded as per
> +# the flags, and nowhere else.
> +#
> +#set -x

stray debug line

> +
> +ALL_TESTS=3D"br_flood_unknown_bc_test br_flood_unknown_uc_test br_flood_=
unknown_mc_test"
> +NUM_NETIFS=3D4
> +
> +SRC_MAC=3D"00:de:ad:be:ef:00"
> +GRP_IP4=3D"225.1.2.3"
> +GRP_MAC=3D"01:00:01:c0:ff:ee"
> +GRP_IP6=3D"ff02::42"
> +
> +BC_PKT=3D"ff:ff:ff:ff:ff:ff $SRC_MAC 00:04 48:45:4c:4f"

HELO to you too

> +UC_PKT=3D"02:00:01:c0:ff:ee $SRC_MAC 00:04 48:45:4c:4f"
> +MC_PKT=3D"01:00:5e:01:02:03 $SRC_MAC 08:00 45:00 00:20 c2:10 00:00 ff 11=
 12:b2 01:02:03:04 e1:01:02:03 04:d2 10:e1 00:0c 6e:84 48:45:4c:4f"
> +
> +# Disable promisc to ensure we only receive flooded frames
> +export TCPDUMP_EXTRA_FLAGS=3D"-pl"

Exporting should be required only for sub-shells, doesn't apply when you
source a script.

> +
> +source lib.sh
> +
> +h1=3D${NETIFS[p1]}
> +h2=3D${NETIFS[p3]}
> +swp1=3D${NETIFS[p2]}
> +swp2=3D${NETIFS[p4]}
> +
> +#
> +# Port mappings and flood flag pattern to set/detect
> +#
> +declare -A ports=3D([br0]=3Dbr0 [$swp1]=3D$h1 [$swp2]=3D$h2)

Maybe you could populate the "ports" and the "flagN" arrays in the same
order, i.e. bridge first for all?

Also, to be honest, a generic name like "ports" is hard to digest,
especially since you have another generic variable name "iface".
Maybe "brports" and "station" is a little bit more specific?

> +declare -A flag1=3D([$swp1]=3Doff [$swp2]=3Doff [br0]=3Doff)
> +declare -A flag2=3D([$swp1]=3Doff [$swp2]=3Don  [br0]=3Doff)
> +declare -A flag3=3D([$swp1]=3Doff [$swp2]=3Don  [br0]=3Don )
> +declare -A flag4=3D([$swp1]=3Doff [$swp2]=3Doff [br0]=3Don )

If it's not too much, maybe these could be called "flags_pass1", etc.
Again, it was a bit hard to digest on first read.

> +
> +switch_create()
> +{
> +	ip link add dev br0 type bridge
> +
> +	for port in ${!ports[@]}; do
> +		[ "$port" !=3D "br0" ] && ip link set dev $port master br0
> +		ip link set dev $port up
> +	done
> +}
> +
> +switch_destroy()
> +{
> +	for port in ${!ports[@]}; do
> +		ip link set dev $port down
> +	done
> +	ip link del dev br0
> +}
> +
> +setup_prepare()
> +{
> +	vrf_prepare
> +
> +	let i=3D1
> +	for iface in ${ports[@]}; do
> +		[ "$iface" =3D "br0" ] && continue
> +		simple_if_init $iface 192.0.2.$i/24 2001:db8:1::$i/64
> +		let i=3D$((i + 1))
> +	done
> +
> +	switch_create
> +}
> +
> +cleanup()
> +{
> +	pre_cleanup
> +	switch_destroy
> +
> +	let i=3D1
> +	for iface in ${ports[@]}; do
> +		[ "$iface" =3D "br0" ] && continue
> +		simple_if_fini $iface 192.0.2.$i/24 2001:db8:1::$i/64
> +		let i=3D$((i + 1))
> +	done
> +
> +	vrf_cleanup
> +}
> +
> +do_flood_unknown()
> +{
> +	local type=3D$1
> +	local pass=3D$2
> +	local flag=3D$3
> +	local pkt=3D$4
> +	local -n flags=3D$5

I find it slightly less confusing if "flag" and "flags" are next to each
other in the parameter list, since they're related.

> +
> +	RET=3D0
> +	for port in ${!ports[@]}; do
> +		if [ "$port" =3D "br0" ]; then
> +			self=3D"self"
> +		else
> +			self=3D""
> +		fi
> +		bridge link set dev $port $flag ${flags[$port]} $self
> +		check_err $? "Failed setting $port $flag ${flags[$port]}"
> +	done
> +
> +	for iface in ${ports[@]}; do
> +		tcpdump_start $iface
> +	done
> +
> +	$MZ -q $h1 "$pkt"
> +	sleep 1
> +
> +	for iface in ${ports[@]}; do
> +		tcpdump_stop $iface
> +	done
> +
> +	for port in ${!ports[@]}; do
> +		iface=3D${ports[$port]}
> +
> +#		echo "Dumping PCAP from $iface, expecting ${flags[$port]}:"
> +#		tcpdump_show $iface

Do something about the commented lines.

> +		tcpdump_show $iface |grep -q "$SRC_MAC"

Space between pipe and grep.

> +		rc=3D$?
> +
> +		check_err_fail "${flags[$port]} =3D on"  $? "failed flooding from $h1 =
to port $port"

I think the "failed" word here is superfluous, since check_err_fail
already says "$what succeeded, but should have failed".

> +		check_err_fail "${flags[$port]} =3D off" $? "flooding from $h1 to port=
 $port"
> +	done
> +
> +	log_test "flood unknown $type pass $pass/4"
> +}
> +
> +br_flood_unknown_bc_test()
> +{
> +	do_flood_unknown BC 1 bcast_flood "$BC_PKT" flag1
> +	do_flood_unknown BC 2 bcast_flood "$BC_PKT" flag2
> +	do_flood_unknown BC 3 bcast_flood "$BC_PKT" flag3
> +	do_flood_unknown BC 4 bcast_flood "$BC_PKT" flag4
> +}
> +
> +br_flood_unknown_uc_test()
> +{
> +	do_flood_unknown UC 1 flood "$UC_PKT" flag1
> +	do_flood_unknown UC 2 flood "$UC_PKT" flag2
> +	do_flood_unknown UC 3 flood "$UC_PKT" flag3
> +	do_flood_unknown UC 4 flood "$UC_PKT" flag4
> +}
> +
> +br_flood_unknown_mc_test()
> +{
> +	do_flood_unknown MC 1 mcast_flood "$MC_PKT" flag1
> +	do_flood_unknown MC 2 mcast_flood "$MC_PKT" flag2
> +	do_flood_unknown MC 3 mcast_flood "$MC_PKT" flag3
> +	do_flood_unknown MC 4 mcast_flood "$MC_PKT" flag4
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
> --=20
> 2.25.1
>=
