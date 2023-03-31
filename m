Return-Path: <hans@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F099844B6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4F67844B5
From: Hans Schultz <netdev@kapio-technology.com>
In-Reply-To: <20230330192714.oqosvifrftirshej@skbuf>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-7-netdev@kapio-technology.com>
 <ZBgdAo8mxwnl+pEE@shredder> <87a5zzh65p.fsf@kapio-technology.com>
 <ZCMYbRqd+qZaiHfu@shredder> <874jq22h2u.fsf@kapio-technology.com>
 <20230330192714.oqosvifrftirshej@skbuf>
Date: Fri, 31 Mar 2023 09:43:34 +0200
Message-ID: <874jq1mkm1.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, open list <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated
 list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Ido Schimmel <idosch@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1
 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Thu, Mar 30, 2023 at 22:27, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Thu, Mar 30, 2023 at 09:07:53PM +0200, Hans Schultz wrote:
>> Not true, it reveals that I forgot to put it in the patch, that's all. As
>> I cannot run several of these tests because of memory constraints I link
>> the file to a copy in a rw area where I modify the list and just run one
>> of the subtests at a time. If I try to run the whole it always fails
>> after a couple of sub-tests with an error.
>> 
>> It seems to me that these scripts are quite memory consuming as they
>> accumulate memory consuption in relation to what is loaded along the
>> way. A major problem with my system.
>
> I'm sorry for perhaps asking something entirely obvious, but have you tried:
>
> kernel-dir $ rsync -avr tools/testing/selftests/ root@$board:selftests/
> board $ cd selftests/drivers/net/dsa/
> board $ ./bridge_locked_port.sh lan0 lan1 lan2 lan3
>
> ?
>
> This is how I always run them, and it worked fine with both Debian
> (where it's easy to add missing packages to the rootfs) or with a more
> embedded-oriented Buildroot.

I am not entirely clear of your idea. You need somehow to boot into a
system with the patched net-next kernel or you have a virtual machine
boot into a virtual OS. I guess it is the last option you refer to using
Debian?
