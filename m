Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED794610AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16ADA61087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JG0zmDr4Gx7JTYrA4JUjYF+9TusUlPQwAzE14ZbaLBE=;
 b=oRqBiOJYIlMdDowmL/wHGABFcI0fDixl2PMB36ctD5uSKk3azFGtf6qd2Fvk85nbjC
 RZGiY6WOS6aL3GADhFTaSpq9sDvNd66O4zvJIfSzbuoiU8TfqAStjiekALks5NkGSaKe
 ovGZ8gH0HmxO9jFlluSL74dBYh1vn5KfO7NSBBuv+DCGaPm6jsuW1hq8QeP+fNTfmlqX
 3IcskUgDBjlFzRib6paxCj+S90vgVnJVBiNY0ccVMPpVBJ9PeZVJOHdXXs+2uIBtQoT/
 vlsHkNs0iO6OaL9F9gRjvD02YML4zxlAojbWSyksCeYa74+TLtrx2SxLVb3arsFe5b7r
 ZhGg==
Date: Thu, 19 Jan 2023 01:01:35 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230118230135.szu6a7kvt2mjb3i5@skbuf>
References: <20230117185714.3058453-1-netdev@kapio-technology.com>
 <20230117185714.3058453-3-netdev@kapio-technology.com>
 <20230117231750.r5jr4hwvpadgopmf@skbuf>
 <e4acb7edb300d41a9459890133b928b4@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4acb7edb300d41a9459890133b928b4@kapio-technology.com>
Subject: Re: [Bridge] [RFC PATCH net-next 2/5] net: dsa: propagate flags
 down towards drivers
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

On Wed, Jan 18, 2023 at 11:35:08PM +0100, netdev@kapio-technology.com wrote:
> I am not sure I understand you entirely.
> From my standpoint I see it as so: that until now any fdb entry coming to
> port_fdb_add() (or port_fdb_del()) are seen as static entries. And this
> changes nothing with respect to those static entries as how drivers handle
> them.

This is true; it is implicit that the port_fdb_add() and port_fdb_del()
DSA methods request switches to operate on static FDB entries (in hardware).

> When the new dynamic flag is true, all drivers will ignore it in patch #3,
> so basically nothing will change by that.

This is not true, because it assumes that DSA never called port_fdb_add()
up until now for bridge FDB entries with the BR_FDB_STATIC flag unset,
which is incorrect (it did).

So what will change is that drivers which used to react to those bridge
FDB entries will stop doing so.

> Then in patch #5 the dynamic flag is handled by the mv88e6xxx driver.
> 
> I don't know the assisted_learning_on_cpu_port feature you mention, but
> there has still not been anything but static entries going towards
> port_fdb_add() yet...

For starters, you can read the commit message of the patch that
introduced it, which is d5f19486cee7 ("net: dsa: listen for
SWITCHDEV_{FDB,DEL}_ADD_TO_DEVICE on foreign bridge neighbors").
