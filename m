Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06E2982AF5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48ECA82907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw6682kc/DZV9ZI9Esqa7vHuDGcKIwUBWoAk25d563U=;
 b=NKyrNGGxT9N3Dnzr355DK6Ldr611OyyJ4mKMIlWAP+NKamVvhyp4vsaVk05bWPHblagfNTbAYtYsDzLfgplgTxI05uATQgOwipXBTXqACTKUkvPaqIHcgJoQt6JY+LrEGF4+AclVpyq2EpMun0ZFAeblcK14CUGDTYtk11rNroKOaYrkXWwvblPgxnh7HQFluXzbqP/+nnOK7QP76a45IbIy5kPoryiBTrLZK3igWEo7PksGod4nrZ4uYTDJYW93p6O3U3PehVx6a70b9GfCg1Ef0QSH1dddvUxtUn76Q8yJB28/upuSjaI3kFO7F8fOBHdVIkr8qtfO3qnw9ZUuCw==
Date: Wed, 21 Sep 2022 10:15:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Yyq6BnUfctLeerqE@shredder>
References: <YxNo/0+/Sbg9svid@shredder>
 <5cee059b65f6f7671e099150f9da79c1@kapio-technology.com>
 <Yxmgs7Du62V1zyjK@shredder>
 <8dfc9b525f084fa5ad55019f4418a35e@kapio-technology.com>
 <20220908112044.czjh3xkzb4r27ohq@skbuf>
 <152c0ceadefbd742331c340bec2f50c0@kapio-technology.com>
 <20220911001346.qno33l47i6nvgiwy@skbuf>
 <15ee472a68beca4a151118179da5e663@kapio-technology.com>
 <Yx73FOpN5uhPQhFl@shredder>
 <086704ce7f323cc1b3cca78670b42095@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086704ce7f323cc1b3cca78670b42095@kapio-technology.com>
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
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Tue, Sep 20, 2022 at 11:29:12PM +0200, netdev@kapio-technology.com wrote:
> I have made a blackhole selftest, which looks like this:
> 
> test_blackhole_fdb()
> {
>         RET=0
> 
>         check_blackhole_fdb_support || return 0
> 
>         tcpdump_start $h2
>         $MZ $h1 -q -t udp -a $h1 -b $h2

I don't think you can give an interface name to '-a' and '-b'?

>         tcpdump_stop
>         tcpdump_show | grep -q udp
>         check_err $? "test_blackhole_fdb: No packet seen on initial"
>         tcpdump_cleanup
> 
>         bridge fdb add `mac_get $h2` dev br0 blackhole
>         bridge fdb show dev br0 | grep -q "blackhole"

Make this grep more specific so that we are sure it is the entry user
space installed. Something like this:

bridge fdb get `mac_get $h2` br br0 | grep -q blackhole

>         check_err $? "test_blackhole_fdb: No blackhole FDB entry found"
> 
>         tcpdump_start $h2
>         $MZ $h1 -q -t udp -a $h1 -b $h2
>         tcpdump_stop
>         tcpdump_show | grep -q udp
>         check_fail $? "test_blackhole_fdb: packet seen with blackhole fdb
> entry"
>         tcpdump_cleanup

The tcpdump filter is not specific enough. It can catch other UDP
packets (e.g., multicast) being received by $h2. Anyway, to be sure the
feature works as expected we need to make sure that the packets are not
even egressing $swp2. Checking that they are not received by $h2 is not
enough. See this (untested) suggestion [1] that uses a tc filter on the
egress of $swp2.

> 
>         bridge fdb del `mac_get $h2` dev br0 blackhole
>         bridge fdb show dev br0 | grep -q "blackhole"
>         check_fail $? "test_blackhole_fdb: Blackhole FDB entry not deleted"
> 
>         tcpdump_start $h2
>         $MZ $h1 -q -t udp -a $h1 -b $h2
>         tcpdump_stop
>         tcpdump_show | grep -q udp
>         check_err $? "test_blackhole_fdb: No packet seen after removing
> blackhole FDB entry"
>         tcpdump_cleanup
> 
>         log_test "Blackhole FDB entry test"
> }
> 
> the setup is simple and is the same as in bridge_sticky_fdb.sh.
> 
> Does the test look sound or is there obvious mistakes?

[1]
blackhole_fdb()
{
	RET=0

	tc filter add dev $swp2 egress protocol ip pref 1 handle 1 flower \
		dst_ip 192.0.2.2 ip_proto udp dst_port 12345 action pass

	$MZ $h1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
		-a own -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q

	tc_check_packets "dev $swp2 egress" 1 1
	check_err $? "Packet not seen on egress before adding blackhole entry"

	bridge fdb add `mac_get $h2` dev br0 blackhole
	bridge fdb get `mac_get $h2` br br0 | grep -q blackhole
	check_err $? "Blackhole entry not found"

	$MZ $h1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
		-a own -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q

	tc_check_packets "dev $swp2 egress" 1 1
	check_err $? "Packet seen on egress after adding blackhole entry"

	# Check blackhole entries can be replaced.
	bridge fdb replace `mac_get $h2` dev $swp2 master static
	bridge fdb get `mac_get $h2` br br0 | grep -q blackhole
	check_fail $? "Blackhole entry found after replacement"

	$MZ $h1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
		-a own -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q

	tc_check_packets "dev $swp2 egress" 1 2
	check_err $? "Packet not seen on egress after replacing blackhole entry"

	bridge fdb del `mac_get $h2` dev $swp2 master static
	tc filter del dev $swp2 egress protocol ip pref 1 handle 1 flower

	log_test "Blackhole FDB entry"
}
