Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 1 Jan 2007 09:30:36 +0200
Message-ID: <50F73B338A7FD943B7937BBCF99BFBDE01C3E1B3@mail.sofaware.com>
From: "Uri Simchoni" <UriS@sofaware.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] libbridge<->sysfs interface - some bugs
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi,
 
I think I detected some bugs in libbridge 1.2. Probably none detected
them so far because of the fallback to ioctl() whenever anything fails.
On my system (user 32 bits, kernel 64 bits) the fallback doesn't work.

It would be nice BTW to have a compile time option that leaves the ioctl
fallback out...

Here's what I've found (first patch is a compilation patch I posted last
week):

diff -ru --strip-trailing-cr bridge-utils-1.2/libbridge/Makefile.in
/Arrow75/CN3XXX-SDK/linux/embedded_rootfs/build/bridge-utils-1.2/libbrid
ge/Makefile.in
--- bridge-utils-1.2/libbridge/Makefile.in	2006-09-09
09:30:32.000000000 +0300
+++
/Arrow75/CN3XXX-SDK/linux/embedded_rootfs/build/bridge-utils-1.2/libbrid
ge/Makefile.in	2006-12-31 10:21:01.584005800 +0200
@@ -5,7 +5,8 @@
 RANLIB=@RANLIB@
 
 CC=@CC@
-CFLAGS = -Wall -g $(KERNEL_HEADERS)
+CFLAGS = -Wall @CFLAGS@
+INCLUDE=$(KERNEL_HEADERS)
 
 prefix=@prefix@
 exec_prefix=@exec_prefix@
diff -ru --strip-trailing-cr
bridge-utils-1.2/libbridge/libbridge_devif.c
/Arrow75/CN3XXX-SDK/linux/embedded_rootfs/build/bridge-utils-1.2/libbrid
ge/libbridge_devif.c
--- bridge-utils-1.2/libbridge/libbridge_devif.c	2006-09-09
09:30:32.000000000 +0300
+++
/Arrow75/CN3XXX-SDK/linux/embedded_rootfs/build/bridge-utils-1.2/libbrid
ge/libbridge_devif.c	2007-01-01 08:22:29.063200300 +0200
@@ -56,7 +56,7 @@
 	if (!f) 
 		fprintf(stderr, "%s: %s\n", dev, strerror(errno));
 	else {
-		fscanf(f, "%d", &value);
+		fscanf(f, "%i", &value);
 		fclose(f);
 	}
 	return value;
@@ -282,7 +282,7 @@
 	char path[SYSFS_PATH_MAX];
 	FILE *f;
 
-	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/%s", bridge,
name);
+	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/bridge/%s",
bridge, name);
 
 	f = fopen(path, "w");
 	if (f) {
diff -ru --strip-trailing-cr bridge-utils-1.2/libbridge/libbridge_init.c
/Arrow75/CN3XXX-SDK/linux/embedded_rootfs/build/bridge-utils-1.2/libbrid
ge/libbridge_init.c
--- bridge-utils-1.2/libbridge/libbridge_init.c	2006-09-09
09:30:32.000000000 +0300
+++
/Arrow75/CN3XXX-SDK/linux/embedded_rootfs/build/bridge-utils-1.2/libbrid
ge/libbridge_init.c	2007-01-01 07:35:25.610075300 +0200
@@ -186,7 +186,7 @@
 	struct dirent **namelist;
 	char path[SYSFS_PATH_MAX];
 
-	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/brport",
brname);
+	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/brif",
brname);
 	count = scandir(path, &namelist, 0, alphasort);
 	if (count < 0)
 		return old_foreach_port(brname, iterator, arg);
