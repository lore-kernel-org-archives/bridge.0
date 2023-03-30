Return-Path: <hans@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 058AD60B43
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0572760B06
From: Hans Schultz <netdev@kapio-technology.com>
In-Reply-To: <20230330130936.hxme34qrqwolvpsh@skbuf>
References: <20230327115206.jk5q5l753aoelwus@skbuf>
 <87355qb48h.fsf@kapio-technology.com>
 <20230327160009.bdswnalizdv2u77z@skbuf>
 <87pm8tooe1.fsf@kapio-technology.com>
 <20230327225933.plm5raegywbe7g2a@skbuf>
 <87ileljfwo.fsf@kapio-technology.com>
 <20230328114943.4mibmn2icutcio4m@skbuf>
 <87cz4slkx5.fsf@kapio-technology.com>
 <20230330124326.v5mqg7do25tz6izk@skbuf>
 <87wn2yxunb.fsf@kapio-technology.com>
 <20230330130936.hxme34qrqwolvpsh@skbuf>
Date: Thu, 30 Mar 2023 16:54:19 +0200
Message-ID: <875yaimgro.fsf@kapio-technology.com>
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

On Thu, Mar 30, 2023 at 16:09, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Thu, Mar 30, 2023 at 02:59:04PM +0200, Hans Schultz wrote:
>> On Thu, Mar 30, 2023 at 15:43, Vladimir Oltean <olteanv@gmail.com> wrote:
>> > On Tue, Mar 28, 2023 at 09:45:26PM +0200, Hans Schultz wrote:
>> >> So the solution would be to not let the DSA layer send the
>> >> SWITCHDEV_FDB_OFFLOADED event in the case when the new dynamic flag is
>> >> set?
>> >
>> > I have never said that.
>> 
>> No, I was just thinking of a solution based on your previous comment
>> that dynamic fdb entries with the offloaded flag set should not be aged
>> out by the bridge as they are now.
>
> If you were a user of those other drivers, and you ran the command:
> "bridge fdb add ... master dynamic"
> would you be ok with the behavior: "I don't have dynamic FDB entries,
> but here's a static one for you"?

I don't know if you have a solution in mind wrt the behaviour of the
offloaded flag if it is not to do as it does now and let the bridge age
out dynamic entries. That led me to conclude that this patch-set cannot
use the offloaded flag, but you seem to suggest otherwise.

If you have a suggestion, feel free.
