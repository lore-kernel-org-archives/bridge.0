Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8313D416C5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C0CF415F6
MIME-Version: 1.0
Date: Fri, 20 Jan 2023 22:16:03 +0100
From: netdev@kapio-technology.com
In-Reply-To: <20230119134045.fqdt6zrna5x3iavt@skbuf>
References: <20230117185714.3058453-1-netdev@kapio-technology.com>
 <20230117185714.3058453-2-netdev@kapio-technology.com>
 <20230117230806.ipwcbnq4jcc4qs7z@skbuf>
 <a3bba3eb856a00b5e5e0c1e2ffe8749a@kapio-technology.com>
 <20230119093358.gbyka2x4qbxxr43b@skbuf>
 <20230119134045.fqdt6zrna5x3iavt@skbuf>
Message-ID: <29501147c96e7e2f06c999410d42e2bf@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 1/5] net: bridge: add dynamic flag
 to switchdev notifier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET
 SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1
 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On 2023-01-19 14:40, Vladimir Oltean wrote:
> On Thu, Jan 19, 2023 at 11:33:58AM +0200, Vladimir Oltean wrote:
>> On Wed, Jan 18, 2023 at 11:14:00PM +0100, netdev@kapio-technology.com 
>> wrote:
>> > > > +	item->is_dyn = !test_bit(BR_FDB_STATIC, &fdb->flags);
>> > >
>> > > Why reverse logic? Why not just name this "is_static" and leave any
>> > > further interpretations up to the consumer?
>> >
>> > My reasoning for this is that the common case is to have static entries,
>> > thus is_dyn=false, so whenever someone uses a switchdev_notifier_fdb_info
>> > struct the common case does not need to be entered.
>> > Otherwise it might also break something when someone uses this struct and if
>> > it was 'is_static' and they forget to code is_static=true they will get
>> > dynamic entries without wanting it and it can be hard to find such an error.
>> 
>> I'll leave it up to bridge maintainers if this is preferable to 
>> patching
>> all callers of SWITCHDEV_FDB_ADD_TO_BRIDGE such that they set 
>> is_static=true.
> 
> Actually, why would you assume that all users of 
> SWITCHDEV_FDB_ADD_TO_BRIDGE
> want to add static FDB entries? You can't avoid inspecting the code and
> making sure that the is_dyn/is_static flag is set correctly either way.

Well, up until this patch set there is no option, besides entries from 
SWITCHDEV_FDB_ADD_TO_BRIDGE events will get the external learned flag 
set, so they will not be aged by the bridge, and so dynamic entries that 
way don't make much sense I think. Is that not right?
