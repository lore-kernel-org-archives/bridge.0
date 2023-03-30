Return-Path: <hans@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6061B41EAE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16B7B40298
From: Hans Schultz <netdev@kapio-technology.com>
In-Reply-To: <ZCMYbRqd+qZaiHfu@shredder>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-7-netdev@kapio-technology.com>
 <ZBgdAo8mxwnl+pEE@shredder> <87a5zzh65p.fsf@kapio-technology.com>
 <ZCMYbRqd+qZaiHfu@shredder>
Date: Thu, 30 Mar 2023 21:07:53 +0200
Message-ID: <874jq22h2u.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated
 list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1
 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Tue, Mar 28, 2023 at 19:40, Ido Schimmel <idosch@nvidia.com> wrote:
> On Sun, Mar 26, 2023 at 05:41:06PM +0200, Hans Schultz wrote:
>> On Mon, Mar 20, 2023 at 10:44, Ido Schimmel <idosch@nvidia.com> wrote:
>> >> +	$MZ $swp1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
>> >> +		-a $mac -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
>> >> +	tc_check_packets "dev $swp2 egress" 1 1
>> >> +	check_fail $? "Dynamic FDB entry did not age out"
>> >
>> > Shouldn't this be check_err()? After the FDB entry was aged you want to
>> > make sure that packets received via $swp1 with SMAC being $mac are no
>> > longer forwarded by the bridge.
>> 
>> I was thinking that check_fail() will pass when tc_check_packets() does
>> not see any packets, thus the test passing here when no packets are forwarded?
>
> What do you mean by "I was *thinking*"? How is it possible that you are
> submitting a selftest that you didn't bother running?!
>
> I see you trimmed my earlier question: "Does this actually work?"
>
> I tried it and it passed:
>
> # ./bridge_locked_port.sh                         
> TEST: Locked port ipv4                                              [ OK ]
> TEST: Locked port ipv6                                              [ OK ]
> TEST: Locked port vlan                                              [ OK ]            
> TEST: Locked port MAB                                               [ OK ]            
> TEST: Locked port MAB roam                                          [ OK ]
> TEST: Locked port MAB configuration                                 [ OK ]
> TEST: Locked port MAB FDB flush                                     [ OK ]
>
> And I couldn't understand how that's even possible. Then I realized that
> the entire test is dead code because the patch is missing this
> fundamental hunk:
>
> ```
> diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
> index dbc7017fd45d..5bf6b2aa1098 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
> @@ -9,6 +9,7 @@ ALL_TESTS="
>         locked_port_mab_roam
>         locked_port_mab_config
>         locked_port_mab_flush
> +       locked_port_dyn_fdb
>  "
>  
>  NUM_NETIFS=4
> ```
>
> Which tells me that you didn't even try running it once.

Not true, it reveals that I forgot to put it in the patch, that's all. As
I cannot run several of these tests because of memory constraints I link
the file to a copy in a rw area where I modify the list and just run one
of the subtests at a time. If I try to run the whole it always fails
after a couple of sub-tests with an error.

It seems to me that these scripts are quite memory consuming as they
accumulate memory consuption in relation to what is loaded along the
way. A major problem with my system.
