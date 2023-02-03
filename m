Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E5798224E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 874CB8224D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2i9kAduLyvWzDNPasV+KzeGgY8drvOps/KxoO5LHdEw=;
 b=Vh4yFSLP4dnir5alPOP/BdqGJ1iEQMpXhQ+vDTowlNH9vMovkkNBYPi8Uhk8C7itGw
 pWJPGbneNPZx8bgItqJXAuo9hewbHrvUsmkjhmhjo7iVzDaPKFrVlDjUisuzBbOPzaBk
 hoew3vOtR7JhNkpbPch0cih/aKZQY3wZX9AulnE0kyyhblR3bKcZnRU35XovU5/9VbYj
 lHi0Szbc9Ujf075Lgy9ykV7iQTSzJNKLodhKzj3evBAx2txbaKjEgLHvLZEo7Spemc80
 Fne13usGX0QFsuTnmHXtqiB94MQK2ebcXK5/Xito6NgmRWOGINev3LN1yORMLgTrA/pn
 3OHA==
Date: Fri, 3 Feb 2023 22:44:22 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230203204422.4wrhyathxfhj6hdt@skbuf>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-6-netdev@kapio-technology.com>
 <Y9lkXlyXg1d1D0j3@corigine.com>
 <9b12275969a204739ccfab972d90f20f@kapio-technology.com>
 <Y9zDxlwSn1EfCTba@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9zDxlwSn1EfCTba@corigine.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, netdev@kapio-technology.com, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Fri, Feb 03, 2023 at 09:20:22AM +0100, Simon Horman wrote:
> > else if (someflag)
> >         dosomething();
> > 
> > For now only one flag will actually be set and they are mutually exclusive,
> > as they will not make sense together with the potential flags I know, but
> > that can change at some time of course.
> 
> Yes, I see that is workable. I do feel that checking for other flags would
> be a bit more robust. But as you say, there are none. So whichever
> approach you prefer is fine by me.

The model we have for unsupported bits in the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS
and SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS handlers is essentially this:

	if (flags & ~(supported_flag_mask))
		return -EOPNOTSUPP;

	if (flags & supported_flag_1)
		...

	if (flags & supported_flag_2)
		...

I suppose applying this model here would address Simon's extensibility concern.
