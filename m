Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:30 +0300
Message-Id: <1499172811-16271-36-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 35/36] net,
	ax25: convert ax25_route.refcount from atomic_t to refcount_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: peterz@infradead.org, jchapman@katalix.com, bfields@fieldses.org, linux-sctp@vger.kernel.org, jlayton@poochiereds.net, Elena Reshetova <elena.reshetova@intel.com>, steffen.klassert@secunet.com, zyan@redhat.com, herbert@gondor.apana.org.au, linux-x25@vger.kernel.org, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, jmorris@namei.org, 3chas3@gmail.com, kuznet@ms2.inr.ac.ru, jreuter@yaina.de, keescook@chromium.org, santosh.shilimkar@oracle.com, jhs@mojatatu.com, Hans Liljestrand <ishkamiel@gmail.com>, linux-hams@vger.kernel.org, David Windsor <dwindsor@gmail.com>, linux-nfs@vger.kernel.org, sage@redhat.com, nhorman@tuxdriver.com, yoshfuji@linux-ipv6.org, vyasevich@gmail.com, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, ralf@linux-mips.org, kaber@trash.net, davem@davemloft.net

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
 include/net/ax25.h    | 6 +++---
 net/ax25/ax25_route.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/ax25.h b/include/net/ax25.h
index edd82f0..e3467ba 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -185,7 +185,7 @@ typedef struct {
 
 typedef struct ax25_route {
 	struct ax25_route	*next;
-	atomic_t		refcount;
+	refcount_t		refcount;
 	ax25_address		callsign;
 	struct net_device	*dev;
 	ax25_digi		*digipeat;
@@ -194,14 +194,14 @@ typedef struct ax25_route {
 
 static inline void ax25_hold_route(ax25_route *ax25_rt)
 {
-	atomic_inc(&ax25_rt->refcount);
+	refcount_inc(&ax25_rt->refcount);
 }
 
 void __ax25_put_route(ax25_route *ax25_rt);
 
 static inline void ax25_put_route(ax25_route *ax25_rt)
 {
-	if (atomic_dec_and_test(&ax25_rt->refcount))
+	if (refcount_dec_and_test(&ax25_rt->refcount))
 		__ax25_put_route(ax25_rt);
 }
 
diff --git a/net/ax25/ax25_route.c b/net/ax25/ax25_route.c
index e1fda27..0446b89 100644
--- a/net/ax25/ax25_route.c
+++ b/net/ax25/ax25_route.c
@@ -114,7 +114,7 @@ static int __must_check ax25_rt_add(struct ax25_routes_struct *route)
 		return -ENOMEM;
 	}
 
-	atomic_set(&ax25_rt->refcount, 1);
+	refcount_set(&ax25_rt->refcount, 1);
 	ax25_rt->callsign     = route->dest_addr;
 	ax25_rt->dev          = ax25_dev->dev;
 	ax25_rt->digipeat     = NULL;
-- 
2.7.4

