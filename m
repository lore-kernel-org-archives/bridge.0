Return-Path: <ap420073@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=RNOs0gippc48oI1ljVSqLonFCd5o2axGJZBKtTvPhSc=;
 b=bvDRD6V45T+aam+5saAJ+SuWVFHrBil11q/s2FR4D5/4KC+7XdTT9ycg0X2YAHX77x
 255DPBeqEZuFzM0uaLq3X/uudpcGTOpcag1WF1LE0KBjimAXli0Chwr+5SxiwJxXSWmk
 ifi7wN4XZIK0F8kuzbGk4n1chL7sp7ULLZ50Wgk6mPLwu1q9Q5br9lTOG+Tq4gPgGy+L
 O4WmOgbGYMUw0BY00uRQicDWPxcXLdXk/h3MEGSPiiuUv0LwJZAfmh9PI7nkBmxD8TMD
 z7odcj7Z3zUlSdgaqnDDy0s/eCkooLVLPB7FhlUqp6ucedOaQwOlEUfY1Coada/V+Qyn
 Tngw==
From: Taehee Yoo <ap420073@gmail.com>
Date: Sun, 25 Apr 2021 15:52:05 +0000
Message-Id: <20210425155207.29888-1-ap420073@gmail.com>
Subject: [Bridge] [PATCH net 0/2] Subject: [PATCH net 0/2] net: fix lockdep
	false positive splat
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, roopa@nvidia.com, nikolay@nvidia.com, ast@kernel.org, andriin@fb.com, daniel@iogearbox.net, weiwan@google.com, cong.wang@bytedance.com, bjorn@kernel.org, herbert@gondor.apana.org.au, bridge@lists.linux-foundation.org
Cc: ap420073@gmail.com

This patchset is to fix lockdep false positive splat in multicast part of
the bridge.

When mdb or multicast config is changed, it acquires multicast_lock,
which is a per-interface(bridge) lock.
So, spin_lock_nested() should be used instead of spin_lock() because
interfaces can be recursive.
The spin_lock_nested() needs 'subclass' parameter.

The first patch adds a new helper function, which returns the nest_level
variable under RCU. The nest_level variable can be used as 'subclass'
parameter of spin_lock_nested().
The second patch fix lockdep false positive splat in the bridge multicast
part by using netdev_get_nest_level_rcu().

Taehee Yoo (2):
  net: core: make bond_get_lowest_level_rcu() generic
  net: bridge: fix lockdep multicast_lock false positive splat

 drivers/net/bonding/bond_main.c |  45 +---------
 include/linux/netdevice.h       |   1 +
 net/bridge/br_mdb.c             |  12 +--
 net/bridge/br_multicast.c       | 146 ++++++++++++++++++++------------
 net/bridge/br_multicast_eht.c   |  18 ++--
 net/bridge/br_private.h         |  48 +++++++++++
 net/core/dev.c                  |  44 ++++++++++
 7 files changed, 204 insertions(+), 110 deletions(-)

-- 
2.17.1

