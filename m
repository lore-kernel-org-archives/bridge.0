Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6EBD681E85
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98D5C81CDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680180209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n/8td5sRl3oLpjvJWr+SauyjMW5J+/af8DNO0aQQsj4=;
 b=R6I/30BG5UPA5FkYjKVUOSk8ON+L56EIBLONKVcUcG66As/OewLwhMJOEZ7pH/CLIF
 lw5Ldo93TyCnbouWW7sn6r3X1q4G9eBsDkqM7EGHS++EvGHXZ1BPDKRnhCkRnHpH3k7W
 toyOaQ8AdiCXYmHXxTqfMSFBKgw1bzxE4IuGtB3xQgGZ5fyVGYpbDHx/jTc/43Plix+k
 TfXLtwH042/qHJ2RMlQ5OwK2exvA5LqhC/2Bcjao6WLpg3vfRYD38I+FcWic3HWgUBY4
 0OuxkiVp/bNVDNwReIudGNhx0j7PVxoWzHj4bgO+e68KZRf4WBgjXUwtpjuoIHRN3Bwa
 nxMg==
Date: Thu, 30 Mar 2023 15:43:26 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230330124326.v5mqg7do25tz6izk@skbuf>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-3-netdev@kapio-technology.com>
 <20230327115206.jk5q5l753aoelwus@skbuf>
 <87355qb48h.fsf@kapio-technology.com>
 <20230327160009.bdswnalizdv2u77z@skbuf>
 <87pm8tooe1.fsf@kapio-technology.com>
 <20230327225933.plm5raegywbe7g2a@skbuf>
 <87ileljfwo.fsf@kapio-technology.com>
 <20230328114943.4mibmn2icutcio4m@skbuf>
 <87cz4slkx5.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz4slkx5.fsf@kapio-technology.com>
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

On Tue, Mar 28, 2023 at 09:45:26PM +0200, Hans Schultz wrote:
> So the solution would be to not let the DSA layer send the
> SWITCHDEV_FDB_OFFLOADED event in the case when the new dynamic flag is
> set?

I have never said that.
