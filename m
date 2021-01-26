Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XdLi2k7bp5m2hq3pEkkJKOTLNg7Dpyy+GJx91gunEG8=;
 b=RAQdfDKfGB5XehyNiAe7lCmK/wr+jWCKZgZCPxq8MlVuEH6vVEzbcnYBvKZhUbl4In
 lLLXCtzwYSN3eleiegfCjn1mBDa0lqHdczqrKTlWJuLbW6HsEDvYvdsgPKmkfMJgE9CP
 oCUz8WD7umQ7Bq+tM9jdH5bdFc/+ID2KeYOWQdfbJ+oWV+brDLytO5heWlM36JM0MYi1
 1iCJhT4JpWLTgCwwBit2B9CXHiK7Tc9NFeLZ0KpStjry7XuzcZX6dmORHQRJSkl/sU1u
 MjkSwARjz1LtZk0+AwfWaVyjv8dN6nlvgQ9FefSbUac1in9WkdfDDR2NlJkaLksjLAL3
 l82w==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 26 Jan 2021 11:21:30 +0200
Message-Id: <20210126092132.407355-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/2] net: bridge: multicast: per-port EHT
	hosts limit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
This set adds a simple configurable per-port EHT tracked hosts limit.
Patch 01 adds a default limit of 512 tracked hosts per-port, since the EHT
changes are still only in net-next that shouldn't be a problem. Then
patch 02 adds the ability to configure and retrieve the hosts limit
and to retrieve the current number of tracked hosts per port.

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: multicast: add per-port EHT hosts limit
  net: bridge: multicast: make tracked EHT hosts limit configurable

 include/uapi/linux/if_link.h      |  2 ++
 net/bridge/br_multicast.c         | 16 ++++++++++++++++
 net/bridge/br_multicast_eht.c     |  7 +++++++
 net/bridge/br_netlink.c           | 19 ++++++++++++++++++-
 net/bridge/br_private.h           |  2 ++
 net/bridge/br_private_mcast_eht.h | 28 ++++++++++++++++++++++++++++
 net/bridge/br_sysfs_if.c          | 26 ++++++++++++++++++++++++++
 net/core/rtnetlink.c              |  2 +-
 8 files changed, 100 insertions(+), 2 deletions(-)

-- 
2.29.2

