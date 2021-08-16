Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6TDmKThXQnwJ9/lpiXTr7wPbuz+EjXXtj7u1wDzkO5M=;
 b=Y19/YiD3KnkC03qYx0indOUyDBvwrWKUVIY0ybeFfFx8Zf9BHT3Nuq/xciwsycA2vU
 iS2P3ROP/iZHE6b8+2TN8Kj2yAFnpdGKLufBA5UMLJkWMjhatQ0mdctRXDWg7mUgnhjx
 X1MuJzqShYg7y94MX/NnDa4qOqKF0bebVJtuxmDPc0VNNwdx7TYn/m4yb8GsTyabnyzn
 /dQOE8LU2jD9+mvheSmbs9+VY0cXrJmrHZq04NN2mzCxMADtxBxjxa/wPI/wfuTVTWuT
 F1g1JTst4uA1u6IKVlIlmJATYPyAopXuvvMZ9VG0bOJHfX5Svvq9OoMYyWPzA2Td8m0j
 BJ0g==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 16 Aug 2021 17:57:03 +0300
Message-Id: <20210816145707.671901-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/4] net: bridge: vlan: fixes for vlan
	mcast contexts
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
These are four fixes for vlan multicast contexts. The first patch enables
mcast ctx snooping when adding already existing master vlans to be
consistent with the rest of the code. The second patch accounts for the
mcast ctx router ports when allocating skb for notification. The third
one fixes two suspicious rcu usages due to wrong vlan group helper, and
the fourth updates host vlan mcast state along with port mcast state.

Thanks,
 Nik


Nikolay Aleksandrov (4):
  net: bridge: vlan: enable mcast snooping for existing master vlans
  net: bridge: vlan: account for router port lists when notifying
  net: bridge: mcast: use the correct vlan group helper
  net: bridge: mcast: toggle also host vlan state in
    br_multicast_toggle_vlan

 net/bridge/br_mdb.c          | 30 ++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c    | 10 +++++++---
 net/bridge/br_private.h      |  7 +------
 net/bridge/br_vlan.c         |  1 +
 net/bridge/br_vlan_options.c | 17 +++++++++--------
 5 files changed, 48 insertions(+), 17 deletions(-)

-- 
2.31.1

