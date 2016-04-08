Return-Path: <lucien.xin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=8KCNGht+FEXl7fFU3ASRT8Yn+IwamdDeupkXRoxyknE=;
	b=v93lreJ6VqiRdquJkNov10NHvPST5av3EV8eAXhZzgra6mYLIE1L4zbx3vuAtcR9I9
	A+IzyM6xqnC6UcNNu8L7tF2hcOa/z8LPotnXPNHDt32SUWHMuzlqh703Y3fqeUNKcObx
	IcQZoLGccm86HIEjFYept/ou6aXcVmcxszrvR7ik0sQWMaiflS+WdhCvstC8+HzeruqH
	u154fh1aLzozFLa+4jriLCh4b8//OoOOiUGDYNafKi7+zOhhvJydSe7QbTIN/SgfOwWv
	bXXyk0JBeRLlK13/S1bpG0lQRS/VbhimQEGX0oFdPNiMGoiF8DHZJtYN/Va1hGh8Rip2
	LJOQ==
From: Xin Long <lucien.xin@gmail.com>
Date: Sat,  9 Apr 2016 00:03:27 +0800
Message-Id: <cover.1460131308.git.lucien.xin@gmail.com>
Subject: [Bridge] [PATCHv3 net-next 0/6] bridge: support sending rntl info
	when we set attributes through sysfs/ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: network dev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org
Cc: nikolay@cumulusnetworks.com, davem@davemloft.net

This patchset is used to support sending rntl info to user in some places,
and ensure that whenever those attributes change internally or from sysfs,
that a netlink notification is sent out to listeners.

It also make some adjustment in bridge sysfs so that we can implement this
easily.

I've done some tests on this patchset, like:
[br_sysfs]
  1. change all the attribute values of br or brif:
  $ echo $value > /sys/class/net/br0/bridge/{*}
  $ echo $value > /sys/class/net/br0/brif/eth1/{*}

  2. meanwhile, on another terminal to observe the msg:
  $ bridge monitor

[br_ioctl]
  1. in bridge-utils package, do some changes in br_set, let brctl command
  use ioctl to set attribute:
         if ((ret = set_sysfs(path, value)) < 0) { -->
         if (1) {

  $ brctl set*

  2. meanwhile, on another terminal to observe the msg:
  $ bridge monitor

This test covers all the attributes that brctl and sysfs support to set.

Xin Long (6):
  bridge: simplify the flush_store by calling store_bridge_parm
  bridge: simplify the forward_delay_store by calling store_bridge_parm
  bridge: simplify the stp_state_store by calling store_bridge_parm
  bridge: a netlink notification should be sent when those attributes
    are changed by br_sysfs_br
  bridge: a netlink notification should be sent when those attributes
    are changed by br_sysfs_if
  bridge: a netlink notification should be sent when those attributes
    are changed by ioctl

 net/bridge/br_ioctl.c    | 40 ++++++++++++++---------
 net/bridge/br_sysfs_br.c | 84 ++++++++++++++++++++----------------------------
 net/bridge/br_sysfs_if.c |  5 +--
 net/bridge/br_vlan.c     | 30 +++--------------
 4 files changed, 66 insertions(+), 93 deletions(-)

-- 
2.1.0

