From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Date: Fri, 16 Mar 2007 02:19:39 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_76f+F8UT5CZoBz+"
Message-Id: <200703160219.39993.s0348365@sms.ed.ac.uk>
Subject: [Bridge] bridge-utils doesn't like name "bridge"
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org
Cc: shemminger@osdl.org

--Boundary-00=_76f+F8UT5CZoBz+
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

The "brctl show" (and probably other commands) do not work properly in the 
current git version of bridge-utils, and at least the 1.2 release in Debian 
testing.

The reason is that some sloppy code detects bridges under sysfs by simply 
matching dirents matching "%s/bridge" under /sys/class/net. Unfortunately, if 
a bridge is actually _called_ "bridge", this logic fails because the "." 
directory matches.

Since the expected files do not exist under /sys/class/net/./bridge, but 
under /sys/class/net/bridge/bridge, it causes a segfault.

The attached patch fixes the problem by excluding any dirent with '.' at the 
beginning, which risks breaking nothing but does filter out ".", etc. as 
possible matches for bridge interfaces.

Please apply.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

--Boundary-00=_76f+F8UT5CZoBz+
Content-Type: text/x-diff; charset="us-ascii";
	name="bridge-utils-1.2-bridge-name-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bridge-utils-1.2-bridge-name-fix.diff"

diff -Nudr bridge-utils-1.2/libbridge/libbridge_init.c bridge-utils-1.2.new/libbridge/libbridge_init.c
--- bridge-utils-1.2/libbridge/libbridge_init.c 2006-09-09 06:30:31.000000000 +0100
+++ bridge-utils-1.2.new/libbridge/libbridge_init.c     2007-03-16 01:45:26.080465228 +0000
@@ -49,6 +49,10 @@
 	char path[SYSFS_PATH_MAX];
 	struct stat st;

+	/* the bridge might actually be called "bridge", so don't match '.' */
+	if (entry->d_name[0] == '.')
+		return 0;
+
 	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/bridge", entry->d_name);
 	return stat(path, &st) == 0 && S_ISDIR(st.st_mode);
 }

--Boundary-00=_76f+F8UT5CZoBz+--
