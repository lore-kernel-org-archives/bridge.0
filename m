Return-Path: <mazo@telum.ru>
From: Andrey Mazo <mazo@telum.ru>
Date: Fri, 21 Feb 2014 16:58:41 +0400
Message-Id: <1392987521-2289-5-git-send-email-mazo@telum.ru>
In-Reply-To: <1392987521-2289-1-git-send-email-mazo@telum.ru>
References: <1392987521-2289-1-git-send-email-mazo@telum.ru>
Subject: [Bridge] [PATCH 4/4] bridge-utils: Pretty print configure help
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Use special AS_HELP_STRING() macro to correctly format configure --help
output.

Before the change:
"""
Optional Packages:
  --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
  --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
  --with-linux-headers     Location of the linux headers to use
"""

After the change:
"""
Optional Packages:
  --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
  --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
  --with-linux-headers    location of the linux headers to use
"""

Signed-off-by: Andrey Mazo <mazo@telum.ru>
---
 configure.ac | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 096f017..6b24e9e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2,8 +2,11 @@ dnl Process this file with autoconf to produce a configure script.
 AC_INIT([bridge-utils],[1.5])
 AC_CONFIG_HEADERS(libbridge/config.h)
 
-AC_ARG_WITH( linux-headers, [  --with-linux-headers     Location of the linux headers to use], 
-    KERNEL_HEADERS=$withval, KERNEL_HEADERS="/usr/src/linux/include")
+AC_ARG_WITH([linux-headers],
+    [AS_HELP_STRING([--with-linux-headers], [location of the linux headers to use])],
+    [KERNEL_HEADERS=$withval],
+    [KERNEL_HEADERS="/usr/src/linux/include"]
+)
 
 dnl Checks for programs.
 AC_PROG_CC
-- 
1.8.4.5

