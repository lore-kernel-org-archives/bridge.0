Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D114813FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DD4C813FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNHsRfmOCpTOUJJ3RortJNyQmr3iYJrRJ6vNvwZYvpo=;
 b=o1xXadDApB5d05IJmgInzmpNSAxPLlNxGU+TfY4tfDsukX8TsB93whV5JKrwxXvwqJjzrzkbj3h3mX0wLurgbjvDZ/rm0Cq2dSseLGZ6VnqyzG4RQ0t1tnJ8HA/YdaV4B8EkkCfduyVvxOujvJsIsVTdjFQVc27vEB5zHBV+k7RsGajBT1H9zv9pCv68wNDWgmtyTbFReDY8qQSO/wJwXH2cSfyMthON12ztjvTvm6oNt5EtbVvUpoqUQTToymi/gxl0sAvJXquM/CUIprO+mLxkDssQ+N4+4CQSWoYjiAo4Y1hAy4HWsWKOYu84bCoJL7Sbv5H2bXA7mvfCu0Ztqw==
Date: Mon, 20 Mar 2023 10:44:50 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZBgdAo8mxwnl+pEE@shredder>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-7-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318141010.513424-7-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v2 net-next 6/6] selftests: forwarding: add
 dynamic FDB test
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Sat, Mar 18, 2023 at 03:10:10PM +0100, Hans J. Schultz wrote:
> +# Test of dynamic FDB entries.
> +locked_port_dyn_fdb()
> +{
> +	local mac=00:01:02:03:04:05
> +	local ageing_time
> +
> +	RET=0
> +	ageing_time=$(bridge_ageing_time_get br0)
> +	tc qdisc add dev $swp2 clsact
> +	ip link set dev br0 type bridge ageing_time $LOW_AGEING_TIME
> +	bridge link set dev $swp1 learning on locked on
> +
> +	bridge fdb replace $mac dev $swp1 master dynamic
> +	tc filter add dev $swp2 egress protocol ip pref 1 handle 1 flower \
> +		dst_ip 192.0.2.2 ip_proto udp dst_port 12345 action pass
> +
> +	$MZ $swp1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
> +		-a $mac -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q

Packets should be injected via $h1, not $swp1. See other test cases in
this file.

> +	tc_check_packets "dev $swp2 egress" 1 1
> +	check_err $? "Packet not seen on egress after adding dynamic FDB"

Does this actually work? The packet is transmitted via $swp1, I don't
understand how it can arrive at the egress of $swp2.

> +
> +	sleep $((LOW_AGEING_TIME / 100 + 10))
> +
> +	$MZ $swp1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
> +		-a $mac -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
> +	tc_check_packets "dev $swp2 egress" 1 1
> +	check_fail $? "Dynamic FDB entry did not age out"

Shouldn't this be check_err()? After the FDB entry was aged you want to
make sure that packets received via $swp1 with SMAC being $mac are no
longer forwarded by the bridge.

Also, I suggest executing 'bridge fdb get' to make sure the entry is no
longer present in the bridge FDB.

> +
> +	ip link set dev br0 type bridge ageing_time $ageing_time
> +	bridge link set dev $swp1 learning off locked off
> +	tc qdisc del dev $swp2 clsact
> +
> +	log_test "Locked port dyn FDB"
> +}
> +
>  trap cleanup EXIT
>  
>  setup_prepare
> -- 
> 2.34.1
> 
