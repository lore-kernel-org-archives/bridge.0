Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C9868187F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66B8981854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjSm/Gn6HoNmncxU1UAmoG6ogZjOGBFzR1j6mE7SU+s=;
 b=Dda8c19MjKTkm9ujhty8iPi+WZLoGyEr4YyNIeIiGMuR/2blnNavSeoedeBN6ruBiDTHDyTXruKY1if+YIPlbBz6weofFOE7Y1x3G7VNFMsCcm9V+aB22D5yTYYewyvlMKtAMCs7ffCYw7y+gt5jwA0MPxNcLWZBSJaVlH38nC9zgdOXtJ778CLrnjX3IyDGWzop7mDAVBSPKWcgZ5031hEsT/xtE91N8pkfHs2NODTzW4PLlAQcdtaf079rsUDytLeoMy8dAieIqh5z9VjNWNB+OMIjnBNBQg0BI/gaOyvuWD1VpzvFB5QDcHrRWEDTr8hAuZuUXOZ8XA0e75gwmQ==
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 8 Nov 2022 11:47:06 +0100
Message-ID: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 00/15] mlxsw: Add 802.1X and MAB offload
	support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, mlxsw@nvidia.com, Jiri Pirko <jiri@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>

Ido Schimmel <idosch@nvidia.com> writes:

This patchset adds 802.1X [1] and MAB [2] offload support in mlxsw.

Patches #1-#3 add the required switchdev interfaces.

Patches #4-#5 add the required packet traps for 802.1X.

Patches #6-#10 are small preparations in mlxsw.

Patch #11 adds locked bridge port support in mlxsw.

Patches #12-#15 add mlxsw selftests. The patchset was also tested with
the generic forwarding selftest ('bridge_locked_port.sh').

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=a21d9a670d81103db7f788de1a4a4a6e4b891a0b
[2] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=a35ec8e38cdd1766f29924ca391a01de20163931

Hans J. Schultz (1):
  bridge: switchdev: Allow device drivers to install locked FDB entries

Ido Schimmel (14):
  bridge: switchdev: Let device drivers determine FDB offload indication
  bridge: switchdev: Reflect MAB bridge port flag to device drivers
  devlink: Add packet traps for 802.1X operation
  mlxsw: spectrum_trap: Register 802.1X packet traps with devlink
  mlxsw: reg: Add Switch Port FDB Security Register
  mlxsw: spectrum: Add an API to configure security checks
  mlxsw: spectrum_switchdev: Prepare for locked FDB notifications
  mlxsw: spectrum_switchdev: Add support for locked FDB notifications
  mlxsw: spectrum_switchdev: Use extack in bridge port flag validation
  mlxsw: spectrum_switchdev: Add locked bridge port support
  selftests: devlink_lib: Split out helper
  selftests: mlxsw: Add a test for EAPOL trap
  selftests: mlxsw: Add a test for locked port trap
  selftests: mlxsw: Add a test for invalid locked bridge port
    configurations

 .../networking/devlink/devlink-trap.rst       |  13 +++
 drivers/net/ethernet/mellanox/mlxsw/reg.h     |  35 ++++++
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  22 ++++
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   5 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |  64 +++++++++--
 .../ethernet/mellanox/mlxsw/spectrum_trap.c   |  25 +++++
 drivers/net/ethernet/mellanox/mlxsw/trap.h    |   2 +
 include/net/devlink.h                         |   9 ++
 include/net/switchdev.h                       |   1 +
 net/bridge/br.c                               |   5 +-
 net/bridge/br_fdb.c                           |  22 +++-
 net/bridge/br_private.h                       |   2 +-
 net/bridge/br_switchdev.c                     |   6 +-
 net/core/devlink.c                            |   3 +
 .../drivers/net/mlxsw/devlink_trap_control.sh |  22 ++++
 .../net/mlxsw/devlink_trap_l2_drops.sh        | 105 ++++++++++++++++++
 .../selftests/drivers/net/mlxsw/rtnetlink.sh  |  31 ++++++
 .../selftests/net/forwarding/devlink_lib.sh   |  19 ++--
 18 files changed, 366 insertions(+), 25 deletions(-)

-- 
2.35.3

