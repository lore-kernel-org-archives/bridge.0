Return-Path: <razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri,  2 Oct 2015 15:05:09 +0200
Message-Id: <1443791113-12738-1-git-send-email-razor@blackwall.org>
Subject: [Bridge] [PATCH net-next 0/4] bridge: vlan: cleanups & fixes (part
	2)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, vyasevich@gmail.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Hi,
This is the second follow-up set with one fix (patch 01) and more cleanups
(patches 02,03 and 04). These are minor compared to the previous ones and
should be the last before taking on the optimization changes on the
fast-path.

Cheers,
 Nik

Nikolay Aleksandrov (4):
  bridge: vlan: use rcu list for the ordered vlan list
  bridge: vlan: use br_vlan_(get|put)_master to deal with refcounts
  bridge: vlan: drop master_flags from __vlan_add
  bridge: vlan: use br_vlan_should_use to simplify __vlan_add/del

 net/bridge/br_netlink.c |  10 ++++-
 net/bridge/br_private.h |   2 +-
 net/bridge/br_vlan.c    | 102 +++++++++++++++++++++++++++---------------------
 3 files changed, 66 insertions(+), 48 deletions(-)

-- 
2.4.3

