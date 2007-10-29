DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
	bh=OpMB7stwW8NeOUc1rLmz6y32t9PFgynD+3+xwJnwEng=;
	b=iQliF3D0BlS0MDOHituC2kKqsPHLrrwyO9QEAspWtlmmZgRT+3NNFiSmYl7b/WNfWwny1K6Sm6LV8s4fidpYXqK45D7k3F4eo6h1S1KHQ5pXOVP4QzxuolpGDfP9MNomBGhv9M2Z19MO5qKVTkSkUTw1Fuvlufo0RlWcqmUkuMo=
From: Alon Bar-Lev <alon.barlev@gmail.com>
Date: Mon, 29 Oct 2007 14:08:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710291408.41267.alon.barlev@gmail.com>
Subject: [Bridge] [PATCH] Allow bridge-utils to run when no TCP/IP is
	available
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>, bridge@lists.linux-foundation.org


This simple patch create AF_LOCAL socket instead of AF_INET so if TCP/IP
is not linked into kernel it still works.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp bridge-utils-1.2.org/libbridge/libbridge_init.c bridge-utils-1.2/libbridge/libbridge_init.c
--- bridge-utils-1.2.org/libbridge/libbridge_init.c	2006-09-09 08:30:31.000000000 +0300
+++ bridge-utils-1.2/libbridge/libbridge_init.c	2007-10-30 05:11:10.000000000 +0200
@@ -32,7 +32,7 @@ int br_socket_fd = -1;
 
 int br_init(void)
 {
-	if ((br_socket_fd = socket(AF_INET, SOCK_STREAM, 0)) < 0)
+	if ((br_socket_fd = socket(AF_LOCAL, SOCK_STREAM, 0)) < 0)
 		return errno;
 	return 0;
 }
