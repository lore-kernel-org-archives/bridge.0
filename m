Return-Path: <dsahern@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0B4F423DD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A44C421C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689354077; x=1691946077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zsNeqji1XYB0jXHNl1SF54r4WjafGvPzvfwZx0ZnD4A=;
 b=ZTTOIcw1yPG20kHkYiHm4QBfF+RLSm255lGSV6nC1KQlESzSiI9ABxSlYKOfU1fZc2
 QgEXxlQB2nRh6ZsIx43Ck280e2cMoy3xuQXwiolqVmez6FHQFjhzgt/0e2m4joeYtOGE
 07j3fD4gEvdlrHR9xAGVjrhcUYufLK9W/ZS+4wiEiP5urt1WJSPPi7otGg55uGVf9E4l
 xTerY2pSeovFfbYQSkT1JYQAh/yMKRaObMBqjiCQOxQLSdyJvzMwRXAoFjUdGmlWkWsG
 qVElN67xw/O3gcmJohg4Lqj5CDDmY6l0zLoMiHyInZ7XsQQk+sJrR9KB0VHw/8NOQTrg
 FBbw==
Message-ID: <ba91d049-21a1-9cea-a000-a016c753b1a8@gmail.com>
Date: Fri, 14 Jul 2023 11:01:15 -0600
MIME-Version: 1.0
Content-Language: en-US
References: <20230713070925.3955850-1-idosch@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20230713070925.3955850-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 0/4] Add backup nexthop ID support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, taspelund@nvidia.com, razor@blackwall.org, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 7/13/23 1:09 AM, Ido Schimmel wrote:
> tl;dr
> =====
> 
> This patchset adds a new bridge port attribute specifying the nexthop
> object ID to attach to a redirected skb as tunnel metadata. The ID is
> used by the VXLAN driver to choose the target VTEP for the skb. This is
> useful for EVPN multi-homing, where we want to redirect local
> (intra-rack) traffic upon carrier loss through one of the other VTEPs
> (ES peers) connected to the target host.
> 
> Background
> ==========
> 
> In a typical EVPN multi-homing setup each host is multi-homed using a
> set of links called ES (Ethernet Segment, i.e., LAG) to multiple leaf
> switches in a rack. These switches act as VTEPs and are not directly
> connected (as opposed to MLAG), but can communicate with each other (as
> well as with VTEPs in remote racks) via spine switches over L3.
> 
> The control plane uses Type 1 routes [1] to create a mapping between an
> ES and VTEPs where the ES has active links. In addition, the control
> plane uses Type 2 routes [2] to create a mapping between {MAC, VLAN} and
> an ES.
> 
> These tables are then used by the control plane to instruct VTEPs how to
> reach remote hosts. For example, assuming {MAC X, VLAN Y} is accessible
> via ES1 and this ES has active links to VTEP1 and VTEP2. The control
> plane will program the following entries to a remote VTEP:
> 
>  # ip nexthop add id 1 via $VTEP1_IP fdb
>  # ip nexthop add id 2 via $VTEP2_IP fdb
>  # ip nexthop add id 10 group 1/2 fdb
>  # bridge fdb add $MAC_X dev vx0 master extern_learn vlan $VLAN_Y
>  # bridge fdb add $MAC_Y dev vx0 self extern_learn nhid 10 src_vni $VNI_Y
> 
> Remote traffic towards the host will be load balanced between VTEP1 and
> VTEP2. If the control plane notices a carrier loss on the ES1 link
> connected to VTEP1, it will issue a Type 1 route withdraw, prompting
> remote VTEPs to remove the effected nexthop from the group:
> 
>  # ip nexthop replace id 10 group 2 fdb
> 
> Motivation
> ==========
> 
> While remote traffic can be redirected to a VTEP with an active ES link
> by withdrawing a Type 1 route, the same is not true for local traffic. A
> host that is multi-homed to VTEP1 and VTEP2 via another ES (e.g., ES2)
> will send its traffic to {MAC X, VLAN Y} via one of these two switches,
> according to its LAG hash algorithm which is not under our control. If
> the traffic arrives at VTEP1 - which no longer has an active ES1 link -
> it will be dropped due to the carrier loss.
> 
> In MLAG setups, the above problem is solved by redirecting the traffic
> through the peer link upon carrier loss. This is achieved by defining
> the peer link as the backup port of the host facing bond. For example:
> 
>  # bridge link set dev bond0 backup_port bond_peer
> 
> Unlike MLAG, there is no peer link between the leaf switches in EVPN.
> Instead, upon carrier loss, local traffic should be redirected through
> one of the active ES peers. This can be achieved by defining the VXLAN
> port as the backup port of the host facing bonds. For example:
> 
>  # bridge link set dev es1_bond backup_port vx0
> 
> However, the VXLAN driver is not programmed with FDB entries for locally
> attached hosts and therefore does not know to which VTEP to redirect the
> traffic to. This will result in the traffic being replicated to all the
> VTEPs (potentially hundreds) in the network and each VTEP dropping the
> traffic, except for the active ES peer.
> 
> Avoiding the flooding by programming local FDB entries in the VXLAN
> driver is not a viable solution as it requires to significantly increase
> the number of programmed FDB entries.
> 
> Implementation
> ==============
> 
> The proposed solution is to create an FDB nexthop group for each ES with
> the IP addresses of the active ES peers and set this ID as the backup
> nexthop ID (new bridge port attribute) of the ES link. For example, on
> VTEP1:
> 
>  # ip nexthop add id 1 via $VTEP2_IP fdb
>  # ip nexthop add id 10 group 1 fdb
>  # bridge link set dev es1_bond backup_nhid 10
>  # bridge link set dev es1_bond backup_port vx0
> 
> When the ES link loses its carrier, traffic will be redirected to the
> VXLAN port, but instead of only attaching the tunnel ID (i.e., VNI) as
> tunnel metadata to the skb, the backup nexthop ID will be attached as
> well. The VXLAN driver will then use this information to forward the skb
> via the nexthop object associated with the ID, as if the skb hit an FDB
> entry associated with this ID.
> 
> Testing
> =======
> 
> A test for both the existing backup port attribute as well as the new
> backup nexthop ID attribute is added in patch #4.
> 
> Patchset overview
> =================
> 
> Patch #1 extends the tunnel key structure with the new nexthop ID field.
> 
> Patch #2 uses the new field in the VXLAN driver to forward packets via
> the specified nexthop ID.
> 
> Patch #3 adds the new backup nexthop ID bridge port attribute and
> adjusts the bridge driver to attach the ID as tunnel metadata upon
> redirection.
> 
> Patch #4 adds a selftest.
> 
> iproute2 patches can be found here [3].
> 
> [1] https://datatracker.ietf.org/doc/html/rfc7432#section-7.1
> [2] https://datatracker.ietf.org/doc/html/rfc7432#section-7.2
> [3] https://github.com/idosch/iproute2/tree/submit/backup_nhid_v1
> 

Looks good to me. Thanks for the detailed cover letter and test coverage

