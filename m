Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=73ciu6eFOPHbqo4MJgjXh4/QYZ5M67T1wK+DASmK9NE=;
 b=DaguywYnXaB5G+/wUWtHvNyDG1c1zijWNwRMBQDCYCF62OfhAdXJOnm+M7+Alsq7Lu
 +UYRLmbfdv2rr92dPElP66Em4P6ykmydnfyuWxSwffY/iWRIYQ61Tt98d0dDjdEO70Z0
 h44GqX/EmP0wFQgmZNs4oD3W4NnmUBuK+mAi/Af2zR00chDU3nsi/k3FHJ16Qa1QJ/6e
 OGRrfpUEXHRvd9z0kxW8Vtu933kts++nwlOtfgQ9jj/rbD6IXvFMjckirvKiM8OTYhPT
 OhV7JWJ0lmC/nuNdvosxOqQizxr3Ao8IyrEdgf0huBgXuFSQnAosKyDxyKywWkSQ5zoU
 9+cw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 26 Jan 2021 11:35:31 +0200
Message-Id: <20210126093533.441338-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 0/2] net: bridge: multicast: per-port
	EHT hosts limit
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
Let's be on the safe side and limit the number of tracked hosts by
default while allowing the user to increase that limit if needed.

v2: patch 2: move br_multicast_eht_set_hosts_limit() to br_multicast_eht.c,
             no functional change

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: multicast: add per-port EHT hosts limit
  net: bridge: multicast: make tracked EHT hosts limit configurable

 include/uapi/linux/if_link.h      |  2 ++
 net/bridge/br_multicast.c         |  1 +
 net/bridge/br_multicast_eht.c     | 22 ++++++++++++++++++++++
 net/bridge/br_netlink.c           | 19 ++++++++++++++++++-
 net/bridge/br_private.h           |  2 ++
 net/bridge/br_private_mcast_eht.h | 28 ++++++++++++++++++++++++++++
 net/bridge/br_sysfs_if.c          | 26 ++++++++++++++++++++++++++
 net/core/rtnetlink.c              |  2 +-
 8 files changed, 100 insertions(+), 2 deletions(-)

-- 
2.29.2

