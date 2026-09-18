Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C8D3D79FB
	for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745398; cv=none; b=RWUaRwmH/wJlbWcdgDTS+KdOepQDbOMfzvOeVF49iqHq1CmGQjIIWMtgCS1dSl/BDMzkuJkq1WNllPO5z69HLfp5h5jm6nmD7kPnNHMaYvfRgCEA56LxThhCBY5axCUUbsrZNlylgOLGMFWO8qkmzc2JqmCr86lFG0j/O/Tf+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745398; c=relaxed/simple;
	bh=XYsfo8o5Asadzmw159ufKmUqiSadcrJylPnfHJNeQts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKWFH8MhUTbpYmvmboWObovP7hf8d3HaL/4KX22R8/wluGLqPfXhCkS19hs6ziR4bcUt7Uf74/xJI6Ec42yQHlFzZvZkFya2gHfUZ3ETw/l+/zv/os9O38rtGsdrqvZfN/bFTpyBvNL4EU2Df4jkOwLKtlCnZXF3gKF7Hq1MDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=d5/xpugA; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="d5/xpugA"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so5873375e9.2
        for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789745395; x=1790350195; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9rB3tIRMtglcqN6pGjAHeHm2M9HV8sIVhRduA6yeaWI=;
        b=d5/xpugA0UbuLOB9uf2R5m+CyL+h8xpaDUmYaWwWv6JPl18ApohclamXXFNFKxsGt2
         b68sy7OsXBL9m65MpDMqpKJirYp2teMrnVYmIqXWOPx52HpaHjfVISDXh4wwl9o/DMvu
         aGRMl2vcrtdQbU1OIRomPSs8WfyOHxgoxfjgVFPmu3TbWk+k/vIlyPiDbk8thsV7zOEW
         hgPUzeUn+z51hT875jbZbBUufg4BA3a7NqWr7gYtFdUbrxab5zhpdEGrJ9uieSG5PQH1
         ZpIPVzup6QYp+t21c8cB7+CEW6tTr5TvVTLve0XeslGTSD14lgNQ9aLDQEayTNyO2ejX
         /zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745395; x=1790350195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9rB3tIRMtglcqN6pGjAHeHm2M9HV8sIVhRduA6yeaWI=;
        b=sgolJuvZvJcSdHeFhegx0CZ0zkdcytCfQcNAVIaliUyp4ebpcx9hxkLN0PTkNPHfah
         zEJf6tuA4ZGPaINSC+KRK0N0EbblItZidHi6gMZeDB2npmn9gFm3XM33u5PamM0OEvUg
         GRogI583AjbAhB1aVwRNew4iS79fxD9Sd502G2OilRHlGCqDGgvymCFHMXDTy5f8yHTM
         qDHb35O2EOxcU7yh6fjDUJZ9rJyV/oEKS1TZy4JqxOPHIOhuPiJ0emxkKxk43MNc4mK0
         i8PLOvZyDjOjiOghsQ1KmjqjLE0FmlEOwF74TTTdvUn3uW5PiFiqxc7C6hID3Na3lX9e
         iFsw==
X-Forwarded-Encrypted: i=1; AKwUvBxb/YbhIPbdTK1Y9LWkdnYSN43lP2jDT0H7gpp9ZURB+ELLpWkJhy4SGyITC63rWedUp9q/vN0=@lists.linux.dev
X-Gm-Message-State: AFuF++l2HPpd4roOMghJPYWqQJgQwZM5pyyx40SDUhmoJqf1H+ezL+R4
	IeN4iNtijMnv+BYcrIf3czfU2ZYTQ1DAD9YmTyIf5x/dmjTcKQEX7Ri/ba/2Tozsy6I=
X-Gm-Gg: AYBFou1kBJotmOZEQ9ZOdx+w/CtWpD/BiqsZPo2mRr1GmUpF4Mj4TeY7UDimDRzwiB7
	GQUn6ROk0ReETopQCZdk3TOGSXAA5EvZF9MR3kYvE8Kxcb/Z8OeJNkG5FLlMWbaAHaIT/dR3wfR
	asmwAy6MTIHZLGW1+QtzZ9Gk5T7Rpb4yrDYnmXBT2cvTqxNiObzclFuYfRkyUOuEPa8OPsnpr6r
	SzYotLojpGrM7bE9Zo0cJTlFicgHQMxdYXntRa3VjHlOwu2RsK0WiCIYftGmYFg41tQg97Ap73y
	5YEPJXMYZWXZMqbVV5BKzq/99s9V/VR+7MAeOaj6Ia1WOoqazbU3msIXiyWluZcI1hgu2k/4I+G
	ORlHj2UQOI0Z1LXLlOqV9bInjTHgdE3Ej87oAMney0H8B+EisGcN8hhu9qqEDJ6TZLMkT4ABmSO
	AgBLzav9lcIsaxvNrHss+LKTlxjaMeY6ChErurXRonurZVzs9jqConArbCltz9g6F97KGkelyHw
	yEyEKDBKbD4e6nLen4EtQ==
