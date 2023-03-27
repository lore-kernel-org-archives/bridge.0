Return-Path: <hans@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78624610D7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 481C2610C8
From: Hans Schultz <netdev@kapio-technology.com>
In-Reply-To: <20230327160009.bdswnalizdv2u77z@skbuf>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-3-netdev@kapio-technology.com>
 <20230327115206.jk5q5l753aoelwus@skbuf>
 <87355qb48h.fsf@kapio-technology.com>
 <20230327160009.bdswnalizdv2u77z@skbuf>
Date: Mon, 27 Mar 2023 23:49:58 +0200
Message-ID: <87pm8tooe1.fsf@kapio-technology.com>
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

On Mon, Mar 27, 2023 at 19:00, Vladimir Oltean <olteanv@gmail.com> wrote:
> A reasonable question you could ask yourself is: why do my BR_FDB_OFFLOADED
> entries have this flag in the software bridge in the first place?
> Did I add code for it? Is it because there is some difference between
> mv88e6xxx and ocelot/felix, or is it because dsa_fdb_offload_notify()
> gets called in both cases from generic code just the same?
>
> And if dsa_fdb_offload_notify() gets called in both cases just the same,
> but no other driver except for mv88e6xxx emits the SWITCHDEV_FDB_DEL_TO_BRIDGE
> which you've patched the bridge to expect in this series, then what exactly
> is surprising in the fact that offloaded and dynamic FDB entries now become
> stale, but are not removed from the software bridge as they were before?

Yes, I see I have missed that the dsa layer already adds the offloaded
flag in dsa_slave_switchdev_event_work() in slave.c.

My first approach was to use the SWITCHDEV_FDB_ADD_TO_BRIDGE event
and not the SWITCHDEV_FDB_OFFLOADED event as the first would set the
external learned flag which is not aged out by the bridge.
I have at some point earlier asked why there would be two quite
equivalent flags and what the difference between them are, but I didn't
get a response.

Now I see the difference and that I cannot use the offloaded flag
without changing the behaviour of the system as I actually change the
behaviour of the offloaded flag in this version of the patch-set.

So if the idea of a 'synthetically' learned fdb entry from the driver
using the SWITCHDEV_FDB_ADD_TO_BRIDGE event from the driver towards the
bridge instead is accepted, I can go with that?
(thus removing all the changes in the patch-set regarding the offloaded
flag ofcourse)
