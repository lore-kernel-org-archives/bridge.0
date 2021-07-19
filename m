Return-Path: <ioana.ciornei@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDk7iu4bU+NNj8YO6A31AIaqXeSoGpD6DvY+AqknM9Y=;
 b=KO6iAO0Tr3WDYHA4G7HCGJeI/tQzfAKVzLXrwKw/RJEP7CGDr2XGi2XF85vEAeCpeC0BP0HqnEriVkTR5OUYSxL0uZTnkPnm7YWgEq5HaSS6lGulC1YB/czZtKYOM3FRhplPUWDtZpvZuo8dAFuCi3dn3P8pxE3T7goTRPrkaK4=
From: Ioana Ciornei <ioana.ciornei@nxp.com>
Date: Mon, 19 Jul 2021 09:26:26 +0000
Message-ID: <20210719092625.tnbgghblfqiwtrwl@skbuf>
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-11-vladimir.oltean@nxp.com>
In-Reply-To: <20210718214434.3938850-11-vladimir.oltean@nxp.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F50B7B1BB8BB4E40956FFE541EF2452A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v4 net-next 10/15] net: bridge: switchdev
 object replay helpers for everybody
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ido Schimmel <idosch@idosch.org>, Marek Behun <kabel@blackhole.sk>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Steen Hegelund <Steen.Hegelund@microchip.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Lars Povlsen <lars.povlsen@microchip.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Taras Chornyi <tchornyi@marvell.com>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Jul 19, 2021 at 12:44:29AM +0300, Vladimir Oltean wrote:
> Starting with commit 4f2673b3a2b6 ("net: bridge: add helper to replay
> port and host-joined mdb entries"), DSA has introduced some bridge
> helpers that replay switchdev events (FDB/MDB/VLAN additions and
> deletions) that can be lost by the switchdev drivers in a variety of
> circumstances:
>=20
> - an IP multicast group was host-joined on the bridge itself before any
>   switchdev port joined the bridge, leading to the host MDB entries
>   missing in the hardware database.
> - during the bridge creation process, the MAC address of the bridge was
>   added to the FDB as an entry pointing towards the bridge device
>   itself, but with no switchdev ports being part of the bridge yet, this
>   local FDB entry would remain unknown to the switchdev hardware
>   database.
> - a VLAN/FDB/MDB was added to a bridge port that is a LAG interface,
>   before any switchdev port joined that LAG, leading to the hardware
>   database missing those entries.
> - a switchdev port left a LAG that is a bridge port, while the LAG
>   remained part of the bridge, and all FDB/MDB/VLAN entries remained
>   installed in the hardware database of the switchdev port.
>=20
> Also, since commit 0d2cfbd41c4a ("net: bridge: ignore switchdev events
> for LAG ports which didn't request replay"), DSA introduced a method,
> based on a const void *ctx, to ensure that two switchdev ports under the
> same LAG that is a bridge port do not see the same MDB/VLAN entry being
> replayed twice by the bridge, once for every bridge port that joins the
> LAG.
>=20
> With so many ordering corner cases being possible, it seems unreasonable
> to expect a switchdev driver writer to get it right from the first try.
> Therefore, now that we are past the beta testing period for the bridge
> replay helpers used in DSA only, it is time to roll them out to all
> switchdev drivers.
>=20
> To convert the switchdev object replay helpers from "pull mode" (where
> the driver asks for them) to a "push mode" (where the bridge offers them
> automatically), the biggest problem is that the bridge needs to be aware
> when a switchdev port joins and leaves, even when the switchdev is only
> indirectly a bridge port (for example when the bridge port is a LAG
> upper of the switchdev).
>=20
> Luckily, we already have a hook for that, in the form of the newly
> introduced switchdev_bridge_port_offload() and
> switchdev_bridge_port_unoffload() calls. These offer a natural place for
> hooking the object addition and deletion replays.
>=20
> Extend the above 2 functions with:
> - pointers to the switchdev atomic notifier (for FDB replays) and the
>   blocking notifier (for MDB and VLAN replays).
> - the "const void *ctx" argument required for drivers to be able to
>   disambiguate between which port is targeted, when multiple ports are
>   lowers of the same LAG that is a bridge port. Most of the drivers pass
>   NULL to this argument, except the ones that support LAG offload and hav=
e
>   the proper context check already in place in the switchdev blocking
>   notifier handler.
>=20
> am65_cpsw and cpsw had the same name for the switchdev notifiers, so I
> renamed the am65_cpsw ones with an am65_ prefix.
>=20
> Also unexport the replay helpers, since nobody except the bridge calls
> them directly now.
>=20
> Note that:
> (a) we abuse the terminology slightly, because FDB entries are not
>     "switchdev objects", but we count them as objects nonetheless.
>     With no direct way to prove it, I think they are not modeled as
>     switchdev objects because those can only be installed by the bridge
>     to the hardware (as opposed to FDB entries which can be propagated
>     in the other direction too). This is merely an abuse of terms, FDB
>     entries are replayed too, despite not being objects.
> (b) the bridge does not attempt to sync port attributes to newly joined
>     ports, just the countable stuff (the objects). The reason for this
>     is simple: no universal and symmetric way to sync and unsync them is
>     known. For example, VLAN filtering: what to do on unsync, disable or
>     leave it enabled? Similarly, STP state, ageing timer, etc etc. What
>     a switchdev port does when it becomes standalone again is not really
>     up to the bridge's competence, and the driver should deal with it.
>     On the other hand, replaying deletions of switchdev objects can be
>     seen a matter of cleanup and therefore be treated by the bridge,
>     hence this patch.
> (c) I do not expect a lot of functional change introduced for drivers in
>     this patch, because:
>     - nbp_vlan_init() is called _after_ netdev_master_upper_dev_link(),
>       so br_vlan_replay() should not do anything for the new drivers on
>       which we call it. The existing drivers where there was even a
>       slight possibility for there to exist a VLAN on a bridge port
>       before they join it are already guarded against this: mlxsw and
>       prestera deny joining LAG interfaces that are members of a bridge.
>     - br_fdb_replay() should now notify of local FDB entries, but I
>       patched all drivers except DSA to ignore these new entries in
>       commit 2c4eca3ef716 ("net: bridge: switchdev: include local flag
>       in FDB notifications"). Driver authors can lift this restriction
>       as they wish.
>     - br_mdb_replay() should now fix the issue described in commit
>       2c4eca3ef716 ("net: bridge: switchdev: include local flag in FDB
>       notifications") for all drivers, I don't see any downside.
>=20
> Cc: Vadym Kochan <vkochan@marvell.com>
> Cc: Taras Chornyi <tchornyi@marvell.com>
> Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
> Cc: Lars Povlsen <lars.povlsen@microchip.com>
> Cc: Steen Hegelund <Steen.Hegelund@microchip.com>
> Cc: UNGLinuxDriver@microchip.com
> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Acked-by: Ioana Ciornei <ioana.ciornei@nxp.com> # dpaa2-switch
