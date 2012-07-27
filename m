Return-Path: <amwang@redhat.com>
From: Cong Wang <amwang@redhat.com>
Date: Fri, 27 Jul 2012 23:38:01 +0800
Message-Id: <1343403484-29347-5-git-send-email-amwang@redhat.com>
In-Reply-To: <1343403484-29347-1-git-send-email-amwang@redhat.com>
References: <1343403484-29347-1-git-send-email-amwang@redhat.com>
Subject: [Bridge] [PATCH 4/7] bridge: call NETDEV_RELEASE notifier in
	br_del_if()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, Cong Wang <amwang@redhat.com>, "David S. Miller" <davem@davemloft.net>

When a bridge interface deletes its underlying ports, it should
notify netconsole too, like what bonding interface does.

Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Cong Wang <amwang@redhat.com>
---
 net/bridge/br_if.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index e1144e1..d243914 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -427,6 +427,7 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 	if (!p || p->br != br)
 		return -EINVAL;
 
+	call_netdevice_notifiers(NETDEV_RELEASE, br->dev);
 	del_nbp(p);
 
 	spin_lock_bh(&br->lock);
-- 
1.7.7.6

