Return-Path: <shhuiw@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject
	:content-type:content-transfer-encoding;
	bh=CZXiPmWX9eeWRgzHzZDNPr4OGNYCwXhdcY/0UORUWXY=;
	b=Gd20cYEvydgzj06l6H8RIrK+tt04ir+3BcG1y+fugqT0mTopbgC+2oJjd6Q6E/kWba
	BuVMVXD0ZJUyOGnWCJrIlfcgwmRqih2mfC686+KItzhT0bUubobQIA/SO3myo6B/dTBj
	MY6E3LDYNvpScWJjbY2mgugCRqujGSoyi3jiDQPczkSsWvwfEgh5S/8wxCN3Doik/LZm
	J5Dm0mS2hIw2d9vkErJxwUnngL+jRpD4bIbWxvRu/FFXmRdSRngusOZBNKHkIe2Y9uAm
	uwbBRX7Au9yg2/jMpCKDwnOm+NVQllteZ2+VVBR5EzFMCv1O3FKasN1IEB4RbGJ+4KQQ
	FmsA==
Message-ID: <520046FE.3010305@gmail.com>
Date: Tue, 06 Aug 2013 08:44:46 +0800
From: Wang Sheng-Hui <shhuiw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge: correct the comment for file br_sysfs_br.c
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org


br_sysfs_if.c is for sysfs attributes of bridge ports, while br_sysfs_br.c
is for sysfs attributes of bridge itself. Correct the comment here.

Signed-off-by: Wang Sheng-Hui <shhuiw@gmail.com>
---
 net/bridge/br_sysfs_br.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 394bb96..3b9637f 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -1,5 +1,5 @@
 /*
- *	Sysfs attributes of bridge ports
+ *	Sysfs attributes of bridge
  *	Linux ethernet bridge
  *
  *	Authors:
-- 
1.7.10.4
