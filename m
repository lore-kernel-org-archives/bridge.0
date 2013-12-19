Return-Path: <tanxiaojun@huawei.com>
From: Tan Xiaojun <tanxiaojun@huawei.com>
Date: Thu, 19 Dec 2013 13:28:09 +0800
Message-ID: <1387430894-11220-1-git-send-email-tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH 0/5] bridge: cleanup and fix checkpatch errors
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org, davem@davemloft.net, bart.de.schuymer@pandora.be
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Clean up and fix some checkpatch errors in bridge driver.

Tan Xiaojun (5):
  bridge: remove unnecessary condition judgment
  bridge: remove unnecessary parentheses
  bridge: add space before '(/{', after ',', etc.
  bridge: change "foo* bar" to "foo *bar"
  bridge: change the position of '{' to the pre line

 net/bridge/br_fdb.c                   |  3 +--
 net/bridge/br_forward.c               |  4 ++--
 net/bridge/br_ioctl.c                 |  2 +-
 net/bridge/br_netfilter.c             |  2 +-
 net/bridge/br_netlink.c               |  3 +--
 net/bridge/br_private.h               |  2 +-
 net/bridge/br_stp_timer.c             |  2 +-
 net/bridge/br_sysfs_if.c              | 20 ++++++++++----------
 net/bridge/netfilter/ebt_log.c        |  2 +-
 net/bridge/netfilter/ebt_snat.c       |  2 +-
 net/bridge/netfilter/ebtable_broute.c |  6 ++----
 net/bridge/netfilter/ebtable_filter.c |  9 +++------
 net/bridge/netfilter/ebtable_nat.c    |  9 +++------
 net/bridge/netfilter/ebtables.c       | 17 ++++++++---------
 14 files changed, 36 insertions(+), 47 deletions(-)

-- 
1.8.0


