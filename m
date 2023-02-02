Return-Path: <SRS0=aOxR=56=goodmis.org=rostedt@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C9DC41CB1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19B3F41CAA
Date: Thu, 2 Feb 2023 11:22:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20230202112222.327d3a79@rorschach.local.home>
In-Reply-To: <008620de41985a3a757c7099bc712ae75739db27.1675271084.git.petrm@nvidia.com>
References: <cover.1675271084.git.petrm@nvidia.com>
 <008620de41985a3a757c7099bc712ae75739db27.1675271084.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next mlxsw v2 06/16] net: bridge: Add a
 tracepoint for MDB overflows
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org

On Wed, 1 Feb 2023 18:28:39 +0100
Petr Machata <petrm@nvidia.com> wrote:

> The following patch will add two more maximum MDB allowances to the global
> one, mcast_hash_max, that exists today. In all these cases, attempts to a=
dd
> MDB entries above the configured maximums through netlink, fail noisily a=
nd
> obviously. Such visibility is missing when adding entries through the
> control plane traffic, by IGMP or MLD packets.
>=20
> To improve visibility in those cases, add a trace point that reports the
> violation, including the relevant netdevice (be it a slave or the bridge
> itself), and the MDB entry parameters:
>=20
> 	# perf record -e bridge:br_mdb_full &
> 	# [...]
> 	# perf script | cut -d: -f4-
> 	 dev v2 af 2 src ::ffff:0.0.0.0 grp ::ffff:239.1.1.112/00:00:00:00:00:00=
 vid 0
> 	 dev v2 af 10 src :: grp ff0e::112/00:00:00:00:00:00 vid 0
> 	 dev v2 af 2 src ::ffff:0.0.0.0 grp ::ffff:239.1.1.112/00:00:00:00:00:00=
 vid 10
> 	 dev v2 af 10 src 2001:db8:1::1 grp ff0e::1/00:00:00:00:00:00 vid 10
> 	 dev v2 af 2 src ::ffff:192.0.2.1 grp ::ffff:239.1.1.1/00:00:00:00:00:00=
 vid 10
>=20
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: linux-trace-kernel@vger.kernel.org
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>=20
> Notes:
>     v2:
>     - Report IPv4 as an IPv6-mapped address through the IPv6 buffer
>       as well, to save ring buffer space.
>=20
>  include/trace/events/bridge.h | 58 +++++++++++++++++++++++++++++++++++
>  net/core/net-traces.c         |  1 +
>  2 files changed, 59 insertions(+)
>=20

=46rom the tracing point of view:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
