Return-Path: <fredrik.markstrom@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=vH6alTiayX1LhY4/NYIkKgGfNtfNSQzjbLtoLm/QWkk=;
	b=VpnUlRt7OlnBdCphnfPWa6TbOuE5yZjVuHxh+5LyVi2sbITK4brLXan/CT1F9EgxYL
	r+KKdkKsnhX6bzLg3SG3JwUg6GjlYsetFLPE9Oi7UxGTlEPL3gHaw5krDp7mupJkn2QJ
	RmSpN1UI5X4zYjn0NwXgyeRdjMy0gak4D79D73wNoqBcH3kYms33OeagOddOBaH+KCLP
	BmvcFUeHgVrTj/hyb3n4vOZQYEeILYRLZ8SokXRUbfaXt3PEkvNCuKyN7WBhLz3DRfh/
	E7KtX4Eo/Dy1A1IBWcg1N0SI4LcSJBhVC1uIowfhf+JGcaZ9eVSn2dBL9Pypl0Ls4rK3
	lBnA==
From: Fredrik Markstrom <fredrik.markstrom@gmail.com>
Date: Thu, 11 May 2017 15:46:26 +0200
Message-Id: <20170511134629.139528-1-fredrik.markstrom@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 0/2] net: Set maximum receive packet size on
	veth interfaces
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
end of the pair. This is inconsistent with most hardware ethernet drivers
that happily receives packets up the the ethernet MTU independent of the
configured MTU.

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

v2 - Updated description and fixed compile error in net/bridge/br_forward.c

-- 
2.11.0

