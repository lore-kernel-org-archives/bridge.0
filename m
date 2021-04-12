Return-Path: <matthew.weber@rockwellcollins.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rockwellcollins.com; s=hrcrc2020;
 h=from:to:cc:subject:date:message-id;
 bh=7LIvHoGH5BOpbn/7Pvv1gTxxp/EZlQ7PilgSRSf9hzM=;
 b=aG7siru3l8o3/4+Up7xvvxoRqeXb+7HBIqrGZ4ia/Pl55skYUyQJMPKT
 zv95opXSa1Upaj7xXLaRSJHwD+p6yfHu7WMCfTX/pRGtiUO458ni8gNAG
 Fvli7jQV7F6hFmFjYVOOAl4VevO5zaujzWnsSs54j2TQpZxbR/GyjEjIi
 EhsJOcuJNAreDsw72qrSa7gNTCON7wDzkAKRta58YRaJHY65fLmMpu3Qd
 QkwPFs0/c08RtGBjyLYMRwGuhirc7VKh8g8ga9LjG6c1j5IezCvaVaSk0
 4qKajk/zTmYA2X0Bw6FACOYts+TXEQPUgtO7QxVGI9O0ylQeqTy7cmI42 Q==;
From: Matt Weber <matthew.weber@rockwellcollins.com>
Date: Mon, 12 Apr 2021 09:30:34 -0500
Message-Id: <20210412143034.22415-1-matthew.weber@rockwellcollins.com>
Subject: [Bridge] [PATCH] Include header for use of PATH_MAX
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Since a1f20223cfcf7b9eae8c9e7e7a07e7bf1377f65b in some build
configurations PATH_MAX is undefined.

Build log from Buildroot testing failure:
http://autobuild.buildroot.net/results/3ec818e676827c03f08c264c6c7a53b025b7ba1d/build-end.log

...
/home/giuliobenetti/autobuild/run/instance-0/output-1/host/bin/arm-buildroot-linux-musleabihf-gcc -Wall -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -O2   -I/home/giuliobenetti/autobuild/run/instance-0/output-1/host/arm-buildroot-linux-musleabihf/sysroot/usr/include  -c libbridge_misc.c
libbridge_init.c: In function 'isbridge':
libbridge_init.c:49:12: error: 'PATH_MAX' undeclared (first use in this function); did you mean 'AF_MAX'?
   49 |  char path[PATH_MAX];
      |            ^~~~~~~~
      |            AF_MAX
libbridge_init.c:49:12: note: each undeclared identifier is reported only once for each function it appears in
libbridge_init.c:49:7: warning: unused variable 'path' [-Wunused-variable]
   49 |  char path[PATH_MAX];
      |       ^~~~
make[2]: *** [Makefile:37: libbridge_init.o] Error 1
make[2]: *** Waiting for unfinished jobs....
libbridge_devif.c: In function 'fpopen':
libbridge_devif.c:33:12: error: 'PATH_MAX' undeclared (first use in this function); did you mean 'AF_MAX'?
   33 |  char path[PATH_MAX];
      |            ^~~~~~~~
      |            AF_MAX

Signed-off-by: Matthew Weber <matthew.weber@rockwellcollins.com>
---
 libbridge/libbridge_devif.c | 1 +
 libbridge/libbridge_init.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libbridge/libbridge_devif.c b/libbridge/libbridge_devif.c
index 8b7d954..95f7769 100644
--- a/libbridge/libbridge_devif.c
+++ b/libbridge/libbridge_devif.c
@@ -24,6 +24,7 @@
 #include <string.h>
 #include <dirent.h>
 #include <fcntl.h>
+#include <linux/limits.h>
 
 #include "libbridge.h"
 #include "libbridge_private.h"
diff --git a/libbridge/libbridge_init.c b/libbridge/libbridge_init.c
index c914971..645dda6 100644
--- a/libbridge/libbridge_init.c
+++ b/libbridge/libbridge_init.c
@@ -24,6 +24,7 @@
 #include <dirent.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <linux/limits.h>
 
 #include "libbridge.h"
 #include "libbridge_private.h"
-- 
2.17.1

