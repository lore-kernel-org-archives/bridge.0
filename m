Return-Path: <yajun.deng@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1626697338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vu7b9z6fy5eQBUVOgQ3fNILEElmkneJNf7Gu+XNQsCQ=;
 b=LQ5iMGMce0BId8ZMN7GgvooaWIunoMl/2GnrFI1IIUAAoHPMpbmv9VNM5KaK1BYEVGRAjZ
 avv9n3OxxFGZcet/s319LB5suQIH7knhvA/ZwBCSvYBhGeeWpHRg+EuBLRghNiZ4TNsOaX
 /QFW3BVPxKWugNiVVwBwGbhNM0fqSK0=
From: Yajun Deng <yajun.deng@linux.dev>
Date: Mon, 19 Jul 2021 20:21:54 +0800
Message-Id: <20210719122158.5037-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 0/4] Remove rtnetlink_send() in rtnetlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, yoshfuji@linux-ipv6.org, dsahern@kernel.org, courmisch@gmail.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, johannes@sipsolutions.net
Cc: linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>

rtnetlink_send() is similar to rtnl_notify(), there is no need for two 
functions to do the same thing. we can remove rtnetlink_send() and 
modify rtnl_notify() to adapt more case.

Patch1: remove rtnetlink_send() modify rtnl_notify() to adapt 
more case in rtnetlink.
Path2,Patch3: Adjustment parameters in rtnl_notify().
Path4: rtnetlink_send() already removed, use rtnl_notify() instead 
of rtnetlink_send().

Yajun Deng (4):
  rtnetlink: remove rtnetlink_send() in rtnetlink
  net: Adjustment parameters in rtnl_notify()
  vxlan: Adjustment parameters in rtnl_notify()
  net/sched: use rtnl_notify() instead of rtnetlink_send()

 drivers/net/vxlan.c       |  2 +-
 include/linux/rtnetlink.h |  7 +++----
 include/net/netlink.h     |  5 ++---
 net/bridge/br_fdb.c       |  2 +-
 net/bridge/br_mdb.c       |  4 ++--
 net/bridge/br_netlink.c   |  2 +-
 net/bridge/br_vlan.c      |  2 +-
 net/core/fib_rules.c      |  2 +-
 net/core/neighbour.c      |  2 +-
 net/core/net_namespace.c  |  2 +-
 net/core/rtnetlink.c      | 27 ++++++++-------------------
 net/dcb/dcbnl.c           |  2 +-
 net/decnet/dn_dev.c       |  2 +-
 net/decnet/dn_table.c     |  2 +-
 net/ipv4/devinet.c        |  4 ++--
 net/ipv4/fib_semantics.c  |  2 +-
 net/ipv4/fib_trie.c       |  2 +-
 net/ipv4/ipmr.c           |  4 ++--
 net/ipv4/nexthop.c        |  4 ++--
 net/ipv6/addrconf.c       |  8 ++++----
 net/ipv6/ip6mr.c          |  4 ++--
 net/ipv6/ndisc.c          |  2 +-
 net/ipv6/route.c          |  9 +++++----
 net/mpls/af_mpls.c        |  4 ++--
 net/phonet/pn_netlink.c   |  4 ++--
 net/sched/act_api.c       | 13 ++++++-------
 net/sched/cls_api.c       | 14 +++++++-------
 net/sched/sch_api.c       | 13 ++++++-------
 net/wireless/wext-core.c  |  2 +-
 29 files changed, 69 insertions(+), 83 deletions(-)

-- 
2.32.0

