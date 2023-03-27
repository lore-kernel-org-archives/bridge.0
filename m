Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AA606059C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5936360586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679917930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=reW1DVwM1zk8Q9iqp1u3bB31mlwrsAJaRz6RuSIoXIU=;
 b=M1zZJS7aR62kTdJ1jkufI//A+r0KrxQx24PFXrRWBX2xnMPE6tABYKqI2H4s2xqk3u
 lx715LjMHeL8JxddEDtGvf2MqmMZJu6/KNdO1igiaFxZyAKXsKvr02xlpfrVKi8TevBp
 QR9RxKgUwi/MVBJ1Axaj3wUOgXnTbx3ATx3JvSxb7YnmtnYvKvq9MCSEU+5gtUju8znz
 gjDAS/0UoZyMaEr1mmzJnF0mhrczZe+NnIt+99HuglMce8Q5Zattl2b85mo1jKFyfBOO
 rkOXXjLLpDbqJTJ0hIeVxNAszfJyAi/5uEwHLIePTh+Q+hEKTm+896smc6GdIy8TqZA2
 1j3Q==
Date: Mon, 27 Mar 2023 14:52:06 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230327115206.jk5q5l753aoelwus@skbuf>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-3-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318141010.513424-3-netdev@kapio-technology.com>
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
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Sat, Mar 18, 2023 at 03:10:06PM +0100, Hans J. Schultz wrote:
> diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> index e5f156940c67..c07a2e225ae5 100644
> --- a/net/dsa/dsa.c
> +++ b/net/dsa/dsa.c
> @@ -626,6 +626,12 @@ static int dsa_switch_setup(struct dsa_switch *ds)
>  
>  	ds->configure_vlan_while_not_filtering = true;
>  
> +	/* Since dynamic FDB entries are legacy, all switch drivers should
> +	 * support the flag at least by just installing a static entry and
> +	 * letting the bridge age it.
> +	 */
> +	ds->supported_fdb_flags = DSA_FDB_FLAG_DYNAMIC;

I believe that switchdev has a structural problem in the fact that FDB
entries with flags that aren't interpreted by drivers (so they don't
know if those flags are set or unset) are still passed to the switchdev
notifier chains by default.

I don't believe that anybody used 'bridge fdb add <mac> <dev> master dynamic"
while relying on a static FDB entry in the DSA offloaded data path.

Just like commit 6ab4c3117aec ("net: bridge: don't notify switchdev for
local FDB addresses"), we could deny that for stable kernels, and add
the correct interpretation of the flag in net-next.

Ido, Nikolay, Roopa, Jiri, thoughts?

> +
>  	err = ds->ops->setup(ds);
>  	if (err < 0)
>  		goto unregister_notifier;

By the way, there is a behavior change here.

Before:

$ ip link add br0 type bridge && ip link set br0 up
$ ip link set swp0 master br0 && ip link set swp0 up
$ bridge fdb add dev swp0 00:01:02:03:04:05 master dynamic
[   70.010181] mscc_felix 0000:00:00.5: felix_fdb_add: port 0 addr 00:01:02:03:04:05 vid 0
[   70.019105] mscc_felix 0000:00:00.5: felix_fdb_add: port 0 addr 00:01:02:03:04:05 vid 1
.... 5 minutes later
[  371.686935] mscc_felix 0000:00:00.5: felix_fdb_del: port 0 addr 00:01:02:03:04:05 vid 1
[  371.695449] mscc_felix 0000:00:00.5: felix_fdb_del: port 0 addr 00:01:02:03:04:05 vid 0
$ bridge fdb | grep 00:01:02:03:04:05

After:

$ ip link add br0 type bridge && ip link set br0 up
$ ip link set swp0 master br0 && ip link set swp0 up
$ bridge fdb add dev swp0 00:01:02:03:04:05 master dynamic
[  222.071492] mscc_felix 0000:00:00.5: felix_fdb_add: port 0 addr 00:01:02:03:04:05 vid 0 flags 0x1
[  222.081154] mscc_felix 0000:00:00.5: felix_fdb_add: port 0 addr 00:01:02:03:04:05 vid 1 flags 0x1
.... 5 minutes later
$ bridge fdb | grep 00:01:02:03:04:05
00:01:02:03:04:05 dev swp0 vlan 1 offload master br0 stale
00:01:02:03:04:05 dev swp0 offload master br0 stale
00:01:02:03:04:05 dev swp0 vlan 1 self
00:01:02:03:04:05 dev swp0 self

As you can see, the behavior is not identical, and it made more sense
before.
