Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 841FF60B74
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6611E607F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4AthPWbMfFaYPs4+NGIwulHWDc0XnUxiNJWN8M35SI=;
 b=nJiNsdruHppkZxMr48/fYsBe/Oeqr2xpoLaLQVbQM8uIoC+/Jcpx66/Jymr63O8BiXar2q2Xl2/zMGl3mm+DVMX4U0HAtEKDWwJT0z8ziTcB79pHV+88ureSK61717EptzEnYp/fohZ5Kl2V5yZmBF2cQte9OARBwolkwWSjZkL/JSOmP2K3tOTVh0DvSEaFnJRUb0Z0BkJpSKuRHosOYkSkeIZQKlQSeHwVVZ/KPel/4fibbigsMOKQssv70GJD0gmHzSQvvcrSrLKt32fP2HXdsdHCBmmoMsKDbowycYJ7Zv8l5qX1g2vPRLyDR7WMzYylsSjeLGAi/c9gtI2HIA==
Date: Tue, 8 Nov 2022 12:59:00 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y2o2dB+k+yDHRVtA@shredder>
References: <cover.1667902754.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 00/15] mlxsw: Add 802.1X and MAB
	offload support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>, vladimir.oltean@nxp.com
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Jiri Pirko <jiri@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>, Eric Dumazet <edumazet@google.com>, mlxsw@nvidia.com, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

+ Vladimir

You weren't copied on the patches by mistake. They are available here:
https://lore.kernel.org/netdev/cover.1667902754.git.petrm@nvidia.com/

On Tue, Nov 08, 2022 at 11:47:06AM +0100, Petr Machata wrote:
> Ido Schimmel <idosch@nvidia.com> writes:
> 
> This patchset adds 802.1X [1] and MAB [2] offload support in mlxsw.
> 
> Patches #1-#3 add the required switchdev interfaces.
> 
> Patches #4-#5 add the required packet traps for 802.1X.
> 
> Patches #6-#10 are small preparations in mlxsw.
> 
> Patch #11 adds locked bridge port support in mlxsw.
> 
> Patches #12-#15 add mlxsw selftests. The patchset was also tested with
> the generic forwarding selftest ('bridge_locked_port.sh').
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=a21d9a670d81103db7f788de1a4a4a6e4b891a0b
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=a35ec8e38cdd1766f29924ca391a01de20163931
> 
> Hans J. Schultz (1):
>   bridge: switchdev: Allow device drivers to install locked FDB entries
> 
> Ido Schimmel (14):
>   bridge: switchdev: Let device drivers determine FDB offload indication
>   bridge: switchdev: Reflect MAB bridge port flag to device drivers
>   devlink: Add packet traps for 802.1X operation
>   mlxsw: spectrum_trap: Register 802.1X packet traps with devlink
>   mlxsw: reg: Add Switch Port FDB Security Register
>   mlxsw: spectrum: Add an API to configure security checks
>   mlxsw: spectrum_switchdev: Prepare for locked FDB notifications
>   mlxsw: spectrum_switchdev: Add support for locked FDB notifications
>   mlxsw: spectrum_switchdev: Use extack in bridge port flag validation
>   mlxsw: spectrum_switchdev: Add locked bridge port support
>   selftests: devlink_lib: Split out helper
>   selftests: mlxsw: Add a test for EAPOL trap
>   selftests: mlxsw: Add a test for locked port trap
>   selftests: mlxsw: Add a test for invalid locked bridge port
>     configurations
> 
>  .../networking/devlink/devlink-trap.rst       |  13 +++
>  drivers/net/ethernet/mellanox/mlxsw/reg.h     |  35 ++++++
>  .../net/ethernet/mellanox/mlxsw/spectrum.c    |  22 ++++
>  .../net/ethernet/mellanox/mlxsw/spectrum.h    |   5 +-
>  .../mellanox/mlxsw/spectrum_switchdev.c       |  64 +++++++++--
>  .../ethernet/mellanox/mlxsw/spectrum_trap.c   |  25 +++++
>  drivers/net/ethernet/mellanox/mlxsw/trap.h    |   2 +
>  include/net/devlink.h                         |   9 ++
>  include/net/switchdev.h                       |   1 +
>  net/bridge/br.c                               |   5 +-
>  net/bridge/br_fdb.c                           |  22 +++-
>  net/bridge/br_private.h                       |   2 +-
>  net/bridge/br_switchdev.c                     |   6 +-
>  net/core/devlink.c                            |   3 +
>  .../drivers/net/mlxsw/devlink_trap_control.sh |  22 ++++
>  .../net/mlxsw/devlink_trap_l2_drops.sh        | 105 ++++++++++++++++++
>  .../selftests/drivers/net/mlxsw/rtnetlink.sh  |  31 ++++++
>  .../selftests/net/forwarding/devlink_lib.sh   |  19 ++--
>  18 files changed, 366 insertions(+), 25 deletions(-)
> 
> -- 
> 2.35.3
> 
