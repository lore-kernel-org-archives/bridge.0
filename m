Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795872906;
	b=cWnN3av42jwE/v7llqDEWzNTroKAYS02byp8xyt7qIPxjna5I8qVIxqbbNbGGckDM2Mg
	 vPvkAj5GNIh1smLLZavqTEGdlmKpO2dnbA/ry7QI+1bmPNZdzZijxg/E8w94cfAzwcxvA
	 QMFbHM+KW/bYHrVWBSl/HN/GJe2zZMg6aJp9UA3WKgCAo83PHs2BBNbRo47pl2ap+04hU
	 S/zEGG8eiVmcbD2WknmX3o+J7wcrGufrV3+buL1SeB5FADQyITP5szsqRBMswPjqqCMzF
	 I80P9WCeh3oos2ulDGCyH3tCNRTwGz8p+MMGpVjbDjVPUWjjS9Su8ekLfCP9inAByaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795872906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=onrn3RJVqKNpamhnrDLLJaXa7ducP+r9ZkZuOTHwGqs=;
	b=fP3UDBaNh6zcHgZ3Gp4ECdSnOpDRK7NBToFLPHxp5tyKmKWt0wmYMVehngyZVy/rkDLS
	 iVGBNEmgpto/E0Nj2QFjpxtHNWp5gR1dGc2QtWsXBlq79UB5EOu3e0adSddVqzt3DEx0t
	 EQhJb15HxrMyZDlOJSnLjZx9EbWq8B0lziY/iBNfeCCqOPgBdUVJe0cw6Ury+SmkO7SoT
	 +0bwUePrJ0pCmdz68hpk2Z9TJh8Ghd13doViGmWpB8X7usnk+t5Z6zA/iOm1fBKdzxy2s
	 MRMcN2H+Y+D+iEvQAPaKoijMpYpWWo3BN7cOMkShIGrbP9I4JqpT8wKzKmWe83e8Xyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=iXWwIM9t;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33F4606A324
	for <bridge@lists.linux.dev>; Sat, 28 Nov 2026 13:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D33F4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=iXWwIM9t
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ba38c41804so10692421a12.3
        for <bridge@lists.linux.dev>; Sat, 28 Nov 2026 05:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795872904; x=1796477704; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=onrn3RJVqKNpamhnrDLLJaXa7ducP+r9ZkZuOTHwGqs=;
        b=iXWwIM9tdkkkRiCATrAmApigAuhBVI37Vyx8ommCuSpIcWKK3VfXZzOSf0ZiJbd1PD
         Gwcp5tr/uyXLUBtXpa9I3HYIVdu93qRNjJhadt4tucd0kBzXbVDj35tN+KZ+99/x44m5
         2URFU9t+qnhYTGEfF4klC6+kDxVDVM8TOUnn0wqPtkrOhY6yFC/bVY+4VEsAhORT8TCN
         ar8GQNaX7B+dYe2XpwRLayBkBicfWKoZZzZ0SQh+gx/yWCbC0cQTfcvfbuNID5at0QKu
         hGZ25JA0y1m+MonhQ1qAqVAfe9H3nD1eZAvcTzfGoMdjvvwccfAHZUtB4SM4DDXYAMZ3
         Z2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795872904; x=1796477704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=onrn3RJVqKNpamhnrDLLJaXa7ducP+r9ZkZuOTHwGqs=;
        b=ZpzY+XiHKKfWF3rOxxOzvVBJzfWgpgAa5RhmcfkRHXTm2YcfyEMKZjaV8/JXEkp4EG
         7YJ8HjIP/ZCCMTm0qR8hldchC/qaySeUcqIDKIQ5Z2pH+FZ7zhsQQi900jrrx1q0cypv
         xpUyjSV5OKTqbSi0SmWcQd+8ZeEqY1BZR30R7AIoDvMN3xWqhOSwvlPweQfq4fI5sOMP
         pswmtLXl3ZVEN55BdpjZ7wb6Y75f4hEoKki/CpE/5+2Apm78k0prEp+GyWPhTQrWqGL6
         LgH2Z6djo8Mrotlp6sEhqqUOK4BlWOGTf3ZRUSnRNCeHx+x6y/SFD+qe835Mir3iURxk
         LnWg==
