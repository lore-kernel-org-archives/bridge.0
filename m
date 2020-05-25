Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1590393381; x=1621929381;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gka3xhQHdVujI+DvQjAJqTOsOu9U8CaV+bHB/w8dE/o=;
 b=YyIwB8za8r2vJdfhDQU+5CVvtDoAlCxV2w513h3UyP0FCQ4sDaFKI4EU
 HyEJL7a+otopljhrXC3rp9D20UNtt48Ls26mB+hBvjk2mNlE6U2EgM16W
 h+p5OgAvFGYTwJ+uuGuOUBPfP3yD9jXn2iY3LKmasUzlOYFBYINMOyHCE
 2vtk2VGlU+2gRQqnQwuNNTJxKFcPYzSBrv9DNhsDJexeJGb4YkgQ/ntlT
 /KjNxduk89yYEGpQZpuWW3+uRYA5k3uxiD7rbaCVpsRRTsXDjIOvaGIzW
 0eTaQtUhyvIBut6jS9RG4njEx0VOgs6z2Y1NAByrCxODO3oGjHbaFU51X Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 25 May 2020 09:55:41 +0000
Message-ID: <20200525095541.46673-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH] bridge: mrp: Fix out-of-bounds read in br_mrp_parse
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch, UNGLinuxDriver@microchip.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzbot+9c6f0f1f8e32223df9a4@syzkaller.appspotmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>

The issue was reported by syzbot. When the function br_mrp_parse was
called with a valid net_bridge_port, the net_bridge was an invalid
pointer. Therefore the check br->stp_enabled could pass/fail
depending where it was pointing in memory.
The fix consists of setting the net_bridge pointer if the port is a
valid pointer.

Reported-by: syzbot+9c6f0f1f8e32223df9a4@syzkaller.appspotmail.com
Fixes: 6536993371fa ("bridge: mrp: Integrate MRP into the bridge")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp_netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
index 397e7f710772a..4a08a99519b04 100644
--- a/net/bridge/br_mrp_netlink.c
+++ b/net/bridge/br_mrp_netlink.c
@@ -27,6 +27,12 @@ int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
 	struct nlattr *tb[IFLA_BRIDGE_MRP_MAX + 1];
 	int err;
 
+	/* When this function is called for a port then the br pointer is
+	 * invalid, therefor set the br to point correctly
+	 */
+	if (p)
+		br = p->br;
+
 	if (br->stp_enabled != BR_NO_STP) {
 		NL_SET_ERR_MSG_MOD(extack, "MRP can't be enabled if STP is already enabled");
 		return -EINVAL;
-- 
2.26.2

