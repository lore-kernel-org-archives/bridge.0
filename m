Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=U0kiHPd8vVMzUfrIH4eQy9QOgI871QT6lUVDAO0BmLM=;
	b=eBUvkFajZIBRFmIKQW5xx3NeMKBfTvnHUDftUJJfn+OFFZM3Zm/wXOLzBAMkPqwqI1
	spyX5+qORnCEHHFulKsk5jWo/u0qXQ4bhkeo0eJk9PSOl0A21J7Y7DUGtcR612/QvG+u
	aSIwMHHXQmTDBT5asnwfSJ75yQIaiKLk/1d/Q=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 20 Jul 2018 17:48:24 +0300
Message-Id: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 0/2] net: bridge: add support for backup
	port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

Hi,
This set introduces a new bridge port option that allows any port to have
any other port (in the same bridge of course) as its backup and traffic
will be forwarded to the backup port when the primary goes down. This is
mainly used in MLAG and EVPN setups where we have peerlink path which is
a backup of many (or even all) ports and is a participating bridge port
itself. There's more detailed information in patch 02. Patch 01 just
prepares the port sysfs code for options that take raw value. The main
issues that this set solves are scalability and fallback latency.

We have used similar code for over 6 months now to bring the fallback
latency of the backup peerlink down and avoid fdb notification storms.
Also due to the nature of master devices such setup is currently not
possible, and last but not least having tens of thousands of fdbs require
thousands of calls to switch.

I've also CCed our MLAG experts that have been using similar option.

Thanks,
 Nik


Nikolay Aleksandrov (2):
  net: bridge: add support for raw sysfs port options
  net: bridge: add support for backup port

 include/uapi/linux/if_link.h |  1 +
 net/bridge/br_forward.c      | 16 ++++++++-
 net/bridge/br_if.c           | 53 ++++++++++++++++++++++++++++
 net/bridge/br_netlink.c      | 30 +++++++++++++++-
 net/bridge/br_private.h      |  3 ++
 net/bridge/br_sysfs_if.c     | 82 ++++++++++++++++++++++++++++++++++++--------
 6 files changed, 168 insertions(+), 17 deletions(-)

-- 
2.11.0