X-Forwarded-Encrypted: i=1; AL+hErHSFI3PRKDLw8yTcyYCxJYD2bnHHzDIHBiO+VaiNkIpSLzXHPDnm3CEPDnmcilXsAQ3fNCoXuI=@lists.linux.dev
X-Gm-Message-State: APuU4Z/XmZHvsXYNSebjFO+tFx5OLkx2/xd8sSW223oYNIS9xG84RnLr
	awB48LERB8YTLs+Kdt4dWp0+kXogQCo8uKwoq3WpQ3zqW2EQdTpU3IpkyLw1g1EjZw==
X-Gm-Gg: AZFdTZdrgxfA7jsi8acmIfEh9ekhjjFB3GB60ij3pUeUL/rgeZylHwpYc0ajg0YrEEz
	sL4WTqltW8uT8GJvjFBtAdDFbaJBapckvA4z0m8MSkPwX/BrZUoZml0SibpuAR2oPS4puHEfajL
	HFzrLkmju9/4ykZOPTK3K0kgLo2mDDlbRvSlTTuY8hdrNup0leE2BR7AY3fibwG04eX9BOWRutp
	josWFVstQwqSPkh1gsU9kLhGxgNVT/eUM6jUdzXuQYUGVYQPczZZEmuCx8svR0y/fMxofaj/TCw
	mmaNCChBTnXTaC5qOBE/Q11LIMoSDpSdPI9H0YJZT5ZDVLwLaw4dYDjY9hRgN1pz5KHbwLAcVbe
	2JxJcCVANrTa3gicFUiCKK3zZXyXRjSPKDstyg34W49JFZmKanSu1S/uO6X/eqQBEf9/S5Ckwer
	SQFwH+wujCC2LTt2Lb+n+/6OQJ/fddGJtKB9oPI69UHkOXkQ8/TNcgJ2MM1HXy2zTeccqBq2HjQ
	GbP8nJ6KxNMi+dasyT+pTYZunXfW7CmXBoAOypBLQ43d9LyD6WJze/AXxhMcZlSXZbnl8+JvjN2
	CGmfYe644tK81c4SQyHjRMc5t40293kAbLtwuF6YBpap08EE+Pl7Ds4cSxa4WfosZeUx3SAEtMV
	XmJiyY3+mQmxtNmzQ8xudy3uoA3bvmlbxPLCkUiY/jlfCA5iRg1WXuhF4NMufuRepprjrQPsFQH
	4D5xhWts173No8Jrvrtt4qLg6HUdPUq1ny36xypOkJz5dbS+MvtM6yMDHl6LOqOnFodRLf/Qm77
	G9ftEcfArMSyPaVEGr6RbVZ2iwk30lmwwhsKoC2K1IK3vE0vdGvnsQUVzJafd79nn+Y/SprqJZr
	UZp6jRr7fbtGfP/VgtPyNvthPdqKSpFqiufnNbdaIDlQzTdL7l/D/g==
