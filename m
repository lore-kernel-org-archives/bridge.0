Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9EkdsdYrApQ7+f5B8Pf+SPksTX/P+n0hxS3e4gT9YU8=;
 b=xqiRpsxL69vB0rwu/tqx/+M8yMfnqdwIb7raj+3psGPAF3iRPd6FMf46Tn4VpwyItb
 LHQcr8Ax3liG9F1syUcoSfiF5j2K2cTZ+uVYAhkmZ53Sih1ZFMTUj/Gu5d98VE1eQhz7
 X4z3w6gR0WR4VvFpZ8vvtEI8fyRyW4zoYDXY4zto0r2hni1xTyxeoy90wsy8N94LR8KJ
 8EBf8/GeQwHJMySq3h0zLRqfsq3qd5Upf4TcUUDzHr6CVr6Me78rYi4k3F2S8FQdpFRS
 okJ1JqXxx7Wu6JYjlmSVM4+0i0pfJYD9BfLnS/ZdbuMifq4WG6dTkFbd/X2jpfwsw/Ti
 /v3w==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu,  5 Aug 2021 11:29:00 +0300
Message-Id: <20210805082903.711396-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/3] net: bridge: fix recent ioctl changes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, arnd@arndb.de, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
These are three fixes for the recent bridge removal of ndo_do_ioctl
done by commit ad2f99aedf8f ("net: bridge: move bridge ioctls out of
.ndo_do_ioctl"). Patch 01 fixes a deadlock of the new bridge ioctl
hook lock and rtnl by taking a netdev reference and always taking the
bridge ioctl lock first then rtnl from within the bridge hook.
Patch 02 fixes old_deviceless() bridge calls device name argument, and
patch 03 checks in dev_ifsioc()'s SIOCBRADD/DELIF cases if the netdevice is
actually a bridge before interpreting its private ptr as net_bridge.

Patch 01 was tested by running old bridge-utils commands with lockdep
enabled. Patch 02 was tested again by using bridge-utils and using the
respective ioctl calls on a "up" bridge device. Patch 03 was tested by
using the addif ioctl on a non-bridge device (e.g. loopback).

Thanks,
 Nik

Nikolay Aleksandrov (3):
  net: bridge: fix ioctl locking
  net: bridge: fix ioctl old_deviceless bridge argument
  net: core: don't call SIOCBRADD/DELIF for non-bridge devices

 net/bridge/br_if.c    |  4 +---
 net/bridge/br_ioctl.c | 39 +++++++++++++++++++++++++--------------
 net/core/dev_ioctl.c  |  9 ++++++++-
 3 files changed, 34 insertions(+), 18 deletions(-)

-- 
2.31.1

