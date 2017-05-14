Return-Path: <david.michael@coreos.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coreos.com; s=google;
	h=from:to:subject:date:message-id:mime-version;
	bh=RHKB7hHgi9fmqevAPGeqWBbzPvVxTUjPthrT9BUmSQs=;
	b=a0zSL27WRyJcR92ioSog3uUhR7sT80u9RuIoZjVzFI6yr7s75yinhvYn7NSRSdn3zu
	7HRTKlZfhIstQ3ULXRRh07iErqIfFf3QgcsXP6P4MyRSsVtt+YrXT32qYwA+phFnGvl9
	k2NZY52qINTIsfeK+25YA9IItQ2jcw1ufbdZQ=
From: David Michael <david.michael@coreos.com>
Date: Sat, 13 May 2017 19:23:34 -0700
Message-ID: <87pofci3bt.fsf@coreos.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH] libbridge: Include the configured CFLAGS when
	compiling
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

---

Hi,

When compiling bridge-utils, the CFLAGS set during "configure" are only
used in the brctl directory.  Can they be included in libbridge, too?

Thanks.

David

 libbridge/Makefile.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libbridge/Makefile.in b/libbridge/Makefile.in
index 20512c4..4e1cddc 100644
--- a/libbridge/Makefile.in
+++ b/libbridge/Makefile.in
@@ -5,7 +5,7 @@ AR=ar
 RANLIB=@RANLIB@
 
 CC=@CC@
-CFLAGS = -Wall -g $(KERNEL_HEADERS)
+CFLAGS = -Wall -g $(KERNEL_HEADERS) @CFLAGS@
 
 prefix=@prefix@
 exec_prefix=@exec_prefix@
-- 
2.7.4

