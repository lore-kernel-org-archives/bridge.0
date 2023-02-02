Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A633760AD2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 034F861180
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1675355779; x=1675442179; bh=TIhEi6ttvP0lJU+5WCdxSL+GeMSa
 1GjHCMM3WgC2HbI=; b=VSnQjrveDF/yWKN17jbl9A9KQ/20d/BLeyFmh0sJKD56
 mr2sArWTxPJqrq0t21IsDdsmuGPwzjV8N3BCxZkYApxD4AySNsR8Q5pubCcrm6N9
 v0HNjbvyq7XNxz9EYe+S74z9J/64clwZjICyOemliKqsmTlJfD7umrgNMaGtDvZF
 7JacA/sjYffBIvZagOMjNOrS0z10yFIYqa8FiZMC5IFBwQCfv4xQy+FRhe582e1k
 A8T2NY+LPGDILcFXSBNzbXL2a2UtxlBylDyeMxSkQTdTwfh7P3BFj3neTk9MmiRM
 rIWs41yaVPnc6rZqsp87EV/xcK6pkXDGagWgLvyOJQ==
Date: Thu, 2 Feb 2023 18:36:14 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <Y9vmfoaFxPdKvgxt@shredder>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <Y9lrIWMnWLqGreZL@shredder>
 <e2535b002be9044958ab0003d8bd6966@kapio-technology.com>
 <Y9vaIOefIf/gI0BR@shredder>
 <3cecf4425b0e6f38646e25e40fd8f0fd@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cecf4425b0e6f38646e25e40fd8f0fd@kapio-technology.com>
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
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Thu, Feb 02, 2023 at 05:19:07PM +0100, netdev@kapio-technology.com wrote:
> On 2023-02-02 16:43, Ido Schimmel wrote:
> > On Thu, Feb 02, 2023 at 08:37:08AM +0100, netdev@kapio-technology.com
> > wrote:
> > > On 2023-01-31 20:25, Ido Schimmel wrote:
> > > >
> > > > Will try to review tomorrow, but it looks like this set is missing
> > > > selftests. What about extending bridge_locked_port.sh?
> > > 
> > > I knew you would take this up. :-)
> > > But I am not sure that it's so easy to have selftests here as it is
> > > timing
> > > based and it would take the 5+ minutes just waiting to test in the
> > > stadard
> > > case, and there is opnly support for mv88e6xxx driver with this
> > > patch set.
> > 
> > The ageing time is configurable: See commit 081197591769 ("selftests:
> > net: bridge: Parameterize ageing timeout"). Please add test cases in the
> > next version.
> 
> When I was looking at configuring the ageing time last time, my finding was
> that the ageing time could not be set very low as there was some part in the
> DSA layer etc, and confusion wrt units. I think the minimum secured was like
> around 2 min. (not validated), which is not that much of an improvement for
> fast testing. If you know what would be a good low timeout to set, I would
> like to know.

My point is that the ageing time is parametrized via 'LOW_AGEING_TIME'
in forwarding.config so just use '$LOW_AGEING_TIME' in the selftest and
set it as high as it needs to be for mv88e6xxx in your own
forwarding.config.
