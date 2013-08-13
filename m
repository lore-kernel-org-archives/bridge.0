Return-Path: <mazo@telum.ru>
From: Andrey Mazo <mazo@telum.ru>
Date: Tue, 13 Aug 2013 20:44:57 +0400
Message-Id: <1376412297-18098-1-git-send-email-mazo@telum.ru>
Subject: [Bridge] [bridge-utils] [PATCH] Abort compilation on error in any
	subdirectory.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Currently bridge-utils makefile ignores compilation errors in
subdirectories, stepping into consecutive subdirs and finally
returning exit status of the last subdirectory's make.
The last subdirectory is now "doc", which has nothing to do for target "all",
so global `make all` always succeeds, effectively ignoring any build
errors in "libbridge" and "brctl" subdirectories.
This behaviour is odd as it breaks anyone relying on make's exit status.

Fix this by simply aborting make on the first error.
Don't inspect MAKEFLAGS for -k for simplicity.

Signed-off-by: Andrey Mazo <mazo@telum.ru>

diff --git a/Makefile.in b/Makefile.in
index 2f2fcba..5aed223 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -14,7 +14,7 @@ distdir = $(PACKAGE)-$(VERSION)
 SUBDIRS=libbridge brctl doc
 
 all:
-	for x in $(SUBDIRS); do $(MAKE) $(MFLAGS) -C $$x ; done
+	for x in $(SUBDIRS); do $(MAKE) $(MFLAGS) -C $$x || exit 1 ; done
 
 clean:
 	for x in $(SUBDIRS); do $(MAKE) $(MFLAGS) -C $$x clean ; done
@@ -28,5 +28,5 @@ maintainer-clean: distclean
 	rm -f brctl/Makefile libbridge/Makefile doc/Makefile
 
 install:
-	for x in $(SUBDIRS); do $(MAKE) $(MFLAGS) -C $$x install; done
+	for x in $(SUBDIRS); do $(MAKE) $(MFLAGS) -C $$x install || exit 1 ; done
 
-- 
1.8.1.5

