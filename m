Return-Path: <>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=DN8ZoZdGfVEsVHjTWyC7pWRWkFwEdQ1waIdqXbpGFiY=;
	b=gD7lDjDRGRAHGq7xEgo9yBrFpvzM7x7+mReevepuCWunzwQ6A/U0fQDVp7pe86iW5w
	6vwQ13yZQTEgoWE3GfbpXcuSAeE8od9NsDmNPj8XxBCdd8nKH7NNhOW/xInATBC4xm9q
	3oby65al4Smb09qSf89iNcTJE2IxUb5NIYXyY=
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Tue,  3 Oct 2017 21:43:52 -0700
Message-Id: <1507092235-39876-1-git-send-email-roopa@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v3 0/3] bridge: neigh msg proxy and flood
	suppression support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Roopa Prabhu <roopa@cumulusnetworks.com>

This series implements arp and nd suppression in the bridge
driver for ethernet vpns. It implements rfc7432, section 10
https://tools.ietf.org/html/rfc7432#section-10
for ethernet VPN deployments. It is similar to the existing
BR_ARP_PROXY flag but has a few semantic differences to conform
to EVPN standard. In case of EVPN, it is mainly used to avoid flooding to
tunnel ports like vxlan. Unlike the existing flags it suppresses flood
of all neigh discovery packets (arp, nd) to tunnel ports.

v2 : rebase to latest + address some optimization feedback from Nikolay.
v3 : fix kbuild reported build errors with CONFIG_INET off

Roopa Prabhu (3):
  bridge: add new BR_NEIGH_SUPPRESS port flag to suppress arp and nd
    flood
  neigh arp suppress first
  bridge: suppress nd messages from going to BR_NEIGH_SUPPRESS ports

 include/linux/if_bridge.h    |   1 +
 include/uapi/linux/if_link.h |   1 +
 net/bridge/Makefile          |   2 +-
 net/bridge/br_arp_nd_proxy.c | 492 +++++++++++++++++++++++++++++++++++++++++++
 net/bridge/br_device.c       |  18 ++
 net/bridge/br_forward.c      |   3 +-
 net/bridge/br_if.c           |   5 +
 net/bridge/br_input.c        |  73 ++-----
 net/bridge/br_netlink.c      |  16 +-
 net/bridge/br_private.h      |   9 +
 net/bridge/br_sysfs_if.c     |   2 +
 11 files changed, 561 insertions(+), 61 deletions(-)
 create mode 100644 net/bridge/br_arp_nd_proxy.c

-- 
2.1.4

