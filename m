Return-Path: <simon.horman@corigine.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9F2560B23
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8CAD605A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElbqQq3AfMbIofWiTsbPWBjKCmxBgVLCoQHIVzFfxX4=;
 b=q85Ir+LI4oAXYozXuoIHCLwOQJcXN+UQ+CzjP6NZA4JwW4jtqeM071+DdtJWM4Cm2Nm5iy/d0OJAUVO5/wmR0lyiVmrVbVeYd1cVU5UVQuYbFJ45c0bHUytQmbqidWIco8hKAMYoCsBlR9cNO0Vj1ky/NaBDyMQmOV+p6ui0C2Q=
Date: Mon, 6 Feb 2023 17:02:16 +0100
From: Simon Horman <simon.horman@corigine.com>
Message-ID: <Y+EkiAyexZrPoCpP@corigine.com>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-6-netdev@kapio-technology.com>
 <Y9lkXlyXg1d1D0j3@corigine.com>
 <9b12275969a204739ccfab972d90f20f@kapio-technology.com>
 <Y9zDxlwSn1EfCTba@corigine.com>
 <20230203204422.4wrhyathxfhj6hdt@skbuf>
 <Y94TebdRQRHMMj/c@corigine.com>
 <4abbe32d007240b9c3aea9c8ca936fa3@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4abbe32d007240b9c3aea9c8ca936fa3@kapio-technology.com>
MIME-Version: 1.0
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
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Sat, Feb 04, 2023 at 09:48:24AM +0100, netdev@kapio-technology.com wrote:
> On 2023-02-04 09:12, Simon Horman wrote:
> > On Fri, Feb 03, 2023 at 10:44:22PM +0200, Vladimir Oltean wrote:
> > > On Fri, Feb 03, 2023 at 09:20:22AM +0100, Simon Horman wrote:
> > > > > else if (someflag)
> > > > >         dosomething();
> > > > >
> > > > > For now only one flag will actually be set and they are mutually exclusive,
> > > > > as they will not make sense together with the potential flags I know, but
> > > > > that can change at some time of course.
> > > >
> > > > Yes, I see that is workable. I do feel that checking for other flags would
> > > > be a bit more robust. But as you say, there are none. So whichever
> > > > approach you prefer is fine by me.
> > > 
> > > The model we have for unsupported bits in the
> > > SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS
> > > and SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS handlers is essentially this:
> > > 
> > > 	if (flags & ~(supported_flag_mask))
> > > 		return -EOPNOTSUPP;
> > > 
> > > 	if (flags & supported_flag_1)
> > > 		...
> > > 
> > > 	if (flags & supported_flag_2)
> > > 		...
> > > 
> > > I suppose applying this model here would address Simon's
> > > extensibility concern.
> > 
> > Yes, that is the model I had in mind.
> 
> The only thing is that we actually need to return both 0 and -EOPNOTSUPP for
> unsupported flags. The dynamic flag requires 0 when not supported (and
> supported) AFAICS.
> Setting a mask as 'supported' for a feature that is not really supported
> defeats the notion of 'supported' IMHO.

Just to clarify my suggestion one last time, it would be along the lines
of the following (completely untested!). I feel that it robustly covers
all cases for fdb_flags. And as a bonus doesn't need to be modified
if other (unsupported) flags are added in future.

	if (fdb_flags & ~(DSA_FDB_FLAG_DYNAMIC))
		return -EOPNOTSUPP;

	is_dynamic = !!(fdb_flags & DSA_FDB_FLAG_DYNAMIC)
	if (is_dynamic)
		state = MV88E6XXX_G1_ATU_DATA_STATE_UC_AGE_7_NEWEST;


And perhaps for other drivers:

	if (fdb_flags & ~(DSA_FDB_FLAG_DYNAMIC))
		return -EOPNOTSUPP;
	if (fdb_flags)
		return 0;

Perhaps a helper would be warranted for the above.

But in writing this I think that, perhaps drivers could return -EOPNOTSUPP
for the DSA_FDB_FLAG_DYNAMIC case and the caller can handle, rather tha
propagate, -EOPNOTSUPP.

Returning -EOPNOTSUPP is the normal way to drivers to respond to requests
for unsupported hardware offloads. Sticking to that may be clearner
in the long run. That said, I do agree your current patch is correct
given the flag that is defined (by your patchset).
