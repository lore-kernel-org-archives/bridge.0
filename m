Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794696811;
	b=g7/NRjrI8KGjZPiSyaKb6MQyz0mQc61fcW1ZxjCwy8eXSrSgu/p241IIfYzNHef2zgJZ
	 dJU1TWhizwJ4cIcKatj9glpqZKpZbntX2E+D7+lyKzRcedlSpZlfwGTPnNTjBjCfVzrch
	 AK4NSdMkpqrvYh3O/0hTTbOI3VfeFK04Ffas0KMhwxk4Izc8i5ALIdoEuioMt7FKzBu99
	 S8b3JhPP0FmIQDJB90gpzfPIQ1lJyk9BIiiPf9N0rQ0ShX8B3pYrXDN1f/DhTgzJyeawd
	 bPLuNjV1rb940ssT+FU34dmvZ/j9OMrJg2DC7HW9lVoxfsflRAEUsabtb1KyH6cdjcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794696811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=V0y6h2XKEysZJ+laS9P/XZXjBihBy4ddjWcUsNiUbjc=;
	b=px5QfCkyvhIcOyeyOqCw8I1jrj6k/Kwa/v9H63ul8AWI8pTxRp8lqM2l/XVmVlHN//uG
	 yk1ejs4WV9O863BIW2630vX3fa3MwcwX0Dd/4e1JQGzFm/sSMKNqejYTdud5pHdud7P7J
	 Gxlfzab/3WZhjF04KuTE43/OGwN/uW6UarcvT35mfuJTs+/qvzNDo4oZFpYt1AOG4K/JR
	 rSvCHuQNuDrNwIZpOvBe9rSnQBeiE6B3I3MZfzYloxGqAkE5YstFcN2Bn3gPG09Zd/Q05
	 PJnG8clD8eaP1+YCXb77nZTXvMOnWD3mcl/HYZZOaGFbmi8lq77HvB+ZEstudDZufHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=VpCutjS6;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F0606A8A6
	for <bridge@lists.linux.dev>; Sat, 14 Nov 2026 22:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 642F0606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=VpCutjS6
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so3595061a12.3
        for <bridge@lists.linux.dev>; Sat, 14 Nov 2026 14:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794696809; x=1795301609; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V0y6h2XKEysZJ+laS9P/XZXjBihBy4ddjWcUsNiUbjc=;
        b=VpCutjS6ZNL+FCM+ScSUqzwWw/HhnCvYpl+PixlZ9niw/nEbzLJkxbsAm2cFqi5NL6
         hmky0MvFI40z+q18VPtiR91OaUU4uowqwMSPtGoKU8yRffC44CmzKDKjbvXRviaYHbIE
         4Cv7F3JCbfnyt3A89u5DDKZQQBd+nBPRCZ4VAcf27ibwL0mj40d8bVYxTk+VYCSMYke9
         mu6VeXw/VBeVC7MsOdoEo9bkaIf6EYyfN7MJJc+ZyehGwEWwmG6OjNm1os/p//vRhncY
         hyzZdm2Z4F2qMj61QXIEPuCF0TcaxsJiPGQkreUHQeHhm29DQcnlbACxY3e26Xvgfgc1
         c98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794696809; x=1795301609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V0y6h2XKEysZJ+laS9P/XZXjBihBy4ddjWcUsNiUbjc=;
        b=wZmcJKo0LI8oxyl1KC9lQ4gsMlfnljJLTsJa8YCURmzFNh2xD48v1r92e5N4ZoMyS4
         lF0oZWteMgE4Z0onROXKDqm2VIBxtzWW0/8pw+GDRhFsLlvJYN7Gk+1sMCkKupJ4jr+7
         45i4aw//ilclWXiwdItKICxhKMXzjGInxDPtyQu6pOW3WAuCifpsrhAAaqAG3FD6YHRg
         eS0FgGbcwV5L6X13dcO0d3eX86hixBSbHPpv5m5WaW6GHbHKpFfafNgyQ8xSJoHSbXYM
         cRNLs+kB4/qyMs2KoUeoDvmIeBkdRiar5vIz+1R7xebkxIkeLYWEudYuvl8DZC6cZzgA
         Ob/A==
X-Forwarded-Encrypted: i=1; AL+hErGQh/xD1MZXvG7NpOvIbpIUaqXGlAoqdAGHzjKaOWTjKslt1HNgDhm5GlMOKRu8J4/Et0Ome5o=@lists.linux.dev
X-Gm-Message-State: APuU4Z/DexpTdXrT4E7Q6tj5audLcaw+38BwkNVmthMQUGxpmMfaz/gD
	UdTmPyzmTpdS2xxWfTMXzpiCku4Uc3a3Ya8TD4l9ghTsT0arbxdzft0pKw8/7C1sGA==
