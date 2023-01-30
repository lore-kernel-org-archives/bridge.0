Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49952813E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93836813DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQSQNHvdmHrZfvTpuOCXzFSzJhBIxeY8EVaGtiQ8U5g=;
 b=AzsGIliu3kymNjiIOIZAxWDOhptJj31kvUlNGKNiSQAbXRSElcaJ9noaiHzx0dim2lxT/d4mnRq+KatAICqY4pDUteyhgMm2Ort4GP4WpiGJ5m+v3ifdjxhlulW4WLvTq2Te2QFloBXitN4bTVTJ0UqoDd/n8bGEI/mIuZTHsMgy1iMG733XvMQP6aOTG+IxVSE7p8mspeHINsVciu5jyNBXctbQF3KkISmxmABugML+8Si//DqeTIWqJaBNtPBUVM391SY9QdJuY+tXXgWiQvz/K9syzm/sSAvz4rgI4e9BDNgIkvPp2Ngj1ryB8KLshi4c/6SbdqQp3zBpSOWw8A==
Date: Mon, 30 Jan 2023 10:08:21 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y9d69bP7tzp/2reQ@shredder>
References: <cover.1674752051.git.petrm@nvidia.com>
 <1dcd4638d78c469eaa2f528de1f69b098222876f.1674752051.git.petrm@nvidia.com>
 <81821548-4839-e7ba-37b0-92966beb7930@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81821548-4839-e7ba-37b0-92966beb7930@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 07/16] net: bridge: Maintain number of
 MDB entries in net_bridge_mcast_port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Sun, Jan 29, 2023 at 06:55:26PM +0200, Nikolay Aleksandrov wrote:
> On 26/01/2023 19:01, Petr Machata wrote:
> > The MDB maintained by the bridge is limited. When the bridge is configured
> > for IGMP / MLD snooping, a buggy or malicious client can easily exhaust its
> > capacity. In SW datapath, the capacity is configurable through the
> > IFLA_BR_MCAST_HASH_MAX parameter, but ultimately is finite. Obviously a
> > similar limit exists in the HW datapath for purposes of offloading.
> > 
> > In order to prevent the issue of unilateral exhaustion of MDB resources,
> > introduce two parameters in each of two contexts:
> > 
> > - Per-port and per-port-VLAN number of MDB entries that the port
> >   is member in.
> > 
> > - Per-port and (when BROPT_MCAST_VLAN_SNOOPING_ENABLED is enabled)
> >   per-port-VLAN maximum permitted number of MDB entries, or 0 for
> >   no limit.
> > 
> > The per-port multicast context is used for tracking of MDB entries for the
> > port as a whole. This is available for all bridges.
> > 
> > The per-port-VLAN multicast context is then only available on
> > VLAN-filtering bridges on VLANs that have multicast snooping on.
> > 
> > With these changes in place, it will be possible to configure MDB limit for
> > bridge as a whole, or any one port as a whole, or any single port-VLAN.
> > 
> > Note that unlike the global limit, exhaustion of the per-port and
> > per-port-VLAN maximums does not cause disablement of multicast snooping.
> > It is also permitted to configure the local limit larger than hash_max,
> > even though that is not useful.
> > 
> > In this patch, introduce only the accounting for number of entries, and the
> > max field itself, but not the means to toggle the max. The next patch
> > introduces the netlink APIs to toggle and read the values.
> > 
> > Note that the per-port-VLAN mcast_max_groups value gets reset when VLAN
> > snooping is enabled. The reason for this is that while VLAN snooping is
> > disabled, permanent entries can be added above the limit imposed by the
> > configured maximum. Under those circumstances, whatever caused the VLAN
> > context enablement, would need to be rolled back, adding a fair amount of
> > code that would be rarely hit and tricky to maintain. At the same time,
> > the feature that this would enable is IMHO not interesting: I posit that
> > the usefulness of keeping mcast_max_groups intact across
> > mcast_vlan_snooping toggles is marginal at best.
> > 
> 
> Hmm, I keep thinking about this one and I don't completely agree. It would be
> more user-friendly if the max count doesn't get reset when mcast snooping is toggled.
> Imposing order of operations (first enable snooping, then config max entries) isn't necessary
> and it makes sense for someone to first set the limit and then enable vlan snooping.
> Also it would be consistent with port max entries, I'd prefer if we have the same
> behaviour for port and vlan pmctxs. If we allow to set any maximum at any time we
> don't need to rollback anything, also we already always lookup vlans in br_multicast_port_vid_to_port_ctx()
> to check if snooping is enabled so we can keep the count correct regardless, the same as
> it's done for the ports. Keeping both limits with consistent semantics seems better to me.
> 
> WDYT ?

The current approach is strict and prevents user space from performing
configuration that does not make a lot of sense:

1. Setting the maximum to be less than the current count.

2. Increasing the port-VLAN count above port-VLAN maximum when VLAN
snooping is disabled (i.e., maximum is not enforced) and then enabling
VLAN snooping.

However, it is not consistent with similar existing behavior where the
kernel is more liberal. For example:

1. It is possible to set the global maximum to be less than the current
number of entries.

2. Other port-VLAN attributes are not reset when VLAN snooping is
toggled.

And it also results in order of operations problems like you described.

So, it seems to me that we have more good reasons to not reset the
maximum than to reset it. Regardless of which path we take, it is
important to document the behavior in the man page (and in the commit
message, obviously) to avoid "bug reports" later on.
