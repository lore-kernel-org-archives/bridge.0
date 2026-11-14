Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794696808;
	b=lbyYfs8+oCshwTWvzs1QUKIUF8C9RqQ5Wjf78DikcXLFcL1WdnspdtwzcCHFFPTSekdR
	 YrSFSZfdy3TUNO8YqyOxPrRx/DZpIF4JM1hvxUTq4Nw+/kkjQLSaYLm4W3N/ERAdVy8//
	 ZNLjcpT3W+hHSxiGQSwUjv//nEo6kS9lUaSy/3oLGYOiJxhdMc+CCTF2/nlFHgnNikMHs
	 zTFZaYshp1/QODlinxr2tlCU/50zBqU5jfYshjKITWj8iqICGbvTXCYVy174TbufBG5Y5
	 4ce2IwTR84S+CLdePriQ3MJRryY0WGVvudg4eNk8gAIRjg/aHwKyWNunjYJHMV7SOpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794696808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zfcSy76pYo4+KmPuxjlwpmlNL9IIkiVdSH2l/JZ+u80=;
	b=HOdCGO9fv99CyoQE88SDENUNA2ELdhJFvHEX1uULL6QUofbKXHv/GsY1nKjul4VYs9fM
	 FaAR5hP5vP4tOQ7n+GtRSt+HgfTtqUJZh6Q15gz5azEokebDaNE/XQ6xu+pDslwU9rf6A
	 tfw/XTGwoSP4eAdxLNds5KQhzrjPQN7VPl0RwwceUHjM6DI0wyki1N1CaBFJJhiB3EwIu
	 k42VOO9mTdCECR3/BbgjBvt3x2wQJBS1fUlYzqY+qLz5tbxqjfUI3uMTI+W2iKVhdITl1
	 Vyt5fpjcLrHrERG4vi1L1XPLyAV+XMn1LvYYqHuCuUrs999UyXhaiLBYTMlMX3dn/TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=hUBPSmqQ;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CA1606A338
	for <bridge@lists.linux.dev>; Sat, 14 Nov 2026 22:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6CA1606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=hUBPSmqQ
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c506a231b88so334043666b.3
        for <bridge@lists.linux.dev>; Sat, 14 Nov 2026 14:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794696806; x=1795301606; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zfcSy76pYo4+KmPuxjlwpmlNL9IIkiVdSH2l/JZ+u80=;
        b=hUBPSmqQlfaACUUYNBX56s2xaSN4fS9n46zwW0bNfD1i555q4Gs5vzqS3TFTQY/JZN
         UD0L7hTj6J1rKFT48xvLaPRxMHF0OSW7mEHlrkMchSjh9f4OOlggZBDKV2P+p0v7Gv5V
         YfVc5G3ZVamYR7B8JrIihhHqDU3aFkpvA6s5ORJBlLWn8Bm4SCibc6WoSu2SCKhbKaNu
         D2qn9ZnVQdLVp80iXAi/CYsEkQ4ltIChf1DWlM1I/k5huQWPL6AVMC6S9W2kmB41mSdX
         NJ7vWKEToh6V81l3aVm2mzdxmT8KoE38kzyBih+wMwBbU8CqMnUhDz3lSRa6NdkHcrrf
         i+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794696806; x=1795301606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zfcSy76pYo4+KmPuxjlwpmlNL9IIkiVdSH2l/JZ+u80=;
        b=WvlMU67ur1NHlpZ+3kPdYvvQ8q5rSi4JqnbJd21Scil6c5mY2cFqCl7tgvHkEL0MHY
         kURG2s4H9X8Y8bApZCNlpupdHKqptSSXRuWTQgn/2lENX28/nR0BLLbghOajP1AXhpNF
         8MDLOt/bv8a+doqBbU4ySPJGVOus6ILM/jRIG4tlL8hbONXb8kEsKBYS3wslJOi67tDw
         GSuaxV6AKbDe2P5HyFEVFQ0tb5ZcACURqbftSNiBLTD2z/zarvQeU/Ih+NCu0H/Rw59n
         wA/3oyyOtEoJ6GtdV59k7uER5DalkKO6jBKgi6HO4z9yij5fY9FrrSfqSEl7IN6PLseg
         NSZA==
