Return-Path: <arvind.yadav.cs@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=16vOTggiZT31B+PWqHYlfzBLnGLrGIBdUOGNuadFLkU=;
	b=jax8rqca8MWiWgWWdYEiX5I9hIFPzcAfM1nALvwHUwSwQ+Ikhw0fWHcMr53GhTO1NK
	nh45z5YWOw8wpC806brrY96aq+klJ3PLI8iE/+9YGCw813aZBVRRp9W7ln4+We76bohb
	5b/8vS368xFlmvT4FYpRVmB/jAVd/qg7E4uxe2sA5vVfX9jFeBwv7T2mUGnKnbzrY2ry
	AzUABnFdK8pg2wG9Ntg/CxhQos4/nGDkjeQ4rmJqxlGoTR/9hi825eosTBc6Xl6ImN9G
	hjVHMH+bCbCv1BXrTL+rEMMwkOmgDlWoCoS0fi0SdbKXNUkzKJtiNmyRxi4XTfX7w9/Y
	cI1w==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Message-Id: <dc7089d0bab72d77ef4819b7d46c8cf88cae6588.1498734476.git.arvind.yadav.cs@gmail.com>
Subject: [Bridge] [PATCH] net: bridge: constify attribute_group structures.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Thu, 29 Jun 2017 11:10:29 -0000
To: stephen@networkplumber.org, davem@davemloft.net, bridge@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   2645	    896	      0	   3541	    dd5	net/bridge/br_sysfs_br.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   2701	    832	      0	   3533	    dcd	net/bridge/br_sysfs_br.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 net/bridge/br_sysfs_br.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 0b5dd60..723f25e 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -865,7 +865,7 @@ static ssize_t vlan_stats_enabled_store(struct device *d,
 	NULL
 };
 
-static struct attribute_group bridge_group = {
+static const struct attribute_group bridge_group = {
 	.name = SYSFS_BRIDGE_ATTR,
 	.attrs = bridge_attrs,
 };
-- 
1.9.1

