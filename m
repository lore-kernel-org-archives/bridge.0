Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=7L0xTa6HUjap5hvS5D6PfDYA/2qTJS8vMeAX54+U6P8=;
	b=AVfJJ2Z3BJxohhvaJosGHfmuHpolN4+mn5xeHpQxDwgH3+SrEUl98/yXAbSXa6HrrI
	4JvrRQVv7UzDD9bz2MhL4WnF+YaOqQNAFun0jH3RrPQinnlWTyhDy86oazrKG/TLUpwN
	PwvUIgLrxVT4L4harlpMJVk2jgKcAEkmM/k+JkSvW1ESuJ6L/Bu3/L3JczIwvKGnEQhH
	ZXBhOpqk4zcQBJ6zfETqsl/Jt3lo8zzqiss7oc01+1xpY8Hzs9Y1U6ehGcw4SeVkgoKi
	5TEuayykwBgMfDShRSR+BIdrNZV53/w5T++btSZtuRGJVQYGaxm3Qdm7MAQtLtBHY+tD
	Mp4A==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 09:50:50 -0800
Message-Id: <20190210175105.31629-2-f.fainelli@gmail.com>
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 01/16] Documentation: networking:
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
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

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
2.19.1

