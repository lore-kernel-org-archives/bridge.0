Return-Path: <igor.mitsyanko.os@quantenna.com>
From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Date: Fri,  9 Mar 2018 19:03:03 -0800
Message-Id: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
Subject: [Bridge] [PATCH net-next 0/5] Switchdev: flooding offload option
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: ivecera@redhat.com, igor.mitsyanko.os@quantenna.com, jiri@resnulli.us, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

Main goal of the patchset is to allow for flooding offload to switchdev
in scenarios when HW switchdev ports and SW ports are operating in a
single bridge.

In case a data frame that needs to be flooded is ingressed on a SW port,
    it needs to be flooded to a single HW port of any given
    switchdev-capable hardware only. Switchdev hardware will than take care
    about flooding to the rest of the ports that it manages.


Igor Mitsyanko (5):
  bridge: initialize port flags with switchdev defaults
  bridge: propagate BR_ flags updates through sysfs to switchdev
  bridge: allow switchdev port to handle flooding by itself
  bridge: provide sysfs and netlink interface to set BR_FLOOD_OFFLOAD
  bridge: verify "HW only" flags can't be set without HW support

 include/linux/if_bridge.h    |  1 +
 include/uapi/linux/if_link.h |  1 +
 net/bridge/br_forward.c      |  2 ++
 net/bridge/br_if.c           | 17 ++++++++++++++++-
 net/bridge/br_netlink.c      |  8 +++++++-
 net/bridge/br_private.h      | 13 ++++++++++++-
 net/bridge/br_switchdev.c    | 14 +++++++++++++-
 net/bridge/br_sysfs_if.c     | 17 +++++++++++++----
 8 files changed, 65 insertions(+), 8 deletions(-)

-- 
2.9.5

