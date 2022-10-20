Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13EBA42257
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9335642264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDjlAV2B5PLWaEiiAhnQ3gBii1XZvZttHzVQXmFo82I=;
 b=PiOk1hZV8RsHJgz/bSeNc/o22QGZtXNazdIr1EydeD43PCfiQtLzD9zjNPIOYtzl1jE5paIz7T5G2FNVlTzXwNimd96TiR3lUXj5/VYAV1BpwT3d962XAYwCew0w0EhjOZ2u4Xi9CdPHWEoGCjg4dQYmy/4e86h9c+89vKQbF11lf0i3K0qE1xfk9N3Op2pdvi2UOZvwEyvEvMM2J2FvhfeK3qU4XVmwv4svPJ1TRV+xGral1Fc8+mNzugJ93bNGYXAMZbCJjrnHR8IOMMYcA4s9ME1lK0F94W9Qwrq8XQYzmA1VKcBjI9on29auusEfCUFLw5YcSbNetMAJryRLgQ==
Date: Thu, 20 Oct 2022 17:58:42 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y1FiImF3i4s0bLuD@shredder>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221020130224.6ralzvteoxfdwseb@skbuf> <Y1FMAI9BzDRUPi5Y@shredder>
 <20221020133506.76wroc7owpwjzrkg@skbuf> <Y1FTzyPdTbAF+ODT@shredder>
 <20221020140400.h4czo4wwv7erncy7@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020140400.h4czo4wwv7erncy7@skbuf>
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

On Thu, Oct 20, 2022 at 05:04:00PM +0300, Vladimir Oltean wrote:
> On Thu, Oct 20, 2022 at 04:57:35PM +0300, Ido Schimmel wrote:
> > On Thu, Oct 20, 2022 at 04:35:06PM +0300, Vladimir Oltean wrote:
> > > On Thu, Oct 20, 2022 at 04:24:16PM +0300, Ido Schimmel wrote:
> > > > On Thu, Oct 20, 2022 at 04:02:24PM +0300, Vladimir Oltean wrote:
> > > > > On Tue, Oct 18, 2022 at 06:56:12PM +0200, Hans J. Schultz wrote:
> > > > > > @@ -3315,6 +3316,7 @@ static int dsa_slave_fdb_event(struct net_device *dev,
> > > > > >  	struct dsa_port *dp = dsa_slave_to_port(dev);
> > > > > >  	bool host_addr = fdb_info->is_local;
> > > > > >  	struct dsa_switch *ds = dp->ds;
> > > > > > +	u16 fdb_flags = 0;
> > > > > >  
> > > > > >  	if (ctx && ctx != dp)
> > > > > >  		return 0;
> > > > > > @@ -3361,6 +3363,9 @@ static int dsa_slave_fdb_event(struct net_device *dev,
> > > > > >  		   orig_dev->name, fdb_info->addr, fdb_info->vid,
> > > > > >  		   host_addr ? " as host address" : "");
> > > > > >  
> > > > > > +	if (fdb_info->locked)
> > > > > > +		fdb_flags |= DSA_FDB_FLAG_LOCKED;
> > > > > 
> > > > > This is the bridge->driver direction. In which of the changes up until
> > > > > now/through which mechanism will the bridge emit a
> > > > > SWITCHDEV_FDB_ADD_TO_DEVICE with fdb_info->locked = true?
> > > > 
> > > > I believe it can happen in the following call chain:
> > > > 
> > > > br_handle_frame_finish
> > > >    br_fdb_update // p->flags & BR_PORT_MAB
> > > >        fdb_notify
> > > >            br_switchdev_fdb_notify
> > > > 
> > > > This can happen with Spectrum when a packet ingresses via a locked port
> > > > and incurs an FDB miss in hardware. The packet will be trapped and
> > > > injected to the Rx path where it should invoke the above call chain.
> > > 
> > > Ah, so this is the case which in mv88e6xxx would generate an ATU
> > > violation interrupt; in the Spectrum case it generates a special packet.
> > 
> > Not sure what you mean by "special" :) It's simply the packet that
> > incurred the FDB miss on the SMAC.
> > 
> > > Right now this packet isn't generated, right?
> > 
> > Right. We don't support BR_PORT_LOCKED so these checks are not currently
> > enabled in hardware. To be clear, only packets received via locked ports
> > are able to trigger the check.
> > 
> > > 
> > > I think we have the same thing in ocelot, a port can be configured to
> > > send "learn frames" to the CPU.
> > > 
> > > Should these packets be injected into the bridge RX path in the first
> > > place? They reach the CPU because of an FDB miss, not because the CPU
> > > was the intended destination.
> > 
> > The reason to inject them to the Rx path is so that they will trigger
> > the creation of the "locked" entry in the bridge driver (when MAB is
> > on), thereby notifying user space about the presence of a new MAC behind
> > the locked port. We can try to parse them in the driver and notify the
> > bridge driver via SWITCHDEV_FDB_ADD_TO_BRIDGE, but it's quite ugly...
> 
> "ugly" => your words, not mine... But abstracting things a bit, doing
> what you just said (SWITCHDEV_FDB_ADD_TO_BRIDGE) for learn frames would
> be exactly the same thing as what mv88e6xxx is doing (so your "ugly"
> comment equally applies to Marvell).

My understanding is that mv88e6xxx only reads the SMAC and FID/VID from
hardware and notifies them to the bridge driver. It does not need to
parse them out of the Ethernet frame that triggered the "violation".
This is the "ugly" part (in my opinion).

> The learn frames are "special" in the sense that they don't belong to
> the data path of the software bridge*, they are just hardware specific
> information which the driver must deal with, using a channel that
> happens to be Ethernet and not an IRQ/MDIO.

I think we misunderstand each other because I don't understand why you
call them "special" nor "hardware specific information" :/ We don't
inject to the software data path some hardware specific frames, but
rather the original Ethernet frames that triggered the violation. The
same thing happens with packets that encountered a neighbour miss during
routing or whose TTL was decremented to zero. The hardware can't
generate ARP or ICMP packets, so the original packet is injected to the
Rx path so that the kernel will generate the necessary control packets
in response.

> *in other words, a bridge with proper RX filtering should not even
> receive these frames, or would need special casing for BR_PORT_MAB to
> not drop them in the first place.
> 
> I would incline towards an unified approach for CPU assisted learning,
> regardless of this (minor, IMO) difference between Marvell and other
> vendors.

OK, understood. Assuming you don't like the above, I need to check if we
can do something similar to what mv88e6xxx is doing (because I don't
think mv88e6xxx can do anything else).
