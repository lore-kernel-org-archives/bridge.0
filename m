Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 792E060D52
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5031260BAA
MIME-Version: 1.0
Date: Sat, 04 Feb 2023 09:48:24 +0100
From: netdev@kapio-technology.com
In-Reply-To: <Y94TebdRQRHMMj/c@corigine.com>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-6-netdev@kapio-technology.com>
 <Y9lkXlyXg1d1D0j3@corigine.com>
 <9b12275969a204739ccfab972d90f20f@kapio-technology.com>
 <Y9zDxlwSn1EfCTba@corigine.com> <20230203204422.4wrhyathxfhj6hdt@skbuf>
 <Y94TebdRQRHMMj/c@corigine.com>
Message-ID: <4abbe32d007240b9c3aea9c8ca936fa3@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 5/5] net: dsa: mv88e6xxx:
 implementation of dynamic ATU entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Simon Horman <simon.horman@corigine.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET
 SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1
 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On 2023-02-04 09:12, Simon Horman wrote:
> On Fri, Feb 03, 2023 at 10:44:22PM +0200, Vladimir Oltean wrote:
>> On Fri, Feb 03, 2023 at 09:20:22AM +0100, Simon Horman wrote:
>> > > else if (someflag)
>> > >         dosomething();
>> > >
>> > > For now only one flag will actually be set and they are mutually exclusive,
>> > > as they will not make sense together with the potential flags I know, but
>> > > that can change at some time of course.
>> >
>> > Yes, I see that is workable. I do feel that checking for other flags would
>> > be a bit more robust. But as you say, there are none. So whichever
>> > approach you prefer is fine by me.
>> 
>> The model we have for unsupported bits in the 
>> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS
>> and SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS handlers is essentially this:
>> 
>> 	if (flags & ~(supported_flag_mask))
>> 		return -EOPNOTSUPP;
>> 
>> 	if (flags & supported_flag_1)
>> 		...
>> 
>> 	if (flags & supported_flag_2)
>> 		...
>> 
>> I suppose applying this model here would address Simon's extensibility 
>> concern.
> 
> Yes, that is the model I had in mind.

The only thing is that we actually need to return both 0 and -EOPNOTSUPP 
for unsupported flags. The dynamic flag requires 0 when not supported 
(and supported) AFAICS.
Setting a mask as 'supported' for a feature that is not really supported 
defeats the notion of 'supported' IMHO.
