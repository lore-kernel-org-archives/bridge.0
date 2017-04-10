Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=R6r3SA
	6+V8Jlxsi4v7Gs1p5oMZgb0bB0BByWvbaK1uI=; b=lTzxzuQE7OPSqBfx6xM9P+
	Tk28lKFi6BhZfAQJ6FdXhig5mxmzLd6WrzDuIgBuen+Oh9TXagyQtm+109PKrdfs
	sHOdHKoM/w5jvU5IszDVGJcH78ShJGsw7fwTl3KnzLEFaKRkHrT4YnjF8iI35fds
	2W2oZ+uHzDK+c6BAmrVLfuxRlhs5xTyjZOMlNBCsgjavBVvukDleBw204Ker9C7G
	GlK6PwaxBrdpSGE53JWVkNkCZ3vNS/jlFa3+wGXPMrTe9bAG8vdHFndM786tlhFj
	13SLEyi+8a5vPaRnousJFbMXx+af9aHod0azN7w6Zaq5lZJLrr+Gxjmq+ClvpmVw
	==
From: idosch@idosch.org
Date: Mon, 10 Apr 2017 14:59:26 +0300
Message-Id: <20170410115928.9344-1-idosch@idosch.org>
Subject: [Bridge] [PATCH net v3 0/2] bridge: Fix kernel oops during bridge
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
Cc: Ido Schimmel <idosch@mellanox.com>, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, peter@svinota.eu, bridge@lists.linux-foundation.org, davem@davemloft.net

From: Ido Schimmel <idosch@mellanox.com>

First patch adds a missing ndo_uninit() in the bridge driver, which is a
prerequisite for the second patch that actually fixes the oops.

Please consider both patches for 4.4.y, 4.9.y and 4.10.y

Ido Schimmel (2):
  bridge: implement missing ndo_uninit()
  bridge: netlink: register netdevice before executing changelink

 net/bridge/br_device.c    | 20 +++++++++++---------
 net/bridge/br_if.c        |  1 -
 net/bridge/br_multicast.c |  7 +++++--
 net/bridge/br_netlink.c   |  7 +++++--
 net/bridge/br_private.h   |  5 +++++
 5 files changed, 26 insertions(+), 14 deletions(-)

-- 
2.9.3

