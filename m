Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 421F481D02
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF74881CDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmojUwGvuBPC2+8KcDSWClnwjj6lQdxfL7qXg2y2ooI=;
 b=T4gGqb3F1OLoUxY8FM8Elw8glVtmg+LcRgWJo4xS40DmiOD3s10o9eh2Qf1uP3B/T0tymsVA1Za2Sw+2PTqJ6Tmou2G8R94prKLEdDgKuXB0f3kwJJxMJITLidNyw+56+10K/pixROrELd7n2TS4/Bd8c24RIFIgmkcsHseTOoz1iQsZTe7Ca6XN0onY98vQQ1zIM/F6vrSALD84GklzBakTRQh0+D9gQTcABhjCH1CxLKtIvqNTzTLmMNIpsYwiREYmznzZoO4WgXtWsVbjjNA+EH9oqp6Xbh70LOMaJkw1FAtcynhS41V5BbZ/Vbp+enfK+fynU7eC/jsR/DD3IA==
Date: Wed, 28 Sep 2022 11:46:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YzQJ5MRSL/ShRSgP@shredder>
References: <20220908112044.czjh3xkzb4r27ohq@skbuf>
 <152c0ceadefbd742331c340bec2f50c0@kapio-technology.com>
 <20220911001346.qno33l47i6nvgiwy@skbuf>
 <15ee472a68beca4a151118179da5e663@kapio-technology.com>
 <Yx73FOpN5uhPQhFl@shredder>
 <086704ce7f323cc1b3cca78670b42095@kapio-technology.com>
 <Yyq6BnUfctLeerqE@shredder>
 <7a4549d645f9bbbf41e814f087eb07d1@kapio-technology.com>
 <YzPwwuCe0HkJpkQe@shredder>
 <0c6b93c828d9b52346ddb3d445446734@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6b93c828d9b52346ddb3d445446734@kapio-technology.com>
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

On Wed, Sep 28, 2022 at 09:47:42AM +0200, netdev@kapio-technology.com wrote:
> On 2022-09-28 08:59, Ido Schimmel wrote:
> 
> > Why not found? This works:
> > 
> >  # bridge fdb add 00:11:22:33:44:55 dev br0 self local
> >  $ bridge fdb get 00:11:22:33:44:55 br br0
> 
> With:
>  # bridge fdb replace 00.11.22.33.44.55 dev $swpX static
> 
> fdb_find_rcu() will not find the entry added with 'dev br0' above, and will
> thus add a new entry afaik.

It needs "master" keyword:

 $ bridge fdb get 00:11:22:33:44:55 br br0
 Error: Fdb entry not found.
 # bridge fdb add 00:11:22:33:44:55 dev br0 self local
 $ bridge fdb get 00:11:22:33:44:55 br br0
 00:11:22:33:44:55 dev br0 master br0 permanent
 # bridge fdb replace 00:11:22:33:44:55 dev dummy10 master static
 $ bridge fdb get 00:11:22:33:44:55 br br0
 00:11:22:33:44:55 dev dummy10 master br0 static

"master" means manipulate the FDB of the master device. Therefore, the
replace command manipulates the FDB of br0.

"self" (which is the default [1]) means manipulate the FDB of the device
itself. In case of br0 it means manipulate the FDB of the bridge device.
For physical devices it usually translates to manipulating the unicast
address filter list.

[1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/bridge/fdb.c#n511
