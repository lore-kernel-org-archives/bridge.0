Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=NDJ9mh80iZLdDoZd5SY+wYUAw8eGJQtg/oEhCzJb8AQ=;
	b=Smo43UCWmyVSxtp6Ei2gJ/oZ3uBoA/3TpF/0bqWT1DZgLVWvCy/i3QibNf9E0QHqyd
	92L2ux24zvLW1CfHRXvh61Cu4yFrVdj2xquLhypXSwcTuG3azx8WYm1powLO3AuKpjLi
	fet0vpmjtAt9RN94nIljA4IR1sLeWZ13P1x3g=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 30 Aug 2016 15:08:57 +0200
Message-Id: <1472562539-23247-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 0/2] net: bridge: add per-port unknown
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

