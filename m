Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33B974174B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 856404174A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hXrFo+KeQWDPJTUmHvqK6UwaGP0y77GYlkmmu+Bmrvw=;
 b=F6SIdhRSD01zOomuDLBjGM9ozwU9Ah+xNbQ6FZPtmnZYZstNYK3wfr2zcbVarTWsG/
 eF0zW0zRncI4vUihj6tRyOtOhPq31tsDW4qiKUKqAyuZFh8D+TeBDuQm9+CIRvWyXM5w
 9YdZeP06EY3Ek2FUw01uBoV5w/PGc5lkVdZ9Sq9l9QjmlZydoUguqBPjDPCBF3jdceAE
 ovLyJWqIM7yK/WDdzq4AGxa1LCltOs+PVJGpWzfh8MEbDTrvY+dRZEl6WUr3lrlgu8s7
 cr6sPCLeOZGlkGR4VvgTgo+xBBjm+zNm+L7bi7B8OJ1klJSWrLWRTgEyc4zX/tW5qSbu
 1JrA==
Message-ID: <3d7387d0-cff6-f403-55fc-1cb41e87db1a@blackwall.org>
Date: Tue, 7 Feb 2023 00:24:25 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230204170801.3897900-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230204170801.3897900-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 00/13] vxlan: Add MDB support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 2/4/23 19:07, Ido Schimmel wrote:
> tl;dr
> =====
> 
> This patchset implements MDB support in the VXLAN driver, allowing it to
> selectively forward IP multicast traffic to VTEPs with interested
> receivers instead of flooding it to all the VTEPs as BUM. The motivating
> use case is intra and inter subnet multicast forwarding using EVPN
> [1][2], which means that MDB entries are only installed by the user
> space control plane and no snooping is implemented, thereby avoiding a
> lot of unnecessary complexity in the kernel.
> 
> Background
> ==========
> 
> Both the bridge and VXLAN drivers have an FDB that allows them to
> forward Ethernet frames based on their destination MAC addresses and
> VLAN/VNI. These FDBs are managed using the same PF_BRIDGE/RTM_*NEIGH
> netlink messages and bridge(8) utility.
> 
> However, only the bridge driver has an MDB that allows it to selectively
> forward IP multicast packets to bridge ports with interested receivers
> behind them, based on (S, G) and (*, G) MDB entries. When these packets
> reach the VXLAN driver they are flooded using the "all-zeros" FDB entry
> (00:00:00:00:00:00). The entry either includes the list of all the VTEPs
> in the tenant domain (when ingress replication is used) or the multicast
> address of the BUM tunnel (when P2MP tunnels are used), to which all the
> VTEPs join.
> 
> Networks that make heavy use of multicast in the overlay can benefit
> from a solution that allows them to selectively forward IP multicast
> traffic only to VTEPs with interested receivers. Such a solution is
> described in the next section.
> 
> Motivation
> ==========
> 
> RFC 7432 [3] defines a "MAC/IP Advertisement route" (type 2) [4] that
> allows VTEPs in the EVPN network to advertise and learn reachability
> information for unicast MAC addresses. Traffic destined to a unicast MAC
> address can therefore be selectively forwarded to a single VTEP behind
> which the MAC is located.
> 
> The same is not true for IP multicast traffic. Such traffic is simply
> flooded as BUM to all VTEPs in the broadcast domain (BD) / subnet,
> regardless if a VTEP has interested receivers for the multicast stream
> or not. This is especially problematic for overlay networks that make
> heavy use of multicast.
> 
> The issue is addressed by RFC 9251 [1] that defines a "Selective
> Multicast Ethernet Tag Route" (type 6) [5] which allows VTEPs in the
> EVPN network to advertise multicast streams that they are interested in.
> This is done by having each VTEP suppress IGMP/MLD packets from being
> transmitted to the NVE network and instead communicate the information
> over BGP to other VTEPs.
> 
> The draft in [2] further extends RFC 9251 with procedures to allow
> efficient forwarding of IP multicast traffic not only in a given subnet,
> but also between different subnets in a tenant domain.
> 
> The required changes in the bridge driver to support the above were
> already merged in merge commit 8150f0cfb24f ("Merge branch
> 'bridge-mcast-extensions-for-evpn'"). However, full support entails MDB
> support in the VXLAN driver so that it will be able to selectively
> forward IP multicast traffic only to VTEPs with interested receivers.
> The implementation of this MDB is described in the next section.
> 
> Implementation
> ==============
> 
> The user interface is extended to allow user space to specify the
> destination VTEP(s) and related parameters. Example usage:
> 
>   # bridge mdb add dev vxlan0 port vxlan0 grp 239.1.1.1 permanent dst 198.51.100.1
>   # bridge mdb add dev vxlan0 port vxlan0 grp 239.1.1.1 permanent dst 192.0.2.1
> 
>   $ bridge -d -s mdb show
>   dev vxlan0 port vxlan0 grp 239.1.1.1 permanent filter_mode exclude proto static dst 192.0.2.1    0.00
>   dev vxlan0 port vxlan0 grp 239.1.1.1 permanent filter_mode exclude proto static dst 198.51.100.1    0.00
> 
> Since the MDB is fully managed by user space and since snooping is not
> implemented, only permanent entries can be installed and temporary
> entries are rejected by the kernel.
> 
> The netlink interface is extended with a few new attributes in the
> RTM_NEWMDB / RTM_DELMDB request messages:
> 
> [ struct nlmsghdr ]
> [ struct br_port_msg ]
> [ MDBA_SET_ENTRY ]
> 	struct br_mdb_entry
> [ MDBA_SET_ENTRY_ATTRS ]
> 	[ MDBE_ATTR_SOURCE ]
> 		struct in_addr / struct in6_addr
> 	[ MDBE_ATTR_SRC_LIST ]
> 		[ MDBE_SRC_LIST_ENTRY ]
> 			[ MDBE_SRCATTR_ADDRESS ]
> 				struct in_addr / struct in6_addr
> 		[ ...]
> 	[ MDBE_ATTR_GROUP_MODE ]
> 		u8
> 	[ MDBE_ATTR_RTPORT ]
> 		u8
> 	[ MDBE_ATTR_DST ]	// new
> 		struct in_addr / struct in6_addr
> 	[ MDBE_ATTR_DST_PORT ]	// new
> 		u16
> 	[ MDBE_ATTR_VNI ]	// new
> 		u32
> 	[ MDBE_ATTR_IFINDEX ]	// new
> 		s32
> 	[ MDBE_ATTR_SRC_VNI ]	// new
> 		u32
> 
> RTM_NEWMDB / RTM_DELMDB responses and notifications are extended with
> corresponding attributes.
> 
> One MDB entry that can be installed in the VXLAN MDB, but not in the
> bridge MDB is the catchall entry (0.0.0.0 / ::). It is used to transmit
> unregistered multicast traffic that is not link-local and is especially
> useful when inter-subnet multicast forwarding is required. See patch #12
> for a detailed explanation and motivation. It is similar to the
> "all-zeros" FDB entry that can be installed in the VXLAN FDB, but not
> the bridge FDB.
> 
> "added_by_star_ex" entries?
> ---------------------------
> 
> The bridge driver automatically installs (S, G) MDB port group entries
> marked as "added_by_star_ex" whenever it detects that an (S, G) entry
> can prevent traffic from being forwarded via a port associated with an
> EXCLUDE (*, G) entry. The bridge will add the port to the port group of
> the (S, G) entry, thereby creating a new port group entry. The
> complexity associated with these entries is not trivial, but it needs to
> reside in the bridge driver because it automatically installs MDB
> entries in response to snooped IGMP / MLD packets.
> 
> The same in not true for the VXLAN MDB which is entirely managed by user
> space who is fully capable of forming the correct replication lists on
> its own. In addition, the complexity associated with the
> "added_by_star_ex" entries in the VXLAN driver is higher compared to the
> bridge: Whenever a remote VTEP is added to the catchall entry, it needs
> to be added to all the existing MDB entries, as such a remote requested
> all the multicast traffic to be forwarded to it. Similarly, whenever an
> (*, G) or (S, G) entry is added, all the remotes associated with the
> catchall entry need to be added to it.
> 
> Given the above, this RFC does not implement support for such entries.
> One argument against this decision can be that in the future someone
> might want to populate the VXLAN MDB in response to decapsulated IGMP /
> MLD packets and not according to EVPN routes. Regardless of my doubts
> regarding this possibility, it is unclear to me why the snooping
> functionality cannot be implemented in user space by opening an
> AF_PACKET socket on the VXLAN device and sniffing IGMP / MLD packets.
> 
> I believe that the decision to place snooping functionality in the
> bridge driver was made without appreciation for the complexity that
> IGMPv3 support would bring and that a more informed decision should be
> made for the VXLAN driver.
> 

Hmm, while I agree that having the control plane in user-space is nice,
I do like having a relatively straight-forward and well maintained
protocol implementation in the kernel too, similar to its IGMPv3 client
support which doesn't need third party packages or external software
libraries to work. That being said, I do have (an unfinished) patch-set
that adds a bridge daemon to FRR, I think we can always add a knob to
switch to some more advanced user-space daemon which can snoop.

Anyway to the point - this patch-set looks ok to me, from bridge PoV
it's mostly code shuffling, and the new vxlan code is fairly straight-
forward.

Cheers,
  Nik
