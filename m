Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAAC96079E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 23AEC6079D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0piNMHbPRHz2tA4mZUV2Fet5WHFOTUIUdxfjvlIt6G4=;
 b=sLQOZdeSewwXHrl2/bFMLVMXSY9TNwluzVjPMp5kp15b8PpkMEdv3Nwd1S408E3lw8R5tp/EvmFqWKiF50SyyjuJ/LSWTxFl0A+jd8faTvcVU+JIiLolfbToEBdREfXzrKxSyfRVlTphPU49ERlcyyJqSG0OrmfzG8Y2TDP9AC0=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 27 Oct 2022 22:58:32 +0000
Message-ID: <20221027225832.2yg4ljivjymuj353@skbuf>
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-2-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-2-idosch@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F78154D6E27BF4D8179E9E08ED9D297@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH net-next 01/16] bridge: Add MAC
 Authentication Bypass (MAB) support
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

Hi Ido,

Thanks for the commit message. It is very good.

On Tue, Oct 25, 2022 at 01:00:09PM +0300, Ido Schimmel wrote:
> From: "Hans J. Schultz" <netdev@kapio-technology.com>
>=20
> Hosts that support 802.1X authentication are able to authenticate
> themselves by exchanging EAPOL frames with an authenticator (Ethernet
> bridge, in this case) and an authentication server. Access to the
> network is only granted by the authenticator to successfully
> authenticated hosts.
>=20
> The above is implemented in the bridge using the "locked" bridge port
> option. When enabled, link-local frames (e.g., EAPOL) can be locally
> received by the bridge, but all other frames are dropped unless the host
> is authenticated. That is, unless the user space control plane installed
> an FDB entry according to which the source address of the frame is
> located behind the locked ingress port. The entry can be dynamic, in
> which case learning needs to be enabled so that the entry will be
> refreshed by incoming traffic.
>=20
> There are deployments in which not all the devices connected to the
> authenticator (the bridge) support 802.1X. Such devices can include
> printers and cameras. One option to support such deployments is to
> unlock the bridge ports connecting these devices, but a slightly more
> secure option is to use MAB. When MAB is enabled, the MAC address of the
> connected device is used as the user name and password for the
> authentication.
>=20
> For MAB to work, the user space control plane needs to be notified about
> MAC addresses that are trying to gain access so that they will be
> compared against an allow list. This can be implemented via the regular
> learning process with the following differences:
>=20
> 1. Learned FDB entries are installed with a new "locked" flag indicating
>    that the entry cannot be used to authenticate the device. The flag
>    cannot be set by user space, but user space can clear the flag by
>    replacing the entry, thereby authenticating the device.
>=20
> 2. FDB entries cannot roam to locked ports to prevent unauthenticated
>    devices from disrupting traffic destined to already authenticated
>    devices.

The behavior described in (2) has nothing to do with locked FDB entries
or MAB (what is described in this paragraph), it applies to all of them,
no? The code was already there:

	if (p->flags & BR_PORT_LOCKED)
		if (!fdb_src || READ_ONCE(fdb_src->dst) !=3D p ||
		    test_bit(BR_FDB_LOCAL, &fdb_src->flags))
			goto drop;

I think you mean to say: the above already holds true, but the relevant
implication here is that locked FDB entries will not be created if the
MAC address is present in the FDB on any other port?

I think some part of this comment should also go to the convoluted
BR_PORT_LOCKED block from br_handle_frame_finish()?

I was going to ask if we should bother to add code to prohibit packets
from being forwarded to an FDB entry that was learned as LOCKED, since
that FDB entry is more of a "ghost" and not something fully committed?

But with the "never roam to locked port" policy, I don't think there is
any practical risk that the extra code would mitigate. Assume that a
"snooper" wants to get the traffic destined for a MAC DA X, so it creates
a LOCKED FDB entry. It has to time itself just right, 5 minutes after
the station it wants to intercept has gone silent (or before the station
said anything). Anyone thinking it's talking to X now talks to the snooper.
But this attack vector is bounded in time. As long as X says anything,
the LOCKED FDB entry moves towards X, and the LOCKED flag gets cleared.

>=20
> Enable this behavior using a new bridge port option called "mab". It can
> only be enabled on a bridge port that is both locked and has learning
> enabled. A new option is added because there are pure 802.1X deployments
> that are not interested in notifications about "locked" FDB entries.
>=20
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>=20
> Notes:
>     Changes made by me:
>    =20
>      * Reword commit message.
>      * Reword comment regarding 'NTF_EXT_LOCKED'.
>      * Use extack in br_fdb_add().
>      * Forbid MAB when learning is disabled.

Forbidding MAB when learning is disabled makes sense to me, since it
means accepting that MAB is a form of learning (as the implementation
also shows; all other callers of br_fdb_update() are guarded by a
port learning check). I believe this will also make life easier with
offloading drivers. Thanks.

>  include/linux/if_bridge.h      |  1 +
>  include/uapi/linux/if_link.h   |  1 +
>  include/uapi/linux/neighbour.h |  8 +++++++-
>  net/bridge/br_fdb.c            | 24 ++++++++++++++++++++++++
>  net/bridge/br_input.c          | 15 +++++++++++++--
>  net/bridge/br_netlink.c        | 13 ++++++++++++-
>  net/bridge/br_private.h        |  3 ++-
>  net/core/rtnetlink.c           |  5 +++++
>  8 files changed, 65 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index d62ef428e3aa..1668ac4d7adc 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -59,6 +59,7 @@ struct br_ip_list {
>  #define BR_MRP_LOST_IN_CONT	BIT(19)
>  #define BR_TX_FWD_OFFLOAD	BIT(20)
>  #define BR_PORT_LOCKED		BIT(21)
> +#define BR_PORT_MAB		BIT(22)

Question about unsetting BR_PORT_MAB using IFLA_BRPORT_MAB: should this
operation flush BR_FDB_LOCKED entries on the port?

> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 68b3e850bcb9..068fced7693c 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -109,9 +109,20 @@ int br_handle_frame_finish(struct net *net, struct s=
ock *sk, struct sk_buff *skb
>  		struct net_bridge_fdb_entry *fdb_src =3D
>  			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
> =20
> -		if (!fdb_src || READ_ONCE(fdb_src->dst) !=3D p ||
> -		    test_bit(BR_FDB_LOCAL, &fdb_src->flags))
> +		if (!fdb_src) {
> +			unsigned long flags =3D 0;
> +
> +			if (p->flags & BR_PORT_MAB) {
> +				__set_bit(BR_FDB_LOCKED, &flags);
> +				br_fdb_update(br, p, eth_hdr(skb)->h_source,
> +					      vid, flags);
> +			}
>  			goto drop;
> +		} else if (READ_ONCE(fdb_src->dst) !=3D p ||
> +			   test_bit(BR_FDB_LOCAL, &fdb_src->flags) ||
> +			   test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {

Minor nitpick: shouldn't br_fdb_update() also be called when the packet
matched on a BR_FDB_LOCKED entry on port p, so as to refresh it, if the
station is persistent? Currently I believe the FDB entry will expire
within 5 minutes of the first packet, regardless of subsequent traffic.

> +			goto drop;
> +		}
>  	}
> =20
>  	nbp_switchdev_frame_mark(p, skb);=
