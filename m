Return-Path: <elena.reshetova@intel.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1489749344; x=1521285344;
	h=from:to:cc:subject:date:message-id:in-reply-to: references;
	bh=zLXmlaLhQaR3ICv5ByxjamqhU2a7B4hUJIpD9EgGLTI=;
	b=GHJOzZOX3clUbTbRwFDoXNR5nBOrxflGSGO4Y7ibWx6uaezg9RDxP7Nb
	IGvPsHqOGegQuqspa0cp182m/7YAfw==;
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Fri, 17 Mar 2017 13:12:55 +0200
Message-Id: <1489749179-12063-15-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1489749179-12063-1-git-send-email-elena.reshetova@intel.com>
References: <1489749179-12063-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 14/18] net,
	lapb: convert lapb_cb.refcnt from atomic_t to refcount_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: peterz@infradead.org, jchapman@katalix.com, Elena Reshetova <elena.reshetova@intel.com>, johan.hedberg@gmail.com, linux-x25@vger.kernel.org, bridge@lists.linux-foundation.org, jmorris@namei.org, 3chas3@gmail.com, Hans Liljestrand <ishkamiel@gmail.com>, keescook@chromium.org, marcel@holtmann.org, jhs@mojatatu.com, kuznet@ms2.inr.ac.ru, linux-hams@vger.kernel.org, David Windsor <dwindsor@gmail.com>, yoshfuji@linux-ipv6.org, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, ralf@linux-mips.org, kaber@trash.net, linux-bluetooth@vger.kernel.org, davem@davemloft.net

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 include/net/lapb.h    | 3 ++-
 net/lapb/lapb_iface.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/lapb.h b/include/net/lapb.h
index 9510f87..85e7737 100644
--- a/include/net/lapb.h
+++ b/include/net/lapb.h
@@ -1,6 +1,7 @@
 #ifndef _LAPB_H
 #define _LAPB_H 
 #include <linux/lapb.h>
+#include <linux/refcount.h>
 
 #define	LAPB_HEADER_LEN	20		/* LAPB over Ethernet + a bit more */
 
@@ -101,7 +102,7 @@ struct lapb_cb {
 	struct lapb_frame	frmr_data;
 	unsigned char		frmr_type;
 
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 };
 
 /* lapb_iface.c */
diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
index b50b64a..e15314e 100644
--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -54,12 +54,12 @@ static void lapb_free_cb(struct lapb_cb *lapb)
 
 static __inline__ void lapb_hold(struct lapb_cb *lapb)
 {
-	atomic_inc(&lapb->refcnt);
+	refcount_inc(&lapb->refcnt);
 }
 
 static __inline__ void lapb_put(struct lapb_cb *lapb)
 {
-	if (atomic_dec_and_test(&lapb->refcnt))
+	if (refcount_dec_and_test(&lapb->refcnt))
 		lapb_free_cb(lapb);
 }
 
@@ -136,7 +136,7 @@ static struct lapb_cb *lapb_create_cb(void)
 	lapb->mode    = LAPB_DEFAULT_MODE;
 	lapb->window  = LAPB_DEFAULT_WINDOW;
 	lapb->state   = LAPB_STATE_0;
-	atomic_set(&lapb->refcnt, 1);
+	refcount_set(&lapb->refcnt, 1);
 out:
 	return lapb;
 }
-- 
2.7.4

