Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54EF6411AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BCD3B411A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaA/vhJtZKpr0s2EktWOS6qma2h9xSmkonCZoNVig+Y=;
 b=rq9YY7xdCtPuLb7jSOdeoODdqz9rwMH3Wwi/V0WBpEyCRF3jguvXRsQyKwqOSwB+5dI/WJ5h46R314ejAPAN5/Kd/xMZfK2rqwSTm+zCGNb5aXLn7CYdLWEcnxwc2aFxxM3mvhfhXkYBSekynGEaNPW8gcR3rkh37m26cygIQ/Q4Ipq2S8Cm0n1832iDr7JiqtMst5FpMB+oJX7WrGV4gjCf4pNn8PiJKpcapfnuOWJHG+2v+W8Rc9wPIjxFKXZU/AoepTRO+dpVgforfx4uSQxhHsYS48rLvABMbOcMt3szwLQCriyL+Pjuveg3yj9pOhLUPyad47hTRRmUNfXDmA==
Date: Thu, 8 Sep 2022 10:59:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Yxmgs7Du62V1zyjK@shredder>
References: <YwxtVhlPjq+M9QMY@shredder>
 <2967ccc234bb672f5440a4b175b73768@kapio-technology.com>
 <Ywyj1VF1wlYqlHb6@shredder>
 <9e1a9eb218bbaa0d36cb98ff5d4b97d7@kapio-technology.com>
 <YwzPJ2oCYJQHOsXD@shredder>
 <69db7606896c77924c11a6c175c4b1a6@kapio-technology.com>
 <YwzjPcQjfLPk3q/k@shredder>
 <f1a17512266ac8b61444e7f0e568aca7@kapio-technology.com>
 <YxNo/0+/Sbg9svid@shredder>
 <5cee059b65f6f7671e099150f9da79c1@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cee059b65f6f7671e099150f9da79c1@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v5 net-next 6/6] selftests: forwarding: add
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
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Wed, Sep 07, 2022 at 11:10:07PM +0200, netdev@kapio-technology.com wrote:
> I am at the blackhole driver implementation now, as I suppose that the
> iproute2 command should work with the mv88e6xxx driver when adding blackhole
> entries (with a added selftest)?
> I decided to add the blackhole feature as new ops for drivers with functions
> blackhole_fdb_add() and blackhole_fdb_del(). Do you agree with that
> approach?

I assume you are talking about extending 'dsa_switch_ops'? If so, it's
up to the DSA maintainers to decide.
