Return-Path: <mazo@telum.ru>
From: Andrey Mazo <mazo@telum.ru>
Date: Tue, 13 Aug 2013 20:45:42 +0400
Message-Id: <1376412342-18131-1-git-send-email-mazo@telum.ru>
Subject: [Bridge] [bridge-utils] [PATCH] Removed unused variable in
	doc/Makefile.in
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


Signed-off-by: Andrey Mazo <mazo@telum.ru>

diff --git a/doc/Makefile.in b/doc/Makefile.in
index 23bfb06..df5a1a7 100644
--- a/doc/Makefile.in
+++ b/doc/Makefile.in
@@ -10,8 +10,6 @@ bindir=@bindir@
 sbindir=@sbindir@
 mandir=@mandir@
 
-SUBDIRS=libbridge brctl
-
 all:
 
 clean:
-- 
1.8.1.5