X-Gm-Gg: AYBFou0Xr98KkqSIbdmmRVgRKyffDpLYVI0GVEBCQ4PBhi5jWj9k1USCqAa+YghYPDy
	dHr1wK3uZlhBOs1c0pkOGvxgfToHzKk1lKPcio8/no3DvijIY6VR9enrfDPfuWVsreCoCeRpU7T
	po+E/YJshMUuKmCP06eCNovmufaOQINUNpiWIKW7VqgYWgTzmi22UCvk0c1Yd886C55nVmRg8FO
	oX/+8JzBeFyu10lxJaxz9L2cwj3BleBYghc/cRjt5ThvLlwI5YYOuazxoXw18rtWFF7AAiS0Fyw
	05rEp0sPs1lDWn/sQ3RLTvRBR6EsJs72ZYeAy3R1iWc/939jdgflzppTzbQSZ3YbsJybTT+FISy
	GRokbqY1ofijszEumnROM3xZO6tBavQl3PTIHejmIMYiezU7SYK3vffr7OOa8eqiGKpl+/vQn52
	Nnqj/t7bcI0Q4q69oRctun25z+rd1vAPHjp+2caiu6/bBi92UVhFuSVB/xO8WYMO1Sm6mvKxOxY
	6/anKnALkFLzAzAr9EyUcHBC18rjm4h+BigE9pt4mDO+MqudmhH/2zIoHl1s62fFCB1A5x8euBK
	vpnZI13ne/XazgnuEqzUcIxgL9e/Nsl0xvIbJp/XkQmHcP0JdcxwUkDJUt3PsWVA3vr1qCLlYod
	1vb8ajnyJv0TvWPjWkLk27Z6JG7ePAPtXwQeahP6HawscB0JJcMiZD42BRqNzw78C+2aP8g9NMg
	77+ApvzZpHXufT7HpiMlxQ4QfCxXVShhsVgTpm3a9qs6WMN+cVy7mvYcnlXgN9+KcKU5wstCA8T
	1KWqGfq5LmFHaQho/Cq8fZhpRu4vy3KuWFx49ewFqDsIIJekoeBLpIL3DA4Atj3jt2ySF0UKsUt
	/aNVGRot5uAWwN9SC+AQCRAjtpNgZitZGF+peNoaYa6bLqrS0Xu9WERvmflG7E68
X-Received: by 2002:a17:906:c14f:b0:c50:5a51:632f with SMTP id a640c23a62f3a-c50963ce147mr563396966b.39.1794696808641;
        Sat, 14 Nov 2026 14:53:28 -0800 (PST)
