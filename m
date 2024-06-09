Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C601A29A
	for <bridge@lists.linux.dev>; Sun,  9 Jun 2024 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921682; cv=none; b=AxzViJbSuwESt5U1NdjhUa0qjh69FqS1LEi6K0As6JiVal8tSnlR7BMg9rlD8A3tX33WN/2KR8sadvEHRwJKur8iSlqgQY34uGqp2jufzS82+wgl5MCxKIbsMC1RnAnzlKmZniYXlZBz8zwc53sB/Cuup0LXT9op1omVIBAzv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921682; c=relaxed/simple;
	bh=irC8fbFwp7wQh8iZf7JFEGok5dZ8XencbVCgVtWTxS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIooBB/SqTOfP7FOp6JSzFMMxQFbVO+/UccV5LAXfCVVvZjmT6wXYcXWN4txplSqp9rSdfkm11GQfSMPY+YNErF/q99Rt9KR0eQDzBZVZacKfp5yibe4IYJe2AWhJnyEACBd1Vq4WjUfYMHsGrx5PzmD3lCIpFpe1aDFhMcd8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=fCRsvyXY; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="fCRsvyXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UkPBDoz0/T0BpEX6aT7kB9YfBRlH8trgIJDVH+Mo814=;
  b=fCRsvyXYKWWrMrtyUOKC2r+mAOP1Mrr62JK1is8IDKXo5ovDWJdvl/nf
   QIq+Nr4EWSjWRKc49yr+WQgBkgPta5K6/mM3TjllkKlJQdhFO1J/AuBI3
   ZnLRlK7FLXCBkj/50gAAQpfu+Wdgx+7vb55zQNIgbIgPEjqQCWVlfDTkp
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,225,1712613600"; 
   d="scan'208";a="169696902"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 10:27:49 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Roopa Prabhu <roopa@nvidia.com>
Cc: kernel-janitors@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 07/14] net: bridge: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun,  9 Jun 2024 10:27:19 +0200
Message-Id: <20240609082726.32742-8-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240609082726.32742-1-Julia.Lawall@inria.fr>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SLOB was removed, it is not necessary to use call_rcu
when the callback only performs kmem_cache_free. Use
kfree_rcu() directly.

The changes were done using the following Coccinelle semantic patch.
This semantic patch is designed to ignore cases where the callback
function is used in another way.

// <smpl>
@r@
expression e;
local idexpression e2;
identifier cb,f;
position p;
@@

(
call_rcu(...,e2)
|
call_rcu(&e->f,cb@p)
)

@r1@
type T;
identifier x,r.cb;
@@

 cb(...) {
(
   kmem_cache_free(...);
|
   T x = ...;
   kmem_cache_free(...,x);
|
   T x;
   x = ...;
   kmem_cache_free(...,x);
)
 }

@s depends on r1@
position p != r.p;
identifier r.cb;
@@

 cb@p

@script:ocaml@
cb << r.cb;
p << s.p;
@@

Printf.eprintf "Other use of %s at %s:%d\n"
   cb (List.hd p).file (List.hd p).line

@depends on r1 && !s@
expression e;
identifier r.cb,f;
position r.p;
@@

- call_rcu(&e->f,cb@p)
+ kfree_rcu(e,f)

@r1a depends on !s@
type T;
identifier x,r.cb;
@@

- cb(...) {
(
-  kmem_cache_free(...);
|
-  T x = ...;
-  kmem_cache_free(...,x);
|
-  T x;
-  x = ...;
-  kmem_cache_free(...,x);
)
- }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

---
 net/bridge/br_fdb.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index c77591e63841..6d04b48f7e2c 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -73,13 +73,6 @@ static inline int has_expired(const struct net_bridge *br,
 	       time_before_eq(fdb->updated + hold_time(br), jiffies);
 }
 
-static void fdb_rcu_free(struct rcu_head *head)
-{
-	struct net_bridge_fdb_entry *ent
-		= container_of(head, struct net_bridge_fdb_entry, rcu);
-	kmem_cache_free(br_fdb_cache, ent);
-}
-
 static int fdb_to_nud(const struct net_bridge *br,
 		      const struct net_bridge_fdb_entry *fdb)
 {
@@ -329,7 +322,7 @@ static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
 	if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &f->flags))
 		atomic_dec(&br->fdb_n_learned);
 	fdb_notify(br, f, RTM_DELNEIGH, swdev_notify);
-	call_rcu(&f->rcu, fdb_rcu_free);
+	kfree_rcu(f, rcu);
 }
 
 /* Delete a local entry if no other port had the same address.

