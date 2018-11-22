Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=cLcX/HtdZPD5RPJJo0CFzqMmGMTapS772G5FByIydqo=;
	b=gDsVMKymW+WwGMs7Wiof1T5hFFaVmAuWYf82VbUBk621ne5EQ6H3xTv4Uo6SEYAvl5
	ABWyfVnThctAd28zsWeLn/D1i4FF2jpyerdK028ZsPRH4rg9TyT+AXANOzCyUu5Oc20e
	Q4HJTRZASLy6mpFY9zqXlG3nHUlQC4og8qQW0=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 22 Nov 2018 06:29:23 +0200
Message-Id: <20181122042925.8878-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 0/2] net: bridge: add an option to disabe
	linklocal learning
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, andrew@lunn.ch, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Hi,
This set adds a new bridge option which can control learning from
link-local packets, by default learning is on to be consistent and avoid
breaking users expectations. If the new no_linklocal_learn option is
enabled then the bridge will stop learning from link-local packets.

In order to save space for future boolean options, patch 01 adds a new
bool option API that uses a bitmask to control boolean options. The
bridge is by far the largest netlink attr user and we keep adding simple
boolean options which waste nl attr ids and space. We're not directly
mapping these to the in-kernel bridge flags because some might require
more complex configuration changes (e.g. if we were to add the per port
vlan stats now, it'd require multiple checks before changing value).
Any new bool option needs to be handled by both br_boolopt_toggle and get
in order to be able to retrieve its state later. All such options are
automatically exported via netlink. The behaviour of setting such
options is consistent with netlink option handling when a missing
option is being set (silently ignored), e.g. when a newer iproute2 is used
on older kernel.

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: add support for user-controlled bool options
  net: bridge: add no_linklocal_learn bool option

 include/uapi/linux/if_bridge.h | 21 ++++++++++
 include/uapi/linux/if_link.h   |  1 +
 net/bridge/br.c                | 72 ++++++++++++++++++++++++++++++++++
 net/bridge/br_input.c          |  4 +-
 net/bridge/br_netlink.c        | 17 +++++++-
 net/bridge/br_private.h        |  7 ++++
 net/bridge/br_sysfs_br.c       | 22 +++++++++++
 net/core/rtnetlink.c           |  2 +-
 8 files changed, 143 insertions(+), 3 deletions(-)

-- 
2.17.2

