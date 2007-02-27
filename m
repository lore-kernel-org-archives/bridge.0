Date: Tue, 27 Feb 2007 09:52:51 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070227095251.0c20eebd@freekitty>
In-Reply-To: <20070221224255.790379091@linux-foundation.org>
References: <20070221224107.741532037@linux-foundation.org>
	<20070221224255.790379091@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 3+/4] bridge: fix locking of set path cost
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org, Srinivas Aji <Aji_Srinivas@emc.com>

This change goes with earlier change to get rid of 
work queue for path cost. Now stp_set_path_cost does its own
locking. This is to allow it to call br_path_cost() which calls
ethtool interfaces (might sleep).


Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>
---
 net/bridge/br_ioctl.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- bridge.orig/net/bridge/br_ioctl.c	2007-02-27 09:46:15.000000000 -0800
+++ bridge/net/bridge/br_ioctl.c	2007-02-27 09:43:24.000000000 -0800
@@ -291,12 +291,11 @@
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		spin_lock_bh(&br->lock);
 		if ((p = br_get_port(br, args[1])) == NULL)
 			ret = -EINVAL;
 		else
 			br_stp_set_path_cost(p, args[2]);
-		spin_unlock_bh(&br->lock);
+
 		return ret;
 	}
 
