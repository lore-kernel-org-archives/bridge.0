Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F4129410D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44706410C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5M8Fx1V6BI9wC4Rfe4cdEOngK8wJXgYTrL1iDgs66Q=;
 b=F9UWqSRerbKkdC7/PEgRQL6dpyJmzEedY7clfpPJgtBfUhHkOA7rCpckCu2t5wsKGsZRVqo0Jrli/A8nCYP6/PQt0PYOX/mQCKz70pThCQot3b47k0U4SfQpfBaU1G88yBPWv0/NMdMPi6c8mRoKeZf5XjkD442xM33pgvpJnBeI2MaqlxfWXg0piM5r5jfE/s1BXSVilHJ+Ni+rHLXbFSU1eFnLuuWp2MOBwTF10HOfICx4UToB5Pq1+sxjK3PVCsIEwKZPBW69vguWcgQ0JTgUImmhhK56h7VAi18XS1ehNSe29a8ssUd2ghrLIabt/2cIv9DALO/UXbgYSbcBgQ==
Date: Wed, 28 Sep 2022 09:59:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YzPwwuCe0HkJpkQe@shredder>
References: <Yxmgs7Du62V1zyjK@shredder>
 <8dfc9b525f084fa5ad55019f4418a35e@kapio-technology.com>
 <20220908112044.czjh3xkzb4r27ohq@skbuf>
 <152c0ceadefbd742331c340bec2f50c0@kapio-technology.com>
 <20220911001346.qno33l47i6nvgiwy@skbuf>
 <15ee472a68beca4a151118179da5e663@kapio-technology.com>
 <Yx73FOpN5uhPQhFl@shredder>
 <086704ce7f323cc1b3cca78670b42095@kapio-technology.com>
 <Yyq6BnUfctLeerqE@shredder>
 <7a4549d645f9bbbf41e814f087eb07d1@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4549d645f9bbbf41e814f087eb07d1@kapio-technology.com>
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

Sorry for the delay, was away.

On Tue, Sep 27, 2022 at 10:33:10AM +0200, netdev@kapio-technology.com wrote:
> On 2022-09-21 09:15, Ido Schimmel wrote:
> > 	bridge fdb add `mac_get $h2` dev br0 blackhole
> 
> To make this work, I think we need to change the concept, so that blackhole
> FDB entries are added to ports connected to the bridge, thus
>      bridge fdb add MAC dev $swpX master blackhole
> 
> This makes sense as the driver adds them based on the port where the SMAC is
> seen, even though the effect of the blackhole FDB entry is switch wide.

Asking user space to associate a blackhole entry with a bridge port does
not make sense to me because unlike regular entries, blackhole entries
do not forward packets out of this port. Blackhole routes and nexthops
are not associated with a device either.

> Adding them to the bridge (e.g. f.ex. br0) will not work in the SW bridge as
> the entries then are not found.

Why not found? This works:

 # bridge fdb add 00:11:22:33:44:55 dev br0 self local
 $ bridge fdb get 00:11:22:33:44:55 br br0
 00:11:22:33:44:55 dev br0 master br0 permanent

With blackhole support I expect:

 # bridge fdb add 00:11:22:33:44:55 dev br0 self local blackhole
 $ bridge fdb get 00:11:22:33:44:55 br br0
 00:11:22:33:44:55 dev br0 master br0 permanent blackhole
