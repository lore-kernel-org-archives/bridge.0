Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC0D64180F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BF1A40978
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDev4h0NnBgmjI2bEQrPsQycTtB9XDfUzzJHeIjxhN0=;
 b=PvUAWzflhGE/Ww2Z4xoPfINUG51Z518rHsfJfj2O6mLRmrjddumPQnHh2yg6Zoj1reTGQx3TVvVNclWMwsCn45CJ+S7FS92LxP1VLgw/B5O2S5pxlHQzPvUwMQlobVqqqrKZ4BNraO6xS3YqbMR8kYJcsj2Q8JZP+c8nwTH5lahOReW9dDqzhjLL4MNzxOtJCQP1L7Ho/u5fkmNzAsM1uvGkclKquAWW5iQk3qNyswA52ZiHMfPB60CU1cE4nZSoQOhTZLibm4Dgi3jCqVKoEtLNtUi4olmHTcz4wnaj2kwCJzNlK2VOLgkENZf7JHEo8KQh6Q+E4qRxBNewztYTnA==
Date: Tue, 28 Mar 2023 19:40:13 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZCMYbRqd+qZaiHfu@shredder>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-7-netdev@kapio-technology.com>
 <ZBgdAo8mxwnl+pEE@shredder> <87a5zzh65p.fsf@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5zzh65p.fsf@kapio-technology.com>
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
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Sun, Mar 26, 2023 at 05:41:06PM +0200, Hans Schultz wrote:
> On Mon, Mar 20, 2023 at 10:44, Ido Schimmel <idosch@nvidia.com> wrote:
> >> +	$MZ $swp1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
> >> +		-a $mac -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
> >> +	tc_check_packets "dev $swp2 egress" 1 1
> >> +	check_fail $? "Dynamic FDB entry did not age out"
> >
> > Shouldn't this be check_err()? After the FDB entry was aged you want to
> > make sure that packets received via $swp1 with SMAC being $mac are no
> > longer forwarded by the bridge.
> 
> I was thinking that check_fail() will pass when tc_check_packets() does
> not see any packets, thus the test passing here when no packets are forwarded?

What do you mean by "I was *thinking*"? How is it possible that you are
submitting a selftest that you didn't bother running?!

I see you trimmed my earlier question: "Does this actually work?"

I tried it and it passed:

# ./bridge_locked_port.sh                         
TEST: Locked port ipv4                                              [ OK ]
TEST: Locked port ipv6                                              [ OK ]
TEST: Locked port vlan                                              [ OK ]            
TEST: Locked port MAB                                               [ OK ]            
TEST: Locked port MAB roam                                          [ OK ]
TEST: Locked port MAB configuration                                 [ OK ]
TEST: Locked port MAB FDB flush                                     [ OK ]

And I couldn't understand how that's even possible. Then I realized that
the entire test is dead code because the patch is missing this
fundamental hunk:

```
diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
index dbc7017fd45d..5bf6b2aa1098 100755
--- a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
@@ -9,6 +9,7 @@ ALL_TESTS="
        locked_port_mab_roam
        locked_port_mab_config
        locked_port_mab_flush
+       locked_port_dyn_fdb
 "
 
 NUM_NETIFS=4
```

Which tells me that you didn't even try running it once. Now the test
failed as I expected:

# ./bridge_locked_port.sh                         
TEST: Locked port ipv4                                              [ OK ]
TEST: Locked port ipv6                                              [ OK ]
TEST: Locked port vlan                                              [ OK ]
TEST: Locked port MAB                                               [ OK ]
TEST: Locked port MAB roam                                          [ OK ]
TEST: Locked port MAB configuration                                 [ OK ]            
TEST: Locked port MAB FDB flush                                     [ OK ]
TEST: Locked port dyn FDB                                           [FAIL]            
        Packet not seen on egress after adding dynamic FDB

Fixed by:

```
@@ -336,7 +337,7 @@ locked_port_dyn_fdb()
        tc filter add dev $swp2 egress protocol ip pref 1 handle 1 flower \
                dst_ip 192.0.2.2 ip_proto udp dst_port 12345 action pass
 
-       $MZ $swp1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
+       $MZ $h1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
                -a $mac -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
        tc_check_packets "dev $swp2 egress" 1 1
        check_err $? "Packet not seen on egress after adding dynamic FDB"
```

Ran it again and it failed because of the second issue I pointed out:

# ./bridge_locked_port.sh 
TEST: Locked port ipv4                                              [ OK ]
TEST: Locked port ipv6                                              [ OK ]
TEST: Locked port vlan                                              [ OK ]
TEST: Locked port MAB                                               [ OK ]
TEST: Locked port MAB roam                                          [ OK ]
TEST: Locked port MAB configuration                                 [ OK ]
TEST: Locked port MAB FDB flush                                     [ OK ]
TEST: Locked port dyn FDB                                           [FAIL]
        Dynamic FDB entry did not age out                                             

Fixed by:

```
@@ -346,7 +347,7 @@ locked_port_dyn_fdb()
        $MZ $swp1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
                -a $mac -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
        tc_check_packets "dev $swp2 egress" 1 1
-       check_fail $? "Dynamic FDB entry did not age out"
+       check_err $? "Dynamic FDB entry did not age out"
 
        ip link set dev br0 type bridge ageing_time $ageing_time
        bridge link set dev $swp1 learning off locked off
```

# ./bridge_locked_port.sh 
TEST: Locked port ipv4                                              [ OK ]
TEST: Locked port ipv6                                              [ OK ]
TEST: Locked port vlan                                              [ OK ]
TEST: Locked port MAB                                               [ OK ]
TEST: Locked port MAB roam                                          [ OK ]
TEST: Locked port MAB configuration                                 [ OK ]
TEST: Locked port MAB FDB flush                                     [ OK ]
TEST: Locked port dyn FDB                                           [ OK ]

Sigh
