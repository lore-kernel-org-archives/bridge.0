Return-Path: <simon.horman@corigine.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A06D60BF2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76D7560BD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKVGHeb22qzfhzH0WK8BTep6YXmUCvDuCjosBg2TlME=;
 b=k1g+GkDzccdzfKSIT/dygh80YJRCc31I/6xqX09BwfCf33Deb4MU1wi4kawYFLkmFLeTXEpkkKvUfeyEdlY99Vt3pvZOj3GzgAf9/ZnYo5/Jc+ajG3DJlYI4OvHHnxp2R9qVayXIf2tZpjk2edxhWY6ucJhV73L1qqVDOe88VXE=
Date: Mon, 20 Feb 2023 15:11:19 +0100
From: Simon Horman <simon.horman@corigine.com>
Message-ID: <Y/N/h5WMRzl0i2IT@corigine.com>
References: <20230130173429.3577450-6-netdev@kapio-technology.com>
 <Y9lkXlyXg1d1D0j3@corigine.com>
 <9b12275969a204739ccfab972d90f20f@kapio-technology.com>
 <Y9zDxlwSn1EfCTba@corigine.com>
 <20230203204422.4wrhyathxfhj6hdt@skbuf>
 <Y94TebdRQRHMMj/c@corigine.com>
 <4abbe32d007240b9c3aea9c8ca936fa3@kapio-technology.com>
 <Y+EkiAyexZrPoCpP@corigine.com>
 <87fsb83q5s.fsf@kapio-technology.com>
 <20230217174431.bkkvfmtno56mfh5a@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217174431.bkkvfmtno56mfh5a@skbuf>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 5/5] net: dsa: mv88e6xxx:
 implementation of dynamic ATU entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Hans Schultz <netdev@kapio-technology.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Fri, Feb 17, 2023 at 07:44:31PM +0200, Vladimir Oltean wrote:
> On Tue, Feb 14, 2023 at 10:14:55PM +0100, Hans Schultz wrote:
> > On Mon, Feb 06, 2023 at 17:02, Simon Horman <simon.horman@corigine.com> wrote:
> > >
> > > Just to clarify my suggestion one last time, it would be along the lines
> > > of the following (completely untested!). I feel that it robustly covers
> > > all cases for fdb_flags. And as a bonus doesn't need to be modified
> > > if other (unsupported) flags are added in future.
> > >
> > > 	if (fdb_flags & ~(DSA_FDB_FLAG_DYNAMIC))
> > > 		return -EOPNOTSUPP;
> > >
> > > 	is_dynamic = !!(fdb_flags & DSA_FDB_FLAG_DYNAMIC)
> > > 	if (is_dynamic)
> > > 		state = MV88E6XXX_G1_ATU_DATA_STATE_UC_AGE_7_NEWEST;
> > >
> > >
> > > And perhaps for other drivers:
> > >
> > > 	if (fdb_flags & ~(DSA_FDB_FLAG_DYNAMIC))
> > > 		return -EOPNOTSUPP;
> > > 	if (fdb_flags)
> > > 		return 0;
> > >
> > > Perhaps a helper would be warranted for the above.
> > 
> > How would such a helper look? Inline function is not clean.
> > 
> > >
> > > But in writing this I think that, perhaps drivers could return -EOPNOTSUPP
> > > for the DSA_FDB_FLAG_DYNAMIC case and the caller can handle, rather tha
> > > propagate, -EOPNOTSUPP.
> > 
> > I looked at that, but changing the caller is also a bit ugly.
> 
> Answering on behalf of Simon, and hoping he will agree.

Sorry for not responding earlier - I was on vacation last week.

TBH my idea was not nearly as well developed as the one you describe below.
But yes, I agree this is an interesting approach.

> You are missing a big opportunity to make the kernel avoid doing useless work.
> The dsa_slave_fdb_event() function runs in atomic switchdev notifier context,
> and schedules a deferred workqueue item - dsa_schedule_work() - to get sleepable
> context to program hardware.
> 
> Only that scheduling a deferred work item is not exactly cheap, so we try to
> avoid doing that unless we know that we'll end up doing something with that
> FDB entry once the deferred work does get scheduled:
> 
> 	/* Check early that we're not doing work in vain.
> 	 * Host addresses on LAG ports still require regular FDB ops,
> 	 * since the CPU port isn't in a LAG.
> 	 */
> 	if (dp->lag && !host_addr) {
> 		if (!ds->ops->lag_fdb_add || !ds->ops->lag_fdb_del)
> 			return -EOPNOTSUPP;
> 	} else {
> 		if (!ds->ops->port_fdb_add || !ds->ops->port_fdb_del)
> 			return -EOPNOTSUPP;
> 	}
> 
> What you should be doing is you should be using the pahole tool to find
> a good place for a new unsigned long field in struct dsa_switch, and add
> a new field ds->supported_fdb_flags. You should extend the early checking
> from dsa_slave_fdb_event() and exit without doing anything if the
> (fdb->flags & ~ds->supported_fdb_flags) expression is non-zero.
> 
> This way you would kill 2 birds with 1 stone, since individual drivers
> would no longer need to check the flags; DSA would guarantee not calling
> them with unsupported flags.
> 
> It would be also very good to reach an agreement with switchdev
> maintainers regarding the naming of the is_static/is_dyn field.
> 
> It would also be excellent if you could rename "fdb_flags" to just
> "flags" within DSA.
