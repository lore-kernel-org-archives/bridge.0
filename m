Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nDUBbtdHt7Z9suYjI/Po8cN8ood0qhS4xL1CgqJIkQ=;
 b=kL5TDeMjLnbGGXyGdPa5mzX7Sqi3cUgN3Gk3daPQLS1v/IikWWkqjXhOmd8QyLEyS90zMmNlmM1RH/FfmQl0T6/AsVgdjlAMMWgNQ1ZzoPmTMacSld7PBNatc81+Hw4B1BGEoP1ilMPEdO4t8UW6lup7I4VX+SGqlq01n5zo3+I=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun, 13 Dec 2020 13:55:58 +0000
Message-ID: <20201213135557.ysmx3qjnafl5yihm@skbuf>
References: <20201213024018.772586-1-vladimir.oltean@nxp.com>
 <20201213024018.772586-2-vladimir.oltean@nxp.com>
 <85b824ea-5f43-b483-55b6-4ffd0e8275d8@nvidia.com>
In-Reply-To: <85b824ea-5f43-b483-55b6-4ffd0e8275d8@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1FE01054C65A434E987CA83C6F8E98E4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v2 net-next 1/6] net: bridge: notify switchdev
 of disappearance of old FDB entry upon migration
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Marek Behun <marek.behun@nic.cz>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

Hi Nik,

On Sun, Dec 13, 2020 at 03:22:16PM +0200, Nikolay Aleksandrov wrote:
> Hi Vladimir,
> Thank you for the good explanation, it really helps a lot to understand t=
he issue.
> Even though it's deceptively simple, that call adds another lock/unlock f=
or everyone
> when moving or learning (due to notifier lock)

This unlikely code path is just on movement, as far as I understand it.
How often do we expect that to happen? Is there any practical use case
where an FDB entry ping pongs between ports?

> , but I do like how simple the solution
> becomes with this change, so I'm not strictly against it. I think I'll ad=
d a "refcnt"-like
> check in the switchdev fn which would process the chain only when there a=
re registered users
> to avoid any locks when moving fdbs on pure software bridges (like it was=
 before swdev).

That makes sense.

> I get that the alternative is to track these within DSA, I'm tempted to s=
ay that's not such
> a bad alternative as this change would make moving fdbs slower in general=
.

I deliberately said "rule" instead of "static FDB entry" and "control
interface" instead of "CPU port" because this is not only about DSA.
I know of at least one other switchdev device which doesn't support
source address learning for host-injected traffic. It isn't even so much
of a quirk as it is the way that the hardware works. If you think of it
as a "switch with queues", there would be little reason for a hardware
designer to not just provide you the means to inject directly into the
queues of the egress port, therefore bypassing the normal analyzer and
forwarding logic.

Everything we do in DSA must be copied sooner or later in other similar
drivers, to get the same functionality. So I would really like to keep
this interface simple, and not inflict unnecessary complications if
possible.

> Have you thought about another way to find out, e.g. if more fdb
> information is passed to the notifications ?

Like what, keep emitting just the ADD notification, but put some
metadata in it letting listeners know that it was actually migrated from
a different bridge port, in order to save one notification? That would
mean that we would need to:

	case SWITCHDEV_FDB_ADD_TO_DEVICE:
		fdb_info =3D ptr;

		if (dsa_slave_dev_check(dev)) {
			if (!fdb_info->migrated_from_dev || dsa_slave_dev_check(fdb_info->migrat=
ed_from_dev)) {
				if (!fdb_info->added_by_user)
					return NOTIFY_OK;

				dp =3D dsa_slave_to_port(dev);

				add =3D true;
			} else if (fdb_info->migrated_from_dev && !dsa_slave_dev_check(fdb_info-=
>migrated_from_dev)) {
				/* An address has migrated from a non-DSA port
				 * to a DSA port. Check if that non-DSA port was
				 * bridged with us, aka if we previously had that
				 * address installed towards the CPU.
				 */
				struct net_device *br_dev;
				struct dsa_slave_priv *p;

				br_dev =3D netdev_master_upper_dev_get_rcu(dev);
				if (!br_dev)
					return NOTIFY_DONE;

				if (!netif_is_bridge_master(br_dev))
					return NOTIFY_DONE;

				p =3D dsa_slave_dev_lower_find(br_dev);
				if (!p)
					return NOTIFY_DONE;

				delete =3D true;
			}
		} else {
			/* Snoop addresses learnt on foreign interfaces
			 * bridged with us, for switches that don't
			 * automatically learn SA from CPU-injected traffic
			 */
			struct net_device *br_dev;
			struct dsa_slave_priv *p;

			br_dev =3D netdev_master_upper_dev_get_rcu(dev);
			if (!br_dev)
				return NOTIFY_DONE;

			if (!netif_is_bridge_master(br_dev))
				return NOTIFY_DONE;

			p =3D dsa_slave_dev_lower_find(br_dev);
			if (!p)
				return NOTIFY_DONE;

			dp =3D p->dp->cpu_dp;

			if (!dp->ds->assisted_learning_on_cpu_port)
				return NOTIFY_DONE;
		}
	case SWITCHDEV_FDB_DEL_TO_DEVICE:
		not shown here

I probably didn't even get it right. We would need to delete an entry
from the notification of a FDB insertion, which is a bit counter-intuitive,
and the logic is a bit mind-boggling. I don't know, it is all much
simpler if we just emit an insertion notification on insertion and a
deletion notification on deletion. Which way you prefer, really.=
