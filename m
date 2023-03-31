Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E438740093
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A2A4400A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680255456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2I7yU40CH1KTIPKs6kPsl2SefiwR2YueS62dP0NZHu0=;
 b=CULtuAu+grWGSjin+B2q5K4vYLYkcVUEPT39QZYv//yLch8kj4X27vymmyL6jBA+6i
 ACX6DSEhIpF/wfIzCNgePEz4Vh8s7ay58GscTeT85T1s0GBwPwzwrUMGQt5B18kY6yGt
 6pnNAfBEPK90KIPsAWjhQtATM+vY7j2qnuCzy28AkPwgdA0wZiMdDFqUAjg5x0HOdywP
 RCbkrkVCOApLgALXeDU7BFWqM8Jw0onrurgD9v1FxXo9Pjel8PvrWFWJbC8sy/v87HQY
 6igVRZ6GHH31atrxF93yu5HzZFuCVxemH5qtqiMhRdt4LWTplUbroNn5PAMAJQxsMd+q
 tVxA==
Date: Fri, 31 Mar 2023 12:37:32 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230331093732.s6loozkdhehewlm4@skbuf>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-7-netdev@kapio-technology.com>
 <ZBgdAo8mxwnl+pEE@shredder> <87a5zzh65p.fsf@kapio-technology.com>
 <ZCMYbRqd+qZaiHfu@shredder> <874jq22h2u.fsf@kapio-technology.com>
 <20230330192714.oqosvifrftirshej@skbuf>
 <871ql5mjjp.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871ql5mjjp.fsf@kapio-technology.com>
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

On Fri, Mar 31, 2023 at 10:06:34AM +0200, Hans Schultz wrote:
> The memory problems are of course on the embedded target. In that case I
> think it would be a very good idea to do something to design the system
> better, so that it frees memory between the subtests.

People like Martin Blumenstingl have managed to deploy and run the
networking kselftests on OpenWRT, which typically runs on very
resource-constrained embedded devices.
https://lore.kernel.org/netdev/CAFBinCDX5XRyMyOd-+c_Zkn6dawtBpQ9DaPkA4FDC5agL-t8CA@mail.gmail.com/
https://lore.kernel.org/netdev/20220707135532.1783925-1-martin.blumenstingl@googlemail.com/

Considering that, you'll have to come with a much more concrete description
of why the system should be "designed better" and "free memory between
subtests" (what memory?!) before you could run it on your target system.

Either that, or at least take into serious consideration the fact that you
may be hung up on doing something which isn't necessary for the end goal.

I simply have no clue what you're talking about. It's as if we're talking
about completely different things.

> If all tests are always run on the bridge only, I think they don't make
> much sense as these patchsets are directed towards switchcores.

Is this supposed to mean something, or is it just a random thought you
had, that you believed it would be good to share with us?

The tools/testing/selftests/net/forwarding/lib.sh central framework has
the NETIF_TYPE and NETIF_CREATE variables, which indicate that by default,
veth interfaces are created. When running a bridge selftest with veth as
bridge ports, indeed software bridging should take place, and those
selftests should work fine. In Linux, the software behavior represents a
model for the offload behavior, since offloads are 100% transparent to
the user most of the time.

Below in lib.sh, there is a line which sources "$relative_path/forwarding.config",
a file which can contain customizations of the default variables used by
the framework. Even though it isn't strictly necessary to put the
customized bash variables in a forwarding.config file, it is more
convenient to do this than to specify them as environment variables.

If you "cd tools/testing/selftests/drivers/net/dsa/", you will find
precisely such a forwarding.config file there, which contains the line
"NETIF_CREATE=no", which means that when you run the symlinked sub-group
of forwarding tests relevant to DSA from this folder, the expectation is
that the bridge ports are not veth interfaces created for the test, but
rather, physical ports.

So, by running the command I posted in the earlier email, you actually
run it on the physical DSA user port interfaces, and it should pass
there too. This is based on the equivalency principle between the
software and the hardware data paths that I was talking about.

If you're actively and repeatedly making an effort to work with your eyes
closed, and then build strawmen around the fact that you don't see, then
you're not going to get very friendly reactions from people, me included,
who explain things to you that pertain to your due diligence. This is
because these people know the things that they're explaining to you out
of their own due diligence, and, as a result, are not easily fooled by
your childish excuses.
