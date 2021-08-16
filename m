Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qrgX9mkMySys2qqZfdyzIpqPBGrmxciDBq8IvhkKYPo=;
 b=cmDpAUSYRrg5Wn2RkMba5vTWd2xWbMFOxoa+ArS1wP2A3xTvn78pMoTnrb8qTeBiLY
 kneDtQf74WnkI2Y8xMCOkEL/gge+e6DMyVtgAKp3SMVrLookOtcZeFx8YBuxXmhDkFpO
 Pqq/b1KF3IP88Y2kV+EaOUBcyyHLij/lIa60swjCeObNXPxJUzAbYdj51GmJEYbMP9TE
 xrZR0S/lsbex5/TQ0zjas2kpZfr56+LzwhujIWvIfstqZebToQzw4PneEFZ37bTSsI48
 wIvkNdDzUvFLcBJSPDm0+rK5SBz6d8knOvpompWfVA1NVeJm3lbsl1swCGvNHKWzs32L
 NHkA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 16 Aug 2021 13:11:31 +0300
Message-Id: <20210816101134.577413-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/3] net: bridge: mcast: fixes for mcast
	querier state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
These three fix querier state dumping. The first patch can be considered
a minor behaviour improvement, it avoids dumping querier state when mcast
snooping is disabled. The second patch was a report of sizeof(0) used
for nested netlink attribute size which should be just 0, and the third
patch accounts for IPv6 querier state size when allocating skb for
notifications.

Thanks,
 Nik

Nikolay Aleksandrov (3):
  net: bridge: mcast: don't dump querier state if snooping is disabled
  net: bridge: mcast: drop sizeof for nest attribute's zero size
  net: bridge: mcast: account for ipv6 size when dumping querier state

 net/bridge/br_multicast.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.31.1