X-Forwarded-Encrypted: i=1; AL+hErE4XTJiQ3zmNA3hSkhdGC5xXyFBdJlY7HVCrGLIZpjpynJhCmCSwPR8l5n0bWJydone6Sgc3Vc=@lists.linux.dev
X-Gm-Message-State: APuU4Z/r6tqYEwGsyKicP8eSQ/a89+CMrqdvnZ28HRtDMfY2oOfZASus
	qoOn3WTsyK9iYYJAv6ln3r0sXqLCRcMLUsCcijeCzqaWONG1vBzPBz9V3XZ9ms2ZWg==
X-Gm-Gg: AYBFou0W/mXwGrdaYHax7XTytoj+CEkq8VKc/mMS0zTlXDRW4dbz5DvQQASuZBA3/C5
	jJCG6oU1d9vVK5jyS6TFiHNBBkqEpUY2E65hCsnmpYL7gEtvS1baLjgF5srykqlXZH/4LYusBLY
	A9u1czTppbCYI+M4H/5ZYtqaCFIMb6p7lHSXm7FvqsEGAZlYUjWBmFQLBg65y2D9lvSDinHT7x1
	1hZz7YxQIGM7nB7ioMt2Uurvvnb2u8Mv5WcnZ/EGSz3VD/xuSKn9eVUsAq3QoewaC/VO7sxkDbz
	qnj3k33m2B5leKYNm/bGG+sLq3bF9rND3PUg8m+h9Hbll/BlxraBhDGV4FLFvqLuR0odwBCFiz6
	AevvcIsrb6enjYZU/y+xedHs+r2BmJyqmOfS8lG7AI2EetIK2KHFLnw6o5+Uscr/UvbSoI12Le3
	IG2XbTi62IyUqZbQ5UKk5yVKlw/i/Oc53YmH8Na9ZHXSrQnZNB/VtKTqe6ZluOMLqTdLc9Ubxwh
	D5XgR4p2xpC7442Zyf9Hb1k2sUL/+H7CKf40+9H6YhHRLJtTlGJptzRpnuAgi1bbx7OmBC20e8g
	v0ihyFIqJM7J0ZgBdTCqE9nBSuwLUtK8R8g5wwLX9OCBT1Svuzedwgb907JbQs8GUKhIMz4KzAG
	dxRKX7vf05Y9um+RYRrQI2g8ElIdRsvxcFl+t+j3T2lcse2eBr6FkjwNC5J92XX3IsYn/vCwXo7
	moCo3/vZDB7HJp3mRHXs+xnH6Aq2pk5fCzeOGyDteNzO5buPg3z0rmYBilL7zLXpuAGOAhf2Dbr
	PZJvZ9wOagoPppSzPccj49s+I5dfs5Q0xcoONOksTn+hc7UwQT4f5ZnIXvpMij19kvRkz2qSqBO
	89wWPivKu97fQFYndK+GpFWT/PgqO5VYVKTlNs37tX1Mgu6zRSdnsl9s/SIkjKyCb80cjXcV0JP
	IFwDws7gWww==
X-Received: by 2002:a17:906:9fcd:b0:c50:9149:48e4 with SMTP id a640c23a62f3a-c50963db437mr499324666b.11.1794696806243;
        Sat, 14 Nov 2026 14:53:26 -0800 (PST)
