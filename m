Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A484821AE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65C62821A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcPpoSiSaGxNIfnuIIRDoLKO9CGyQ76D8Xx9uyJRWWA=;
 b=Xosl8u09r8DyYKvTrif9/ScUiBtZm2QEceLMRH3L6pSRsRzAIQDWWA0wEAH2EFz+SluBrPIMa+dKmEnSXBQ+htFpTBkrdnNkG4p9aLC9NH/lZTgelMhu6EBAYsuY8pfub2WxVtsZwUhAqKP2rbDwU3xhDkp2xic2HCH77GdRsCXYfz3+jCfrWDjS8tiDTaxFji7OzFPxWwS3UwQAjH/8mlAxLuGm/KqtWpV2f/+8mzYuz24O8W1asa2ljYFhrwdTRMZjxnb4WrYXsq3+9MZ7pL40A/gyFjO5ggvfbXJa5fx2GXrk+d3JxNba+7+W2vKg7yqDv8vhG0bnSansMN+H/A==
Date: Fri, 3 Feb 2023 16:39:16 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y90clBUNv2c8ScHl@shredder>
References: <cover.1675359453.git.petrm@nvidia.com>
 <ad5b9a4a971f7a38951cb8475ca3c9a16057b0fd.1675359453.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5b9a4a971f7a38951cb8475ca3c9a16057b0fd.1675359453.git.petrm@nvidia.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v3 08/16] net: bridge: Add netlink
 knobs for number / maximum MDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Thu, Feb 02, 2023 at 06:59:26PM +0100, Petr Machata wrote:
> The previous patch added accounting for number of MDB entries per port and
> per port-VLAN, and the logic to verify that these values stay within
> configured bounds. However it didn't provide means to actually configure
> those bounds or read the occupancy. This patch does that.
> 
> Two new netlink attributes are added for the MDB occupancy:
> IFLA_BRPORT_MCAST_N_GROUPS for the per-port occupancy and
> BRIDGE_VLANDB_ENTRY_MCAST_N_GROUPS for the per-port-VLAN occupancy.
> And another two for the maximum number of MDB entries:
> IFLA_BRPORT_MCAST_MAX_GROUPS for the per-port maximum, and
> BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS for the per-port-VLAN one.
> 
> Note that the two new IFLA_BRPORT_ attributes prompt bumping of
> RTNL_SLAVE_MAX_TYPE to size the slave attribute tables large enough.
> 
> The new attributes are used like this:
> 
>  # ip link add name br up type bridge vlan_filtering 1 mcast_snooping 1 \
>                                       mcast_vlan_snooping 1 mcast_querier 1
>  # ip link set dev v1 master br
>  # bridge vlan add dev v1 vid 2
> 
>  # bridge vlan set dev v1 vid 1 mcast_max_groups 1
>  # bridge mdb add dev br port v1 grp 230.1.2.3 temp vid 1
>  # bridge mdb add dev br port v1 grp 230.1.2.4 temp vid 1
>  Error: bridge: Port-VLAN is already in 1 groups, and mcast_max_groups=1.
> 
>  # bridge link set dev v1 mcast_max_groups 1
>  # bridge mdb add dev br port v1 grp 230.1.2.3 temp vid 2
>  Error: bridge: Port is already in 1 groups, and mcast_max_groups=1.
> 
>  # bridge -d link show
>  5: v1@v2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br [...]
>      [...] mcast_n_groups 1 mcast_max_groups 1
> 
>  # bridge -d vlan show
>  port              vlan-id
>  br                1 PVID Egress Untagged
>                      state forwarding mcast_router 1
>  v1                1 PVID Egress Untagged
>                      [...] mcast_n_groups 1 mcast_max_groups 1
>                    2
>                      [...] mcast_n_groups 0 mcast_max_groups 0
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
