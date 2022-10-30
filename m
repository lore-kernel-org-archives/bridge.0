Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FEE160A72
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58AE7608D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtO4U7/EbBgufiT2h61+/lk5j0vYNdzAggxl6HGJzPs=;
 b=M3JQJcW/T0YDTyovzhBg9IprY/yAuBzk39jyRdYsmU7LSVtSwBrn5vRfQGtnHMXxRM2WbRsQR219swpZms/7zIPqwxPc5CotC8sYCXpU0CNv1xDOYs/dRvweDm39NkSpSnz848pNKvHVmnE/iVJLRmajjj5spRs31YYyw18SllhztkldtRntHZhAZWNJKrAxRwLH9nX61PEGoM6LOD3COt97e1sgHucFtQW90pcsc+m4SBMUSaYx+4CgNUbhTN0L7ZfbEjC5AkdavmL2jqtlxdQJwAOTCihtUMCy+vUP8fJhHgENm3WF/VwaRZ4+vRJyKj4F92qZLg+fWN4FWLkPXA==
Date: Sun, 30 Oct 2022 14:48:10 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y15yitWoBeDVi43l@shredder>
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-2-idosch@nvidia.com>
 <20221027225832.2yg4ljivjymuj353@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027225832.2yg4ljivjymuj353@skbuf>
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
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "petrm@nvidia.com" <petrm@nvidia.com>, "ivecera@redhat.com" <ivecera@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "razor@blackwall.org" <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "roopa@nvidia.com" <roopa@nvidia.com>, "netdev@kapio-technology.com" <netdev@kapio-technology.com>, "edumazet@google.com" <edumazet@google.com>, "mlxsw@nvidia.com" <mlxsw@nvidia.com>, "jiri@nvidia.com" <jiri@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>

On Thu, Oct 27, 2022 at 10:58:32PM +0000, Vladimir Oltean wrote:
> Hi Ido,
> 
> Thanks for the commit message. It is very good.
> 
> On Tue, Oct 25, 2022 at 01:00:09PM +0300, Ido Schimmel wrote:
> > From: "Hans J. Schultz" <netdev@kapio-technology.com>
> > 
> > Hosts that support 802.1X authentication are able to authenticate
> > themselves by exchanging EAPOL frames with an authenticator (Ethernet
> > bridge, in this case) and an authentication server. Access to the
> > network is only granted by the authenticator to successfully
> > authenticated hosts.
> > 
> > The above is implemented in the bridge using the "locked" bridge port
> > option. When enabled, link-local frames (e.g., EAPOL) can be locally
> > received by the bridge, but all other frames are dropped unless the host
> > is authenticated. That is, unless the user space control plane installed
> > an FDB entry according to which the source address of the frame is
> > located behind the locked ingress port. The entry can be dynamic, in
> > which case learning needs to be enabled so that the entry will be
> > refreshed by incoming traffic.
> > 
> > There are deployments in which not all the devices connected to the
> > authenticator (the bridge) support 802.1X. Such devices can include
> > printers and cameras. One option to support such deployments is to
> > unlock the bridge ports connecting these devices, but a slightly more
> > secure option is to use MAB. When MAB is enabled, the MAC address of the
> > connected device is used as the user name and password for the
> > authentication.
> > 
> > For MAB to work, the user space control plane needs to be notified about
> > MAC addresses that are trying to gain access so that they will be
> > compared against an allow list. This can be implemented via the regular
> > learning process with the following differences:
> > 
> > 1. Learned FDB entries are installed with a new "locked" flag indicating
> >    that the entry cannot be used to authenticate the device. The flag
> >    cannot be set by user space, but user space can clear the flag by
> >    replacing the entry, thereby authenticating the device.
> > 
> > 2. FDB entries cannot roam to locked ports to prevent unauthenticated
> >    devices from disrupting traffic destined to already authenticated
> >    devices.
> 
> The behavior described in (2) has nothing to do with locked FDB entries
> or MAB (what is described in this paragraph), it applies to all of them,
> no? The code was already there:
> 
> 	if (p->flags & BR_PORT_LOCKED)
> 		if (!fdb_src || READ_ONCE(fdb_src->dst) != p ||
> 		    test_bit(BR_FDB_LOCAL, &fdb_src->flags))
> 			goto drop;
> 
> I think you mean to say: the above already holds true, but the relevant
> implication here is that locked FDB entries will not be created if the
> MAC address is present in the FDB on any other port?

Yes, will reword to make this clearer.

> 
> I think some part of this comment should also go to the convoluted
> BR_PORT_LOCKED block from br_handle_frame_finish()?