Received: from Desktop.fritz.box (p200300f24709e8006da21e9e53ecde1c.dip0.t-ipconnect.de. [2003:f2:4709:e800:6da2:1e9e:53ec:de1c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b56df7sm262479666b.47.2026.11.14.14.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 14:53:27 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: dsa: fix host fdb refcount when a bridge fdb entry roams
Date: Sat, 14 Nov 2026 23:53:23 +0100
Message-ID: <bf1624a8295e435bfbe75534f51c9c87809378c7.1794696609.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794696608.git.julius@bairaktaris.de>
References: <cover.1794696608.git.julius@bairaktaris.de>
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

A bridge FDB entry on a foreign port is a host address on every user
port in the bridge. When the entry roams, br_fdb_update() notifies the
deletion from the old port and the addition on the new one without a
lock. With two CPUs receiving the address on different ports, DSA can
get two deletions for one addition, an addition for a port the entry
already left, or the deletion before the addition. Counting these
events either makes a deletion find no reference left on the CPU port,
or leaks a reference, which keeps the address on the CPU port after the
entry moved to a user port or was deleted. The first ends in this
error, here from dsa_loop:

  port 1 failed to delete 02:5a:0b:a2:1a:46 vid 0 from fdb: -2

Instead of counting, each user port records the host addresses it
holds. On every event it holds the address while the bridge has the
entry on a foreign port and notifies switchdev of it (a learned entry
only with assisted learning), or has it as a local entry, and releases
it otherwise. A deletion that still finds the entry on its own port was
sent before the bridge changed the port, so the address is released.
Replayed deletions release it without the lookup.

An entry on a user port, also one of another tree, is
notified only to that port. An addition there releases the address on
every user port of the bridge that holds it, from the lower devices of
the bridge, and before the entry is installed: some switches keep one
entry per address, which a later release would erase. This also covers a
"bridge fdb replace" onto a user port, which notifies no deletion. A
failed host address add does not report the entry as offloaded and
undoes its unicast filter reference on the conduit; a failed delete
drops the record, so the conduit reference is not released twice.

FDB events can still be queued when a port leaves the bridge or fails to
join it. The events read dp->bridge once and are dropped when it is
gone, the FDB helpers take the bridge from the caller, and
dsa_port_bridge_destroy() clears dp->bridge before it flushes the
workqueue and releases the records, so the bridge is not freed under a
running event.

In QEMU, with dsa_loop given FDB operations and assisted learning, two
veth ports in its bridge and one source address sent from both on two
CPUs for 5 s, the deletion fails and the address stays on the CPU port
after both veth ports go down in 4 of 5 boots. With this change neither
happens in 5 of 5 boots, and the address is removed when the user ports
leave the bridge. A "bridge fdb replace" of the address onto a user port
leaves it on the CPU port in 5 of 5 boots without this change and
removes it in 5 of 5 with it. Replacing the entry with a local one and
back leaves no address behind. With 40 static entries to replay and the
N-th allocation of "ip link set lan1 master br0" failing for N = 1 to
150, the bridge join fails 73 to 77 times per boot; the previous version
oopses in dsa_user_switchdev_event_work() in 2 of 2 boots, this one
does not in 5 of 5 boots and leaves no address on the CPU port.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
Changes in v2:
- Release the address on every user port of the bridge, also of another
  tree, before the entry is installed.
- Hold addresses of local entries through the same lookup.
- Apply assisted_learning_on_cpu_port; schedule the release before the
  lag_fdb_add check and only for ports that hold a foreign address.
- No offloaded notification for a failed add; undo the conduit
  reference when the switch add fails; drop the record on a failed
  delete.
- Drop events that find no bridge after a failed join; pass the bridge
  to the FDB helpers; READ_ONCE()/WRITE_ONCE() on dp->bridge.

 include/net/dsa.h |   4 +-
 net/dsa/port.c    |  50 ++++---
 net/dsa/port.h    |  26 ++--
 net/dsa/user.c    | 353 ++++++++++++++++++++++++++++++++++++++++++----
 net/dsa/user.h    |  22 +++
 5 files changed, 396 insertions(+), 59 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 5d12191b6f6f5..6e63d88bafa60 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -772,7 +772,9 @@ struct net_device *dsa_port_to_bridge_port(const struct dsa_port *dp)
 static inline struct net_device *
 dsa_port_bridge_dev_get(const struct dsa_port *dp)
 {
-	return dp->bridge ? dp->bridge->dev : NULL;
+	const struct dsa_bridge *bridge = READ_ONCE(dp->bridge);
+
+	return bridge ? bridge->dev : NULL;
 }
 
 static inline unsigned int dsa_port_bridge_num_get(struct dsa_port *dp)
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 1f5536c0dffc2..1ec2c79387150 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -427,7 +427,7 @@ static int dsa_port_bridge_create(struct dsa_port *dp,
 	bridge = dsa_tree_bridge_find(ds->dst, br);
 	if (bridge) {
 		refcount_inc(&bridge->refcount);
-		dp->bridge = bridge;
+		WRITE_ONCE(dp->bridge, bridge);
 		return 0;
 	}
 
@@ -447,7 +447,7 @@ static int dsa_port_bridge_create(struct dsa_port *dp,
 		return -EOPNOTSUPP;
 	}
 
-	dp->bridge = bridge;
+	WRITE_ONCE(dp->bridge, bridge);
 
 	return 0;
 }
@@ -457,7 +457,13 @@ static void dsa_port_bridge_destroy(struct dsa_port *dp,
 {
 	struct dsa_bridge *bridge = dp->bridge;
 
-	dp->bridge = NULL;
+	WRITE_ONCE(dp->bridge, NULL);
+
+	/* Wait for the FDB events that still see the bridge, then release the
+	 * host addresses the port holds, before the drivers are told it left.
+	 */
+	dsa_flush_workqueue();
+	dsa_user_bridge_host_fdb_purge(dp, bridge);
 
 	if (!refcount_dec_and_test(&bridge->refcount))
 		return;
@@ -528,7 +534,9 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 					&dsa_user_switchdev_blocking_notifier);
 	dsa_flush_workqueue();
 out_rollback_unbridge:
+	dsa_port_bridge_destroy(dp, br);
 	dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);
+	return err;
 out_rollback:
 	dsa_port_bridge_destroy(dp, br);
 	return err;
@@ -973,8 +981,8 @@ int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu)
 	return dsa_port_notify(dp, DSA_NOTIFIER_MTU, &info);
 }
 
