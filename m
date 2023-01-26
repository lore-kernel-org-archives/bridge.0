Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D9F1B416D9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61DA540140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AHuJy2kTvQghbLhBH58YHeW0feWMUAUowELWr0FDnnE=;
 b=F5UslJ/IQGOQlPCWggzBc0mVwweuzRxHDauztyBadv3hy4yrf4xNVIv7oTPc5OmUJw
 xh8Iuy1WXhD0CurBZPaeOjU3ru6WLZ+GbE33A13NoGf21DcnXqpp6GxA9I1XyzzfNaVq
 Q97kPqn7ABYSHa7ye4qfOgJ/oCuAhDNBDDz6hLZqOy3dGD92ltD7hQOmz0LB1odeNgt5
 iYgsdLG/3Km+3AVu3T8osoHVtpi32JHzB4dzvzyIstoz8ujIv6aJihTP9KmZ5FEDriLQ
 CrLl0YcnFt+q4PxMKEtOUr5E13j89/0+rEQ50/AyljgFWYlhXDabRra97/YMnL54ZTqm
 mgww==
Date: Thu, 26 Jan 2023 22:28:54 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cover.1674752051.git.petrm@nvidia.com>
References: <cover.1674752051.git.petrm@nvidia.com>
Message-ID: <ED42A6CD-C622-42D9-B236-611E658A041B@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next 00/16] bridge: Limit number of MDB
	entries per port, port-vlan
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

On January 26, 2023 7:01:08 PM GMT+02:00, Petr Machata <petrm@nvidia=2Ecom>=
 wrote:
>The MDB maintained by the bridge is limited=2E When the bridge is configu=
red
>for IGMP / MLD snooping, a buggy or malicious client can easily exhaust i=
ts
>capacity=2E In SW datapath, the capacity is configurable through the
>IFLA_BR_MCAST_HASH_MAX parameter, but ultimately is finite=2E Obviously a
>similar limit exists in the HW datapath for purposes of offloading=2E
>
>In order to prevent the issue of unilateral exhaustion of MDB resources,
>introduce two parameters in each of two contexts:
>
>- Per-port and (when BROPT_MCAST_VLAN_SNOOPING_ENABLED is enabled)
>  per-port-VLAN number of MDB entries that the port is member in=2E
>
>- Per-port and (when BROPT_MCAST_VLAN_SNOOPING_ENABLED is enabled)
>  per-port-VLAN maximum permitted number of MDB entries, or 0 for
>  no limit=2E
>
>Per-port number of entries keeps track of the total number of MDB entries
>configured on a given port=2E The per-port-VLAN value then keeps track of=
 the
