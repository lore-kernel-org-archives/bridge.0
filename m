Return-Path: <ioana.ciornei@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LIyvsYtzRhURqLRstFh+fa3PQsRBnRa3uC/qWvQOyM=;
 b=bV/eTio4MMnqYPXpu7y/ymh7MOKrFv6hEXa9JJnHFPkSvJuxKeG7sTCffwKUeuQ6JDA80Iw2tjuhLdhHjT0pPUnpoCe90TnXdc8z/1RbRX2gDTXjCgrtij6C1/evXjldp5voO6BSLgOuE+R7EezzGOxEHjhReJm7kwHkS/tWdGo=
From: Ioana Ciornei <ioana.ciornei@nxp.com>
Date: Mon, 19 Jul 2021 09:23:49 +0000
Message-ID: <20210719092348.wzpnhcrib24m7zpw@skbuf>
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-10-vladimir.oltean@nxp.com>
In-Reply-To: <20210718214434.3938850-10-vladimir.oltean@nxp.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0E76103D6D80A49B174BFEF581FDFC4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v4 net-next 09/15] net: bridge: switchdev: let
 drivers inform which bridge ports are offloaded
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

On Mon, Jul 19, 2021 at 12:44:28AM +0300, Vladimir Oltean wrote:
> On reception of an skb, the bridge checks if it was marked as 'already
> forwarded in hardware' (checks if skb->offload_fwd_mark =3D=3D 1), and if=
 it
> is, it assigns the source hardware domain of that skb based on the
> hardware domain of the ingress port. Then during forwarding, it enforces
> that the egress port must have a different hardware domain than the
> ingress one (this is done in nbp_switchdev_allowed_egress).
>=20
> Non-switchdev drivers don't report any physical switch id (neither
> through devlink nor .ndo_get_port_parent_id), therefore the bridge
> assigns them a hardware domain of 0, and packets coming from them will
> always have skb->offload_fwd_mark =3D 0. So there aren't any restrictions=
.
>=20
> Problems appear due to the fact that DSA would like to perform software
> fallback for bonding and team interfaces that the physical switch cannot
> offload.
>=20
>        +-- br0 ---+
>       / /   |      \
>      / /    |       \
>     /  |    |      bond0
>    /   |    |     /    \
>  swp0 swp1 swp2 swp3 swp4
>=20
> There, it is desirable that the presence of swp3 and swp4 under a
> non-offloaded LAG does not preclude us from doing hardware bridging
> beteen swp0, swp1 and swp2. The bandwidth of the CPU is often times high
> enough that software bridging between {swp0,swp1,swp2} and bond0 is not
> impractical.
>=20
> But this creates an impossible paradox given the current way in which
> port hardware domains are assigned. When the driver receives a packet
> from swp0 (say, due to flooding), it must set skb->offload_fwd_mark to
> something.
>=20
> - If we set it to 0, then the bridge will forward it towards swp1, swp2
>   and bond0. But the switch has already forwarded it towards swp1 and
>   swp2 (not to bond0, remember, that isn't offloaded, so as far as the
>   switch is concerned, ports swp3 and swp4 are not looking up the FDB,
>   and the entire bond0 is a destination that is strictly behind the
>   CPU). But we don't want duplicated traffic towards swp1 and swp2, so
>   it's not ok to set skb->offload_fwd_mark =3D 0.
>=20
> - If we set it to 1, then the bridge will not forward the skb towards
>   the ports with the same switchdev mark, i.e. not to swp1, swp2 and
>   bond0. Towards swp1 and swp2 that's ok, but towards bond0? It should
>   have forwarded the skb there.
>=20
> So the real issue is that bond0 will be assigned the same hardware
> domain as {swp0,swp1,swp2}, because the function that assigns hardware
> domains to bridge ports, nbp_switchdev_add(), recurses through bond0's
> lower interfaces until it finds something that implements devlink (calls
> dev_get_port_parent_id with bool recurse =3D true). This is a problem
> because the fact that bond0 can be offloaded by swp3 and swp4 in our
> example is merely an assumption.
>=20
> A solution is to give the bridge explicit hints as to what hardware
> domain it should use for each port.
>=20
> Currently, the bridging offload is very 'silent': a driver registers a
> netdevice notifier, which is put on the netns's notifier chain, and
> which sniffs around for NETDEV_CHANGEUPPER events where the upper is a
> bridge, and the lower is an interface it knows about (one registered by
> this driver, normally). Then, from within that notifier, it does a bunch
> of stuff behind the bridge's back, without the bridge necessarily
> knowing that there's somebody offloading that port. It looks like this:
>=20
>      ip link set swp0 master br0
>                   |
>                   v
>  br_add_if() calls netdev_master_upper_dev_link()
>                   |
>                   v
>         call_netdevice_notifiers
>                   |
>                   v
>        dsa_slave_netdevice_event
>                   |
>                   v
>         oh, hey! it's for me!
>                   |
>                   v
>            .port_bridge_join
>=20
> What we do to solve the conundrum is to be less silent, and change the
> switchdev drivers to present themselves to the bridge. Something like thi=
s:
>=20
>      ip link set swp0 master br0
>                   |
>                   v
>  br_add_if() calls netdev_master_upper_dev_link()
>                   |
>                   v                    bridge: Aye! I'll use this
>         call_netdevice_notifiers           ^  ppid as the
>                   |                        |  hardware domain for
>                   v                        |  this port, and zero
>        dsa_slave_netdevice_event           |  if I got nothing.
>                   |                        |
>                   v                        |
>         oh, hey! it's for me!              |
>                   |                        |
>                   v                        |
>            .port_bridge_join               |
>                   |                        |
>                   +------------------------+
>              switchdev_bridge_port_offload(swp0, swp0)
>=20
> Then stacked interfaces (like bond0 on top of swp3/swp4) would be
> treated differently in DSA, depending on whether we can or cannot
> offload them.
>=20
> The offload case:
>=20
>     ip link set bond0 master br0
>                   |
>                   v
>  br_add_if() calls netdev_master_upper_dev_link()
>                   |
>                   v                    bridge: Aye! I'll use this
>         call_netdevice_notifiers           ^  ppid as the
>                   |                        |  switchdev mark for
>                   v                        |        bond0.
>        dsa_slave_netdevice_event           | Coincidentally (or not),
>                   |                        | bond0 and swp0, swp1, swp2
>                   v                        | all have the same switchdev
>         hmm, it's not quite for me,        | mark now, since the ASIC
>          but my driver has already         | is able to forward towards
>            called .port_lag_join           | all these ports in hw.
>           for it, because I have           |
>       a port with dp->lag_dev =3D=3D bond0.    |
>                   |                        |
>                   v                        |
>            .port_bridge_join               |
>            for swp3 and swp4               |
>                   |                        |
>                   +------------------------+
>             switchdev_bridge_port_offload(bond0, swp3)
>             switchdev_bridge_port_offload(bond0, swp4)
>=20
> And the non-offload case:
>=20
>     ip link set bond0 master br0
>                   |
>                   v
>  br_add_if() calls netdev_master_upper_dev_link()
>                   |
>                   v                    bridge waiting:
>         call_netdevice_notifiers           ^  huh, switchdev_bridge_port_=
offload
>                   |                        |  wasn't called, okay, I'll u=
se a
>                   v                        |  hwdom of zero for this one.
>        dsa_slave_netdevice_event           :  Then packets received on sw=
p0 will
>                   |                        :  not be software-forwarded t=
owards
>                   v                        :  swp1, but they will towards=
 bond0.
