Return-Path: <fredrik.markstrom@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=68hAMHLyQIpr3/Gmvac/jiIrTIxOPXW5E6OxEg/dgHc=;
	b=pBLGQnbUWfNgfkUz+BUqoN6ueex3arDAlIL+VInb2dVpGz7onxC8hvKyPpyjCKzTG5
	oXmdNk5VgS8Wl1L7vtcJuMR2XHp2J9k3kotK+ZYcO/NnwMzkuXr3ZYw1dEzeYARyKQVC
	MfR4QfzUQtaPv8GjEf/DIhz/knAcKGX9L3iyywkNK4M45trtQ5CEvi3bXaewP30G8oMy
	0k3rMZurR3nXdtMqTKDaB6nVWeoYO5oZe2ixyuSy1r38vqjaA+wgZN5+Z3PWj23A7xhf
	u9oCQPnZR6PMLTSx8YrViqKhoQHS0E4Jr5eGpiAxS2EfNONZOU31zAbBWi6JebDTZD0u
	RaZg==
From: Fredrik Markstrom <fredrik.markstrom@gmail.com>
Date: Tue,  9 May 2017 14:44:36 +0200
Message-Id: <20170509124439.45674-1-fredrik.markstrom@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 0/2] net: Set maximum receive packet size on veth
	interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Fredrik Markstrom <fredrik.markstrom@gmail.com>, "David S. Miller" <davem@davemloft.net>

Currently veth drops all packets larger then the mtu set on the receiving
end of the pair. This is inconsistent with most hardware ethernet drivers.

This patch set adds a new driver attribute to set the maximum size of
received packet to make it possible to create configurations similar to
those possible with (most) hardware ethernet interfaces.

The set consists of two patches. The first one adding a parameter do the
dev_forward_skb functions to specify the maximum packet size, the
second one implents a new attribute (VETH_MRU) in the veth driver.

Fredrik Markstrom (1):
  veth: Added attribute to set maximum receive size on veth interfaces

Fredrik Markström (1):
  net: Added mtu parameter to dev_forward_skb calls

 drivers/net/ipvlan/ipvlan_core.c |  7 ++++---
 drivers/net/macvlan.c            |  4 ++--
 drivers/net/veth.c               | 45 +++++++++++++++++++++++++++++++++++++++-
 include/linux/netdevice.h        | 10 ++++-----
 include/uapi/linux/veth.h        |  1 +
 net/bridge/br_forward.c          |  4 ++--
 net/core/dev.c                   | 17 +++++++++------
 net/core/filter.c                |  4 ++--
 net/l2tp/l2tp_eth.c              |  2 +-
 9 files changed, 72 insertions(+), 22 deletions(-)

-- 
2.11.0

