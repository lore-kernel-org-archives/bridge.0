Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EFFE408B7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35E0C408B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679957977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vs0lU2V659xfolR59bwYcxi0Nnjs4lVJmYEM9MkDucs=;
 b=kFSkbnLqBTXNziv2ifVthZxzOmPB3NbYEkyApURx8Oas8cCHPoSS+CWMJMLfkMaLxQ
 w3sBU0oRxauj492NqBP2NgItJC1pPYs7kn8NrUixuqvWmRXRZQ8HPHYwcIjs96dXvWjp
 kCc8POpRIpAim8K2sBnk1cfPBh1RbpSBOJBYwmF8yJbYD8hs5Zs0qFy7EGFZTsaQtx/u
 pwVF8TdXHKwGg54Yl6dKMbsFS4C54UWykPKT4U9BWOAjMgUl2eoKbpSU2uEIQmQwLbd0
 BYfxpA3JXHG6Y8LZgt14VH7NdJl6oasHvJPk4YHThi6kd+oe59qgKHgCPPRy1yxb4dR7
 CyOQ==
Date: Tue, 28 Mar 2023 01:59:33 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230327225933.plm5raegywbe7g2a@skbuf>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-3-netdev@kapio-technology.com>
 <20230327115206.jk5q5l753aoelwus@skbuf>
 <87355qb48h.fsf@kapio-technology.com>
 <20230327160009.bdswnalizdv2u77z@skbuf>
 <87pm8tooe1.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm8tooe1.fsf@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v2 net-next 2/6] net: dsa: propagate flags down
 towards drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Mon, Mar 27, 2023 at 11:49:58PM +0200, Hans Schultz wrote:
> My first approach was to use the SWITCHDEV_FDB_ADD_TO_BRIDGE event
> and not the SWITCHDEV_FDB_OFFLOADED event as the first would set the
> external learned flag which is not aged out by the bridge.

Link to patch? I don't see any SWITCHDEV_FDB_ADD_TO_BRIDGE call in
either the v1:
https://lore.kernel.org/netdev/20230130173429.3577450-6-netdev@kapio-technology.com/
or the RFC:
https://lore.kernel.org/netdev/20230117185714.3058453-6-netdev@kapio-technology.com/
and the change log does not mention it either.

> I have at some point earlier asked why there would be two quite
> equivalent flags and what the difference between them are, but I didn't
> get a response.

Actually, the part which you are now posing as a question (what is the
difference?) was part of the premise of your earlier question (there is
no difference => why do we have both?).
https://lore.kernel.org/netdev/d972e76bed896b229d9df4da81ad8eb4@kapio-technology.com/

I believe that no one answered because the question was confused and it
wasn't really clear what you were asking.

> 
> Now I see the difference and that I cannot use the offloaded flag
> without changing the behaviour of the system as I actually change the
> behaviour of the offloaded flag in this version of the patch-set.
> 
> So if the idea of a 'synthetically' learned fdb entry from the driver
> using the SWITCHDEV_FDB_ADD_TO_BRIDGE event from the driver towards the
> bridge instead is accepted, I can go with that?
> (thus removing all the changes in the patch-set regarding the offloaded
> flag ofcourse)

which idea is that, again?
