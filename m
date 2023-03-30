Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 803B3605E0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E37D160E13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680188893;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z0Z7V7Ss/AtXBRghpZkg8HPKEk/gIK+rbrkFIOnWykw=;
 b=hrKdvXgmz+intqH6k/82qhZO+TXJRFUbWkit5YyihN3zsu13/kSZ0hpW0LVa5b7XVy
 h+KE9JOb8fFAzZYG60AOgY5RNeZjapZ/L4Q/l8g7HQ/PudZPn7BQcfZPJUOnIezdbY4C
 WSW3uXVaJ72O2Q73JC17f1rYt+NLA0tgOfwHgId0U4xbayGoLw4zd3TjSMl1QDWNgoay
 yTwQK2Gz1n74v92l4Hst8OFJ8LVY/EVXYX0JhaQjQyWBDAUqOmPaaYMrR+yRmkM0qv9w
 Gx2josZg2bXesXPWbGOJJSnHTl4S9C2rpx+jZ2yk/jHkgPBwBiMzTH317fUL6yDpgkZ4
 ScyQ==
Date: Thu, 30 Mar 2023 18:07:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230330150752.gdquw5kudtrqgzyz@skbuf>
References: <20230327160009.bdswnalizdv2u77z@skbuf>
 <87pm8tooe1.fsf@kapio-technology.com>
 <20230327225933.plm5raegywbe7g2a@skbuf>
 <87ileljfwo.fsf@kapio-technology.com>
 <20230328114943.4mibmn2icutcio4m@skbuf>
 <87cz4slkx5.fsf@kapio-technology.com>
 <20230330124326.v5mqg7do25tz6izk@skbuf>
 <87wn2yxunb.fsf@kapio-technology.com>
 <20230330130936.hxme34qrqwolvpsh@skbuf>
 <875yaimgro.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yaimgro.fsf@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v2 net-next 2/6] net: dsa: propagate flags down
 towards drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Thu, Mar 30, 2023 at 04:54:19PM +0200, Hans Schultz wrote:
> I don't know if you have a solution in mind wrt the behaviour of the
> offloaded flag if it is not to do as it does now and let the bridge age
> out dynamic entries. That led me to conclude that this patch-set cannot
> use the offloaded flag, but you seem to suggest otherwise.
> 
> If you have a suggestion, feel free.

Didn't I explain what I would do from the first reply on this thread?
https://patchwork.kernel.org/project/netdevbpf/patch/20230318141010.513424-3-netdev@kapio-technology.com/#25270613

As a bug fix, stop reporting to switchdev those FDB entries with
BR_FDB_ADDED_BY_USER && !BR_FDB_STATIC. Then, after "net" is merged into
"net-next" next Thursday (the ship has sailed for today), add "bool static"
to the switchdev notifier info, and make all switchdev drivers (everywhere
where a SWITCHDEV_FDB_ADD_TO_DEVICE handler appears) ignore the
"added_by_user && !is_static" combination, but by their own choice and
not by switchdev's choice.

Then, make DSA decide whether to handle the "added_by_user && !is_static"
combination or not, based on the presence of the DSA_FDB_FLAG_DYNAMIC
flag, which will be set in ds->supported_fdb_flags only for the mv88e6xxx
driver. When DSA_FDB_FLAG_DYNAMIC is not supported, DSA will not offload
the FDB entry: neither will it call port_fdb_add(), nor will it emit
SWITCHDEV_FDB_OFFLOADED. Ideally, it would also inform user space that
it can't offload this flag by returning an error, but the lack of an
error propagation mechanism from switchdev to the bridge FDB is a known
limitation which is hard to overcome, and is outside the scope of your
patchset I believe. To see whether DSA has acted upon the "master dynamic"
flag or not, it would be good enough for the user to see something
adequate in "bridge fdb show | grep offloaded", I believe.
