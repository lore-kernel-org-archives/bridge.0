From: "Fischer, Anna" <anna.fischer@hp.com>
Date: Mon, 15 Jun 2009 17:33:35 +0000
Message-ID: <0199E0D51A61344794750DC57738F58E67D2DCECBC@GVW1118EXC.americas.hpqcorp.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH] bridge-utils: fix sysfs path for setting bridge
 configuration parameters
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "evb@yahoogroups.com" <evb@yahoogroups.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "davem@davemloft.net" <davem@davemloft.net>, "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, "adobriyan@gmail.com" <adobriyan@gmail.com>

Under newer kernels the bridge configuration parameters=20
are located under /sys/class/net/$bridgename/bridge/$param,
while the current bridge-utils code is trying to access
them under /sys/class/net/$bridgename/$param. This patch
fixes this issue in the bridge-utils code and so allows=20
setting of bridge configuration parameters using sysfs=20
under newer kernel versions.

Signed-off-by: Anna Fischer <anna.fischer@hp.com>

---

 libbridge/libbridge_devif.c   |   25 +++++++++++++++++++++----
 libbridge/libbridge_private.h |    1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/libbridge/libbridge_devif.c b/libbridge/libbridge_devif.c
index 34e3cc8..547bb86 100644
--- a/libbridge/libbridge_devif.c
+++ b/libbridge/libbridge_devif.c
@@ -73,6 +73,26 @@ static void fetch_tv(const char *dev, const char *name,
 	__jiffies_to_tv(tv, fetch_int(dev, name));
 }
=20
+/* Open sysfs path for writing bridge properties. */
+static FILE *br_sysfs_open(const char *bridge, const char *name)
+{
+	char path[SYSFS_PATH_MAX];
+
+	/* Try accessing /sys/class/net/$bridge/bridge/$name. */
+	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s"
+		 SYSFS_BRIDGE_DIR "/%s", bridge, name);
+	if (!access(path, F_OK))
+		return fopen(path, "w+");
+
+	/* Try using old-style of accessing bridge sysfs properties. */
+	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/%s",
+		 bridge, name);
+	if (!access(path, F_OK))
+		return fopen(path, "w+");
+
+	return NULL;
+}
+
 /*
  * Convert device name to an index in the list of ports in bridge.
  *
@@ -283,12 +303,9 @@ static int br_set(const char *bridge, const char *name=
,
 		  unsigned long value, unsigned long oldcode)
 {
 	int ret;
-	char path[SYSFS_PATH_MAX];
 	FILE *f;
=20
-	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/%s", bridge, name);
-
-	f =3D fopen(path, "w");
+	f =3D br_sysfs_open(bridge, name);
 	if (f) {
 		ret =3D fprintf(f, "%ld\n", value);
 		fclose(f);
diff --git a/libbridge/libbridge_private.h b/libbridge/libbridge_private.h
index 99a511d..1e1a0c6 100644
--- a/libbridge/libbridge_private.h
+++ b/libbridge/libbridge_private.h
@@ -31,6 +31,7 @@
=20
 #define SYSFS_CLASS_NET "/sys/class/net/"
 #define SYSFS_PATH_MAX	256
+#define SYSFS_BRIDGE_DIR "/bridge"
=20
 #define dprintf(fmt,arg...)