>          it's not for me, but
>        bond0 is an upper of swp3
>       and swp4, but their dp->lag_dev
>        is NULL because they couldn't
>             offload it.
>=20
> Basically we can draw the conclusion that the lowers of a bridge port
> can come and go, so depending on the configuration of lowers for a
> bridge port, it can dynamically toggle between offloaded and unoffloaded.
> Therefore, we need an equivalent switchdev_bridge_port_unoffload too.
>=20
> This patch changes the way any switchdev driver interacts with the
> bridge. From now on, everybody needs to call switchdev_bridge_port_offloa=
d
> and switchdev_bridge_port_unoffload, otherwise the bridge will treat the
> port as non-offloaded and allow software flooding to other ports from
> the same ASIC.
>=20
> Note that these functions lay the ground for a more complex handshake
> between switchdev drivers and the bridge in the future. During the
> info->linking =3D=3D false path, switchdev_bridge_port_unoffload() is
> strategically put in the NETDEV_PRECHANGEUPPER notifier as opposed to
> NETDEV_CHANGEUPPER. The reason for this has to do with a future
> migration of the switchdev object replay helpers (br_*_replay) from a
> pull mode (completely initiated by the driver) to a semi-push mode (the
> bridge initiates the replay when the switchdev driver declares that it
> offloads a port). On deletion, the switchdev object replay helpers need
> the netdev adjacency lists to be valid, and that is only true in
> NETDEV_PRECHANGEUPPER. So we need to add trivial glue code to all
> drivers to handle a "pre bridge leave" event, and that is where we hook
> the switchdev_bridge_port_unoffload() call.
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

Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com> # dpaa2-switch: regression
Acked-by: Ioana Ciornei <ioana.ciornei@nxp.com> # dpaa2-switch
