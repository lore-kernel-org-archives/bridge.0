Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3069A82262
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 786C3821C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v8UifT5o8QIL+1ZOw+vxMKGXi/nfDw7qQB6T6ClS8Ic=;
 b=pd4JdGeGvQ+bwoWBkvvdDb0hhyE/Bxhta6bcG3jxt0dWu7ZCdJQHLjZUYh/neaf8kv
 E2vN7hCsLGKW2de3K6muUrxk3KJCGwOsziVlBtiWxe9afhV1sVgLOZTGjzEZ986sCAQE
 fKtMsX5U/ln9C0+q5QNHGuB2n94r0ojW3gCL6ueoVBlSVA0i1kk9DA76BLAopPpz5a+r
 +w+xc49sVxrSI6XphvcS8f9anBNzfLSR2DfW9+hI22SIZJYNLUdgyFra+/+vBm50At92
 l5Es6QjHbL5/d/8HlTu0B/cTjn6/Uqmc6dzhzy8HEN0z3ioILJcKrb0mAt/0BQo+hytZ
 2vtA==
Date: Fri, 3 Feb 2023 23:14:51 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230203211451.3rhg2kg6tjmmhfmp@skbuf>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <Y9lrIWMnWLqGreZL@shredder>
 <e2535b002be9044958ab0003d8bd6966@kapio-technology.com>
 <Y9vaIOefIf/gI0BR@shredder>
 <3cecf4425b0e6f38646e25e40fd8f0fd@kapio-technology.com>
 <Y9vmfoaFxPdKvgxt@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9vmfoaFxPdKvgxt@shredder>
Subject: Re: [Bridge] [PATCH net-next 0/5] ATU and FDB synchronization on
	locked ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, netdev@kapio-technology.com, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Thu, Feb 02, 2023 at 06:36:14PM +0200, Ido Schimmel wrote:
> On Thu, Feb 02, 2023 at 05:19:07PM +0100, netdev@kapio-technology.com wrote:
> > On 2023-02-02 16:43, Ido Schimmel wrote:
> > > On Thu, Feb 02, 2023 at 08:37:08AM +0100, netdev@kapio-technology.com wrote:
> > > > On 2023-01-31 20:25, Ido Schimmel wrote:
> > > > >
> > > > > Will try to review tomorrow, but it looks like this set is missing
> > > > > selftests. What about extending bridge_locked_port.sh?
> > > > 
> > > > I knew you would take this up. :-)
> > > > But I am not sure that it's so easy to have selftests here as it is timing
> > > > based and it would take the 5+ minutes just waiting to test in the stadard
> > > > case, and there is opnly support for mv88e6xxx driver with this
> > > > patch set.
> > > 
> > > The ageing time is configurable: See commit 081197591769 ("selftests:
> > > net: bridge: Parameterize ageing timeout"). Please add test cases in the
> > > next version.
> > 
> > When I was looking at configuring the ageing time last time, my finding was
> > that the ageing time could not be set very low as there was some part in the
> > DSA layer etc, and confusion wrt units. I think the minimum secured was like
> > around 2 min. (not validated), which is not that much of an improvement for
> > fast testing. If you know what would be a good low timeout to set, I would
> > like to know.
> 
> My point is that the ageing time is parametrized via 'LOW_AGEING_TIME'
> in forwarding.config so just use '$LOW_AGEING_TIME' in the selftest and
> set it as high as it needs to be for mv88e6xxx in your own
> forwarding.config.

FWIW, we have a forwarding.config file in tools/testing/selftests/drivers/net/dsa/.
So you could cd to that folder, edit the file with your variable, and run the symlinked
script from there.

> as there was some part in the DSA layer etc

	if (ds->ageing_time_min && ageing_time < ds->ageing_time_min)
		return -ERANGE;

High tech, advanced software.....

You could print the ds->ageing_time_min variable. For mv88e6xxx, my 6390
and 6190 report 3750. I have to admit the ageing time units are confusing,
but Tobias Waldekranz kindly explained in one of those commit messages
that Ido linked to that these represent "centiseconds" (or 37.5 seconds).
And I think we discussed the units with you before. And in general, it's
not hard to find the answer if you search for it, I know I could find it.

Please stop trying to find silly excuses to always go through the path
of minimal resistance.