X-Received: by 2002:a05:6402:3645:b0:6ba:c85e:c0e0 with SMTP id 4fb4d7f45d1cf-6bac85ec268mr13362424a12.28.1795872904135;
        Sat, 28 Nov 2026 05:35:04 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f247080f000000000000000a27.dip0.t-ipconnect.de. [2003:f2:4708:f00::a27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb1d49d992sm5282111a12.26.2026.11.28.05.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 05:35:02 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Linus Walleij <linusw@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>
Subject: [PATCH net v2 1/3] net: dsa: do not run queued FDB events after the port left the bridge
Date: Sat, 28 Nov 2026 14:35:01 +0100
Message-ID: <20261128133503.3887987-2-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128133503.3887987-1-julius@bairaktaris.de>
References: <20261128133503.3887987-1-julius@bairaktaris.de>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FDB events reach DSA from the atomic switchdev notifier and are handled
from dsa_owq. The work builds the dsa_db from dp->bridge, which
dsa_port_bridge_destroy() clears and frees when the port leaves the
bridge or fails to join it.

When switchdev_bridge_port_offload() fails in the FDB replay of
dsa_port_bridge_join(), because dsa_user_fdb_event() could not allocate
its work item, the entries replayed before the failure are still
queued. The rollback clears dp->bridge, and the queued work dereferences
it:

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  Workqueue: dsa_ordered dsa_user_switchdev_event_work
  RIP: 0010:dsa_port_bridge_host_fdb_add+0x141/0x5c0

A bridge leave has the same problem for an event that the notifier
queues after dsa_port_pre_bridge_leave() flushed the workqueue: nothing
orders the dp->bridge check in dsa_user_fdb_event() against the clear,
and on a switch unbind the work can also run after dsa_user_destroy()
freed the port's net_device. The notifier and the taggers read
dp->bridge->dev and ->num without locks while the bridge is freed.

Clear dp->bridge, wait for those readers with synchronize_net(), flush
the workqueue, and only then free the bridge. The work reads dp->bridge
once and drops the event when the port has left; the FDB helpers take
the bridge from it. The join rollback destroys the bridge before it
tells the switches that the port left, as dsa_port_bridge_leave() does,
so a dropped event programs nothing after that.
dsa_port_bridge_dev_get() and dsa_port_bridge_num_get() read the pointer
once, and dsa_port_bridge_create() publishes it with
smp_store_release(), so a reader that sees it also sees its fields. The
other readers outside RTNL only test the pointer, with READ_ONCE().

The rollback oops was pointed out by the hosted Sashiko review of a DSA
host FDB series [1]. In QEMU with KASAN, dsa_loop given FDB operations
that take 15 ms, 40 static FDB entries to replay and the N-th
allocation of "ip link set lan1 master br0" failing for N = 1 to 150,
net oopses as above in 3 of 3 boots, and with this change in none of 3
boots. With the change, 4 to 5 host addresses per boot stay on the CPU
port after those joins (5, 4 and 5 more additions than deletions).
They were added by replayed events that ran before the allocation
failed: br_switchdev_port_offload() does not undo the part of the
replay that succeeded, and this change does not alter that.

Fixes: c26933639b54 ("net: dsa: request drivers to perform FDB isolation")
Fixes: d3eed0e57d5d ("net: dsa: keep the bridge_dev and bridge_num as part of the same structure")
Link: https://lore.kernel.org/all/179480421335.3136.15795220009190349154@kernel.org/ [1]
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
v2:
- The other readers of dp->bridge outside RTNL, dsa_port_to_bridge_port(),
  dsa_find_designated_bridge_port_by_vid(), dsa_default_offload_fwd_mark()
  and dsa_tag_8021q_find_port_by_vbid(), use READ_ONCE() (hosted Sashiko
  review of v1).
- The comment in dsa_port_bridge_destroy() speaks of a tagger that read
  the bridge; a tagger that reads NULL is patch 3.
v1: https://lore.kernel.org/all/20261121185821.1471559-1-julius@bairaktaris.de/

 include/net/dsa.h   | 10 ++++++---
 net/dsa/port.c      | 50 ++++++++++++++++++++++++++++++---------------
 net/dsa/port.h      | 26 ++++++++++++-----------
 net/dsa/tag.h       |  4 ++--
 net/dsa/tag_8021q.c |  2 +-
 net/dsa/user.c      | 25 ++++++++++++++++-------
 6 files changed, 75 insertions(+), 42 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 5d12191b6f6f..47e2162f1d7d 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -758,7 +758,7 @@ static inline struct net_device *dsa_port_to_conduit(const struct dsa_port *dp)
 static inline
 struct net_device *dsa_port_to_bridge_port(const struct dsa_port *dp)
 {
-	if (!dp->bridge)
+	if (!READ_ONCE(dp->bridge))
 		return NULL;
 
 	if (dp->lag)
@@ -772,12 +772,16 @@ struct net_device *dsa_port_to_bridge_port(const struct dsa_port *dp)
 static inline struct net_device *
 dsa_port_bridge_dev_get(const struct dsa_port *dp)
 {
-	return dp->bridge ? dp->bridge->dev : NULL;
+	const struct dsa_bridge *bridge = READ_ONCE(dp->bridge);
+
+	return bridge ? bridge->dev : NULL;
 }
 
 static inline unsigned int dsa_port_bridge_num_get(struct dsa_port *dp)
 {
-	return dp->bridge ? dp->bridge->num : 0;
+	const struct dsa_bridge *bridge = READ_ONCE(dp->bridge);
+
+	return bridge ? bridge->num : 0;
 }
 
 static inline bool dsa_port_bridge_same(const struct dsa_port *a,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 1f5536c0dffc..e41d3639f0f9 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -427,7 +427,8 @@ static int dsa_port_bridge_create(struct dsa_port *dp,
 	bridge = dsa_tree_bridge_find(ds->dst, br);
 	if (bridge) {
 		refcount_inc(&bridge->refcount);
-		dp->bridge = bridge;
+		/* Read without locks, see below */
+		smp_store_release(&dp->bridge, bridge);
 		return 0;
 	}
 
@@ -447,7 +448,8 @@ static int dsa_port_bridge_create(struct dsa_port *dp,
 		return -EOPNOTSUPP;
 	}
 
-	dp->bridge = bridge;
+	/* Read without locks from the switchdev notifiers and the taggers */
+	smp_store_release(&dp->bridge, bridge);
 
 	return 0;
 }
@@ -457,7 +459,14 @@ static void dsa_port_bridge_destroy(struct dsa_port *dp,
 {
 	struct dsa_bridge *bridge = dp->bridge;
 
-	dp->bridge = NULL;
+	WRITE_ONCE(dp->bridge, NULL);
+
+	/* An FDB event from the atomic switchdev notifier that still sees the
+	 * bridge can queue work for it, and a tagger that read it can still
+	 * use it. Wait for them, then for the work they queued.
+	 */
+	synchronize_net();
+	dsa_flush_workqueue();
 
 	if (!refcount_dec_and_test(&bridge->refcount))
 		return;
@@ -528,7 +537,12 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 					&dsa_user_switchdev_blocking_notifier);
 	dsa_flush_workqueue();
 out_rollback_unbridge:
+	/* Drop the FDB events still queued from the replay before the
+	 * switches are told that the port left
+	 */
+	dsa_port_bridge_destroy(dp, br);
 	dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);
+	return err;
 out_rollback:
 	dsa_port_bridge_destroy(dp, br);
 	return err;
@@ -973,8 +987,8 @@ int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu)
 	return dsa_port_notify(dp, DSA_NOTIFIER_MTU, &info);
 }
 
-int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-		     u16 vid)
+int dsa_port_fdb_add(struct dsa_port *dp, const struct dsa_bridge *bridge,
+		     const unsigned char *addr, u16 vid)
 {
 	struct dsa_notifier_fdb_info info = {
 		.dp = dp,
@@ -982,7 +996,7 @@ int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		.vid = vid,
 		.db = {
 			.type = DSA_DB_BRIDGE,
-			.bridge = *dp->bridge,
+			.bridge = *bridge,
 		},
 	};
 
@@ -996,8 +1010,8 @@ int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 	return dsa_port_notify(dp, DSA_NOTIFIER_FDB_ADD, &info);
 }
 
