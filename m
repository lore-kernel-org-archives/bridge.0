Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DC1B404AE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C4DC4048E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2zKEe2WpPkQsCm9Emx4T56l4ghxotjkOXeaugFlX20=;
 b=IYhrKQipjnaKq8ePaUTD1JWYBTvn3bVHXWUJh3SPomCwtAeOQBZXSHxZBR9NBh85rin6Z1bt9qdfuwARYRxHEUxZU1q1dKLytffX1fE1GlmG2LMXNtY8Fcg/nRz4qtYXTDEA1sq6GPge3x82YSNcW/+NsnCjCS/UUZqbPJ/W4rQ/vvdVTN1X4m7RbVBbNqTYK41mzyzM6t7IwKU5UTQzErn7HwNgEB76MeaixCI9o/QNmCe1MLeC7p/LIKsdxB0cddbwuEq04+QN7fENz5rNuk8r2+8Nl+HlwgjZ85Jz3Vq0E5ClIM6Y/KioVNul3IZof9i8nt/8/nGbcS95bHP3tA==
Date: Sat, 27 Aug 2022 21:34:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YwpjqpmG0YaisS9J@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-3-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826114538.705433-3-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v5 net-next 2/6] net: switchdev: add support
 for offloading of fdb locked flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Fri, Aug 26, 2022 at 01:45:34PM +0200, Hans Schultz wrote:
> @@ -1403,6 +1404,15 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  		if (!p)
>  			flags |= BIT(BR_FDB_LOCAL);
>  
> +		if (locked)
> +			flags |= BIT(BR_FDB_ENTRY_LOCKED);
> +
> +		if (blackhole)
> +			flags |= BIT(BR_FDB_BLACKHOLE);
> +
> +		if (sticky)
> +			flags |= BIT(BR_FDB_STICKY);
> +

While reviewing the test cases it occurred to me that the else branch
(FDB entry already exists) needs modifications as well. Something like:

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e7f4fccb6adb..48f842a71597 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1397,6 +1397,21 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
                        modified = true;
                }
 
+               if (local != test_bit(BR_FDB_LOCAL, &fdb->flags)) {
+                       change_bit(BR_FDB_LOCAL, &fdb->flags);
+                       modified = true;
+               }
+
+               if (locked != test_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags)) {
+                       change_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags);
+                       modified = true;
+               }
+
+               if (blackhole != test_bit(BR_FDB_BLACKHOLE, &fdb->flags)) {
+                       change_bit(BR_FDB_BLACKHOLE, &fdb->flags);
+                       modified = true;
+               }
+
                if (swdev_notify)
                        set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);

>  		fdb = fdb_create(br, p, addr, vid, flags);
>  		if (!fdb) {
>  			err = -ENOMEM;
