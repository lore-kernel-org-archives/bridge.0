Return-Path: <lucien.xin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=DtKqfl7X8CUmfyC1wMuazcBxbzQnkIutOQomvFXkmLo=;
	b=CII+EeMmeDcfKdJ9gJbne+/Kqt/x5NVaVWDUG6D6ru33GEnVfPJimTFVsf81MBSLZz
	3rITGfx9yTtK4KpEzwZjyrL+Pk3SyVnJ7yCN+N3lhG5eR53GDIZRmzUlsfQni9giNVrf
	Ysw+GHdJHHWZpE34xx+PH3+KxfvLCuFSqTmN1C7ADFvzZwDXpdYWyN0Iz8FW26+6amxf
	GuVMXqiUHJ/W2JKDCC3RkRMNexfqpbA9e07gMUrwr8VB0x4ipRVVn1LJ50PSSzgNI+YZ
	ICAAuGq80Dk29yG6sqtsbjvJHsFuAfXZaPZbFwn9FTwhApdStAdWlXru3pfsqVHbtZtl
	aCKw==
From: Xin Long <lucien.xin@gmail.com>
Date: Tue,  5 Apr 2016 11:32:35 +0800
Message-Id: <cover.1459827115.git.lucien.xin@gmail.com>
Subject: [Bridge] [PATCHv2 net-next 0/6] bridge: support sending rntl info
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

 net/bridge/br_ioctl.c    | 40 +++++++++++++----------
 net/bridge/br_sysfs_br.c | 83 +++++++++++++++++++-----------------------------
 net/bridge/br_sysfs_if.c |  5 +--
 net/bridge/br_vlan.c     | 30 +++--------------
 4 files changed, 65 insertions(+), 93 deletions(-)

-- 
2.1.0

