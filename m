Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136604;
	b=N+xI+vzrZxPnvCuv6iwhyJUVGIYWlY+zGkJZp9q9vwt7cjJ8veUFgy9Bw4ZuGP0SriZ0
	 SDF/KxhUd68zd1oL6MYKbu8oQ5fA6yD2U98C53MhS/ep/YEoPCXkU0v3CljN/7v1YrmYt
	 MndUm/ddIUkZv8CVL6ax+VZ2qOtnL7//RGbrc0KtSGcCFV0o28YmF4jbLRjVQwi9/OeUz
	 fs5/IBaWqRjLotfgtlW9wP4l0d0BRpJYWUMG1fFVsDwY9JDI6CvmNOw57OjOUASLk7BwH
	 Tv30LxpMmp2tXMxLXPNtSgRMDqKqYkn/23LqP9mfwSW1qH/4vUYWbFJa1C7dyubbQUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/SKSEfqQS8Igvwe99KeR8tpkRTehrw2nZcZ5AJN4mk4=;
	b=4ano0oK537fMrbGrVdV0n18Gk6RoFTmuZIjmK7vyNaC0NjnEeLTdbHYbHyNTGUDqlmes
	 2O86TxZZPeCcbZdUEsFz21bAJO97nzzk5tBFhU70Y4A826ag13kW+LoEPLa5FGvrG1Vyb
	 LH+aIalVndCiGCajh8JlY8syJ9m4JDHEF/tN5EZow2SiTCdqBB5fxUzuqZPArCdj5Mwml
	 EL0bJG+kTrDhVrThD6yfj8nd7PlCYxvpRPxohKU53oNez6AhjbfMPN8TMjxK0Sqh+yGi6
	 rOwSvixW0Gla3eTRMk3ZaYB5oYPEwJ1k2Flnh94rNWGfTlWaWvHic7LG/3SRfpwq/AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=gvaWWQKe;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15099606A331
	for <bridge@lists.linux.dev>; Sun,  8 Nov 2026 11:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15099606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=gvaWWQKe
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c450ab1483cso6101966b.3
        for <bridge@lists.linux.dev>; Sun, 08 Nov 2026 03:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794136602; x=1794741402; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SKSEfqQS8Igvwe99KeR8tpkRTehrw2nZcZ5AJN4mk4=;
        b=gvaWWQKef/joC91xvO20/xNWa8Q6Im3k6y8vsqAXeRDmfE7iaDaDa8IrX4wRacobI7
         nl9w+QH95mrEovVQpZtyd0HHe52hbfEGgmj3NNRxNPelgy5gCiMcgn67Oh6oq0z5MFsl
         n0PVueHiWzXJ1wGmR4liNLIVA3bucee9zrnY+wkICDZnqwKotTXjRpIFC0zzCETFMnJ7
         iQ+75sqZT59AVmqg7taq4Q30C9+JLs1OqlD+tTp6kfyB1bc5cRFDxoCb37auOO7kYzua
         DPYs4AVMGz6/mr7JlosWb0j/tt48QmUnR0rj4Ena/vG7kdrBRPZH2O7g1yZeMRnBhWbr
         nbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794136602; x=1794741402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SKSEfqQS8Igvwe99KeR8tpkRTehrw2nZcZ5AJN4mk4=;
        b=qOjYU1ycmHz3bJ/U7sWC5WQS0UOEG1ZwoSOcNqpCUqbKlGsqKuBZLHlfhJo8M0zoSF
         ILOw/p5y3KUEIriYvD1VQ0EpQ5GF7HI0/X2eQe/XYicTbP+fE2tS7JFc1wZpOOqx5Jcj
         50c+3K1LEJq7Nq7HxeQjv0099aTFj3pEQzRR7ilPx+dau9q5FPkH9cqZPV0yoAnNYA9e
         ubda8AZ6KkvhTkWX15gxQ3LVAAlfyRREj1h3tyao9NcFxBeHTJFVSrfCthbUKO+/7cVf
         C+U0Y2CPdFCkhQqQaTtwFahbqPihXNUITxVOLIJs8QJFC33yrUpoRRFvEv3Kqb2Atbsj
         m/8w==
