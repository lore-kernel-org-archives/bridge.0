Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E767C419BD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3F0A41963
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2sA9EhPclZO6+f6VLQzu+GI/zukGWQQoz8R1Dt12GsI=;
 b=Ssrumq6PQhx2e/g4Bd6SuNl23SQH9Qv/nzp1Uy9v//x8kEfruuqhhMNDkoX0H6ubCI
 MaR+SU/RqMNRmjwnNWDMEcpz5GjfoleC+3BNcTsopxhWnVzJ1nwvkgl4GUS7gqR9n1Fq
 izOLXvz1I0ML3IDmv7IE1eUXRtk1Yci1fVgckWGdmoTrtO/ZlMVH35H0a2v/yyavFMTI
 dgIH49auVy3dEz1m78McldLsu3o9041upq0t+vH0lbSnrUxZ+kOG4XyhlXJ82KOUrTZk
 0WYx/93yCnKvBMWzXt48IicEnnzHqiPpFmQESj7PjC1dRCf2NXHPeU7yGmFs8AcDl6o1
 hazw==
Date: Thu, 19 Jan 2023 15:40:45 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230119134045.fqdt6zrna5x3iavt@skbuf>
References: <20230117185714.3058453-1-netdev@kapio-technology.com>
 <20230117185714.3058453-2-netdev@kapio-technology.com>
 <20230117230806.ipwcbnq4jcc4qs7z@skbuf>
 <a3bba3eb856a00b5e5e0c1e2ffe8749a@kapio-technology.com>
 <20230119093358.gbyka2x4qbxxr43b@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119093358.gbyka2x4qbxxr43b@skbuf>
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
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Thu, Jan 19, 2023 at 11:33:58AM +0200, Vladimir Oltean wrote:
> On Wed, Jan 18, 2023 at 11:14:00PM +0100, netdev@kapio-technology.com wrote:
> > > > +	item->is_dyn = !test_bit(BR_FDB_STATIC, &fdb->flags);
> > > 
> > > Why reverse logic? Why not just name this "is_static" and leave any
> > > further interpretations up to the consumer?
> > 
> > My reasoning for this is that the common case is to have static entries,
> > thus is_dyn=false, so whenever someone uses a switchdev_notifier_fdb_info
> > struct the common case does not need to be entered.
> > Otherwise it might also break something when someone uses this struct and if
> > it was 'is_static' and they forget to code is_static=true they will get
> > dynamic entries without wanting it and it can be hard to find such an error.
> 
> I'll leave it up to bridge maintainers if this is preferable to patching
> all callers of SWITCHDEV_FDB_ADD_TO_BRIDGE such that they set is_static=true.

Actually, why would you assume that all users of SWITCHDEV_FDB_ADD_TO_BRIDGE
want to add static FDB entries? You can't avoid inspecting the code and
making sure that the is_dyn/is_static flag is set correctly either way.
