Return-Path: <simon.horman@corigine.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 675C841058
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1C33400CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi/ZoGN1SblsS/jhCzhzSMKV09ufYuVioFiWZkglVTc=;
 b=JDaGpm+Ln2IYzhv4JR4GRXpx12NELGAuhAc2bHdmJIkkB3Vnr50MuLdccrI301kti3oT8KCiXa1WMq3/NAvpjgbuUY25p98I/+wHvwB5eOG3ov28Qw8VlhH/ot8J/2p6QkWkbm6nF5pauZpfay1PYtgGKzTseQxNBi5nY+SRxXQ=
Date: Fri, 3 Feb 2023 09:20:22 +0100
From: Simon Horman <simon.horman@corigine.com>
Message-ID: <Y9zDxlwSn1EfCTba@corigine.com>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-6-netdev@kapio-technology.com>
 <Y9lkXlyXg1d1D0j3@corigine.com>
 <9b12275969a204739ccfab972d90f20f@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b12275969a204739ccfab972d90f20f@kapio-technology.com>
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

On Thu, Feb 02, 2023 at 06:00:00PM +0100, netdev@kapio-technology.com wrote:
> On 2023-01-31 19:56, Simon Horman wrote:
> > > --- a/drivers/net/dsa/mv88e6xxx/chip.c
> > > +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> > > @@ -42,6 +42,7 @@
> > >  #include "ptp.h"
> > >  #include "serdes.h"
> > >  #include "smi.h"
> > > +#include "switchdev.h"
> > > 
> > >  static void assert_reg_lock(struct mv88e6xxx_chip *chip)
> > >  {
> > > @@ -2726,18 +2727,25 @@ static int mv88e6xxx_port_fdb_add(struct
> > > dsa_switch *ds, int port,
> > >  				  const unsigned char *addr, u16 vid,
> > >  				  u16 fdb_flags, struct dsa_db db)
> > >  {
> > > +	bool is_dynamic = !!(fdb_flags & DSA_FDB_FLAG_DYNAMIC);
> > >  	struct mv88e6xxx_chip *chip = ds->priv;
> > > +	u8 state;
> > >  	int err;
> > > 
> > > -	/* Ignore entries with flags set */
> > > -	if (fdb_flags)
> > > -		return 0;
> > > +	state = MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC;
> > > +	if (is_dynamic)
> > > +		state = MV88E6XXX_G1_ATU_DATA_STATE_UC_AGE_7_NEWEST;
> > 
> > What if flags other than DSA_FDB_FLAG_DYNAMIC are set (in future)?
> 
> They will have to be caught and handled here if there is support for it,
> e.g. something like...
> 
> else if (someflag)
>         dosomething();
> 
> For now only one flag will actually be set and they are mutually exclusive,
> as they will not make sense together with the potential flags I know, but
> that can change at some time of course.

Yes, I see that is workable. I do feel that checking for other flags would
be a bit more robust. But as you say, there are none. So whichever
approach you prefer is fine by me.

> > 
> > > +	else
> > > +		if (fdb_flags)
> > 
> > nit: else if (fdb_flags)
> > 
> > > +			return 0;
> > > 
> > 
> > ...
