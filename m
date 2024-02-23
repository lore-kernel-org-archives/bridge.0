Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0F979DDC
	for <bridge@lists.linux.dev>; Fri, 23 Feb 2024 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688812; cv=none; b=B6Jad73oJUDeqfSdiH/eF/80ccFA2yJ48/24c3oTnipMVzYvRAP6twRb2ZXmKK+E7uQgUAdyBRN0iw1SLnzXBmz7bRqFG8fxXwp5ItCnpJTCZopklBTmGbwExxBaaXrySrD2t+Sh3eWF82I3gNgDaIpJnGrJjEvHZLXIimHdz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688812; c=relaxed/simple;
	bh=n1GgHYtHsxsrAzgKRx3jPsMiLP1I7jvaanq3ckoFtwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7rPjsfS92oU0iavMlWmdNvO63lBzDVODcKaOEGYdYOV/BPU+2DTnUK6MqMyeBLLbCmqtxhpqKDIfPZ/9sj8EMIcuTI2CNfrr9TgmV3h/7qhczOoFC+PBynOnyjlD8szu/8b3VtGmjxvqzI74B4+VpJMqu88UF0UaLbJs4/Rkck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=l/Pxz22r; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="l/Pxz22r"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512a65cd2c7so1115959e87.0
        for <bridge@lists.linux.dev>; Fri, 23 Feb 2024 03:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708688809; x=1709293609; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zkDAooeQBr5rThauoM1g1MywPOKO4Mf+GehhCfGa7To=;
        b=l/Pxz22rHvXpKgu919pupDEFMDKCdHRyTSnolTvP830t27RXvOa86pgXGB6L1VT0VG
         o7F9t9zA2b7hlBecBK6mGtxn9kgZdu6N+ifMgznesLByYDmjjpw7PHQ483Rgucf6fNhv
         PQH+0xZnl94ncEL1vAggHU0Xx3coi/olSt+uUK0z6B+PrbSUWgduLzStzdVVjzKRRdUe
         j8jIIXIEscO45S1/S6cR8Bo0ZDHUTmu5NKE4Ctn9OU5uvcpONa3LaupVJmkI+7rzGHiO
         nsohZoyVuZw4LvSnWesWAdMTZHahIN1o75houvuvbJtkU8bxrGTyh2HE3tcIuDj3ylAd
         mwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688809; x=1709293609;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zkDAooeQBr5rThauoM1g1MywPOKO4Mf+GehhCfGa7To=;
        b=ohKeC4I4OqYljUXRdTJDGQjqz0jI8F9lW7xiyvobG90oFmjB5XAgV0KRZeyDfc9sCc
         Te8gCT+DRDW2OuAn++IKmdnM6TJRMcPP5brf067XIhKV6BQu0ifyXQztWaA3aGICUKIJ
         SrwsDDTEplLAUEoYcrbIzkqN3nPTyW+A/3fkyI2DPBZQt448DEvsl7toVddlV/DY8ZBh
         XXDJ7AkmiXqKu1w1qb+Ayf4g+VZxgWI+Vo/o+vrBkVq9QPGIUoIWv21u43gLP66j5zOo
         SlBhqSLNASRxDQj6g3c/QW9Wl0ba0c0ml5JWOxQWjlnsUMcwTG+Il8A3qspLlnFYSHU0
         NeLw==
X-Forwarded-Encrypted: i=1; AJvYcCV/HSJqUuiCMClsGEESMpmYiXxuaxi9D6fKfeGV0zgyjFLiQ7ECu6xOnOnZdyrTYKwQKJXxiMKvbaj3KAd501fSI57hZQgJ
X-Gm-Message-State: AOJu0YzYrgi6qQZ0s0j0OrRwobeASo9Dz3v6/Qu0OW03AlzbXkjripln
	63kQzCCs0Hvit/ngAXzGUFFJfofg5KiNKmnzvD7FTZPnJtnCURfFz+CHsoSMIQk=
