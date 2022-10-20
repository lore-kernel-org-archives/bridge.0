Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C8E8640936
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9C2A40908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiAnkFhTNtZ+cXSzdoH6LBgydFuoZNuEPknI4Ct6Cpw=;
 b=Em1ga+64y5dPii0oSfQtbbXnQgt9zNcXT9Ll0TAhoooy3GYoIQyQjWPUFLw6AjVgawaNE1H/zAZ2CPtaUTJiqWL9Aab6K9dHedtr7s6G7W1BqELCbqwwpIGdGF5lofpBU8H52kfNggOKCxoU35ePKbdTx3nz2g98cyhgpi23wQt4DvbezBUeYiWvrHTjGfkD6aTG8EVjCDvSUMd1BlCK/9lEyPEkyd3oxpCrbpGxOdVzuSGcqCX2heGDDFByAw/UcZVNA6HjpnbA/1BdPIvqwjs1OQxR6KudTjOhNnCJP5eNqvfFYwCCQtE3eHKNpWzSIGGVpXvr31EaFTvQctQ+vg==
Date: Thu, 20 Oct 2022 16:24:16 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y1FMAI9BzDRUPi5Y@shredder>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221020130224.6ralzvteoxfdwseb@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020130224.6ralzvteoxfdwseb@skbuf>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v8 net-next 05/12] net: dsa: propagate the
 locked flag down through the DSA layer
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, "Hans J. Schultz" <netdev@kapio-technology.com>, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Thu, Oct 20, 2022 at 04:02:24PM +0300, Vladimir Oltean wrote:
> On Tue, Oct 18, 2022 at 06:56:12PM +0200, Hans J. Schultz wrote:
> > @@ -3315,6 +3316,7 @@ static int dsa_slave_fdb_event(struct net_device *dev,
> >  	struct dsa_port *dp = dsa_slave_to_port(dev);
> >  	bool host_addr = fdb_info->is_local;
> >  	struct dsa_switch *ds = dp->ds;
> > +	u16 fdb_flags = 0;
> >  
> >  	if (ctx && ctx != dp)
> >  		return 0;
> > @@ -3361,6 +3363,9 @@ static int dsa_slave_fdb_event(struct net_device *dev,
> >  		   orig_dev->name, fdb_info->addr, fdb_info->vid,
> >  		   host_addr ? " as host address" : "");
> >  
> > +	if (fdb_info->locked)
> > +		fdb_flags |= DSA_FDB_FLAG_LOCKED;
> 
> This is the bridge->driver direction. In which of the changes up until
> now/through which mechanism will the bridge emit a
> SWITCHDEV_FDB_ADD_TO_DEVICE with fdb_info->locked = true?

I believe it can happen in the following call chain:

br_handle_frame_finish
   br_fdb_update // p->flags & BR_PORT_MAB
       fdb_notify
           br_switchdev_fdb_notify

This can happen with Spectrum when a packet ingresses via a locked port
and incurs an FDB miss in hardware. The packet will be trapped and
injected to the Rx path where it should invoke the above call chain.

> Don't the other switchdev drivers except DSA (search for SWITCHDEV_FDB_EVENT_TO_DEVICE
> in the drivers/ folder) need to handle this new flag too, even if to reject it?

Yes, agree. At least with mlxsw it is not a big deal right now because
it ignores entries with !BR_FDB_ADDED_BY_USER and locked entries are
always like that, but it would be good to make it more explicit.

> 
> When other drivers will want to look at fdb_info->locked, they'll have
> the surprise that it's impossible to maintain backwards compatibility,
> because they didn't use to treat the flag at all in the past (so either
> locked or unlocked, they did the same thing).
> 
> > +
> >  	INIT_WORK(&switchdev_work->work, dsa_slave_switchdev_event_work);
> >  	switchdev_work->event = event;
> >  	switchdev_work->dev = dev;
> > @@ -3369,6 +3374,7 @@ static int dsa_slave_fdb_event(struct net_device *dev,
> >  	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
> >  	switchdev_work->vid = fdb_info->vid;
> >  	switchdev_work->host_addr = host_addr;
> > +	switchdev_work->fdb_flags = fdb_flags;
