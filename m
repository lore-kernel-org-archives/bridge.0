Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=V4rWXJ2tpEiNH+IrjeyjPAyIUyY7Pf3NVFBtOzSWDZ4=;
	b=eNyIvroMVMypeiD5Ml26xkHS6byckQi5UFEi/cbEEet0D46En2uc7sq8Il6NalALrA
	/hkoRTKMI0j3TrCvD6/WY5ygOufnTL4HTmMyRh/EwFGZMoz+trU2nN4EqKXB3LIg19Vs
	/Lafdc5yWtpQymIqO//UdJqbTgwGx5Q7CQ7GY=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 26 Feb 2016 21:20:00 +0100
Message-Id: <1456518004-25578-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2 0/4] bridge: mcast: add support for
	temp router port
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
This set adds support for temporary router port which doesn't depend only
on the incoming queries. It can be refreshed by setting multicast_router to
the same value (3). The first two patches are minor changes that prepare
the code for the third which adds this new type of router port.
In order to be able to dump its information the mdb router port format
is changed in patch 04 and extended similar to how mdb entries format was
done recently.
The related iproute2 changes will be posted if this is accepted.

v2: set val first and adjust router type later in patch 01, patch 03 was
split in 2

Thanks,
 Nik


Nikolay Aleksandrov (4):
  bridge: mcast: use names for the different multicast_router types
  bridge: mcast: do nothing if port's multicast_router is set to the
    same val
  bridge: mcast: add support for temporary port router
  bridge: mcast: add support for more router port information dumping

 include/uapi/linux/if_bridge.h | 22 ++++++++++-
 net/bridge/br_mdb.c            | 16 +++++++-
 net/bridge/br_multicast.c      | 83 +++++++++++++++++++++++++++---------------
 3 files changed, 89 insertions(+), 32 deletions(-)

-- 
2.4.3

