Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=OfHxu07kjZVvFJEVu3N+9y03wOgAvIwWlNsRVKIjhZo=;
	b=wGBSsVzOOPIiAOYER9psF7XkmmXqJtuaOQvp4/BroK2rWeTdlIO2Ogwnb4tQazoD/pZ7dsB00I/KMlNSiP1WPXxrf9hFdQBp/gb6wbmeypppXyYASvPGjIkLZvGEOtaoFLcn6pbPLohqXSp0lPiM8Eq9cIw1IYAJvZWXSd9hsZs=
From: <idosch@mellanox.com>
Date: Sat, 8 Apr 2017 14:41:57 +0300
Message-ID: <20170408114159.12722-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net v2 0/2] bridge: Fix kernel oops during bridge
	creation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@mellanox.com>, cera@cera.cz, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, peter@svinota.eu, bridge@lists.linux-foundation.org, davem@davemloft.net

From: Ido Schimmel <idosch@mellanox.com>

First patch adds a missing ndo_uninit() in the bridge driver, which is a
prerequisite for the second patch that actually fixes the oops.

First version was rejected for being "half baked", but given the amount
of changes in this version and that three stable kernels need to be
patched, a better approach might be to simply revert the patch in the
Fixes line and have this patchset go through net-next.

Ido Schimmel (2):
  bridge: implement missing ndo_uninit()
  bridge: netlink: register netdevice before executing changelink

 net/bridge/br_device.c    | 13 ++++++++++---
 net/bridge/br_if.c        |  1 -
 net/bridge/br_multicast.c |  7 +++++--
 net/bridge/br_netlink.c   | 12 ++++++++++--
 net/bridge/br_private.h   |  5 +++++
 5 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.9.3