-int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-		     u16 vid)
+int dsa_port_fdb_add(struct dsa_port *dp, const struct dsa_bridge *bridge,
+		     const unsigned char *addr, u16 vid)
 {
 	struct dsa_notifier_fdb_info info = {
 		.dp = dp,
@@ -982,7 +990,7 @@ int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		.vid = vid,
 		.db = {
 			.type = DSA_DB_BRIDGE,
-			.bridge = *dp->bridge,
+			.bridge = *bridge,
 		},
 	};
 
@@ -996,8 +1004,8 @@ int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 	return dsa_port_notify(dp, DSA_NOTIFIER_FDB_ADD, &info);
 }
 
-int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
-		     u16 vid)
+int dsa_port_fdb_del(struct dsa_port *dp, const struct dsa_bridge *bridge,
+		     const unsigned char *addr, u16 vid)
 {
 	struct dsa_notifier_fdb_info info = {
 		.dp = dp,
@@ -1005,7 +1013,7 @@ int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
 		.vid = vid,
 		.db = {
 			.type = DSA_DB_BRIDGE,
-			.bridge = *dp->bridge,
+			.bridge = *bridge,
 		},
 	};
 
@@ -1041,12 +1049,13 @@ int dsa_port_standalone_host_fdb_add(struct dsa_port *dp,
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
 
@@ -1063,7 +1072,11 @@ int dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
 			return err;
 	}
 
-	return dsa_port_host_fdb_add(dp, addr, vid, db);
+	err = dsa_port_host_fdb_add(dp, addr, vid, db);
+	if (err && (conduit->priv_flags & IFF_UNICAST_FLT))
+		dev_uc_del(conduit, addr);
+
+	return err;
 }
 
 static int dsa_port_host_fdb_del(struct dsa_port *dp,
@@ -1092,12 +1105,13 @@ int dsa_port_standalone_host_fdb_del(struct dsa_port *dp,
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
 
@@ -1113,8 +1127,8 @@ int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
 	return dsa_port_host_fdb_del(dp, addr, vid, db);
 }
 
-int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-			 u16 vid)
+int dsa_port_lag_fdb_add(struct dsa_port *dp, const struct dsa_bridge *bridge,
+			 const unsigned char *addr, u16 vid)
 {
 	struct dsa_notifier_lag_fdb_info info = {
 		.lag = dp->lag,
@@ -1122,7 +1136,7 @@ int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		.vid = vid,
 		.db = {
 			.type = DSA_DB_BRIDGE,
-			.bridge = *dp->bridge,
+			.bridge = *bridge,
 		},
 	};
 
@@ -1132,8 +1146,8 @@ int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 	return dsa_port_notify(dp, DSA_NOTIFIER_LAG_FDB_ADD, &info);
 }
 
-int dsa_port_lag_fdb_del(struct dsa_port *dp, const unsigned char *addr,
-			 u16 vid)
+int dsa_port_lag_fdb_del(struct dsa_port *dp, const struct dsa_bridge *bridge,
+			 const unsigned char *addr, u16 vid)
 {
 	struct dsa_notifier_lag_fdb_info info = {
 		.lag = dp->lag,
@@ -1141,7 +1155,7 @@ int dsa_port_lag_fdb_del(struct dsa_port *dp, const unsigned char *addr,
 		.vid = vid,
 		.db = {
 			.type = DSA_DB_BRIDGE,
-			.bridge = *dp->bridge,
+			.bridge = *bridge,
 		},
 	};
 
diff --git a/net/dsa/port.h b/net/dsa/port.h
index 6bc3291573c02..e665baf7454a5 100644
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
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 041f9060c8ef0..24f9914296660 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -43,6 +43,7 @@ struct dsa_switchdev_event_work {
 	unsigned char addr[ETH_ALEN];
 	u16 vid;
 	bool host_addr;
+	bool replay;
 };
 
 enum dsa_standalone_event {
@@ -2813,6 +2814,7 @@ int dsa_user_create(struct dsa_port *port)
 
 	p->dp = port;
 	INIT_LIST_HEAD(&p->mall_tc_list);
+	INIT_LIST_HEAD(&p->bridge_host_fdbs);
 	port->user = user_dev;
 	dsa_user_setup_tagger(user_dev);
 
@@ -3627,6 +3629,22 @@ static int dsa_user_netdevice_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static bool dsa_foreign_dev_check(const struct net_device *dev,
+				  const struct net_device *foreign_dev)
+{
+	const struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_switch_tree *dst = dp->ds->dst;
+
+	if (netif_is_bridge_master(foreign_dev))
+		return !dsa_tree_offloads_bridge_dev(dst, foreign_dev);
+
+	if (netif_is_bridge_port(foreign_dev))
+		return !dsa_tree_offloads_bridge_port(dst, foreign_dev);
+
+	/* Everything else is foreign */
+	return true;
+}
+
 static void
 dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work)
 {
@@ -3639,6 +3657,270 @@ dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work)
 				 switchdev_work->orig_dev, &info.info, NULL);
 }
 