>subset of MDB entries configured specifically for the given VLAN, on that
>port=2E The number is adjusted as port_groups are created and deleted, an=
d
>therefore under multicast lock=2E
>
>A maximum value, if non-zero, then places a limit on the number of entrie=
s
>that can be configured in a given context=2E Attempts to add entries abov=
e
>the maximum are rejected=2E
>
>Rejection reason of netlink-based requests to add MDB entries is
>communicated through extack=2E This channel is unavailable for rejections
>triggered from the control path=2E To address this lack of visibility, th=
e
>patchset adds a tracepoint, bridge:br_mdb_full:
>
>	# perf record -e bridge:br_mdb_full &
>	# [=2E=2E=2E]
>	# perf script | cut -d: -f4-
>	 dev v2 af 2 src 192=2E0=2E2=2E1/:: grp 239=2E1=2E1=2E1/::/00:00:00:00:0=
0:00 vid 0
>	 dev v2 af 10 src 0=2E0=2E0=2E0/2001:db8:1::1 grp 0=2E0=2E0=2E0/ff0e::1/=
00:00:00:00:00:00 vid 0
>	 dev v2 af 2 src 192=2E0=2E2=2E1/:: grp 239=2E1=2E1=2E1/::/00:00:00:00:0=
0:00 vid 10
>	 dev v2 af 10 src 0=2E0=2E0=2E0/2001:db8:1::1 grp 0=2E0=2E0=2E0/ff0e::1/=
00:00:00:00:00:00 vid 10
>
>This tracepoint is triggered for mcast_hash_max exhaustions as well=2E
>
>The following is an example of how the feature is used=2E A more extensiv=
e
>example is available in patch #8:
>
>	# bridge vlan set dev v1 vid 1 mcast_max_groups 1
>	# bridge mdb add dev br port v1 grp 230=2E1=2E2=2E3 temp vid 1
>	# bridge mdb add dev br port v1 grp 230=2E1=2E2=2E4 temp vid 1
>	Error: bridge: Port-VLAN is already a member in mcast_max_groups (1) gro=
ups=2E
>
>The patchset progresses as follows:
>
>- In patch #1, set strict_start_type at two bridge-related policies=2E Th=
e
>  reason is we are adding a new attribute to one of these, and want the n=
ew
>  attribute to be parsed strictly=2E The other was adjusted for completen=
ess'
>  sake=2E
>
>- In patches #2 to #5, br_mdb and br_multicast code is adjusted to make t=
he
>  following additions smoother=2E
>
>- In patch #6, add the tracepoint=2E
>
>- In patch #7, the code to maintain number of MDB entries is added as
>  struct net_bridge_mcast_port::mdb_n_entries=2E The maximum is added, to=
o,
>  as struct net_bridge_mcast_port::mdb_max_entries, however at this point
>  there is no way to set the value yet, and since 0 is treated as "no
>  limit", the functionality doesn't change at this point=2E Note however,
>  that mcast_hash_max violations already do trigger at this point=2E
>
>- In patch #8, netlink plumbing is added: reading of number of entries, a=
nd
>  reading and writing of maximum=2E
>
>  The per-port values are passed through RTM_NEWLINK / RTM_GETLINK messag=
es
>  in IFLA_BRPORT_MCAST_N_GROUPS and _MAX_GROUPS, inside IFLA_PROTINFO nes=
t=2E
>
>  The per-port-vlan values are passed through RTM_GETVLAN / RTM_NEWVLAN
>  messages in BRIDGE_VLANDB_ENTRY_MCAST_N_GROUPS, _MAX_GROUPS, inside
>  BRIDGE_VLANDB_ENTRY=2E
>
>The following patches deal with the selftest:
>
>- Patches #9 and #10 clean up and move around some selftest code=2E
>
>- Patches #11 to #14 add helpers and generalize the existing IGMP / MLD
>  support to allow generating packets with configurable group addresses a=
nd
>  varying source lists for (S,G) memberships=2E
>
>- Patch #15 adds code to generate IGMP leave and MLD done packets=2E
>
>- Patch #16 finally adds the selftest itself=2E
>
>Petr Machata (16):
>  net: bridge: Set strict_start_type at two policies
>  net: bridge: Add extack to br_multicast_new_port_group()
>  net: bridge: Move extack-setting to br_multicast_new_port_group()
>  net: bridge: Add br_multicast_del_port_group()
>  net: bridge: Change a cleanup in br_multicast_new_port_group() to goto
>  net: bridge: Add a tracepoint for MDB overflows
>  net: bridge: Maintain number of MDB entries in net_bridge_mcast_port
>  net: bridge: Add netlink knobs for number / maximum MDB entries
>  selftests: forwarding: Move IGMP- and MLD-related functions to lib
>  selftests: forwarding: bridge_mdb: Fix a typo
>  selftests: forwarding: lib: Add helpers for IP address handling
>  selftests: forwarding: lib: Add helpers for checksum handling
>  selftests: forwarding: lib: Parameterize IGMPv3/MLDv2 generation
>  selftests: forwarding: lib: Allow list of IPs for IGMPv3/MLDv2
>  selftests: forwarding: lib: Add helpers to build IGMP/MLD leave
>    packets
>  selftests: forwarding: bridge_mdb_max: Add a new selftest
>
> include/trace/events/bridge=2Eh                 |  67 ++
> include/uapi/linux/if_bridge=2Eh                |   2 +
> include/uapi/linux/if_link=2Eh                  |   2 +
> net/bridge/br_mdb=2Ec                           |  17 +-
> net/bridge/br_multicast=2Ec                     | 255 ++++-
> net/bridge/br_netlink=2Ec                       |  21 +-
> net/bridge/br_netlink_tunnel=2Ec                |   3 +
> net/bridge/br_private=2Eh                       |  22 +-
> net/bridge/br_vlan=2Ec                          |  11 +-
> net/bridge/br_vlan_options=2Ec                  |  33 +-
> net/core/net-traces=2Ec                         |   1 +
> net/core/rtnetlink=2Ec                          |   2 +-
> =2E=2E=2E/testing/selftests/net/forwarding/Makefile |   1 +
> =2E=2E=2E/selftests/net/forwarding/bridge_mdb=2Esh    |  60 +-
> =2E=2E=2E/net/forwarding/bridge_mdb_max=2Esh          | 970 ++++++++++++=
++++++
> tools/testing/selftests/net/forwarding/lib=2Esh | 216 ++++
> 16 files changed, 1604 insertions(+), 79 deletions(-)
> create mode 100755 tools/testing/selftests/net/forwarding/bridge_mdb_max=
=2Esh
>


Nice set, thanks! Please hold off applying until Sunday when I'll be able =
to properly review it=2E

Cheers,
  Nik
