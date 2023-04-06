Return-Path: <hans@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92D74843B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0DF0843AB
From: Hans Schultz <netdev@kapio-technology.com>
In-Reply-To: <20230406152443.b3ps4x7e4kz4aes2@skbuf>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-7-netdev@kapio-technology.com>
 <ZBgdAo8mxwnl+pEE@shredder> <87a5zzh65p.fsf@kapio-technology.com>
 <ZCMYbRqd+qZaiHfu@shredder> <874jq22h2u.fsf@kapio-technology.com>
 <20230330192714.oqosvifrftirshej@skbuf>
 <871ql5mjjp.fsf@kapio-technology.com>
 <20230331093732.s6loozkdhehewlm4@skbuf>
 <87tty1nlb4.fsf@kapio-technology.com>
 <20230406152443.b3ps4x7e4kz4aes2@skbuf>
Date: Thu, 06 Apr 2023 18:26:58 +0200
Message-ID: <87wn2pj7sd.fsf@kapio-technology.com>
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, open list <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated
 list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Ido Schimmel <idosch@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1
 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Thu, Apr 06, 2023 at 18:24, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Fri, Mar 31, 2023 at 02:43:11PM +0200, Hans Schultz wrote:
>> I will as long as the system is as it is with these selftests, just run
>> single subtests at a time on target, but if I have new phy problems like
>> the one you have seen I have had before, then testing on target becomes
>> off limits.
>
> Please open a dedicated communication channel (separate email thread on
> netdev@vger.kernel.org) with the appropriate maintainers for the PHY
> code that is failing for you in To:, and you will get the help that you
> need to resolve that and to be able to test on the target board.

The errors from the phy I saw in February. Maybe something was fixed in
the meantime as I did not see the same warning and exception last I
tried to run the newest kernel on target a little over a week ago.
