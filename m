Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60F8740483
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 735C0400A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JglhUSuAsvyo/02iuoDdhbFLRdL0c14GOno7/e71c6I=;
 b=UVFcLtLRlFJ23BO5nFdHnG4XQRcYTdnQfD3m/QakLfwgOixkkCd7UJlVA+CHErZDSK
 yqcpu2eHqMGfmTPApN2EotBAlWuycXT2OjFAFM1+5hggxKMnxWXGuezOaAd4WEJlzw/E
 QwfCAicGgtNoOd8NE+jP3QuxiLJQ5qMyH/pDBuCnlZYt4z3r6VCKUlsfCNk+YLZNLAOA
 jZfpDE2kC2IhtsQcsYya9US9kOGVA9O8AzfTEwo/8FQZKplzXol7D+K0m8g9+ZJMdMlA
 7qnuH1rqNqLEFKQ+7QqHXn3BuFaESpqJ+j9E4Q1RUqqQor0Pmd9ogjMf6JpK5JbYc/PN
 U2Rw==
Date: Fri, 21 Oct 2022 01:43:34 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221020224334.ksh4xciad7yro3cj@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-4-netdev@kapio-technology.com>
 <20221020125549.v6kls2lk7etvay7c@skbuf>
 <e1184c879642c35e4ff6f19e0fd5de46@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1184c879642c35e4ff6f19e0fd5de46@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v8 net-next 03/12] net: bridge: enable bridge
 to install locked fdb entries from drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Fourcot <florent.fourcot@wifirst.fr>, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Thu, Oct 20, 2022 at 09:29:06PM +0200, netdev@kapio-technology.com wrote:
> On 2022-10-20 14:55, Vladimir Oltean wrote:
> > On Tue, Oct 18, 2022 at 06:56:10PM +0200, Hans J. Schultz wrote:
> > > diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> > > index 8f3d76c751dd..c6b938c01a74 100644
> > > --- a/net/bridge/br_switchdev.c
> > > +++ b/net/bridge/br_switchdev.c
> > > @@ -136,6 +136,7 @@ static void br_switchdev_fdb_populate(struct
> > > net_bridge *br,
> > >  	item->added_by_user = test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
> > >  	item->offloaded = test_bit(BR_FDB_OFFLOADED, &fdb->flags);
> > >  	item->is_local = test_bit(BR_FDB_LOCAL, &fdb->flags);
> > > +	item->locked = test_bit(BR_FDB_LOCKED, &fdb->flags);
> > 
> > Shouldn't this be set to 0 here, since it is the bridge->driver
> > direction?
> 
> Wouldn't it be a good idea to allow drivers to add what corresponds to a blackhole
> entry when using the bridge input chain to activate the MAB feature, or in general
> to leave the decision of what to do to the driver implementation?

The patch doesn't propose that. It proposes:

| net: bridge: enable bridge to install locked fdb entries from drivers
| 
| The bridge will be able to install locked entries when receiving
| SWITCHDEV_FDB_ADD_TO_BRIDGE notifications from drivers.

Please write patches which make just one logical change, and explain the
justification for that change and precisely that change in the commit
message.
