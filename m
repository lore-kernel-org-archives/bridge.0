Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=EVNwhizhlEXMr8mW7dUcBr0vghqjCIO9ytagcKaGhN4=;
	b=EQItRCpWfUr1CaImKCOoTxGYxUCtLPoefsEjTqPg8SsMnTVX6XMTY6nd4lOKEHuUvl
	9WY5sNtDlc+N68jzCquXpbBf+77mmpxlUZ0v3KdFWnPdLfOJZtAfJMOJCJLjc1D+b7Yt
	tubEXLivBeooUAtE1S/UV+oG6FpooZWkCcYoE=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 30 Aug 2016 17:23:06 +0200
Message-Id: <1472570588-32503-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2 0/2] net: bridge: add per-port unknown
	multicast flood control
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Hi,
The first patch prepares the forwarding path by having the exact packet
type passed down so we can later filter based on it and the per-port
unknown mcast flood flag introduced in the second patch. It is similar to
how the per-port unknown unicast flood flag works.
Nice side-effects of patch 01 are the slight reduction of tests in the
fast-path and a few minor checkpatch fixes.

v2: make pkt_type an enum as per Stephen's comment

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: change unicast boolean to exact pkt_type
  net: bridge: add per-port multicast flood flag

 include/linux/if_bridge.h    |  3 ++-
 include/uapi/linux/if_link.h |  1 +
 net/bridge/br_device.c       |  8 ++++----
 net/bridge/br_forward.c      |  7 +++++--
 net/bridge/br_if.c           |  2 +-
 net/bridge/br_input.c        | 40 +++++++++++++++++++++++++---------------
 net/bridge/br_netlink.c      | 12 +++++++++---
 net/bridge/br_private.h      |  7 ++++++-
 net/bridge/br_sysfs_if.c     |  1 +
 9 files changed, 54 insertions(+), 27 deletions(-)

-- 
2.1.4

