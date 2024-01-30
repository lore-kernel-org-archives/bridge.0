Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5864371B4C
	for <bridge@lists.linux.dev>; Tue, 30 Jan 2024 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645989; cv=none; b=JjgaS0t8Xcd2AmSrGU9lk4P1vrDrFjlfV4LpVbzvJ4qVf73iHNpdXXmXNzk1R3CuiIMhp8nWmbk4H1fPkC0whXz+iTOsX3Ig8Iyh9VlkmP+WNgYuWaCOSpNXk1ZriMDLjyHZAx1eOI9OCiWcaii0n817gCE5koG7UHoZXz24iGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645989; c=relaxed/simple;
	bh=t6uAJFMViO+HMxmFBNUKRYgjnERIYOpZmhn/2AN2c8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrBPNE2ULcBlTC+81UGs1VMw2qBtC9DinHojvhR27aomElHTPeXrFS/1k/zich8SZC/Qe1msorTh9vNnmgzpCoPflixWKryPpGdGO/12nx72yk/mxylBdiyoUB/+AoWbNctAtbspgVzlDlXCtufp+SrOwAxY3SOh/A5Ld0wQb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=QUc+36T7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="QUc+36T7"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5101f2dfdadso7487873e87.2
        for <bridge@lists.linux.dev>; Tue, 30 Jan 2024 12:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706645985; x=1707250785; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fPaQcwVDm1hs7rZIx/MRtZyeT8rTUy8NvGG7kGqel6E=;
        b=QUc+36T7HpksNh0bKxrJrcWhfpy0YP1mTyhlccE6hadFoltg5ZMs5r01ZjG6bm3A2F
         zAggpivEusHtO9F7Wt04wAVQWr/oM+5mPRRiLgJLSJ7f3lKxLObfJmuNKROw7QXytvBU
         vuNimRIjts1vT+U8e/rmvphgA0bQnFT6+n9JlCcY4omCmkexmUSSbtVAeiUP2Kay2ATt
         64eyj1DN09gz6xUAGAgedhX5qAVtVmQFwgO5XqelxJlqGL5pbTwQgwN3Sz1dRFwl0oBv
         jDfEXp12/1wCsoVAXjHctQQChmMDs14gsVm93LxbadPDtQUnlA/O48hCHWM0/FTnxcNq
         zaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706645985; x=1707250785;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPaQcwVDm1hs7rZIx/MRtZyeT8rTUy8NvGG7kGqel6E=;
        b=h2vxhUvIn2xdxsDpWuoYc8536pXoy1udH8TsPUwh3OEmgLWL5Ox7IXe/vfZM6d69F7
         sdi/ab9wC0NUl3peyXbH1U2AQ+Iy/WItLDe73xPHnca25Cm0qI8881QqiW4JnhOQAZIr
         CoQ2mw4h9RoBhuLeQUhO8x8q+Nax00a9gYFP27vP5MPq6and7QI+EmkcezUsrZ0I+Orp
         vQX//wakgjyf0iNeAaFPAaM33e0USMm/fm+KSziX4e622yNt9vTYAajUvrqJQ1NvuT9e
         tBjtMWjH0j6G4wKGH80hkaA/ikYWRS4S0g4KmpMPASrXJU9SdV6cIcLAanSpaQdfMK6d
         pa0A==
X-Gm-Message-State: AOJu0YwKCA/xeVNr7hPqo38UcBV6T6pu0G0YClOtOO9WBnCrwkn7HNpr
	mBWHX0M3tfCoCXHqDGFudnWaapITwdjMhtM+g8dUj/809OsQwCy5Q5WoBbXEsUw=
X-Google-Smtp-Source: AGHT+IHVFNSV8RrsmxF7rB9qO1wDYJNJ81lroNkUywKlt3ACrS5kOQcymNfQt+XC6TRgrh/CGOyWFQ==
X-Received: by 2002:ac2:5f0f:0:b0:511:17f1:8e09 with SMTP id 15-20020ac25f0f000000b0051117f18e09mr2478972lfq.35.1706645985304;
        Tue, 30 Jan 2024 12:19:45 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id eo15-20020a056512480f00b0051011f64e1bsm1553239lfb.142.2024.01.30.12.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:19:44 -0800 (PST)
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
Subject: [PATCH v2 net-next 1/5] net: switchdev: Wrap enums in mapper macros
Date: Tue, 30 Jan 2024 21:19:33 +0100
Message-Id: <20240130201937.1897766-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130201937.1897766-1-tobias@waldekranz.com>
References: <20240130201937.1897766-1-tobias@waldekranz.com>
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

