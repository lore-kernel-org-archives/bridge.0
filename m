Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=uSRo1/iQhEnjK9ocE1C1HawMnzohfDcN73HihdOFj4g=;
	b=FpYIl8WFDDCacPMcsScbKLJA7onYEjOJCYFV+XUZqg8g5w74Gx8KViCxoUEIyMq45p
	CjHW2pFHkNil+oZ2L42Dn5pHXmRq10KokvqmeDvOX+JitDTRpwauMK6Ss0Qae5RGKoJk
	zUPVnjyAMMylRzlyX23l9cvwIA90d4FQ8ReSg=
From: roopa@cumulusnetworks.com
Date: Thu,  5 Feb 2015 22:24:45 -0800
Message-Id: <1423203885-45657-1-git-send-email-roopa@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next] bridge: add missing bridge port check for
	offloads
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, dan.carpenter@oracle.com, stephen@networkplumber.org, netdev@vger.kernel.org
Cc: davem@davemloft.net

From: Roopa Prabhu <roopa@cumulusnetworks.com>

This patch fixes a missing bridge port check caught by smatch.

setlink/dellink of attributes like vlans can come for a bridge device
and there is no need to offload those today. So, this patch adds a bridge
port check. (In these cases however, the BRIDGE_SELF flags will always be set
and we may not hit a problem with the current code).

smatch complaint:

The patch 68e331c785b8: "bridge: offload bridge port attributes to
switch asic if feature flag set" from Jan 29, 2015, leads to the
following Smatch complaint:

net/bridge/br_netlink.c:552 br_setlink()
	 error: we previously assumed 'p' could be null (see line 518)

net/bridge/br_netlink.c
   517
   518		if (p && protinfo) {
                    ^
Check for NULL.

Reported-By: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
---
 net/bridge/br_netlink.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index b93f42c..4fbcea0 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -543,7 +543,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags)
 				afspec, RTM_SETLINK);
 	}
 
-	if (!(flags & BRIDGE_FLAGS_SELF)) {
+	if (p && !(flags & BRIDGE_FLAGS_SELF)) {
 		/* set bridge attributes in hardware if supported
 		 */
 		ret_offload = netdev_switch_port_bridge_setlink(dev, nlh,
@@ -583,7 +583,7 @@ int br_dellink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags)
 		 */
 		br_ifinfo_notify(RTM_NEWLINK, p);
 
-	if (!(flags & BRIDGE_FLAGS_SELF)) {
+	if (p && !(flags & BRIDGE_FLAGS_SELF)) {
 		/* del bridge attributes in hardware
 		 */
 		ret_offload = netdev_switch_port_bridge_dellink(dev, nlh,
-- 
1.7.10.4