-int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
-		     u16 vid)
+int dsa_port_fdb_del(struct dsa_port *dp, const struct dsa_bridge *bridge,
+		     const unsigned char *addr, u16 vid)
 {
 	struct dsa_notifier_fdb_info info = {
 		.dp = dp,
@@ -1005,7 +1019,7 @@ int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
 		.vid = vid,
 		.db = {
 			.type = DSA_DB_BRIDGE,
-			.bridge = *dp->bridge,
+			.bridge = *bridge,
 		},
 	};
 
@@ -1041,12 +1055,13 @@ int dsa_port_standalone_host_fdb_add(struct dsa_port *dp,
 }
 
 int dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
+				 const struct dsa_bridge *bridge,
 				 const unsigned char *addr, u16 vid)
 {
 	struct net_device *conduit = dsa_port_to_conduit(dp);
 	struct dsa_db db = {
 		.type = DSA_DB_BRIDGE,
-		.bridge = *dp->bridge,
+		.bridge = *bridge,
 	};
 	int err;
 
@@ -1092,12 +1107,13 @@ int dsa_port_standalone_host_fdb_del(struct dsa_port *dp,
 }
 
 int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
+				 const struct dsa_bridge *bridge,
 				 const unsigned char *addr, u16 vid)
 {
 	struct net_device *conduit = dsa_port_to_conduit(dp);
 	struct dsa_db db = {
 		.type = DSA_DB_BRIDGE,
-		.bridge = *dp->bridge,
+		.bridge = *bridge,
 	};
 	int err;
 
@@ -1113,8 +1129,8 @@ int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
 	return dsa_port_host_fdb_del(dp, addr, vid, db);
 }
 