X-Forwarded-Encrypted: i=1; AL+hErGN/AD+pPyaKFTaX5NguMFTM86YAtusOat7WhlZcnaFU8kv8a3eLomN8+cBErjmbvBAkzfNYUE=@lists.linux.dev
X-Gm-Message-State: APuU4Z/lgekLNl5U1CvERbM7nhGxnZteeBv3gT5/Lxo+wprRXRizJggw
	e7rLWGrFGiCMGG+o9g/hsrNZPvEsqbvMeTBty7t7UqvUb4igNEx/tmkgItdxtqATDw==
X-Gm-Gg: AYBFou26aImb2PDDFK9DhfyY+3AWWHtNGXcScnh315ACOocZ66MrtaUm/wUKEZ0IcKg
	sW5k1j/Wigtt6eWmj8sXH8Z6CzuZ8UWyeZXSKIhvq/5Wn0lzki8LcdqQfOMDEjAsARnwU6eOklW
	jCWT+DH6KXcYF4Rttbn4qE4myjAVh1Za6K7zIHVV+0kD17n35mG1o+O9KNty7c+wRbrmLJEEA9t
	aauwoxBAPAVgiCyHh8y1AbZb6epllBpfE05yCvR4xrgpWTQ5iBw2OAYu+8qcgGuWWJ3/1VjcsDE
	McDMFEi69cZ+zSqFN8iCG8wuoJPcSoCWRePGvu7UnX1RQFxxM+0S2cdOV0vHZsEl3RldATpZKME
	u8AK6LPHOknJhpIsk4MYs1MmkjI+K4G+RZmNk0lSbXCVfg0qHiMW2ZNdUlP1GRrjBWoea7Tik70
	JWPOfGRkHoHtmM7iL3KKsFGGt4n1Xu8VrSYFrpijepy0g1h1iUS3q2Q/NFJH1FgYDAbLnjo33cI
	MZkdNkln7ibPxn5sC9YuH45uYDhL4fIPTJc5XopFH4OsafFVkv7NLCvuzEGzqhSOCZ7UqPjaeVu
	39TXewwJmG6OE6fjB2TbHNmP+0mpxCN7NNmhNnzQNoc9hf2hCPLLMstc7zGfWPoikxBZLD1to2C
	KHImfULkiZpXaItEmtHVVgCpASkkJt2DZAXbGeVDEoU1ximuYGQO7Ne+4qMPayeY8vhxZhANN6O
	KmjPbSFD4iHn1S6Vv/si2H3fpXj3f1jJ1sx0vG0zaz36sql3R4BgmBSSF8BM3qOgeiyExUnvWlX
	K/tvhngocmWwcB4lB6Ae5mayIUlMDniHnlLiXPnowJ0Op0/xm6Q6GswAgscem53NAp9lJr9zhfp
	8/DzicnPT1W/Re4xsw==
X-Received: by 2002:a17:906:7953:b0:c3e:34fa:611d with SMTP id a640c23a62f3a-c4d6db15eecmr83366466b.35.1794136602388;
        Sun, 08 Nov 2026 03:16:42 -0800 (PST)
