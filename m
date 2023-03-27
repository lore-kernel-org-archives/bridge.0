Return-Path: <hans@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E8184088B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E2BF404A6
From: Hans Schultz <netdev@kapio-technology.com>
In-Reply-To: <20230327115206.jk5q5l753aoelwus@skbuf>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-3-netdev@kapio-technology.com>
 <20230327115206.jk5q5l753aoelwus@skbuf>
Date: Mon, 27 Mar 2023 17:31:26 +0200
Message-ID: <87355qb48h.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v2 net-next 2/6] net: dsa: propagate flags down
 towards drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES
 ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1
 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Mon, Mar 27, 2023 at 14:52, Vladimir Oltean <olteanv@gmail.com> wrote:
>
> By the way, there is a behavior change here.
>
> Before:
>
> $ ip link add br0 type bridge && ip link set br0 up
> $ ip link set swp0 master br0 && ip link set swp0 up
> $ bridge fdb add dev swp0 00:01:02:03:04:05 master dynamic
> [   70.010181] mscc_felix 0000:00:00.5: felix_fdb_add: port 0 addr 00:01:02:03:04:05 vid 0
> [   70.019105] mscc_felix 0000:00:00.5: felix_fdb_add: port 0 addr 00:01:02:03:04:05 vid 1
> .... 5 minutes later
> [  371.686935] mscc_felix 0000:00:00.5: felix_fdb_del: port 0 addr 00:01:02:03:04:05 vid 1
> [  371.695449] mscc_felix 0000:00:00.5: felix_fdb_del: port 0 addr 00:01:02:03:04:05 vid 0
> $ bridge fdb | grep 00:01:02:03:04:05
>
> After:
>
> $ ip link add br0 type bridge && ip link set br0 up
> $ ip link set swp0 master br0 && ip link set swp0 up
> $ bridge fdb add dev swp0 00:01:02:03:04:05 master dynamic
> [  222.071492] mscc_felix 0000:00:00.5: felix_fdb_add: port 0 addr 00:01:02:03:04:05 vid 0 flags 0x1
> [  222.081154] mscc_felix 0000:00:00.5: felix_fdb_add: port 0 addr 00:01:02:03:04:05 vid 1 flags 0x1
> .... 5 minutes later
> $ bridge fdb | grep 00:01:02:03:04:05
> 00:01:02:03:04:05 dev swp0 vlan 1 offload master br0 stale
> 00:01:02:03:04:05 dev swp0 offload master br0 stale
> 00:01:02:03:04:05 dev swp0 vlan 1 self
> 00:01:02:03:04:05 dev swp0 self
>
> As you can see, the behavior is not identical, and it made more sense
> before.

I see this is Felix Ocelot and there is no changes in this patchset that
affects Felix Ocelot. Thus I am quite sure the results will be the same
without this patchset, ergo it must be because of another patch. All
that is done here in the DSA layer is to pass on an extra field and add
an extra check that will always pass in the case of this flag.