X-Google-Smtp-Source: AGHT+IGDDaf54W831L5Ts8Flm3Ec9j0oLrGHQ4QMtQP0ylEjumhcZqW25LR2wJeBe/FFYgdBRSZ+Mg==
X-Received: by 2002:ac2:4d03:0:b0:512:b24c:dba with SMTP id r3-20020ac24d03000000b00512b24c0dbamr1074063lfi.60.1708688809124;
        Fri, 23 Feb 2024 03:46:49 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b00512d180fd3asm1011694lfq.144.2024.02.23.03.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:46:48 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 1/4] net: switchdev: Wrap enums in mapper macros
Date: Fri, 23 Feb 2024 12:44:50 +0100
Message-Id: <20240223114453.335809-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223114453.335809-1-tobias@waldekranz.com>
References: <20240223114453.335809-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

In order to avoid having to maintain separate mappings from enum
values to strings, wrap enumerators in mapper macros, so that
enum-to-string tables can be generated.

This will make it easier to create helpers that convert switchdev
objects to strings.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h | 113 ++++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 45 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 8346b0d29542..86298a21c6c8 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -16,21 +16,28 @@
 #define SWITCHDEV_F_SKIP_EOPNOTSUPP	BIT(1)
 #define SWITCHDEV_F_DEFER		BIT(2)
 
+#define SWITCHDEV_ATTR_ID_MAPPER(_fn)	\
+	_fn(UNDEFINED),			\
+	_fn(PORT_STP_STATE),		\
+	_fn(PORT_MST_STATE),		\
+	_fn(PORT_BRIDGE_FLAGS),		\
+	_fn(PORT_PRE_BRIDGE_FLAGS),	\
+	_fn(PORT_MROUTER),		\
+	_fn(BRIDGE_AGEING_TIME),	\
+	_fn(BRIDGE_VLAN_FILTERING),	\
+	_fn(BRIDGE_VLAN_PROTOCOL),	\
+	_fn(BRIDGE_MC_DISABLED),	\
+	_fn(BRIDGE_MROUTER),		\
+	_fn(BRIDGE_MST),		\
+	_fn(MRP_PORT_ROLE),		\
+	_fn(VLAN_MSTI),			\
+	/*  */
+
+#define SWITCHDEV_ATTR_ID_ENUMERATOR(_id) \
+	SWITCHDEV_ATTR_ID_ ## _id
+
 enum switchdev_attr_id {
-	SWITCHDEV_ATTR_ID_UNDEFINED,
-	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
-	SWITCHDEV_ATTR_ID_PORT_MST_STATE,
-	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
-	SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
-	SWITCHDEV_ATTR_ID_PORT_MROUTER,
-	SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
-	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
-	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL,
-	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
-	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
-	SWITCHDEV_ATTR_ID_BRIDGE_MST,
-	SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
-	SWITCHDEV_ATTR_ID_VLAN_MSTI,
+	SWITCHDEV_ATTR_ID_MAPPER(SWITCHDEV_ATTR_ID_ENUMERATOR)
 };
 
 struct switchdev_mst_state {
@@ -69,18 +76,25 @@ struct switchdev_attr {
 	} u;
 };
 
