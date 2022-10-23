Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B0A2281A1C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30F3481992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgkDohZ0nafHK3GXt9H+hoBpyjI6eM+OL0s3t8zTxNg=;
 b=O87urIu0OD9N6iqYTJL0pe6Bz2BuX74Pyv1VvVeudAnEtbk/q11TgwWEAoHp8TVA+RCgz2cif2wcvHcjr74UPaZlUY439sVCmgMYt133aQizaA0SW5tbyYeCHD5lf++2eWmaazRfJKY03TIsdtJkogVspCd9Dj2Jft6mqRnl0t4XfiW1ih7RQRQT1Ml9WLXedf2SDvbcD+3Xvgwwrk+4NJB0M3TCQMgXOzVDw4+Q+7z4vKDEZ2LkmuU0YcIXL8+eTnZANa419oVKepQ6rUfUUMSFuwnGjEbbAFLq7BwCVtu+nd3KObVN6xma86SzzVqMG78WknJprByS4o4b2hckeg==
Date: Sun, 23 Oct 2022 09:53:09 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y1Tk1eTlLI6ue8IA@shredder>
References: <82d23b100b8d2c9e4647b8a134d5cbbf@kapio-technology.com>
 <20221021112216.6bw6sjrieh2znlti@skbuf>
 <7bfaae46b1913fe81654a4cd257d98b1@kapio-technology.com>
 <20221021163005.xljk2j3fkikr6uge@skbuf>
 <d1fb07de4b55d64f98425fe66156c4e4@kapio-technology.com>
 <20221021173014.oit3qmpkrsjwzbgu@skbuf>
 <b88e331e016ad3801f1bf1a0dec507f3@kapio-technology.com>
 <20221021181411.sv52q4yxr5r7urab@skbuf> <Y1P0/gYdvrk+W866@shredder>
 <20221022144951.v2twgp2lcnhnbhrv@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022144951.v2twgp2lcnhnbhrv@skbuf>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v8 net-next 10/12] net: dsa: mv88e6xxx:
 mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, netdev@kapio-technology.com, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Oleksandr Mazur <oleksandr.mazur@plvision.eu>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Sat, Oct 22, 2022 at 05:49:51PM +0300, Vladimir Oltean wrote:
> On Sat, Oct 22, 2022 at 04:49:50PM +0300, Ido Schimmel wrote:
> > In the above scenario, learning does not need to be on for the bridge to
> > populate its FDB, but rather for the bridge to refresh the dynamic FDB
> > entries installed by hostapd. This seems like a valid use case and one
> > needs a good reason to break it in future kernels.
> 
> Before suggesting any alternatives, I'd like to know more details about
> how this will work in practice, because I'm aware of the limitations
> that come with DSA not syncing its hardware FDB with the software bridge.
> 
> So you add a dynamic FDB entry from user space, it gets propagated to
> hardware via SWITCHDEV_FDB_ADD_TO_DEVICE, and from there on, they have
> completely independent ageing timers.
> 
> You'll still suffer interruptions in authorization, if the software FDB
> entry expires because it was never refreshed (which will happen if
> traffic is forwarded autonomously and not seen by software). And at this
> stage, you could just add static FDB entries which you periodically
> delete from user space, since the effect would be equivalent.
> 
> If the mitigation to that is going to involve the extern_learn flag, the
> whole point becomes moot (for mv88e6xxx), since FDB refreshing does not
> happen in the bridge driver in that case (so the learning flag can be
> whatever).

Once a dynamic FDB entry is installed in hardware the software bridge no
longer sees the majority of the traffic that refreshes this entry, which
means we need to prevent the bridge from mindlessly ageing and removing
the entry. I see two options, depending on the capabilities of the
underlying hardware implementation:

1. If the hardware is capable of generating an event that an entry was
aged out, then once the dynamic entry was installed in hardware the
device driver needs to let the bridge driver know that it is no longer
responsible for ageing the entry. This can be done by either marking the
entry as extern_learn or offloaded. The latter is more accurate, but we
need to patch br_fdb_cleanup(). Upon an ageing event, the device driver
will tell the bridge to remove the entry via
SWITCHDEV_FDB_DEL_TO_BRIDGE.

2. If the hardware is unable to generate ageing events, but allows
querying the activity of the entry, then the device driver will need to
emulate the behavior of the first option. This allows us to use the same
interface between the bridge and device driver regardless of the
underlying hardware implementation. My feeling is that most devices fall
in the first category.

> > Regarding learning from link-local frames, this can be mitigated by [2]
> > without adding additional checks in the bridge. I don't know why this
> > bridge option was originally added, but if it wasn't for this use case,
> > then now it has another use case.
> 
> There is still the problem that link-local learning is on by default
> (follows the BR_LEARNING setting of the port). I don't feel exactly
> comfortable with the fact that it's easy for a user to miss this and
> leave the port completely insecure.

I'm willing to patch the man page and add a note near the 'locked'
bridge port option.

> > Regarding MAB, from the above you can see that a pure 802.1X
> > implementation that does not involve MAB can benefit from locked bridge
> > ports with learning enabled. It is therefore not accurate to say that
> > one wants MAB merely by enabling learning on a locked port. Given that
> > MAB is a proprietary extension and much less secure than 802.1X, we can
> > assume that there will be deployments out there that do not use MAB and
> > do not care about notifications regarding locked FDB entries. I
> > therefore think that MAB needs to be enabled by a separate bridge port
> > flag that is rejected unless the bridge port is locked and has learning
> > enabled.
> 
> I had missed the detail that dynamic FDB entries will be refreshed only
> with "learning" on. It makes the picture more complete. Only this is
> said in "man bridge":
> 
>        learning on or learning off
>               Controls whether a given port will learn MAC addresses
>               from received traffic or not. If learning if off, the
>               bridge will end up flooding any traffic for which it has
>               no FDB entry. By default this flag is on.
> 
> Can live with MAB being a separate flag if it comes to that, as long as
> 'learning' will continue to have its own specific meaning, independent
> of it (right now that meaning is subtle and undocumented, but makes sense).

Yes, I agree it is subtle.

> > Regarding hardware offload, I have an idea (needs testing) on how to
> > make mlxsw work in a similar way to mv88e6xxx. That is, does not involve
> > injecting frames that incurred a miss to the Rx path. If you guys want,
> > I'm willing to take a subset of the patches here, improve the commit
> > message, do some small changes and submit them along with an mlxsw
> > implementation. My intention is not to discredit anyone (I will keep the
> > original authorship), but to help push this forward and give another
> > example of hardware offload.
> > 
> > [1] https://github.com/westermo/hostapd/commit/10c584b875a63a9e58b0ad39835282545351c30e#diff-338b6fad34b4bdb015d7d96930974bd96796b754257473b6c91527789656d6ed
> > [2] https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=c74a8bc9cf5d6b6c9d8c64d5a80c5740165f315a
> 
> I think it would be very nice if you could do that. As a middle ground
> between mv88e6xxx and mlxsw, I can also try to build a setup on ocelot
> (which should trap frames with MAC SA misses in a similar way to mlxsw,
> but does also not sync its FDB with the bridge, similar to the mv88e6xxx.
> Not sure what to do with dynamic FDB entries).

Will try to post my patches this week.

> If only I would figure out how to configure that hostapd fork (something
> which I never did before).
> 
> Hans, would it be possible to lay out some usage instructions for this fork?

That would be good.
