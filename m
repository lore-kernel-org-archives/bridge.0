Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=r321PWAMEFjT5r81kKiX/eqJ1FlWbJsSU+glz5FPlrk=;
	b=H4WINix3uy3a6QX74h26aV3AF9n+/bxK8se1JV5ZbSrbV8s3wdqLJqwG4z4YCaR6R5
	7c4X+P/+OmLUJ/iinT/IFpl2gaDR90xWToajOcwHPgljU4lLjIvQodfvCBZaswuXR6AG
	bfQKFVAS8jkPb/OTa3c29y6rSADRhDW6l1JSo=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sun, 28 Jul 2019 21:22:30 +0300
Message-Id: <20190728182230.28818-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: delete local fdbs on device init
	failure
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, syzbot+88533dc8b582309bf3ee@syzkaller.appspotmail.com

On initialization failure we have to delete all local fdbs which were
inserted due to the default pvid. This problem has been present since the
inception of default_pvid. Note that currently there are 2 cases:
1) in br_dev_init() when br_multicast_init() fails
2) if register_netdevice() fails after calling ndo_init()

This patch takes care of both since br_vlan_flush() is called on both
occasions. Also the new fdb delete would be a no-op on normal bridge device
destruction since the local fdbs would've been already flushed by
br_dev_delete(). This is not an issue for ports since nbp_vlan_init() is
called last when adding a port thus nothing can fail after it.

Reported-by: syzbot+88533dc8b582309bf3ee@syzkaller.appspotmail.com
Fixes: 5be5a2df40f0 ("bridge: Add filtering support for default_pvid")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
Tested with the provided reproducer and can no longer trigger the leak.
Also tested the br_multicast_init() failure manually by making it always
return an error.

 net/bridge/br_vlan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 021cc9f66804..3e6a702e4c21 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -715,6 +715,11 @@ void br_vlan_flush(struct net_bridge *br)
 
 	ASSERT_RTNL();
 
+	/* delete auto-added default pvid local fdbs before flushing vlans
+	 * otherwise these will be leaked on bridge device init failure
+	 */
+	br_fdb_delete_by_port(br, NULL, 0, 1);
+
 	vg = br_vlan_group(br);
 	__vlan_flush(vg);
 	RCU_INIT_POINTER(br->vlgrp, NULL);
-- 
2.21.0

