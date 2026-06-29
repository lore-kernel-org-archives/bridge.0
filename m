Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A53381AFC
	for <bridge@lists.linux.dev>; Mon, 29 Jun 2026 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736407; cv=none; b=Rh5lZnxt+h5URx9i56IWHLWefOQZmpbmG8EFA88Ddx64m9Bdvm/1S7hK6Yp0RniuJoOWeDKJeTykMJt3DEi35O+uB/Rz1H7xyy7r5tti+rnWedhGhc4wKubbQpp+K31Of9A4j3bxr6PCe/99Y4zmVAYDeEQ8S3ehvWIvzIhFef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736407; c=relaxed/simple;
	bh=ZCRB2ICnhy+yorYHit6z9ApMAWj8ye6ZQlK3b8ptewQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DocIZS++Z/ETYV+5MFaZXRfnG4BvrMC8Vn6zl0B37n2PncgxZp3V2+e+4I83dYAE00QpPsCXUFufN6L1TeVQCgSmOb6E+XKGQ03YB1zqBUdaKms2KzNvXEfv3cZoHzOl9xe7gA3MqNsBr3MuK/KgSZPDm1Ut44ftfqvGaNVyEcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV04Ch0k; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV04Ch0k"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso6061670a12.2
        for <bridge@lists.linux.dev>; Mon, 29 Jun 2026 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782736404; x=1783341204; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyKouin1u5dLTjGH2vHTEIBjw8XShphfnZNY49Ba01Y=;
        b=TV04Ch0kNxcJok6ftw1s7HfCj3PVM5gSdwCE4eTw9fmsRl4d5THGJCyu0L3V9EHuN4
         dLSt3CO+Ee+jepY+ihZf8JL4QBBp5Vse4XGcXpPIzw0A9XjKUFvXX/D2h+AW9bTFBxH1
         N3TPBpwrXaymt+QI5kF4bLO2U74ymSvxRWeSTEo3dG+3HDIChN/U3+PYbHSo0s++BI4A
         EHQQY2QaE0JROtg1aE2nH7IfMdQRGULYieirooqaZfRiBtbiQ3XwQuNSceVOCV0B9YAT
         jiH1QuumOpPRnd78ER8tzuxOE68G/929nQc1J5YYHvOusitICosxGQ5veWIggSBAkVMa
         +XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736404; x=1783341204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IyKouin1u5dLTjGH2vHTEIBjw8XShphfnZNY49Ba01Y=;
        b=CuOhstbeKdpWmzjcv1zDeKussILpIc318CjdXSO6Z2ilaIYnzTW2jDB7xuOHwoKs4B
         KCpl2b8Sk5F4vQo5iVRoXhd10n7w6W/3MQ1RASJZ+CVAoKBZfkBgB3p4kWLBOWDdxfPu
         wBRYLWG5y9ezcNhmdbiRG7MwFP3OwZbo70k3l+6j8KmsM/RExztf8JU4zyGEBvDFqu+/
         gOwEk0IauP0dQilnpiLkDh2hPhxzEEPEmlxzaT1jZ46SWBzDTBpLGirf2jp3NbrN5FSz
         40H93mPOcDrg1+AGaeZtUI2ADdZkvttAd1gTYWmVveX3f7IYCnmneyKro/Q0OAZ31Ahx
         /MRg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/Cy2ZrHj7L+nXpslKSIlmxzsFJw3d8fHMu+kUaaZKTJFVxcQXftLBm9AGuk+cXDh7ht+82gE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3dmIJJK9Cjzxewyy9FoVihZG6Z8O4zdR39CPNsBTvmIuw8TV5
	dDn5RUvNMzrR0PrOOCJY2OAQ2EWiRPqvIJvIHD7Q4nZwp5TUz7H/Fvf6
X-Gm-Gg: AfdE7clkEQ5112rkqKOdrQRGZSzDjT7Utr2Nj71YlI1yFf52Qtl8qoZknK7ITNaFfy6
	U8kQChmXTdLg1JYxOgmrjDfxp8PJ/aQsAJs/yNoGulJ9JI+rrcrEfQoLQ7ZRRMYyd3YLUzDi80S
	a8XyYDqBa+D2G+01U5CIBVFp5Z4KRVHBoROSfyB2VyhkqmmrfWs0Sx7JeRxPBQ0y3Jdh8rD05AW
	k91LM4RdNIzs158oagJWnYApYRoyDoraYsolF8srn0IGxwp87uhCKFQGpyVAfBK5ZRE5Uorq9Ls
	4hwcIoAUN/rpyf5WaH9XhqDbcWwU5lCsv7crNDUX59wd4Mw7/S3Tui9SqqL8VTwSr/eyHS/gAoT
	hLMpSCFmN8pXDdtqVEObEF5vztsyK4+wjr3uc5yEH7T+doRgKkWw2N1IDK9NJ2zuuqiK5raaPaw
	u4Ce6nlhc=