-int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-			 u16 vid)
+int dsa_port_lag_fdb_add(struct dsa_port *dp, const struct dsa_bridge *bridge,
+			 const unsigned char *addr, u16 vid)
 {
 	struct dsa_notifier_lag_fdb_info info = {
 		.lag = dp->lag,
@@ -1122,7 +1138,7 @@ int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		.vid = vid,
 		.db = {
 			.type = DSA_DB_BRIDGE,
-			.bridge = *dp->bridge,
+			.bridge = *bridge,
 		},
 	};
 
@@ -1132,8 +1148,8 @@ int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 	return dsa_port_notify(dp, DSA_NOTIFIER_LAG_FDB_ADD, &info);
 }
 
-int dsa_port_lag_fdb_del(struct dsa_port *dp, const unsigned char *addr,
-			 u16 vid)
+int dsa_port_lag_fdb_del(struct dsa_port *dp, const struct dsa_bridge *bridge,
+			 const unsigned char *addr, u16 vid)
 {
 	struct dsa_notifier_lag_fdb_info info = {
 		.lag = dp->lag,
@@ -1141,7 +1157,7 @@ int dsa_port_lag_fdb_del(struct dsa_port *dp, const unsigned char *addr,
 		.vid = vid,
 		.db = {
 			.type = DSA_DB_BRIDGE,
-			.bridge = *dp->bridge,
+			.bridge = *bridge,
 		},
 	};
 
diff --git a/net/dsa/port.h b/net/dsa/port.h
index 6bc3291573c0..e665baf7454a 100644
--- a/net/dsa/port.h
+++ b/net/dsa/port.h
@@ -46,22 +46,24 @@ int dsa_port_mst_enable(struct dsa_port *dp, bool on,
 int dsa_port_vlan_msti(struct dsa_port *dp,
 		       const struct switchdev_vlan_msti *msti);
 int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu);
-int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-		     u16 vid);
-int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
-		     u16 vid);
+int dsa_port_fdb_add(struct dsa_port *dp, const struct dsa_bridge *bridge,
+		     const unsigned char *addr, u16 vid);
+int dsa_port_fdb_del(struct dsa_port *dp, const struct dsa_bridge *bridge,
+		     const unsigned char *addr, u16 vid);
 int dsa_port_standalone_host_fdb_add(struct dsa_port *dp,
 				     const unsigned char *addr, u16 vid);
 int dsa_port_standalone_host_fdb_del(struct dsa_port *dp,
 				     const unsigned char *addr, u16 vid);
-int dsa_port_bridge_host_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-				 u16 vid);
-int dsa_port_bridge_host_fdb_del(struct dsa_port *dp, const unsigned char *addr,
-				 u16 vid);
-int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-			 u16 vid);
-int dsa_port_lag_fdb_del(struct dsa_port *dp, const unsigned char *addr,
-			 u16 vid);
+int dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
+				 const struct dsa_bridge *bridge,
+				 const unsigned char *addr, u16 vid);
+int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
+				 const struct dsa_bridge *bridge,
+				 const unsigned char *addr, u16 vid);
+int dsa_port_lag_fdb_add(struct dsa_port *dp, const struct dsa_bridge *bridge,
+			 const unsigned char *addr, u16 vid);
+int dsa_port_lag_fdb_del(struct dsa_port *dp, const struct dsa_bridge *bridge,
+			 const unsigned char *addr, u16 vid);
 int dsa_port_fdb_dump(struct dsa_port *dp, dsa_fdb_dump_cb_t *cb, void *data);
 int dsa_port_mdb_add(const struct dsa_port *dp,
 		     const struct switchdev_obj_port_mdb *mdb);
