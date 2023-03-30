Return-Path: <hans@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E39760AEF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34AF160AC4
From: Hans Schultz <netdev@kapio-technology.com>
In-Reply-To: <ZCUuMosWbyq1pK8R@shredder>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-7-netdev@kapio-technology.com>
 <ZBgdAo8mxwnl+pEE@shredder> <87a5zzh65p.fsf@kapio-technology.com>
 <ZCMYbRqd+qZaiHfu@shredder> <87fs9ollmn.fsf@kapio-technology.com>
 <ZCUuMosWbyq1pK8R@shredder>
Date: Thu, 30 Mar 2023 12:29:18 +0200
Message-ID: <87mt3u7csh.fsf@kapio-technology.com>
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
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated
 list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1
 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Thu, Mar 30, 2023 at 09:37, Ido Schimmel <idosch@nvidia.com> wrote:
> On Tue, Mar 28, 2023 at 09:30:08PM +0200, Hans Schultz wrote:
>> 
>> Sorry, but I have sent you several emails telling you about the problems
>> I have with running the selftests due to changes in the phy etc. Maybe
>> you have just not received all those emails?
>> 
>> Have you checked spamfilters?
>> 
>> With the kernels now, I cannot even test with the software bridge and
>> selftests as the compile fails - probably due to changes in uapi headers
>> compared to what the packages my system uses expects.
>
> My spam filters are fine. I saw your emails where you basically said
> that you are too lazy to setup a VM to test your patches and that your
> time is more valuable than mine, which is why I should be testing them.
> Stop making your problems our problems. It's hardly the first time. If
> you are unable to test your patches, then invest the time in fixing your
> setup instead of submitting completely broken patches and making it our
> problem to test and fix them. I refuse to invest time in reviewing /
> testing / reworking your submissions as long as you insist on doing less
> than the bare minimum.
>
> Good luck

I never said or indicated that my time is more valuable than yours. I
have a VM to run these things that some have spent countless hours to
develop with the right tools etc installed and set up. Fixing that
system will take quite many hours for me, so I am asking for some simple
assistance from someone who already has a system running supporting the
newest kernel.

Alternatively if there is an open sourced system available that would be
great.

As this patch-set is for the community and some companies that would
like to use it and not for myself, I am asking for some help from the
community with a task that when someone has the system in place should
not take more than 15-20 minutes, maybe even less.
