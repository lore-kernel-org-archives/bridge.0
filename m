Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6ECC241EC2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C30C1404A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680204455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=THXcfT1gL+QhHkNxKHFXSnGLhR291IgK2JOIaE2Z6qo=;
 b=WmGqWWMzTa4UZZyZupqoOaK6GO0R0gyuPF1w/NqQwOR3PF78xzpkBDkvwwgDoKpLe/
 TO8kQ7yjlIBI/KZP17rpKiGl91hhAscGFQWH8bwfzCwzF7hgA/t1yf2YQ/fuHiOp/Y4S
 m7R0idI3KheKtG2pQCctaTWNZDNuq+HWnorSSdiqG/ymH92rpMLkcGFTOyTtxfcqdxFI
 +HSWS3FP+TZoKgHMkZWokuQpZ/GTLBA5F8DvRGoeZUmx6bxve4cZDoFXog93Ecc/69uL
 FX3PpBeZ/ZID2bZIVnqkah/3XdryzZGiTLyPvI6m/Fr5UTO00wLm0O169i2aocSTk7oI
 jxWg==
Date: Thu, 30 Mar 2023 22:27:14 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230330192714.oqosvifrftirshej@skbuf>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-7-netdev@kapio-technology.com>
 <ZBgdAo8mxwnl+pEE@shredder> <87a5zzh65p.fsf@kapio-technology.com>
 <ZCMYbRqd+qZaiHfu@shredder> <874jq22h2u.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jq22h2u.fsf@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v2 net-next 6/6] selftests: forwarding: add
 dynamic FDB test
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, open list <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Ido Schimmel <idosch@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Thu, Mar 30, 2023 at 09:07:53PM +0200, Hans Schultz wrote:
> Not true, it reveals that I forgot to put it in the patch, that's all. As
> I cannot run several of these tests because of memory constraints I link
> the file to a copy in a rw area where I modify the list and just run one
> of the subtests at a time. If I try to run the whole it always fails
> after a couple of sub-tests with an error.
> 
> It seems to me that these scripts are quite memory consuming as they
> accumulate memory consuption in relation to what is loaded along the
> way. A major problem with my system.

I'm sorry for perhaps asking something entirely obvious, but have you tried:

kernel-dir $ rsync -avr tools/testing/selftests/ root@$board:selftests/
board $ cd selftests/drivers/net/dsa/
board $ ./bridge_locked_port.sh lan0 lan1 lan2 lan3

?

This is how I always run them, and it worked fine with both Debian
(where it's easy to add missing packages to the rootfs) or with a more
embedded-oriented Buildroot.