diff --git a/net/dsa/tag.h b/net/dsa/tag.h
index cf52283fe9df..0e1be1da4537 100644
--- a/net/dsa/tag.h
+++ b/net/dsa/tag.h
@@ -201,7 +201,7 @@ dsa_find_designated_bridge_port_by_vid(struct net_device *conduit, u16 vid)
 		if (dp->type != DSA_PORT_TYPE_USER)
 			continue;
 
-		if (!dp->bridge)
+		if (!READ_ONCE(dp->bridge))
 			continue;
 
 		if (dp->stp_state != BR_STATE_LEARNING &&
@@ -238,7 +238,7 @@ static inline void dsa_default_offload_fwd_mark(struct sk_buff *skb)
 {
 	struct dsa_port *dp = dsa_user_to_port(skb->dev);
 
-	skb->offload_fwd_mark = !!(dp->bridge);
+	skb->offload_fwd_mark = !!READ_ONCE(dp->bridge);
 }
 
 /* Helper for removing DSA header tags from packets in the RX path.
diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index f91646e60246..de7e24f75505 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -482,7 +482,7 @@ dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit, int vbid)
 		return NULL;
 
 	dsa_tree_for_each_user_port(dp, dst) {
-		if (!dp->bridge)
+		if (!READ_ONCE(dp->bridge))
 			continue;
 
 		if (dp->stp_state != BR_STATE_LEARNING &&
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 041f9060c8ef..81f0d3901209 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -3646,6 +3646,7 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 	const unsigned char *addr = switchdev_work->addr;
 	struct net_device *dev = switchdev_work->dev;
 	u16 vid = switchdev_work->vid;
+	const struct dsa_bridge *bridge;
 	struct dsa_switch *ds;
 	struct dsa_port *dp;
 	int err;
@@ -3653,14 +3654,22 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 	dp = dsa_user_to_port(dev);
 	ds = dp->ds;
 
+	/* Gone if the port left the bridge after the event was queued:
+	 * dsa_port_bridge_destroy() clears it before it flushes the workqueue
+	 */
+	bridge = READ_ONCE(dp->bridge);
+	if (!bridge)
+		goto out;
+
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 		if (switchdev_work->host_addr)
-			err = dsa_port_bridge_host_fdb_add(dp, addr, vid);
+			err = dsa_port_bridge_host_fdb_add(dp, bridge, addr,
+							   vid);
 		else if (dp->lag)
-			err = dsa_port_lag_fdb_add(dp, addr, vid);
+			err = dsa_port_lag_fdb_add(dp, bridge, addr, vid);
 		else
-			err = dsa_port_fdb_add(dp, addr, vid);
+			err = dsa_port_fdb_add(dp, bridge, addr, vid);
 		if (err) {
 			dev_err(ds->dev,
 				"port %d failed to add %pM vid %d to fdb: %d\n",
@@ -3672,11 +3681,12 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		if (switchdev_work->host_addr)
-			err = dsa_port_bridge_host_fdb_del(dp, addr, vid);
+			err = dsa_port_bridge_host_fdb_del(dp, bridge, addr,
+							   vid);
 		else if (dp->lag)
-			err = dsa_port_lag_fdb_del(dp, addr, vid);
+			err = dsa_port_lag_fdb_del(dp, bridge, addr, vid);
 		else
-			err = dsa_port_fdb_del(dp, addr, vid);
+			err = dsa_port_fdb_del(dp, bridge, addr, vid);
 		if (err) {
 			dev_err(ds->dev,
 				"port %d failed to delete %pM vid %d from fdb: %d\n",
@@ -3686,6 +3696,7 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 		break;
 	}
 
+out:
 	kfree(switchdev_work);
 }
 
@@ -3718,7 +3729,7 @@ static int dsa_user_fdb_event(struct net_device *dev,
 	if (ctx && ctx != dp)
 		return 0;
 
-	if (!dp->bridge)
+	if (!READ_ONCE(dp->bridge))
 		return 0;
 
 	if (switchdev_fdb_is_dynamically_learned(fdb_info)) {
-- 
2.53.0

