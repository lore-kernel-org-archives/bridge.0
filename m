Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CBBEF41BE8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5294C41B87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1675352614; x=1675439014; bh=JOJYIxLhKlqXLrEBq+v5LlENJBXu
 /0YMWzvW35tuScA=; b=m84jr8rKQV77Hb2CmakvgDV89DA0ahqSC9yuKDL6rjip
 xqThy9a3EDhOe7S1QQXC/FOAlej+sJovhmyCI82ZlkzBXvfb0DKAvIr68wAA0zuT
 lqyMTRCZaPCOfHTJFCDXNq+/G9cOttfUr+M34Ty0V6qCPeARAsRXDJKD7PD7q3Xk
 bDVjhYjpnWTH21BRAtqa4cdgylS7bPRO/pN4REBryibmmeJPZ2Iq582Uhh7z7CfY
 fyUxmXAqFRMj1pvmgaqi9YeXpMOq37zQo5tPy8GaWLs1MEJzdEHMQNJwQb9AYrD9
 ROk/hoKvpk8yF52jkKzvAcLYB4qy1Dhjww3ZrMOMiQ==
Date: Thu, 2 Feb 2023 17:43:28 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <Y9vaIOefIf/gI0BR@shredder>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <Y9lrIWMnWLqGreZL@shredder>
 <e2535b002be9044958ab0003d8bd6966@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2535b002be9044958ab0003d8bd6966@kapio-technology.com>
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

On Thu, Feb 02, 2023 at 08:37:08AM +0100, netdev@kapio-technology.com wrote:
> On 2023-01-31 20:25, Ido Schimmel wrote:
> > 
> > Will try to review tomorrow, but it looks like this set is missing
> > selftests. What about extending bridge_locked_port.sh?
> 
> I knew you would take this up. :-)
> But I am not sure that it's so easy to have selftests here as it is timing
> based and it would take the 5+ minutes just waiting to test in the stadard
> case, and there is opnly support for mv88e6xxx driver with this patch set.

The ageing time is configurable: See commit 081197591769 ("selftests:
net: bridge: Parameterize ageing timeout"). Please add test cases in the
next version.