X-Received: by 2002:a17:907:9452:b0:c12:7e9f:5ae3 with SMTP id a640c23a62f3a-c127e9f5b7bmr43558466b.15.1782736403905;
        Mon, 29 Jun 2026 05:33:23 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05c22sm773866566b.39.2026.06.29.05.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:33:22 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	idosch@nvidia.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bridge@lists.linux.dev,
	coreteam@netfilter.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	rchen14b@gmail.com,
	lorenzo@kernel.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH 2/5] net: bridge: add flow offload helpers
Date: Mon, 29 Jun 2026 14:32:50 +0200
Message-ID: <20260629123253.1912621-3-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629123253.1912621-1-pawlik.dan@gmail.com>
References: <20260629123253.1912621-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three helpers that expose the bridge state needed by nft_flow_offload
without requiring callers to include net/bridge/br_private.h. Each
performs a single br_port_get_rcu() lookup:

 - br_fdb_has_forwarding_entry_rcu(): resolves the VLAN id for the packet
   (skb tag or PVID when filtering is on, 0 otherwise) then checks whether
   the bridge FDB contains a forwarding entry (dst != NULL, non-local) for
   the resulting MAC/VLAN pair.

 - br_vlan_get_offload_info_rcu(): when VLAN filtering is active, returns
   the VLAN id (skb tag or PVID) and writes the bridge VLAN protocol to
   *proto in a single port lookup. Returns 0 when filtering is off.

 - br_vlan_is_enabled_rcu(): returns true when VLAN filtering is enabled
   on the bridge a port device belongs to.

Based on MediaTek SDK patches by Bo-Cun Chen <bc-bocun.chen@mediatek.com>
and the OpenWrt bridge offload series by Ryan Chen <rchen14b@gmail.com>.
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
 include/linux/if_bridge.h | 23 ++++++++++++++++++++
 net/bridge/br_fdb.c       | 32 ++++++++++++++++++++++++++++
 net/bridge/br_vlan.c      | 45 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 75673b8bffcb..c1cae54749c5 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -148,6 +148,9 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
 		     struct bridge_vlan_info *p_vinfo);
 int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 			 struct bridge_vlan_info *p_vinfo);
+u16 br_vlan_get_offload_info_rcu(const struct net_device *dev,
+				 const struct sk_buff *skb, __be16 *proto);
+bool br_vlan_is_enabled_rcu(const struct net_device *dev);
 bool br_mst_enabled(const struct net_device *dev);
 int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids);
 int br_mst_get_state(const struct net_device *dev, u16 msti, u8 *state);
@@ -184,6 +187,17 @@ static inline int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 	return -EINVAL;
 }
 
