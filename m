Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 089DA41EE1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FC1041EDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680794523;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W8yHOaVQ4mahqDoWUZZ0X3+twLrUdiCW/OQNIgPHkpM=;
 b=oZwLocsV6/myf95tPXquC5P3/ayH6gAbBmWdKPVSUnZn6kRTeDqScnnIn5GIxlwbz8
 nJZGvjOLRNAUgjKN8PXwWDCRcZdQQt4RZRHWNK89ycCHgppu7C7O4ozWDeJaf41K61Uh
 XCHSLNMP4ONIQjVBXkMf3l59MTq8pFp/jjC78wzeOS3zutEYhIVWmg4bj8p5L5DGPRsg
 0AOgBoukthw2oMSbXy0UwTa90FzkZqEBtvZJoMFgwYe2I8IudvnqJLxGrI48c+S2ONUQ
 rMDe4Q+9Kvi+Z/zD00KMVwCpG6F+iLyt51C8aFhkLH0FITM+kp655rE19bJGxaKHTUQ5
 YXNw==
Date: Thu, 6 Apr 2023 18:21:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230406152159.zfg6kxuimulnpops@skbuf>
References: <20230327225933.plm5raegywbe7g2a@skbuf>
 <87ileljfwo.fsf@kapio-technology.com>
 <20230328114943.4mibmn2icutcio4m@skbuf>
 <87cz4slkx5.fsf@kapio-technology.com>
 <20230330124326.v5mqg7do25tz6izk@skbuf>
 <87wn2yxunb.fsf@kapio-technology.com>
 <20230330130936.hxme34qrqwolvpsh@skbuf>
 <875yaimgro.fsf@kapio-technology.com>
 <20230330150752.gdquw5kudtrqgzyz@skbuf>
 <87o7o1ox9h.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7o1ox9h.fsf@kapio-technology.com>
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

On Thu, Apr 06, 2023 at 05:17:46PM +0200, Hans Schultz wrote:
> On Thu, Mar 30, 2023 at 18:07, Vladimir Oltean <olteanv@gmail.com> wrote:
> > As a bug fix, stop reporting to switchdev those FDB entries with
> > BR_FDB_ADDED_BY_USER && !BR_FDB_STATIC. Then, after "net" is merged into
> > "net-next" next Thursday (the ship has sailed for today), add "bool static"
> 
> It is probably too late today (now I have a Debian based VM that can do
> the selftests), but with this bug fix I have 1) not submitted bug fixes
> before and 2) it probably needs an appropriate explanation, where I
> don't know the problem well enough for general switchcores to submit
> with a suitable text.

Do you want me to try to submit this change as a bug fix?
