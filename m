Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B28281F32
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7774C81EE0
MIME-Version: 1.0
Date: Fri, 03 Feb 2023 19:41:18 +0100
From: netdev@kapio-technology.com
In-Reply-To: <Y9zDApc6nDO2RzOb@corigine.com>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-4-netdev@kapio-technology.com>
 <Y9lj7RJgyMJfjtGp@corigine.com>
 <0b021777dfc1825b6565c0d9dbd6dbef@kapio-technology.com>
 <Y9zDApc6nDO2RzOb@corigine.com>
Message-ID: <687a1918326d23ec901c1f53f5860592@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 3/5] drivers: net: dsa: add fdb entry
 flags incoming to switchcore drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Simon Horman <simon.horman@corigine.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Cl=C3=A9m?= =?UTF-8?Q?ent_L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1
 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On 2023-02-03 09:17, Simon Horman wrote:
> On Thu, Feb 02, 2023 at 05:45:56PM +0100, netdev@kapio-technology.com 
> wrote:
>> On 2023-01-31 19:54, Simon Horman wrote:
>> > > --- a/drivers/net/dsa/b53/b53_common.c
>> > > +++ b/drivers/net/dsa/b53/b53_common.c
>> > > @@ -1684,11 +1684,15 @@ static int b53_arl_op(struct b53_device
>> > > *dev, int op, int port,
>> > >
>> > >  int b53_fdb_add(struct dsa_switch *ds, int port,
>> > >  		const unsigned char *addr, u16 vid,
>> > > -		struct dsa_db db)
>> > > +		u16 fdb_flags, struct dsa_db db)
>> > >  {
>> > >  	struct b53_device *priv = ds->priv;
>> > >  	int ret;
>> > >
>> > > +	/* Ignore entries with set flags */
>> > > +	if (fdb_flags)
>> > > +		return 0;
>> >
>> >
>> > 	Would returning -EOPNOTSUPP be more appropriate?
>> >
>> > ...
>> 
>> I don't think that would be so good, as the command
>> 
>> bridge fdb replace ADDR dev <DEV> master dynamic
>> 
>> is a valid command and should not generate errors. When ignored by the
>> driver, it will just install a dynamic FDB entry in the bridge, and 
>> the
>> bridge will age it.
> 
> Sure, I agree that it's not necessarily an error that needs
> to propagate to the user.
> 
> My assumption, which I now see is likely false, is that drivers
> could return -EOPNOTSUPP, to indicate to higher layers that the 
> operation
> is not supported. But the higher layers may not propagate that.
> 
> But it seems that is not the case here. So I think return 0 is fine
> after all. Sorry for the noise.

No noise at all... I think your concern is quite ligitimate. With this 
flag there is no iproute2 changes, so not to change behaviour of old 
commands the best is to ignore silently. But I have another flag coming 
up that will be accomodated with a new iproute2 command, and then your 
suggestion is more appropriate. The question will then be if the returns 
for that flag should be -EOPNOTSUPP.