Received: from Desktop.fritz.box (p200300f24709e8006da21e9e53ecde1c.dip0.t-ipconnect.de. [2003:f2:4709:e800:6da2:1e9e:53ec:de1c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b56df7sm262479666b.47.2026.11.14.14.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 14:53:25 -0800 (PST)
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
Subject: [PATCH net-next v2 1/2] net: bridge: switchdev: add br_switchdev_fdb_find_port()
Date: Sat, 14 Nov 2026 23:53:22 +0100
Message-ID: <ce6ea6a96b66c70b882832a07c36caf12193c6c2.1794696609.git.julius@bairaktaris.de>
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

Add an RCU lookup that returns the device br_switchdev_fdb_notify()
reports an FDB entry on: its port, or the bridge for a local entry. It
does not find the entries whose addition the bridge does not notify to
switchdev: locked entries, entries the user added as "master dynamic",
and entries a switchdev driver learned.

A switchdev driver that handles FDB events from a workqueue cannot take
RTNL for br_fdb_find_port(), and has to look up where the bridge has an
entry when it handles an event. The next patch uses the helper for this
in DSA. The filter of br_switchdev_fdb_notify() moves into a helper that
both use, with no functional change; the learning path does not change.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
Changes in v2:
- Kernel-doc and message state what the lookup returns: the bridge for
  a local entry, the port otherwise, nothing for locked, "master
  dynamic" and driver-learned entries.
- Report whether the entry was added by the user.
- The message names the DSA caller.

 include/linux/if_bridge.h | 14 ++++++++
 net/bridge/br_switchdev.c | 72 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 75673b8bffcb8..027147d618a4e 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -201,6 +201,20 @@ static inline int br_mst_get_state(const struct net_device *dev, u16 msti,
 }
 #endif
 
+#if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_NET_SWITCHDEV)
+struct net_device *br_switchdev_fdb_find_port(struct net_device *br_dev,
+					      const unsigned char *addr,
+					      u16 vid, bool *added_by_user);
+#else
+static inline struct net_device *
+br_switchdev_fdb_find_port(struct net_device *br_dev,
+			   const unsigned char *addr, u16 vid,
+			   bool *added_by_user)
+{
+	return NULL;
+}
+#endif
+
 #if IS_ENABLED(CONFIG_BRIDGE)
 struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 				    const unsigned char *addr,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 10f3aea6a1f82..f832657c0c22e 100644
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
@@ -156,9 +152,67 @@ br_switchdev_fdb_notify(struct net_bridge *br,
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
+ * br_switchdev_fdb_find_port - find the device a switchdev entry is reported on
+ * @br_dev: the bridge device
+ * @addr: the MAC address of the entry
+ * @vid: the VLAN of the entry
+ * @added_by_user: set to whether the entry was added by the user, may be NULL
+ *
+ * Must be called under RCU; the device is valid until the read-side critical
+ * section ends.
+ *
+ * Return: the device that br_switchdev_fdb_notify() reports the entry for
+ * @addr and @vid on: its port, or @br_dev for a local entry. NULL if there is
+ * no such entry, or if it is locked, was added with "master dynamic", or was
+ * learned by a switchdev driver, whose addition br_switchdev_fdb_notify()
+ * does not report.
+ */
+struct net_device *br_switchdev_fdb_find_port(struct net_device *br_dev,
+					      const unsigned char *addr,
+					      u16 vid, bool *added_by_user)
+{
+	const struct net_bridge_port *p;
+	struct net_bridge_fdb_entry *f;
+	bool by_user;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "suspicious use outside RCU");
+
+	if (!netif_is_bridge_master(br_dev))
+		return NULL;
+
+	f = br_fdb_find_rcu(netdev_priv(br_dev), addr, vid);
+	if (!f || !br_switchdev_fdb_notifies(f))
+		return NULL;
+
+	by_user = test_bit(BR_FDB_ADDED_BY_USER, &f->flags);
+	if (!by_user && test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags))
+		return NULL;
+
+	if (added_by_user)
+		*added_by_user = by_user;
+
+	if (test_bit(BR_FDB_LOCAL, &f->flags))
+		return br_dev;
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

