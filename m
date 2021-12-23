Return-Path: <repk@triplefau.lt>
From: Remi Pommarel <repk@triplefau.lt>
Date: Thu, 23 Dec 2021 16:31:37 +0100
Message-Id: <20211223153139.7661-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 0/2] Fix SIOCGIFBR/SIOCSIFBR ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

SIOC{G,S}IFBR ioctls have been broken since [0], as discussed here [1]
the intent was to get them working in compat mode.

This serie is gathering patch from [2] with the one from [3].

The first patch fixes the ioctl usage so it can be backported to stable
kernel while the second one adds proper support for those ioctl in
compat mode.

This has been tested with busybox's brctl as below.

Before this serie

- 64-bit brctl:
  $ brctl show
  bridge name     bridge id               STP enabled     interfaces
  brctl: can't get bridge name for index 0: No such device or address

- 32-bit brctl on CONFIG_COMPAT=y kernel:
  $ brctl show
  brctl: SIOCGIFBR: Invalid argument

With first patch of this serie

- 64-bit brctl
  $ brctl show
  bridge name     bridge id               STP enabled     interfaces
  br0             8000.000000000000       no

- 32-bit brctl on CONFIG_COMPAT=y kernel
  $ brctl show
    brctl: SIOCGIFBR: Invalid argument

With both patches

- 64-bit brctl
  $ brctl show
  bridge name     bridge id               STP enabled     interfaces
  br0             8000.000000000000       no

- 32-bit brctl on CONFIG_COMPAT=y kernel
  $ brctl show
  bridge name     bridge id               STP enabled     interfaces
  br0             8000.000000000000       no

[0] commit 561d8352818f ("bridge: use ndo_siocdevprivate")
[1] https://lkml.org/lkml/2021/12/22/805
[2] https://lkml.org/lkml/2021/12/22/743
[3] https://lkml.org/lkml/2021/12/23/212

Thanks,

Remi Pommarel (2):
  net: bridge: fix ioctl old_deviceless bridge argument
  net: bridge: Get SIOCGIFBR/SIOCSIFBR ioctl working in compat mode

 net/bridge/br_ioctl.c | 75 ++++++++++++++++++++++++++++---------------
 net/socket.c          | 20 ++----------
 2 files changed, 52 insertions(+), 43 deletions(-)

-- 
2.33.0

