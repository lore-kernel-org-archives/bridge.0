Return-Path: <mazo@telum.ru>
From: Andrey Mazo <mazo@telum.ru>
Date: Fri, 21 Feb 2014 16:58:40 +0400
Message-Id: <1392987521-2289-4-git-send-email-mazo@telum.ru>
In-Reply-To: <1392987521-2289-1-git-send-email-mazo@telum.ru>
References: <1392987521-2289-1-git-send-email-mazo@telum.ru>
Subject: [Bridge] [PATCH 3/4] bridge-utils: AC_OUTPUT should be used without
	arguments
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This patch is a result of autoupdate-2.69 run and fixes the following
warning:
configure.ac:27: warning: AC_OUTPUT should be used without arguments.
configure.ac:27: You should run autoupdate.

Signed-off-by: Andrey Mazo <mazo@telum.ru>
---
 configure.ac | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5e3f89b..096f017 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,5 +1,5 @@
 dnl Process this file with autoconf to produce a configure script.
-AC_INIT(bridge-utils, 1.5)
+AC_INIT([bridge-utils],[1.5])
 AC_CONFIG_HEADERS(libbridge/config.h)
 
 AC_ARG_WITH( linux-headers, [  --with-linux-headers     Location of the linux headers to use], 
@@ -24,4 +24,5 @@ AC_CHECK_FUNCS(if_nametoindex if_indextoname)
 
 AC_SUBST(KERNEL_HEADERS)
 
-AC_OUTPUT(doc/Makefile libbridge/Makefile brctl/Makefile Makefile bridge-utils.spec)
+AC_CONFIG_FILES([doc/Makefile libbridge/Makefile brctl/Makefile Makefile bridge-utils.spec])
+AC_OUTPUT
-- 
1.8.4.5

