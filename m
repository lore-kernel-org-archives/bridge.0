Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F8F360E84
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B051A600BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5MQHO8EKwJIsLFg/g3UDWTz/OV1D9yhCMi3EQYhYwsY=;
 b=Bvy2tDpDM7BPHd0pjF/vFeJDhNGndCGkHd2Ms3/ge60h+Jkj90CVosOIR4WCV2+AV8
 gA0F+UI+2mOJKmrSsm/Y6KHNR6j+EXIlsscMk3FMbkNvqBmjKfu+na/NgO2JVKQ5CwmF
 QZYepNxfiJQc2cD9lVLHRTHvFMU5e8tOvwcdDnii+VqTxVy4geLUNir3DvvcpNZ/gclz
 5oOKFAsAmByvg1EoEZ8fvZZWX3y9QSEE+HMLL76feba8p2S8Q0smk6M+TqdoGFYB0MzX
 fCD9+oqapEmkl+0/Jm/GhSTFXgRZ6m5WyQqXTxuqbgUhMt2xQaOvMzejArkmGfiaoZVj
 zAvg==
Message-ID: <6a8a5a6f-a5f2-976d-e747-362e44222a1d@blackwall.org>
Date: Fri, 3 Feb 2023 11:02:11 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1675359453.git.petrm@nvidia.com>
 <ad5b9a4a971f7a38951cb8475ca3c9a16057b0fd.1675359453.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ad5b9a4a971f7a38951cb8475ca3c9a16057b0fd.1675359453.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

On 02/02/2023 19:59, Petr Machata wrote:
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
> ---
> 
> Notes:
>     v3:
>     - Move the br_multicast_port_ctx_vlan_disabled() check
>       out to the _vlan_ helpers callers. Thus these helpers
>       cannot fail, which makes them very similar to the
>       _port_ helpers. Have them take the MC context directly
>       and unify them.
>     
>     v2:
>     - Drop locks around accesses in
>       br_multicast_{port,vlan}_ngroups_{get,set_max}(),
>     - Drop bounces due to max<n in
>       br_multicast_{port,vlan}_ngroups_set_max().
> 
>  include/uapi/linux/if_bridge.h |  2 ++
>  include/uapi/linux/if_link.h   |  2 ++
>  net/bridge/br_multicast.c      | 15 +++++++++++++++
>  net/bridge/br_netlink.c        | 17 ++++++++++++++++-
>  net/bridge/br_private.h        |  6 +++++-
>  net/bridge/br_vlan.c           | 11 +++++++----
>  net/bridge/br_vlan_options.c   | 27 ++++++++++++++++++++++++++-
>  net/core/rtnetlink.c           |  2 +-
>  8 files changed, 74 insertions(+), 8 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


