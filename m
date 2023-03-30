Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 426E6403A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 867864037E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680191092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lU9JCkTye6Fj+qGS5BcJ6TDCunaP0ev1Z3VOnL6O7u8=;
 b=ARXUEmqMaQiFvA623fC9h/1bTtbZu+9APT25M51Fyzal5QyyBhpNOKenjrxHC9tNvl
 S5qRlO9XoSCMeMsGUxdNgy5JziINi0lqiObnEMVskhrUlgY/Nx4DIG0QNEQsDohNNwVI
 ZjpV6n4C/vseZe/Yaal+huKNBxLZRFnxa87dsmJ+XNyIozRshatOv7uSBF+5zoQgGC9u
 APpkQ7cgiCA7P+a0ITBi0t+ePzbvRC6ZSQ8PNQFlEV5Nkz3BPNiKrW3feDlfatNMu8VV
 ylQbTLsNnGSA8P3WnQGfjLEZ3+xacpPhY8gzVJGbk7L8KERA9bNGO7XypeGYZuS4b7+c
 MaZw==
Date: Thu, 30 Mar 2023 18:44:31 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230330154431.vii5llyqgiymievp@skbuf>
References: <20230327225933.plm5raegywbe7g2a@skbuf>
 <87ileljfwo.fsf@kapio-technology.com>
 <20230328114943.4mibmn2icutcio4m@skbuf>
 <87cz4slkx5.fsf@kapio-technology.com>
 <20230330124326.v5mqg7do25tz6izk@skbuf>
 <87wn2yxunb.fsf@kapio-technology.com>
 <20230330130936.hxme34qrqwolvpsh@skbuf>
 <875yaimgro.fsf@kapio-technology.com>
 <20230330150752.gdquw5kudtrqgzyz@skbuf>
 <877cuy6ynf.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cuy6ynf.fsf@kapio-technology.com>
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

On Thu, Mar 30, 2023 at 05:34:44PM +0200, Hans Schultz wrote:
> On Thu, Mar 30, 2023 at 18:07, Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> > Then, make DSA decide whether to handle the "added_by_user && !is_static"
> > combination or not, based on the presence of the DSA_FDB_FLAG_DYNAMIC
> > flag, which will be set in ds->supported_fdb_flags only for the mv88e6xxx
> > driver.
> 
> Okay, so this will require a new function in the DSA layer that sets
> which flags are supported and that the driver will call on
> initialization.
> 
> Where (in the DSA layer) should such a function be placed and what
> should it be called?

Don't overthink it, no new function. It's okay to just set
ds->supported_fdb_flags = DSA_FDB_FLAG_DYNAMIC in
mv88e6xxx_register_switch(), near the place where it currently sets
ds->num_lag_ids. Either before dsa_register_switch(), or within the
ds->ops->setup(). Both are fine, since the user network interfaces
haven't been allocated just yet by dsa_slave_create() and so, the
switchdev code path is inaccessible.

Existing drivers will have ds->supported_fdb_flags = 0 by default, since
they allocate the struct dsa_switch with kzalloc(), and DSA will have to
do something sane with that.
