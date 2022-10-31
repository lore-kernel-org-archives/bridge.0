Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B01F81279
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 315BB812F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE9E4lgEDewYRSChq0WRD2OZ4H3ZL80r0nYUv89nFJo=;
 b=SoYrm1lEulMbcHZulJUHXJhjHR1QwibRx9+gPvH/dwvGu+rz+de4wb+fDDsnX/fBR3YKb7cs5e3H0dKym0T90a8Hjyc/oYEXZeJp9IGGYbEAvI/OwG63ioHTa/qQPz1cHQVwx4ftQ4xjrce7G4723W5r+9Ew6ZAEME0gXTz52f8=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 31 Oct 2022 08:32:11 +0000
Message-ID: <20221031083210.fxitourrquc4bo6p@skbuf>
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-11-idosch@nvidia.com>
 <20221025100024.1287157-11-idosch@nvidia.com>
 <20221027233939.x5jtqwiic2kmwonk@skbuf> <Y140a2DqcCaT/5uL@shredder>
In-Reply-To: <Y140a2DqcCaT/5uL@shredder>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E227BB77C4ED9F41968F92FD51D3F3BF@eurprd04.prod.outlook.com>
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

On Sun, Oct 30, 2022 at 10:23:07AM +0200, Ido Schimmel wrote:
> Right. I'm quite reluctant to add the MAB flag to
> BR_PORT_FLAGS_HW_OFFLOAD as part of this patchset for the simple reason
> that it is not really needed. I'm not worried about someone adding it
> later when it is actually needed. We will probably catch the omission
> during code review. Worst case, we have a selftest that will break,
> notifying us that a bug fix is needed.

For drivers which don't emit SWITCHDEV_FDB_ADD_TO_BRIDGE but do offload
BR_PORT_LOCKED (like mv88e6xxx), things will not work correctly on day 1
of BR_PORT_MAB because they are not told MAB is enabled, so they have no
way of rejecting it until things work properly with the offload in place.

It's the same reason for which we have BR_HAIRPIN_MODE | BR_ISOLATED |
BR_MULTICAST_TO_UNICAST in BR_PORT_FLAGS_HW_OFFLOAD, even if nobody acts
upon them.=
