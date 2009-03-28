From: Denys Fedoryschenko <denys@visp.net.lb>
Date: Sat, 28 Mar 2009 15:36:48 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wfizJ7yEgxgr7x+"
Message-Id: <200903281536.48296.denys@visp.net.lb>
Subject: [Bridge] [PATCH] rstp compiling under gcc 4.3.3 fixes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

--Boundary-00=_wfizJ7yEgxgr7x+
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

After fetching current git code and compiling with gcc 4.3.3 got errors
Here is fix, so rstp compile fine with gcc 4.3.3

bridge_track.c and main.c have functions where is return value not checked.
 Because of -Werror it won't compile.
Example:
gcc -Wall -Werror -O2 -g -D_REENTRANT -D__LINUX__ -DVERSION=0.16 -DBUILD=1 -I. -I./include -I./rstplib   -c -o 
main.o main.c
cc1: warnings being treated as errors
main.c: In function 'main':
main.c:81: error: ignoring return value of 'daemon', declared with attribute 
warn_unused_result


Other fix is missing header file
gcc -Wall -O2 -g -D_REENTRANT -D__LINUX__ -DVERSION=0.16 -DBUILD=1 -I. -I./include -I./rstplib   -c -o 
netif_utils.o netif_utils.c
netif_utils.c: In function 'get_bridge_portno':
netif_utils.c:130: error: 'INT_MAX' undeclared (first use in this function)
netif_utils.c:130: error: (Each undeclared identifier is reported only once
netif_utils.c:130: error: for each function it appears in.)

--Boundary-00=_wfizJ7yEgxgr7x+
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rstp-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="rstp-fixes.diff"

diff -Naur rstp/bridge_track.c rstp-new/bridge_track.c
--- rstp/bridge_track.c	2009-03-28 15:27:04.000000000 +0200
+++ rstp-new/bridge_track.c	2009-03-28 15:30:15.000000000 +0200
@@ -386,6 +386,7 @@
 static int stp_enabled(struct ifdata *br)
 {
 	char path[40 + IFNAMSIZ];
+	int ret;
 	sprintf(path, "/sys/class/net/%s/bridge/stp_state", br->name);
 	FILE *f = fopen(path, "r");
 	if (!f) {
@@ -393,7 +394,11 @@
 		return 0;
 	}
 	int enabled = 0;
-	fscanf(f, "%d", &enabled);
+	ret = fscanf(f, "%d", &enabled);
+	if (!ret) {
+		LOG("%s, stp_state parsing error", path);
+		return 0;
+	}
 	fclose(f);
 	INFO("STP on %s state %d", br->name, enabled);
 
diff -Naur rstp/ctl_main.c rstp-new/ctl_main.c
--- rstp/ctl_main.c	2009-03-28 15:27:04.000000000 +0200
+++ rstp-new/ctl_main.c	2009-03-28 15:26:33.000000000 +0200
@@ -16,6 +16,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <limits.h>
 
 #include "ctl_socket_client.h"
 #include "ctl_functions.h"
diff -Naur rstp/main.c rstp-new/main.c
--- rstp/main.c	2009-03-28 15:27:04.000000000 +0200
+++ rstp-new/main.c	2009-03-28 15:32:12.000000000 +0200
@@ -42,7 +42,7 @@
 
 int main(int argc, char *argv[])
 {
-	int c;
+	int c,ret;
 	while ((c = getopt(argc, argv, "dv:")) != -1) {
 		switch (c) {
 		case 'd':
@@ -78,7 +78,11 @@
 			return -1;
 		}
 		openlog("rstpd", 0, LOG_DAEMON);
-		daemon(0, 0);
+		ret = daemon(0, 0);
+		if (ret) {
+			ERROR("daemon() failed");
+			return -1;		    
+		}
 		is_daemon = 1;
 		fprintf(f, "%d", getpid());
 		fclose(f);
diff -Naur rstp/netif_utils.c rstp-new/netif_utils.c
--- rstp/netif_utils.c	2009-03-28 15:27:04.000000000 +0200
+++ rstp-new/netif_utils.c	2009-03-28 15:26:06.000000000 +0200
@@ -32,6 +32,7 @@
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <fcntl.h>
+#include <limits.h>
 
 #include <net/if.h>
 #include <linux/if_ether.h>

--Boundary-00=_wfizJ7yEgxgr7x+--
