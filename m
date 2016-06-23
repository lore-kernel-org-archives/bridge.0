Return-Path: <somasissounds@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=3QouqnA7Qq9gxz6UmzAXZMN55VRSa/8qOXrwlZtlxpM=;
	b=aPKz+1BuMi6KML+L9iSNLSc0tkafSuSuYEgwqSg4GaocvNdDu5J/JYZQNJ1AtUyLJ4
	cGa6wo8FJQOtY02irjQdgIDTstzQFT9+nA0qq53QGK2YeEZFrKVZpNma9kCh3mYkafhJ
	ow8ovv+cSUHiKXt92ChonwdT5ahXJWu6+fSrmI5siV++P1WNUBwMTwSKbx9YReyAjbw3
	yVZU6TRbTFtv+9QtUjLJrfO0RWwTCWJj1varZrGfTGnBZ8icM/bIK+RKHZNlkULZJvtE
	wBgZaxUpfTOYBzkKLYhnnZHX7Lnil0blhOpiXw65VoGddPIJ0PR7UXU5WO3PFEEDKPfK
	FL7w==
From: Kylie McClain <somasissounds@gmail.com>
Date: Wed, 22 Jun 2016 22:50:36 -0400
Message-Id: <20160623025036.5260-1-somasissounds@gmail.com>
Subject: [Bridge] [PATCH] Fix building on musl libc
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Kylie McClain <somasis@exherbo.org>

From: Kylie McClain <somasis@exherbo.org>

- Silence warnings:
  errno.h is defined by POSIX, sys/errno.h is a glibcism, same with
  fcntl.h vs. sys/fcntl.h
- Use standard types rather than _GNU_SOURCE-exposed types
  u_int16_t -> uint16_t
  u_int8_t -> uint8_t
---
 brctl/brctl.c               |  2 +-
 libbridge/libbridge.h       | 13 +++++++------
 libbridge/libbridge_devif.c |  2 +-
 libbridge/libbridge_if.c    |  2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/brctl/brctl.c b/brctl/brctl.c
index 46ca352..8855234 100644
--- a/brctl/brctl.c
+++ b/brctl/brctl.c
@@ -19,7 +19,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/errno.h>
+#include <errno.h>
 #include <getopt.h>
 
 #include "libbridge.h"
diff --git a/libbridge/libbridge.h b/libbridge/libbridge.h
index dd14bae..ff047f9 100644
--- a/libbridge/libbridge.h
+++ b/libbridge/libbridge.h
@@ -19,6 +19,7 @@
 #ifndef _LIBBRIDGE_H
 #define _LIBBRIDGE_H
 
+#include <sys/types.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <linux/if.h>
@@ -46,7 +47,7 @@ struct bridge_info
 	struct timeval bridge_max_age;
 	struct timeval bridge_hello_time;
 	struct timeval bridge_forward_delay;
-	u_int16_t root_port;
+	uint16_t root_port;
 	unsigned char stp_enabled;
 	unsigned char topology_change;
 	unsigned char topology_change_detected;
@@ -59,8 +60,8 @@ struct bridge_info
 
 struct fdb_entry
 {
-	u_int8_t mac_addr[6];
-	u_int16_t port_no;
+	uint8_t mac_addr[6];
+	uint16_t port_no;
 	unsigned char is_local;
 	struct timeval ageing_timer_value;
 };
@@ -70,9 +71,9 @@ struct port_info
 	unsigned port_no;
 	struct bridge_id designated_root;
 	struct bridge_id designated_bridge;
-	u_int16_t port_id;
-	u_int16_t designated_port;
-	u_int8_t priority;
+	uint16_t port_id;
+	uint16_t designated_port;
+	uint8_t priority;
 	unsigned char top_change_ack;
 	unsigned char config_pending;
 	unsigned char state;
diff --git a/libbridge/libbridge_devif.c b/libbridge/libbridge_devif.c
index 1e83925..2cf78f6 100644
--- a/libbridge/libbridge_devif.c
+++ b/libbridge/libbridge_devif.c
@@ -23,7 +23,7 @@
 #include <errno.h>
 #include <string.h>
 #include <dirent.h>
-#include <sys/fcntl.h>
+#include <fcntl.h>
 
 #include "libbridge.h"
 #include "libbridge_private.h"
diff --git a/libbridge/libbridge_if.c b/libbridge/libbridge_if.c
index 77d3f8a..9cf4bac 100644
--- a/libbridge/libbridge_if.c
+++ b/libbridge/libbridge_if.c
@@ -20,7 +20,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
-#include <sys/fcntl.h>
+#include <fcntl.h>
 #include <sys/ioctl.h>
 
 #include "libbridge.h"
-- 
2.9.0

