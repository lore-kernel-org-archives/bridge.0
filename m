Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 28 Dec 2006 12:16:17 +0200
Message-ID: <50F73B338A7FD943B7937BBCF99BFBDE01BF08F8@mail.sofaware.com>
From: "Uri Simchoni" <UriS@sofaware.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] bridge-utils compilation bug
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

I tried to cross-compile bridge-utils, and think I have found a bug in
Makefile.in:

--- /cygdrive/d/sources/bridge-utils-1.1/libbridge/Makefile.in
2004-06-02 20:38:20.000000000 +0300
+++ libbridge/Makefile.in       2006-12-28 11:56:56.576468700 +0200
@@ -5,7 +5,8 @@
 RANLIB=@RANLIB@
 
 CC=@CC@
-CFLAGS = -Wall -g $(KERNEL_HEADERS)
+CFLAGS = -Wall @CFLAGS@
+INCLUDE=$(KERNEL_HEADERS)
 
 prefix=@prefix@
 exec_prefix=@exec_prefix@



Thanks,
Uri.

