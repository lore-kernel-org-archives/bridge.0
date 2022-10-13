Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 898D240461
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F3FF40154
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIXQvwJJFko1U7G4y756veRno+JNEMjMBv70kE44UMc=;
 b=g3seb9VIi43/u7sftABt7ojQTG3YhTCWJ5WU3FAg58TkqIOyBnC3chPnQVVFxy8D4UXfnMMlReaLlY6wgPMN4kdPJrSfiO0kPcyuBEVAU5eURm/oRRKRY2uGP8Aj+h3zJ8IEKpVqY4awqs6rBHwDwX/4sQZ0blv/7ihTfqtX283uATf3Z4F3uBnYHMfhBftXn9pFHV+Y2AN31bV4xpRrg7O06tQx/DUeKzsO9X9HwIUXg/EvlER4U4YquOtyDCqfOLZRYiSFwxyWV7XFmyncn4nr1cusqFqXLvnSSv/j7NpTjumzvTEFmrMK43frPV2tU+PEED76Y4ZoC2IMPeTZKA==
Date: Thu, 13 Oct 2022 17:28:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y0ggn5SZnw+4SGLC@shredder>
References: <20221009174052.1927483-1-netdev@kapio-technology.com>
 <20221009174052.1927483-10-netdev@kapio-technology.com>
 <21f799c5a7a79e2e4b111a95fff6fe3d@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f799c5a7a79e2e4b111a95fff6fe3d@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v7 net-next 9/9] selftests: forwarding: add
 test of MAC-Auth Bypass to locked port tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Wed, Oct 12, 2022 at 11:46:55AM +0200, netdev@kapio-technology.com wrote:
> Ido, have you had time to look at this patch set, and do I need to release a
> v8 to fix those two forgotten statics and maybe also this new switchcore
> driver that was not there when I posted this patch set?

I don't know which changes you are referring to, but v8 should
incorporate all the changes requested so far. Do not post it as long as
net-next is closed (unless marked as RFC):

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#how-often-do-changes-from-these-trees-make-it-to-the-mainline-linus-tree
