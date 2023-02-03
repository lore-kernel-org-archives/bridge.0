Return-Path: <simon.horman@corigine.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 22330429B1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C729741C5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqGXl5Wv3G9fLahc+geuWHLtMDU+xGZqI0CTVLVftUI=;
 b=mJeB1OpnUjI7OWkrAwmikHMCogbxeVpoXsY8gRWSYvbvgjxD+0hWRn1do61XeJxw68FbV7JpRNB1Q34iXwisczewQ0ZnQ/bfU7j3zqOGOsJbsE6oRFXeOfHRW7kENz5T0ovFYDLzNJ8MuuHHjQJpK40EVBzRL9AThmoLe2Qzfp0=
Date: Fri, 3 Feb 2023 09:17:06 +0100
From: Simon Horman <simon.horman@corigine.com>
Message-ID: <Y9zDApc6nDO2RzOb@corigine.com>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-4-netdev@kapio-technology.com>
 <Y9lj7RJgyMJfjtGp@corigine.com>
 <0b021777dfc1825b6565c0d9dbd6dbef@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b021777dfc1825b6565c0d9dbd6dbef@kapio-technology.com>
MIME-Version: 1.0
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
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Thu, Feb 02, 2023 at 05:45:56PM +0100, netdev@kapio-technology.com wrote:
> On 2023-01-31 19:54, Simon Horman wrote:
> > > --- a/drivers/net/dsa/b53/b53_common.c
> > > +++ b/drivers/net/dsa/b53/b53_common.c
> > > @@ -1684,11 +1684,15 @@ static int b53_arl_op(struct b53_device
> > > *dev, int op, int port,
> > > 
> > >  int b53_fdb_add(struct dsa_switch *ds, int port,
> > >  		const unsigned char *addr, u16 vid,
> > > -		struct dsa_db db)
> > > +		u16 fdb_flags, struct dsa_db db)
> > >  {
> > >  	struct b53_device *priv = ds->priv;
> > >  	int ret;
> > > 
> > > +	/* Ignore entries with set flags */
> > > +	if (fdb_flags)
> > > +		return 0;
> > 
> > 
> > 	Would returning -EOPNOTSUPP be more appropriate?
> > 
> > ...
> 
> I don't think that would be so good, as the command
> 
> bridge fdb replace ADDR dev <DEV> master dynamic
> 
> is a valid command and should not generate errors. When ignored by the
> driver, it will just install a dynamic FDB entry in the bridge, and the
> bridge will age it.

Sure, I agree that it's not necessarily an error that needs
to propagate to the user.

My assumption, which I now see is likely false, is that drivers
could return -EOPNOTSUPP, to indicate to higher layers that the operation
is not supported. But the higher layers may not propagate that.

But it seems that is not the case here. So I think return 0 is fine
after all. Sorry for the noise.