+/* The bridge notifies a roaming entry without a lock, so with two CPUs the
+ * deletion from the old port and the addition on the new one can arrive
+ * twice or out of order. Hold the host address while the bridge has the
+ * entry on a foreign port or as a local entry. A deletion that still finds
+ * the entry on its own port was sent before the bridge changed the port. An
+ * entry on a user port, also one of another tree, is notified only to that
+ * port.
+ */
+enum dsa_host_fdb_want {
+	DSA_HOST_FDB_NONE,
+	DSA_HOST_FDB_FOREIGN,
+	DSA_HOST_FDB_LOCAL,
+};
+
+static enum dsa_host_fdb_want
+dsa_user_bridge_host_fdb_wanted(struct net_device *dev,
+				const struct dsa_bridge *bridge,
+				const unsigned char *addr, u16 vid,
+				const struct net_device *leaving)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	enum dsa_host_fdb_want want = DSA_HOST_FDB_NONE;
+	struct net_device *brport;
+	bool by_user = false;
+
+	rcu_read_lock();
+	brport = br_switchdev_fdb_find_port(bridge->dev, addr, vid, &by_user);
+	if (brport == bridge->dev)
+		want = DSA_HOST_FDB_LOCAL;
+	/* Learned entries on foreign ports only count with assisted learning,
+	 * as in dsa_user_fdb_event()
+	 */
+	else if (brport && brport != leaving && !dsa_user_dev_check(brport) &&
+		 dsa_foreign_dev_check(dev, brport) &&
+		 (by_user || dp->ds->assisted_learning_on_cpu_port))
+		want = DSA_HOST_FDB_FOREIGN;
+	rcu_read_unlock();
+
+	return want;
+}
+
+/* Hold, release or retag the host address; return whether it is held
+ * afterwards
+ */
+static bool dsa_user_bridge_host_fdb_set(struct net_device *dev,
+					 const struct dsa_bridge *bridge,
+					 const unsigned char *addr, u16 vid,
+					 enum dsa_host_fdb_want want)
+{
+	struct dsa_user_priv *p = netdev_priv(dev);
+	struct dsa_port *dp = p->dp;
+	struct dsa_user_host_fdb *a, *held = NULL;
+	bool local = want == DSA_HOST_FDB_LOCAL;
+	int err;
+
+	list_for_each_entry(a, &p->bridge_host_fdbs, list) {
+		if (ether_addr_equal(a->addr, addr) && a->vid == vid) {
+			held = a;
+			break;
+		}
+	}
+
+	if (want != DSA_HOST_FDB_NONE && held) {
+		if (held->local != local) {
+			held->local = local;
+			atomic_add(local ? -1 : 1,
+				   &p->bridge_host_fdbs_foreign_n);
+		}
+		return true;
+	}
+
+	if (want == DSA_HOST_FDB_NONE && !held)
+		return false;
+
+	if (want != DSA_HOST_FDB_NONE) {
+		a = kzalloc_obj(*a);
+		if (!a)
+			return false;
+
+		err = dsa_port_bridge_host_fdb_add(dp, bridge, addr, vid);
+		if (err) {
+			dev_err(dp->ds->dev,
+				"port %d failed to add %pM vid %d to fdb: %d\n",
+				dp->index, addr, vid, err);
+			kfree(a);
+			return false;
+		}
+
+		ether_addr_copy(a->addr, addr);
+		a->vid = vid;
+		a->local = local;
+		list_add(&a->list, &p->bridge_host_fdbs);
+		atomic_inc(&p->bridge_host_fdbs_n);
+		if (!local)
+			atomic_inc(&p->bridge_host_fdbs_foreign_n);
+		return true;
+	}
+
+	/* The conduit's unicast filter is released before the switch entry, so
+	 * the record goes even when the latter fails.
+	 */
+	err = dsa_port_bridge_host_fdb_del(dp, bridge, addr, vid);
+	if (err)
+		dev_err(dp->ds->dev,
+			"port %d failed to delete %pM vid %d from fdb: %d\n",
+			dp->index, addr, vid, err);
+
+	list_del(&held->list);
+	atomic_dec(&p->bridge_host_fdbs_n);
+	if (!held->local)
+		atomic_dec(&p->bridge_host_fdbs_foreign_n);
+	kfree(held);
+
+	return false;
+}
+
+static void
+dsa_user_bridge_host_fdb_sync(struct dsa_switchdev_event_work *switchdev_work)
+{
+	bool del = switchdev_work->event == SWITCHDEV_FDB_DEL_TO_DEVICE;
+	const struct net_device *leaving =
+		del ? switchdev_work->orig_dev : NULL;
+	struct net_device *dev = switchdev_work->dev;
+	const unsigned char *addr = switchdev_work->addr;
+	u16 vid = switchdev_work->vid;
+	enum dsa_host_fdb_want want = DSA_HOST_FDB_NONE;
+	const struct dsa_bridge *bridge;
+	bool held;
+
+	/* Cleared before the workqueue is flushed and the bridge is freed */
+	bridge = READ_ONCE(dsa_user_to_port(dev)->bridge);
+	if (!bridge)
+		return;
+
+	if (!(del && switchdev_work->replay))
+		want = dsa_user_bridge_host_fdb_wanted(dev, bridge, addr, vid,
+						       leaving);
+
+	held = dsa_user_bridge_host_fdb_set(dev, bridge, addr, vid, want);
+
+	if (held) {
+		/* Pairs with the barrier in dsa_user_bridge_host_fdb_release():
+		 * either it sees the record, or the entry has moved by the time
+		 * it is looked up again.
+		 */
+		smp_mb();
+		want = dsa_user_bridge_host_fdb_wanted(dev, bridge, addr, vid,
+						       leaving);
+		held = dsa_user_bridge_host_fdb_set(dev, bridge, addr, vid,
+						    want);
+	}
+
+	if (held && !del)
+		dsa_fdb_offload_notify(switchdev_work);
+}
+
+/* Only the user port an entry is on gets its events, so when the entry roams
+ * there, release it on the ports of the bridge that still hold it.
+ */
+static void dsa_user_bridge_host_fdb_release_work(struct work_struct *work)
+{
+	struct dsa_switchdev_event_work *switchdev_work =
+		container_of(work, struct dsa_switchdev_event_work, work);
+	const unsigned char *addr = switchdev_work->addr;
+	struct net_device *dev = switchdev_work->dev;
+	u16 vid = switchdev_work->vid;
+	const struct dsa_bridge *bridge;
+	enum dsa_host_fdb_want want;
+
+	bridge = READ_ONCE(dsa_user_to_port(dev)->bridge);
+	if (bridge) {
+		want = dsa_user_bridge_host_fdb_wanted(dev, bridge, addr, vid,
+						       NULL);
+		dsa_user_bridge_host_fdb_set(dev, bridge, addr, vid, want);
+	}
+
+	kfree(switchdev_work);
+}
+
+struct dsa_user_release_ctx {
+	const unsigned char *addr;
+	u16 vid;
+	bool dynamic;
+	int err;
+};
+
+static int dsa_user_bridge_host_fdb_release_one(struct net_device *lower,
+						struct netdev_nested_priv *priv)
+{
+	struct dsa_user_release_ctx *ctx = (void *)priv->data;
+	struct dsa_switchdev_event_work *switchdev_work;
+	struct dsa_user_priv *p;
+
+	if (!dsa_user_dev_check(lower))
+		return 0;
+
+	/* A learned entry cannot replace a local one, so only the addresses
+	 * held for foreign entries can be affected
+	 */
+	p = netdev_priv(lower);
+	if (!READ_ONCE(p->dp->bridge) ||
+	    !atomic_read(ctx->dynamic ? &p->bridge_host_fdbs_foreign_n :
+					&p->bridge_host_fdbs_n))
+		return 0;
+
+	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
+	if (!switchdev_work) {
+		ctx->err = -ENOMEM;
+		return 0;
+	}
+
+	INIT_WORK(&switchdev_work->work, dsa_user_bridge_host_fdb_release_work);
+	switchdev_work->dev = lower;
+	ether_addr_copy(switchdev_work->addr, ctx->addr);
+	switchdev_work->vid = ctx->vid;
+
+	dsa_schedule_work(&switchdev_work->work);
+
+	return 0;
+}
+
+/* Called under rcu_read_lock() */
+static int dsa_user_bridge_host_fdb_release(struct net_device *dev,
+					    const unsigned char *addr, u16 vid,
+					    bool dynamic)
+{
+	struct dsa_user_release_ctx ctx = {
+		.addr = addr, .vid = vid, .dynamic = dynamic,
+	};
+	struct netdev_nested_priv priv = { .data = &ctx };
+	struct net_device *br = dsa_port_bridge_dev_get(dsa_user_to_port(dev));
+
+	if (!br)
+		return 0;
+
+	/* Pairs with the barrier in dsa_user_bridge_host_fdb_sync() */
+	smp_mb();
+	netdev_walk_all_lower_dev_rcu(br, dsa_user_bridge_host_fdb_release_one,
+				      &priv);
+
+	return ctx.err;
+}
+
+void dsa_user_bridge_host_fdb_purge(struct dsa_port *dp,
+				    const struct dsa_bridge *bridge)
+{
+	struct dsa_user_priv *p = netdev_priv(dp->user);
+	struct dsa_user_host_fdb *a, *tmp;
+	int err;
+
+	list_for_each_entry_safe(a, tmp, &p->bridge_host_fdbs, list) {
+		err = dsa_port_bridge_host_fdb_del(dp, bridge, a->addr, a->vid);
+		if (err)
+			dev_err(dp->ds->dev,
+				"port %d failed to delete %pM vid %d from fdb: %d\n",
+				dp->index, a->addr, a->vid, err);
+		list_del(&a->list);
+		atomic_dec(&p->bridge_host_fdbs_n);
+		if (!a->local)
+			atomic_dec(&p->bridge_host_fdbs_foreign_n);
+		kfree(a);
+	}
+}
+
 static void dsa_user_switchdev_event_work(struct work_struct *work)
 {
 	struct dsa_switchdev_event_work *switchdev_work =
@@ -3646,6 +3928,7 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 	const unsigned char *addr = switchdev_work->addr;
 	struct net_device *dev = switchdev_work->dev;
 	u16 vid = switchdev_work->vid;
+	const struct dsa_bridge *bridge;
 	struct dsa_switch *ds;
 	struct dsa_port *dp;
 	int err;
@@ -3653,14 +3936,28 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 	dp = dsa_user_to_port(dev);
 	ds = dp->ds;
 
+	if (switchdev_work->host_addr) {
+		dsa_user_bridge_host_fdb_sync(switchdev_work);
+		kfree(switchdev_work);
+		return;
+	}
+
+	/* An event that was queued before the port left the bridge finds no
+	 * bridge: dsa_port_bridge_destroy() clears it and flushes the workqueue
+	 * before the bridge is freed.
+	 */
+	bridge = READ_ONCE(dp->bridge);
+	if (!bridge) {
+		kfree(switchdev_work);
+		return;
+	}
+
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		if (switchdev_work->host_addr)
-			err = dsa_port_bridge_host_fdb_add(dp, addr, vid);
-		else if (dp->lag)
-			err = dsa_port_lag_fdb_add(dp, addr, vid);
+		if (dp->lag)
+			err = dsa_port_lag_fdb_add(dp, bridge, addr, vid);
 		else
-			err = dsa_port_fdb_add(dp, addr, vid);
+			err = dsa_port_fdb_add(dp, bridge, addr, vid);
 		if (err) {
 			dev_err(ds->dev,
 				"port %d failed to add %pM vid %d to fdb: %d\n",
@@ -3671,12 +3968,10 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 		break;
 
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		if (switchdev_work->host_addr)
-			err = dsa_port_bridge_host_fdb_del(dp, addr, vid);
-		else if (dp->lag)
-			err = dsa_port_lag_fdb_del(dp, addr, vid);
+		if (dp->lag)
+			err = dsa_port_lag_fdb_del(dp, bridge, addr, vid);
 		else
-			err = dsa_port_fdb_del(dp, addr, vid);
+			err = dsa_port_fdb_del(dp, bridge, addr, vid);
 		if (err) {
 			dev_err(ds->dev,
 				"port %d failed to delete %pM vid %d from fdb: %d\n",
@@ -3689,22 +3984,6 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 	kfree(switchdev_work);
 }
 
-static bool dsa_foreign_dev_check(const struct net_device *dev,
-				  const struct net_device *foreign_dev)
-{
-	const struct dsa_port *dp = dsa_user_to_port(dev);
-	struct dsa_switch_tree *dst = dp->ds->dst;
-
-	if (netif_is_bridge_master(foreign_dev))
-		return !dsa_tree_offloads_bridge_dev(dst, foreign_dev);
-
-	if (netif_is_bridge_port(foreign_dev))
-		return !dsa_tree_offloads_bridge_port(dst, foreign_dev);
-
-	/* Everything else is foreign */
-	return true;
-}
-
 static int dsa_user_fdb_event(struct net_device *dev,
 			      struct net_device *orig_dev,
 			      unsigned long event, const void *ctx,
@@ -3718,12 +3997,16 @@ static int dsa_user_fdb_event(struct net_device *dev,
 	if (ctx && ctx != dp)
 		return 0;
 
-	if (!dp->bridge)
+	if (!READ_ONCE(dp->bridge))
 		return 0;
 
 	if (switchdev_fdb_is_dynamically_learned(fdb_info)) {
 		if (dsa_port_offloads_bridge_port(dp, orig_dev))
-			return 0;
+			return event == SWITCHDEV_FDB_ADD_TO_DEVICE ?
+				dsa_user_bridge_host_fdb_release(dev,
+								 fdb_info->addr,
+								 fdb_info->vid,
+								 true) : 0;
 
 		/* FDB entries learned by the software bridge or by foreign
 		 * bridge ports should be installed as host addresses only if
@@ -3739,6 +4022,19 @@ static int dsa_user_fdb_event(struct net_device *dev,
 	if (dsa_foreign_dev_check(dev, orig_dev))
 		host_addr = true;
 
+	/* The entry is on a user port now, so no other port holds it. Release
+	 * the holds before the entry is installed: some switches keep one
+	 * entry per address, which a later release would erase.
+	 */
+	if (!host_addr && event == SWITCHDEV_FDB_ADD_TO_DEVICE) {
+		int err = dsa_user_bridge_host_fdb_release(dev, fdb_info->addr,
+							   fdb_info->vid,
+							   false);
+
+		if (err)
+			return err;
+	}
+
 	/* Check early that we're not doing work in vain.
 	 * Host addresses on LAG ports still require regular FDB ops,
 	 * since the CPU port isn't in a LAG.
@@ -3768,6 +4064,7 @@ static int dsa_user_fdb_event(struct net_device *dev,
 	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
 	switchdev_work->vid = fdb_info->vid;
 	switchdev_work->host_addr = host_addr;
+	switchdev_work->replay = !!ctx;
 
 	dsa_schedule_work(&switchdev_work->work);
 
diff --git a/net/dsa/user.h b/net/dsa/user.h
index 016884bead3cd..ca9bc1d4f50e7 100644
--- a/net/dsa/user.h
+++ b/net/dsa/user.h
@@ -17,6 +17,14 @@ struct netlink_ext_ack;
 extern struct notifier_block dsa_user_switchdev_notifier;
 extern struct notifier_block dsa_user_switchdev_blocking_notifier;
 
+/* A host address held for a bridge FDB entry */
+struct dsa_user_host_fdb {
+	struct list_head list;
+	unsigned char addr[ETH_ALEN];
+	u16 vid;
+	bool local;
+};
+
 struct dsa_user_priv {
 	/* Copy of CPU port xmit for faster access in user transmit hot path */
 	struct sk_buff *	(*xmit)(struct sk_buff *skb,
@@ -33,6 +41,18 @@ struct dsa_user_priv {
 
 	/* TC context */
 	struct list_head	mall_tc_list;
+
+	/* Host addresses of bridge FDB entries held through this port,
+	 * changed from the DSA workqueue, or with the port out of the bridge
+	 * and the workqueue flushed
+	 */
+	struct list_head	bridge_host_fdbs;
+
+	/* Length of bridge_host_fdbs, and how many of its entries are not
+	 * local to the bridge; read without the workqueue
+	 */
+	atomic_t		bridge_host_fdbs_n;
+	atomic_t		bridge_host_fdbs_foreign_n;
 };
 
 void dsa_user_mii_bus_init(struct dsa_switch *ds);
@@ -47,6 +67,8 @@ void dsa_user_host_uc_uninstall(struct net_device *dev);
 void dsa_user_sync_ha(struct net_device *dev);
 void dsa_user_unsync_ha(struct net_device *dev);
 void dsa_user_setup_tagger(struct net_device *user);
+void dsa_user_bridge_host_fdb_purge(struct dsa_port *dp,
+				    const struct dsa_bridge *bridge);
 int dsa_user_change_mtu(struct net_device *dev, int new_mtu);
 int dsa_user_change_conduit(struct net_device *dev, struct net_device *conduit,
 			    struct netlink_ext_ack *extack);
-- 
2.53.0