X-Received: by 2002:a05:600c:5489:b0:49c:dca4:94c with SMTP id 5b1f17b1804b1-49fc573579amr81100765e9.13.1789745394563;
        Fri, 18 Sep 2026 08:29:54 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fcd0822fbsm1041815e9.3.2026.09.18.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:29:54 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 1/9] net: bridge: factor out common flood completion handling
Date: Fri, 18 Sep 2026 18:29:42 +0300
Message-ID: <20260918152950.1938259-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918152950.1938259-1-razor@blackwall.org>
References: <20260918152950.1938259-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out the common flood completion handling shared by br_flood and
br_multicast_flood into a new helper - br_flood_finish. No functional
changes intended.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_forward.c | 65 ++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 46c762ca5177..31d54125b441 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -197,12 +197,33 @@ static struct net_bridge_port *maybe_deliver(
 	return p;
 }
 
+static void br_flood_finish(struct net_bridge_port *prev, struct sk_buff *skb,
+			    bool local_rcv, bool local_orig)
+{
+	enum skb_drop_reason reason = SKB_DROP_REASON_NO_TX_TARGET;
+
+	if (IS_ERR_OR_NULL(prev)) {
+		if (IS_ERR(prev)) {
+			reason = PTR_ERR(prev) == -ENOMEM ? SKB_DROP_REASON_NOMEM :
+				 SKB_DROP_REASON_NOT_SPECIFIED;
+		}
+
+		if (!local_rcv)
+			kfree_skb_reason(skb, reason);
+		return;
+	}
+
+	if (local_rcv)
+		deliver_clone(prev, skb, local_orig);
+	else
+		__br_forward(prev, skb, local_orig);
+}
+
 /* called under rcu_read_lock */
 void br_flood(struct net_bridge *br, struct sk_buff *skb,
 	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig,
 	      u16 vid)
 {
-	enum skb_drop_reason reason = SKB_DROP_REASON_NO_TX_TARGET;
 	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port *p;
 
@@ -243,25 +264,11 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 		}
 
 		prev = maybe_deliver(prev, p, skb, local_orig);
-		if (IS_ERR(prev)) {
-			reason = PTR_ERR(prev) == -ENOMEM ? SKB_DROP_REASON_NOMEM :
-				 SKB_DROP_REASON_NOT_SPECIFIED;
-			goto out;
-		}
+		if (IS_ERR(prev))
+			break;
 	}
 
-	if (!prev)
-		goto out;
-
-	if (local_rcv)
-		deliver_clone(prev, skb, local_orig);
-	else
-		__br_forward(prev, skb, local_orig);
-	return;
-
-out:
-	if (!local_rcv)
-		kfree_skb_reason(skb, reason);
+	br_flood_finish(prev, skb, local_rcv, local_orig);
 }
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
@@ -301,7 +308,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 			struct net_bridge_mcast *brmctx,
 			bool local_rcv, bool local_orig)
 {
-	enum skb_drop_reason reason = SKB_DROP_REASON_NO_TX_TARGET;
 	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port_group *p;
 	bool allow_mode_include = true;
@@ -343,11 +349,9 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 		}
 
 		prev = maybe_deliver(prev, port, skb, local_orig);
-		if (IS_ERR(prev)) {
-			reason = PTR_ERR(prev) == -ENOMEM ? SKB_DROP_REASON_NOMEM :
-				 SKB_DROP_REASON_NOT_SPECIFIED;
-			goto out;
-		}
+		if (IS_ERR(prev))
+			break;
+
 delivered:
 		if ((unsigned long)lport >= (unsigned long)port)
 			p = rcu_dereference(p->next);
@@ -355,17 +359,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 			rp = rcu_dereference(hlist_next_rcu(rp));
 	}
 
-	if (!prev)
-		goto out;
-
-	if (local_rcv)
-		deliver_clone(prev, skb, local_orig);
-	else
-		__br_forward(prev, skb, local_orig);
-	return;
-
-out:
-	if (!local_rcv)
-		kfree_skb_reason(skb, reason);
+	br_flood_finish(prev, skb, local_rcv, local_orig);
 }
 #endif
-- 
2.47.3

