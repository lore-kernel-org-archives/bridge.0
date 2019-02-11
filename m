Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=whP2T31Mi9yk1nJwoFJ9GEi1TFBKA5bW2oJpYvjtFLM=;
	b=odBBgn09m3CSnwo8BpV1ZdwyoKxI6zXAcmYOB8E4WV7RseuMKFb18n+ySxPrTjrPJj
	jPp4ldQaw1Y+bwbAjjrlxfz0SZ/Gx/NB8Hbc63u7sbDu5eM8lRZ6cxtsD5tNpBp19Kcr
	t6lZv/miLHHY+V39TLgtGoX3ODSqvThlZKj4dT8d6QygKkHan9ASiGq+EZqXirWbVdOc
	JoiCDJnWPXW3TyBfzTGIYKoTMU742ZAr6K4X9iEacCF0B6pkKS3pCxvsv7P56TaUgNZM
	u9zzXJyoI3UOBSXBuM2uvAwIh0+WhE6+53TvC30R8DSN2cnj/O72hHsFO6dkZE3Xc4sH
	q60g==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 11 Feb 2019 11:09:53 -0800
Message-Id: <20190211191001.8623-2-f.fainelli@gmail.com>
In-Reply-To: <20190211191001.8623-1-f.fainelli@gmail.com>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v4 1/9] Documentation: networking:
	switchdev: Update port parent ID section
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, vivien.didelot@gmail.com, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>

Update the section about switchdev drivers having to implement a
switchdev_port_attr_get() function to return
SWITCHDEV_ATTR_ID_PORT_PARENT_ID since that is no longer valid after
commit bccb30254a4a ("net: Get rid of
SWITCHDEV_ATTR_ID_PORT_PARENT_ID").

Fixes: bccb30254a4a ("net: Get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID")
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index f3244d87512a..ea90243340a9 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -92,11 +92,11 @@ device.
 Switch ID
 ^^^^^^^^^
 
-The switchdev driver must implement the switchdev op switchdev_port_attr_get
-for SWITCHDEV_ATTR_ID_PORT_PARENT_ID for each port netdev, returning the same
-physical ID for each port of a switch.  The ID must be unique between switches
-on the same system.  The ID does not need to be unique between switches on
-different systems.
+The switchdev driver must implement the net_device operation
+ndo_get_port_parent_id for each port netdev, returning the same physical ID for
+each port of a switch. The ID must be unique between switches on the same
+system. The ID does not need to be unique between switches on different
+systems.
 
 The switch ID is used to locate ports on a switch and to know if aggregated
 ports belong to the same switch.
-- 
2.17.1