Sure, will add a comment.

> 
> I was going to ask if we should bother to add code to prohibit packets
> from being forwarded to an FDB entry that was learned as LOCKED, since
> that FDB entry is more of a "ghost" and not something fully committed?
> 
> But with the "never roam to locked port" policy, I don't think there is
> any practical risk that the extra code would mitigate. Assume that a
> "snooper" wants to get the traffic destined for a MAC DA X, so it creates
> a LOCKED FDB entry. It has to time itself just right, 5 minutes after
> the station it wants to intercept has gone silent (or before the station
> said anything). Anyone thinking it's talking to X now talks to the snooper.
> But this attack vector is bounded in time. As long as X says anything,
> the LOCKED FDB entry moves towards X, and the LOCKED flag gets cleared.

I think it is best if we keep the semantic of the "locked" flag as the
"entry cannot be used to authenticate the device" and let the MAB user
space daemon worry about the rest. For example, if a MAC address that is
not in the allow list appears behind a locked port, user space can
decide to shutdown the port or install a flower filter that drops
packets destined to this MAC DA.

> 
> > 
> > Enable this behavior using a new bridge port option called "mab". It can
> > only be enabled on a bridge port that is both locked and has learning
> > enabled. A new option is added because there are pure 802.1X deployments
> > that are not interested in notifications about "locked" FDB entries.
> > 
> > Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> > 
> > Notes:
> >     Changes made by me:
> >     
> >      * Reword commit message.
> >      * Reword comment regarding 'NTF_EXT_LOCKED'.
> >      * Use extack in br_fdb_add().
> >      * Forbid MAB when learning is disabled.
> 
> Forbidding MAB when learning is disabled makes sense to me, since it
> means accepting that MAB is a form of learning (as the implementation
> also shows; all other callers of br_fdb_update() are guarded by a
> port learning check). I believe this will also make life easier with
> offloading drivers. Thanks.
> 
> >  include/linux/if_bridge.h      |  1 +
> >  include/uapi/linux/if_link.h   |  1 +
> >  include/uapi/linux/neighbour.h |  8 +++++++-
> >  net/bridge/br_fdb.c            | 24 ++++++++++++++++++++++++
> >  net/bridge/br_input.c          | 15 +++++++++++++--
> >  net/bridge/br_netlink.c        | 13 ++++++++++++-
> >  net/bridge/br_private.h        |  3 ++-
> >  net/core/rtnetlink.c           |  5 +++++
> >  8 files changed, 65 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> > index d62ef428e3aa..1668ac4d7adc 100644
> > --- a/include/linux/if_bridge.h
> > +++ b/include/linux/if_bridge.h
> > @@ -59,6 +59,7 @@ struct br_ip_list {
> >  #define BR_MRP_LOST_IN_CONT	BIT(19)
> >  #define BR_TX_FWD_OFFLOAD	BIT(20)
> >  #define BR_PORT_LOCKED		BIT(21)
> > +#define BR_PORT_MAB		BIT(22)
> 
> Question about unsetting BR_PORT_MAB using IFLA_BRPORT_MAB: should this
> operation flush BR_FDB_LOCKED entries on the port?

Good point. Will try to do that using br_fdb_flush() and add a test
case.

> 
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index 68b3e850bcb9..068fced7693c 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -109,9 +109,20 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
> >  		struct net_bridge_fdb_entry *fdb_src =
> >  			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
> >  
> > -		if (!fdb_src || READ_ONCE(fdb_src->dst) != p ||
> > -		    test_bit(BR_FDB_LOCAL, &fdb_src->flags))
> > +		if (!fdb_src) {
> > +			unsigned long flags = 0;
> > +
> > +			if (p->flags & BR_PORT_MAB) {
> > +				__set_bit(BR_FDB_LOCKED, &flags);
> > +				br_fdb_update(br, p, eth_hdr(skb)->h_source,
> > +					      vid, flags);
> > +			}
> >  			goto drop;
> > +		} else if (READ_ONCE(fdb_src->dst) != p ||
> > +			   test_bit(BR_FDB_LOCAL, &fdb_src->flags) ||
> > +			   test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
> 
> Minor nitpick: shouldn't br_fdb_update() also be called when the packet
> matched on a BR_FDB_LOCKED entry on port p, so as to refresh it, if the
> station is persistent? Currently I believe the FDB entry will expire
> within 5 minutes of the first packet, regardless of subsequent traffic.

Makes sense. Will add.

Thanks!

> 
> > +			goto drop;
> > +		}
> >  	}
> >  
> >  	nbp_switchdev_frame_mark(p, skb);
