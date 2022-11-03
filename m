Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C0E081FB1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E4B0981E72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FiFlm4/ax/AjGG41OkLLpQOSP9+c75dloMOVtHN7xw=;
 b=Fx1H7PV+Mn/Ga47KMTTsfD4c7qo26nSyUVZ7gfA47lwGsj4rcnytfPVA/50x/EJzVu4YMs3jzC9dI1oEAXPF3i5CZpo6sz5UdjEjYg2MXpL0sR6/HOHRw1S4Smc1MrFMc+JsYo6t9URStNEhHDYRDc0DIq9ocOxutQL7lECDOos=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 3 Nov 2022 23:03:17 +0000
Message-ID: <20221103230316.k5gocnfkdslkdimq@skbuf>
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-11-idosch@nvidia.com>
 <20221025100024.1287157-11-idosch@nvidia.com>
 <20221027233939.x5jtqwiic2kmwonk@skbuf> <Y140a2DqcCaT/5uL@shredder>
 <20221031083210.fxitourrquc4bo6p@skbuf>
 <20221103223151.cnmlvgnz3maj75iv@skbuf> <Y2RGr9ssyMXbNsC+@shredder>
In-Reply-To: <Y2RGr9ssyMXbNsC+@shredder>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BD4B9FFE76B464FA4ED73933BF374E0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH net-next 10/16] mlxsw: spectrum_switchdev:
 Add support for locked FDB notifications
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: "petrm@nvidia.com" <petrm@nvidia.com>, "ivecera@redhat.com" <ivecera@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "razor@blackwall.org" <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "roopa@nvidia.com" <roopa@nvidia.com>, "netdev@kapio-technology.com" <netdev@kapio-technology.com>, "edumazet@google.com" <edumazet@google.com>, "mlxsw@nvidia.com" <mlxsw@nvidia.com>, "jiri@nvidia.com" <jiri@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>

On Fri, Nov 04, 2022 at 12:54:39AM +0200, Ido Schimmel wrote:
> Sorry, forgot to reply... I added a patch (see below) to the offload
> set. If the bridge patches are accepted and we have disagreements on the
> offload part I can always split out this patch and send it separately so
> that mv88e6xxx rejects MAB in 6.2.
>
> commit ebdd7363f8c1802af63c35f74d6922b727617a7d
> Author: Ido Schimmel <idosch@nvidia.com>
> Date:   Mon Oct 31 19:36:36 2022 +0200
>
>     bridge: switchdev: Reflect MAB bridge port flag to device drivers
>
>     Reflect the 'BR_PORT_MAB' flag to device drivers so that:
>
>     * Drivers that support MAB could act upon the flag being toggled.
>     * Drivers that do not support MAB will prevent MAB from being enabled=
.
>
>     Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>
> Notes:
>     v1:
>     * New patch.
>
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 8a0abe35137d..7eb6fd5bb917 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -71,7 +71,7 @@ bool nbp_switchdev_allowed_egress(const struct net_brid=
ge_port *p,
>  }
>
>  /* Flags that can be offloaded to hardware */
> -#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
> +#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | BR_PORT_MAB |=
 \
>                                   BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PO=
RT_LOCKED | \
>                                   BR_HAIRPIN_MODE | BR_ISOLATED | BR_MULT=
ICAST_TO_UNICAST)

Yeah, ok, normally the feature would be gated until it really works on
existing offloading drivers, but I suppose a compromise from 100%
correctness could be made if you say you're going to send the offload
bits right away.=