Received: from Desktop (p54afff19.dip0.t-ipconnect.de. [84.175.255.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a99320bsm54261166b.67.2026.11.08.03.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:16:41 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: bridge: switchdev: add br_switchdev_fdb_find_port()
Date: Sun,  8 Nov 2026 12:16:38 +0100
Message-ID: <92a9adba8020449a269bb8941698ea6849b4c372.1794134495.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794134495.git.julius@bairaktaris.de>
References: <cover.1794134495.git.julius@bairaktaris.de>
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

Add an RCU lookup that returns the port of a non-local FDB entry that
switchdev is notified of: not locked, not added by the user as a
dynamic entry, and not learned by a switchdev driver.

A switchdev driver that handles FDB events from a workqueue cannot take
RTNL for br_fdb_find_port(), and has to ignore the entries whose
deletion it will not be notified of. The filter of
br_switchdev_fdb_notify() moves into a helper that both use, with no
functional change; the learning path does not change.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 include/linux/if_bridge.h | 13 ++++++++
 net/bridge/br_switchdev.c | 63 +++++++++++++++++++++++++++++++++------
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 75673b8bffcb8..e050b7e698fc9 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -201,6 +201,19 @@ static inline int br_mst_get_state(const struct net_device *dev, u16 msti,
 }
 #endif
 
+#if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_NET_SWITCHDEV)
+struct net_device *br_switchdev_fdb_find_port(const struct net_device *br_dev,
+					      const unsigned char *addr,
+					      u16 vid);
+#else
+static inline struct net_device *
+br_switchdev_fdb_find_port(const struct net_device *br_dev,
+			   const unsigned char *addr, u16 vid)
+{
+	return NULL;
+}
+#endif
+
 #if IS_ENABLED(CONFIG_BRIDGE)
 struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 				    const unsigned char *addr,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 10f3aea6a1f82..02ca1cbcfede0 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -141,14 +141,10 @@ static void br_switchdev_fdb_populate(struct net_bridge *br,
 	item->info.ctx = ctx;
 }
 
-void
-br_switchdev_fdb_notify(struct net_bridge *br,
-			const struct net_bridge_fdb_entry *fdb, int type)
+static bool br_switchdev_fdb_notifies(const struct net_bridge_fdb_entry *fdb)
 {
-	struct switchdev_notifier_fdb_info item;
-
 	if (test_bit(BR_FDB_LOCKED, &fdb->flags))
-		return;
+		return false;
 
 	/* Entries with these flags were created using ndm_state == NUD_REACHABLE,
 	 * ndm_flags == NTF_MASTER( | NTF_STICKY), ext_flags == 0 by something
@@ -156,9 +152,58 @@ br_switchdev_fdb_notify(struct net_bridge *br,
 	 * Drivers don't know how to deal with these, so don't notify them to
 	 * avoid confusing them.
 	 */
-	if (test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags) &&
-	    !test_bit(BR_FDB_STATIC, &fdb->flags) &&
-	    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
+	return !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags) ||
+	       test_bit(BR_FDB_STATIC, &fdb->flags) ||
+	       test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
+}
+
+/**
+ * br_switchdev_fdb_find_port - find the port of an entry switchdev knows of
+ * @br_dev: the bridge device
+ * @addr: the MAC address of the entry
+ * @vid: the VLAN of the entry
+ *
+ * Must be called under RCU; the device is valid until the read-side critical
+ * section ends.
+ *
+ * Return: the port of the non-local entry for @addr and @vid, or NULL if
+ * there is none or switchdev is not notified of it.
+ */
+struct net_device *br_switchdev_fdb_find_port(const struct net_device *br_dev,
+					      const unsigned char *addr,
+					      u16 vid)
+{
+	const struct net_bridge_port *p;
+	struct net_bridge_fdb_entry *f;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "suspicious use outside RCU");
+
+	if (!netif_is_bridge_master(br_dev))
+		return NULL;
+
+	f = br_fdb_find_rcu(netdev_priv(br_dev), addr, vid);
+	if (!f || test_bit(BR_FDB_LOCAL, &f->flags) ||
+	    !br_switchdev_fdb_notifies(f))
+		return NULL;
+
+	/* learned by a switchdev driver, which is not notified back */
+	if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags) &&
+	    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags))
+		return NULL;
+
+	p = br_fdb_dst_port(f);
+
+	return p ? p->dev : NULL;
+}
+EXPORT_SYMBOL_GPL(br_switchdev_fdb_find_port);
+
+void
+br_switchdev_fdb_notify(struct net_bridge *br,
+			const struct net_bridge_fdb_entry *fdb, int type)
+{
+	struct switchdev_notifier_fdb_info item;
+
+	if (!br_switchdev_fdb_notifies(fdb))
 		return;
 
 	br_switchdev_fdb_populate(br, &item, fdb, NULL);
-- 
2.53.0

