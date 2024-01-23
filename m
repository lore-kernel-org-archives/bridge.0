Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3160DE9
	for <bridge@lists.linux.dev>; Tue, 23 Jan 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024252; cv=none; b=hKAp7bBmnckFy4fOjPWrmJ2rpTg7GEdjIShUvsPGDXZ7See0xNtA5vk3TDsGUnRX5nBfd04d2xChvEisvdIQxYoVSIuhqVC+tn2Zjr15+lOoYpgbh1V2TDiCmyaTZ52nLlat4Vof5aLonGyup7FQTLAmlMPvqY5GAFPxpx4rR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024252; c=relaxed/simple;
	bh=t6uAJFMViO+HMxmFBNUKRYgjnERIYOpZmhn/2AN2c8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fxa5punrb3tRIFqqbwSd+9ksKNxQDFll/vImao1VjRtqjaadrASyj7JDBSLjr8ck1at7llw2Sfyzk4yDTZGsmlaUoWBwzRewLefnNgobU4jdWEwCx2b72uR2TbbsrQFv3f68iTAgZAqJqt1a50bilb/ZKdrrk3IfwXhYIw29FOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=XjIYaRBJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="XjIYaRBJ"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e78f1f41fso4587325e87.2
        for <bridge@lists.linux.dev>; Tue, 23 Jan 2024 07:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706024248; x=1706629048; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fPaQcwVDm1hs7rZIx/MRtZyeT8rTUy8NvGG7kGqel6E=;
        b=XjIYaRBJq8cm+lZUNmrn7wwFVhe5EpkCVhg06ABZk7DO5NzwXdPRa/9ZwWVlL96sue
         VszJRysYAmfLlG8L78JwS2bas45zKlXkfMw+q78d7bivUYUQ5cfRdTFSclzoOLfvMSod
         AwOZ8RzptAi91zuzp+RXOOrJ+bOQGa9sIiRCT6DmQnKWWRrgeaLCoASuSPgc2DK441j/
         NDmbjK+c1vdsjNApmPKiyidR6fBdI41JzivyaRUjTKnWurd2H4yumTDlyu8wA6snEueU
         deSaeNrkkJx97UeSEWSX65ELno3iUPDdw5OYg5z7m0+PL6v4By4BzgxX6a2/TWSYpvYe
         Y9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024248; x=1706629048;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPaQcwVDm1hs7rZIx/MRtZyeT8rTUy8NvGG7kGqel6E=;
        b=si+KWT/tNGwIcO6XxRWusdq+IZgRyR55L511VY6pQgAobcRRbdcOWjkIFoxQ7GmEYZ
         JbdNdApR9wKPlnLdEO5czhgLcN8bxIxM0Tuq+BZA41QP46pVtiU0F2qCV5sqyW3ffigj
         4jOhprEK7HYQmSmjLKd+ffKIasE+9E6YdnnlZu+7xu9Ck9Xtss9otQH5hqWiF8a/qfMZ
         EpFbfSomD9kQNJcxSt56Xcm1BP/rO7KwcprM5HRg0ubynYHVgvkxTV41Kb/w1gaa7/eq
         br8qyvFXIv8/15y8fCedQuzbwpi5SuRcH40OxdoPEWCzGamSImHBiNK8KTzjT9igCGTl
         b0aA==
X-Gm-Message-State: AOJu0YxrmgVE/VRR32JqiR/rQkfoiNxdVaOO+xIB+mMen3CHt/tf+Uq4
	wkXt9oJeyOLqeyx9k1ScfnkqvIOod3aBCTFW8S+u7wuxFDYGM3skOLFrStRgtnU=
X-Google-Smtp-Source: AGHT+IFPao4jpCTPjIUWAvgQ5SK98Il76XVbN67TXhfZYef6P15A89B9DQmxDv6/+zvp20DDi5NJVg==
X-Received: by 2002:a05:6512:1243:b0:50e:4fb2:a65d with SMTP id fb3-20020a056512124300b0050e4fb2a65dmr3212895lfb.6.1706024247984;
        Tue, 23 Jan 2024 07:37:27 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id h23-20020a19ca57000000b0050ee3e540e4sm2386790lfj.65.2024.01.23.07.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:37:27 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: jiri@resnulli.us,
	ivecera@redhat.com,
	netdev@vger.kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] net: switchdev: Wrap enums in mapper macros
Date: Tue, 23 Jan 2024 16:37:03 +0100
Message-Id: <20240123153707.550795-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123153707.550795-1-tobias@waldekranz.com>
References: <20240123153707.550795-1-tobias@waldekranz.com>
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
index a43062d4c734..76eabf95c647 100644
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

