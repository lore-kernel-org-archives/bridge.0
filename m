Date: Fri, 15 May 2009 09:11:58 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090515091158.55090cd0@nehalam>
In-Reply-To: <20090515091013.44b624d7@nehalam>
References: <20090515091013.44b624d7@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 2/2] bridge: fix initial packet flood if !STP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

If bridge is configured with no STP and forwarding delay of 0 (which
is typical for virtualization) then when link starts it will flood all
packets for the first 20 seconds. 

This bug was introduced by a combination of earlier changes:
  * forwarding database uses hold time of zero to indicate 
    user wants to always flood packets
  * optimzation of the case of forwarding delay of 0 avoids the initial
    timer tick

The fix is to just skip all the topology change detection code if
kernel STP is not being used.

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

--- a/net/bridge/br_stp.c	2009-05-14 13:34:49.965908836 -0700
+++ b/net/bridge/br_stp.c	2009-05-14 14:15:11.370903917 -0700
@@ -297,6 +297,9 @@ void br_topology_change_detection(struct
 {
 	int isroot = br_is_root_bridge(br);
 
+	if (br->stp_enabled != BR_KERNEL_STP)
+		return;
+
 	pr_info("%s: topology change detected, %s\n", br->dev->name,
 		isroot ? "propagating" : "sending tcn bpdu");
 
