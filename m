Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDaZfruxRLOBNCUNl44GntcTxlfx0NYWY3plBC20+I0=;
 b=F/KwvChQgRDm8FZ3yh3PFp4cs3Tysu5UJ1cbawxIcbHFPeDN/NxjYIoTd8hPHuslaQGsHIWROfdQvEzlX3avX6Fl4ILrecQ8YNw4imKylOO7n2EHuLpNrMMgNKngabN+LTAgwqT3yDfF1ez8R2XR3rYc4z1IL3hFMfOZliDSvEJ+vu41aVtwpkJjydpnDQlCwR2YAqBicWQWG6357LCikViEzUIZ9crWC25U89086FAGg/j1e/p8i5RnqcabctTmBlfVpeiP02zjSInikVUwRoYn3DlAQIuPc/iMJALiBlR3gmGZrQuP0VEJIqesAR1i1cqiOS5GbQ3Mb0aoSzklEw==
References: <20210504182259.5042-1-Joseph.Huang@garmin.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <6fd5711c-8d53-d72b-995d-1caf77047ecf@nvidia.com>
Date: Tue, 4 May 2021 23:05:24 +0300
In-Reply-To: <20210504182259.5042-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net 0/6] bridge: Fix snooping in multi-bridge
 config with switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joseph Huang <Joseph.Huang@garmin.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@idosch.org>

On 04/05/2021 21:22, Joseph Huang wrote:
> This series of patches contains the following fixes:
> 
> 1. In a distributed system with multiple hardware-offloading bridges,
>    if a multicast source is attached to a Non-Querier bridge, the bridge
>    will not forward any multicast packets from that source to the Querier.
> 
>                     +--------------------+
>                     |                    |
>                     |      Snooping      |    +------------+
>                     |      Bridge 1      |----| Listener 1 |
>                     |     (Querier)      |    +------------+
>                     |                    |
>                     +--------------------+
>                               |
>                               |
>                     +----+---------+-----+
>                     |    | mrouter |     |
>    +-----------+    |    +---------+     |    +------------+
>    | MC Source |----|      Snooping      |----| Listener 2 |
>    +-----------|    |      Bridge 2      |    +------------+
>                     |    (Non-Querier)   |
>                     +--------------------+
> 
>    In this scenario, Listener 1 will never receive multicast traffic
>    from MC Source since Snooping Bridge 2 does not forward multicast
>    packets to the mrouter port. Patches 0001, 0002, and 0003 address
>    this issue.
> 
> 2. If mcast_flood is disabled on a bridge port, some of the snooping
>    functions stop working properly.
> 
>    a. Consider the following scenario:
> 
>                        +--------------------+
>                        |                    |
>                        |      Snooping      |    +------------+
>                        |      Bridge 1      |----| Listener 1 |
>                        |     (Querier)      |    +------------+
>                        |                    |
>                        +--------------------+
>                                  |
>                                  |
>                        +--------------------+
>                        |    | mrouter |     |
>       +-----------+    |    +---------+     |
>       | MC Source |----|      Snooping      |
>       +-----------|    |      Bridge 2      |
>                        |    (Non-Querier)   |
>                        +--------------------+
> 
>       In this scenario, Listener 1 will never receive multicast traffic
>       from MC Source if mcast_flood is disabled on the mrouter port on
>       Snooping Bridge 2. Patch 0004 addresses this issue.
> 
>    b. For a Non-Querier bridge, if mcast_flood is disabled on a bridge
>       port, Queries received from other Querier will not be forwarded
>       out of that bridge port. Patch 0005 addresses this issue.
> 
> 3. After a system boots up, the first couple Reports are not handled
>    properly:
> 
>    1) the Report from the Host is being flooded (via br_flood) to all
>       bridge ports, and
>    2) if the mrouter port's mcast_flood is disabled, the Reports received
>       from other hosts will not be forwarded to the Querier.
> 
>    Patch 0006 addresses this issue.
> 
> These patches were developed and verified initially against 5.4 kernel
> (due to hardware platform limitation) and forward-patched to 5.12.
> Snooping code introduced between 5.4 and 5.12 are not extensively tested
> (only IGMPv2/MLDv1 were tested). The hardware platform used were two
> bridges utilizing a single Marvell 88E6352 Ethernet switch chip (i.e.,
> no cross-chip bridging involved).
> 
> Joseph Huang (6):
>   bridge: Refactor br_mdb_notify
>   bridge: Offload mrouter port forwarding to switchdev
>   bridge: Avoid traffic disruption when Querier state changes
>   bridge: Force mcast_flooding for mrouter ports
>   bridge: Flood Queries even when mcast_flood is disabled
>   bridge: Always multicast_flood Reports
> 
>  net/bridge/br_device.c    |   5 +-
>  net/bridge/br_forward.c   |   3 +-
>  net/bridge/br_input.c     |   5 +-
>  net/bridge/br_mdb.c       |  70 +++++++++++++---------
>  net/bridge/br_multicast.c | 121 ++++++++++++++++++++++++++++++++++----
>  net/bridge/br_private.h   |  11 +++-
>  6 files changed, 169 insertions(+), 46 deletions(-)
> 
> 
> base-commit: 5e321ded302da4d8c5d5dd953423d9b748ab3775
> 

Hi,
This patch-set is inappropriate for -net, if at all. It's quite late over here
and I'll review the rest later, but I can say from a quick peek that patch 02
is unacceptable for it increases the complexity with 1 order of magnitude of all
add/del call paths and some of them can be invoked on user packets. A lot of this
functionality should be "hidden" in the driver or done by a user-space daemon/helper.
Most of the flooding behaviour changes must be hidden behind some new option
otherwise they'll break user setups that rely on the current. I'll review the patches
in detail over the following few days, net-next is closed anyway.

Cheers,
 Nik