+#define SWITCHDEV_OBJ_ID_MAPPER(_fn)	\
+	_fn(UNDEFINED),			\
+	_fn(PORT_VLAN),			\
+	_fn(PORT_MDB),			\
+	_fn(HOST_MDB),			\
+	_fn(MRP),			\
+	_fn(RING_TEST_MRP),		\
+	_fn(RING_ROLE_MRP),		\
+	_fn(RING_STATE_MRP),		\
+	_fn(IN_TEST_MRP),		\
+	_fn(IN_ROLE_MRP),		\
+	_fn(IN_STATE_MRP),		\
+	/*  */
+
+#define SWITCHDEV_OBJ_ID_ENUMERATOR(_id) \
+	SWITCHDEV_OBJ_ID_ ## _id
+
 enum switchdev_obj_id {
-	SWITCHDEV_OBJ_ID_UNDEFINED,
-	SWITCHDEV_OBJ_ID_PORT_VLAN,
-	SWITCHDEV_OBJ_ID_PORT_MDB,
-	SWITCHDEV_OBJ_ID_HOST_MDB,
-	SWITCHDEV_OBJ_ID_MRP,
-	SWITCHDEV_OBJ_ID_RING_TEST_MRP,
-	SWITCHDEV_OBJ_ID_RING_ROLE_MRP,
-	SWITCHDEV_OBJ_ID_RING_STATE_MRP,
-	SWITCHDEV_OBJ_ID_IN_TEST_MRP,
-	SWITCHDEV_OBJ_ID_IN_ROLE_MRP,
-	SWITCHDEV_OBJ_ID_IN_STATE_MRP,
+	SWITCHDEV_OBJ_ID_MAPPER(SWITCHDEV_OBJ_ID_ENUMERATOR)
 };
 
 struct switchdev_obj {
@@ -209,27 +223,36 @@ struct switchdev_brport {
 	bool tx_fwd_offload;
 };
 
+#define SWITCHDEV_TYPE_MAPPER(_fn)	\
+	_fn(UNKNOWN),			\
+					\
+	_fn(FDB_ADD_TO_BRIDGE),		\
+	_fn(FDB_DEL_TO_BRIDGE),		\
+	_fn(FDB_ADD_TO_DEVICE),		\
+	_fn(FDB_DEL_TO_DEVICE),		\
+	_fn(FDB_OFFLOADED),		\
+	_fn(FDB_FLUSH_TO_BRIDGE),	\
+					\
+	_fn(PORT_OBJ_ADD),		\
+	_fn(PORT_OBJ_DEL),		\
+	_fn(PORT_ATTR_SET),		\
+					\
+	_fn(VXLAN_FDB_ADD_TO_BRIDGE),	\
+	_fn(VXLAN_FDB_DEL_TO_BRIDGE),	\
+	_fn(VXLAN_FDB_ADD_TO_DEVICE),	\
+	_fn(VXLAN_FDB_DEL_TO_DEVICE),	\
+	_fn(VXLAN_FDB_OFFLOADED),	\
+					\
+	_fn(BRPORT_OFFLOADED),		\
+	_fn(BRPORT_UNOFFLOADED),	\
+	_fn(BRPORT_REPLAY),		\
+	/*  */
+
+#define SWITCHDEV_TYPE_ENUMERATOR(_id) \
+	SWITCHDEV_ ## _id
+
 enum switchdev_notifier_type {
-	SWITCHDEV_FDB_ADD_TO_BRIDGE = 1,
-	SWITCHDEV_FDB_DEL_TO_BRIDGE,
-	SWITCHDEV_FDB_ADD_TO_DEVICE,
-	SWITCHDEV_FDB_DEL_TO_DEVICE,
-	SWITCHDEV_FDB_OFFLOADED,
-	SWITCHDEV_FDB_FLUSH_TO_BRIDGE,
-
-	SWITCHDEV_PORT_OBJ_ADD, /* Blocking. */
-	SWITCHDEV_PORT_OBJ_DEL, /* Blocking. */
-	SWITCHDEV_PORT_ATTR_SET, /* May be blocking . */
-
-	SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE,
-	SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE,
-	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
-	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
-	SWITCHDEV_VXLAN_FDB_OFFLOADED,
-
-	SWITCHDEV_BRPORT_OFFLOADED,
-	SWITCHDEV_BRPORT_UNOFFLOADED,
-	SWITCHDEV_BRPORT_REPLAY,
+	SWITCHDEV_TYPE_MAPPER(SWITCHDEV_TYPE_ENUMERATOR)
 };
 
 struct switchdev_notifier_info {
-- 
2.34.1