+static inline u16 br_vlan_get_offload_info_rcu(const struct net_device *dev,
+						const struct sk_buff *skb,
+						__be16 *proto)
+{
+	return 0;
+}
+
+static inline bool br_vlan_is_enabled_rcu(const struct net_device *dev)
+{
+	return false;
+}
 static inline bool br_mst_enabled(const struct net_device *dev)
 {
 	return false;
@@ -209,6 +223,8 @@ void br_fdb_clear_offload(const struct net_device *dev, u16 vid);
 bool br_port_flag_is_set(const struct net_device *dev, unsigned long flag);
 u8 br_port_get_stp_state(const struct net_device *dev);
 clock_t br_get_ageing_time(const struct net_device *br_dev);
+bool br_fdb_has_forwarding_entry_rcu(const struct net_device *dev,
+				     const struct sk_buff *skb, const u8 *addr);
 #else
 static inline struct net_device *
 br_fdb_find_port(const struct net_device *br_dev,
@@ -237,6 +253,13 @@ static inline clock_t br_get_ageing_time(const struct net_device *br_dev)
 {
 	return 0;
 }
+
+static inline bool br_fdb_has_forwarding_entry_rcu(const struct net_device *dev,
+						   const struct sk_buff *skb,
+						   const u8 *addr)
+{
+	return false;
+}
 #endif
 
 #endif
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e4570bbed854..3161c2689f6a 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -267,6 +267,38 @@ struct net_bridge_fdb_entry *br_fdb_find_rcu(struct net_bridge *br,
 	return fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
 }
 
+/**
+ * br_fdb_has_forwarding_entry_rcu - check if a MAC can be forwarded by the bridge
+ * @dev: bridge port network device
+ * @skb: packet buffer (used to determine VLAN id)
+ * @addr: destination MAC address
+ *
+ * Resolves the VLAN id for @skb on @dev (skb VLAN tag when present, PVID
+ * when VLAN filtering is enabled, 0 otherwise) then checks whether the bridge
+ * FDB contains a forwarding entry (dst != NULL, not a local/self entry) for
+ * @addr and that VLAN id. Single br_port_get_rcu() lookup.
+ * Must be called under RCU read lock.
+ */
+bool br_fdb_has_forwarding_entry_rcu(const struct net_device *dev,
+				     const struct sk_buff *skb, const u8 *addr)
+{
+	struct net_bridge_port *port = br_port_get_rcu(dev);
+	struct net_bridge_fdb_entry *fdb;
+	u16 vid = 0;
+
+	if (!port)
+		return false;
+	if (br_opt_get(port->br, BROPT_VLAN_ENABLED)) {
+		if (skb_vlan_tag_present(skb))
+			vid = skb_vlan_tag_get_id(skb);
+		else
+			br_vlan_get_pvid_rcu(dev, &vid);
+	}
+	fdb = br_fdb_find_rcu(port->br, addr, vid);
+	return fdb && fdb->dst;
+}
+EXPORT_SYMBOL_GPL(br_fdb_has_forwarding_entry_rcu);
+
 /* When a static FDB entry is added, the mac address from the entry is
  * added to the bridge private HW address list and all required ports
  * are then updated with the new information.
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 5560afcaaca3..0b296362adf7 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1559,6 +1559,51 @@ int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 }
 EXPORT_SYMBOL_GPL(br_vlan_get_info_rcu);
 
+/**
+ * br_vlan_get_offload_info_rcu - get VLAN id and protocol for bridge flow offload
+ * @dev: bridge port network device
+ * @skb: packet buffer
+ * @proto: output for the bridge VLAN protocol (set only when return value != 0)
+ *
+ * When VLAN filtering is enabled, resolves the VLAN id for flow offload (skb
+ * VLAN tag id if present, PVID otherwise) and writes the bridge VLAN protocol
+ * to @proto. Returns 0 when filtering is off or @dev is not a bridge port.
+ * Single br_port_get_rcu() lookup. Must be called under RCU read lock.
+ */
+u16 br_vlan_get_offload_info_rcu(const struct net_device *dev,
+				 const struct sk_buff *skb, __be16 *proto)
+{
+	struct net_bridge_port *port = br_port_get_rcu(dev);
+	u16 vid = 0;
+
+	if (!port || !br_opt_get(port->br, BROPT_VLAN_ENABLED))
+		return 0;
+	if (skb_vlan_tag_present(skb))
+		vid = skb_vlan_tag_get_id(skb);
+	else
+		br_vlan_get_pvid_rcu(dev, &vid);
+	if (vid)
+		*proto = port->br->vlan_proto;
+	return vid;
+}
+EXPORT_SYMBOL_GPL(br_vlan_get_offload_info_rcu);
+
+/**
+ * br_vlan_is_enabled_rcu - check if VLAN filtering is active on a port's bridge
+ * @dev: bridge port network device
+ *
+ * Returns true if VLAN filtering is enabled on the bridge @dev belongs to.
+ * Returns false when @dev is not a bridge port or filtering is off.
+ * Must be called under RCU read lock.
+ */
+bool br_vlan_is_enabled_rcu(const struct net_device *dev)
+{
+	struct net_bridge_port *port = br_port_get_rcu(dev);
+
+	return port && br_opt_get(port->br, BROPT_VLAN_ENABLED);
+}
+EXPORT_SYMBOL_GPL(br_vlan_is_enabled_rcu);
+
 static int br_vlan_is_bind_vlan_dev(const struct net_device *dev)
 {
 	return is_vlan_dev(dev) &&
-- 
2.54.0

