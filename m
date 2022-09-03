Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D04E440484
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1470440283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjhX63khefmEPOZBGQ4oiXb3rTJ+88WV+CjkJ1/kR5g=;
 b=hesk5c84ZzuLcFFSvtHMnnaNVqSbzwCTMIQzQbmOA4m1VEdj25+7zUhImKEs+nwPP/KXYWG6Dq6m9ohaDd+9SReqTxY5hYrQoKQcgZvnRSpwUPCiW4PlISrW1ulA8zRkbnjbY+QhU3KQhGU4VYu+a/waXp5AbO5YAofn+Ad7gTs8H1NpqT26osMIkeRT26lZL/SDL3XdQQkA2JXl8xcsHd8tSe2NOni0ijWjn1llczEKl9Ro49asKJYHh23oVHF9DEhcYgu+V7+UusVn5d/C6pPDKlun42+omO+O68uxweG8SbTXgvEnM8MP5ZdteZdM2Wzq73DJiHC58sJaIECA3g==
Date: Sat, 3 Sep 2022 17:49:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YxNpg76H9ma2zNhZ@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-7-netdev@kapio-technology.com>
 <YwpgvkojEdytzCAB@shredder>
 <b28717f593461865bbfa6bf12e99a2a1@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28717f593461865bbfa6bf12e99a2a1@kapio-technology.com>
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

On Mon, Aug 29, 2022 at 06:07:59PM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-27 20:21, Ido Schimmel wrote:
> > On Fri, Aug 26, 2022 at 01:45:38PM +0200, Hans Schultz wrote:
> 
> > > +	$MZ $h2 -q -t udp -a $mac -b rand
> > > +	bridge fdb show dev $swp2 | grep -q "$mac vlan 1 master br0"
> > > +	check_err $? "Locked port station move: Entry not found on
> > > unlocked port"
> > 
> > Looks like this is going to fail with offloaded data path as according
> > to fdb_print_flags() in iproute2 both the "extern_learn" and "offload"
> > flags will be printed before "master".
> > 
> 
> The output shows like:
> 74:e1:e1:2c:4f:18 dev eth8 vlan 1 master br0 extern_learn offload sticky
> locked blackhole
> 
> "sticky" will of course become "permanent", but I can still make it more
> resilient by piping grep.

OK.

> 
> I suppose that I will keep the "sticky_no_roaming" test even though it is
> not really needed here anymore?

You can send it separately if you want.
