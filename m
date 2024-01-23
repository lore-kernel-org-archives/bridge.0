Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183460DEC
	for <bridge@lists.linux.dev>; Tue, 23 Jan 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024252; cv=none; b=MXa0vy8PDKKGBWeP7b4oHe7ldXnwlR60efMmO1sOqhcN7ko06hSqqWCEDQJMYO4n9Tv+k5UvvIR3jCw4gZjv/c0o0hb/rcr2R2raM3+EyRDNraIrNLGxLjK2PwUjYblzc4MbG8W7nS6xosrxOpH5lDW+pTZ12oy3EsJXoDmDGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024252; c=relaxed/simple;
	bh=jCjAbkJtriD7ifpw1qebNMZZ8BWgs8SNrPPMBTZcbt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9smIpqgo7UtqzNB84unb76sXDD2dpwRNM+Nkzpc09wCUMehZEvk5Ve3Nks4SHpI2MUVM1xYyH67Bk/AasfrWeP5XSdjO5CE+VsXyW82zT+wDFzP77T1A9W9aBngpVC9lqiLKe9e2jc3OapdOF56c1Xwrs7Trd+9n2fRNb9BuUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=3BvC2SZh; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="3BvC2SZh"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5100c3f7df1so485597e87.0
        for <bridge@lists.linux.dev>; Tue, 23 Jan 2024 07:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706024249; x=1706629049; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/kR0u0El9IYx1DrH3bIc67HSSi50NSYYpP/QMJclvuE=;
        b=3BvC2SZh5kD4g7xkVZ2poyP0Xx+leh0JhZP2PDYwLCrowB9Pa+JhxW3F2kkhWXiuCG
         fWj5V+rML9Icgw9q9NIhH0tWInTL0W+vJppVwZrrkTuIYCo0axn2E1AwLTK6hMzjPEtp
         0nwIsDtQNEnnGT5+ccMiFRv6/TUVNZTBuaUJUneOmj6TeljhJ/CNA3BHzBLxZZDXbVCD
         51FjuTIDJjh8rOBy1cS7AK68xIGeR0ZeUZs9tznLUg3n7EemKv/C957SrLrXHAOcB+Xc
         2ICbCjZyGqq6fnDrSR/GzMJlw7XzA48oyDNDYj2i0Df+1XfsLKFdHhVf4rK5a9pdqlG6
         TZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024249; x=1706629049;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/kR0u0El9IYx1DrH3bIc67HSSi50NSYYpP/QMJclvuE=;
        b=jyZsOuDAGqJwRVQwM1dckHmsOpJ8wg+dkbHQ9PRSUr1qWNV4otSo4/YyZX+swRyll3
         ZyRgZcQ6oqwmDmfGL98jBFfCEIMKCwKsipcSulzZLojrSXNebblQfYUvTkOaCp8fCSQj
         aLswWlZyE/pCsH1y8KM92dT+EhDwvYaRLsQ7ooUn9Rd4E6XJsuEejc0NvuKiZG03P9Gx
         10JWmM5N/uSCSxCIdITp8VQn0GHqATPADzYC4azmWwUBNQFiQAXv+ty0CCTG/sT/mIkG
         I56M2uh3KEpEdBInV5wuMGLJ3rEJt0E3Ab6qBR9WhdE0SfTRSgmQuYZV++atZWA+h1B1
         YcQg==
X-Gm-Message-State: AOJu0YyPiYcpChOng2sZV24dktjTKD8GNx78q7/O+mG4wnBtc9IsbjjA
	4vSrIRczWwVcUeIe/vZUcDqEois8vxh8GtSq32AfE2u2YF9dpm/mD5+Mhbch/GA=
X-Google-Smtp-Source: AGHT+IGSn5CrzlN+/laBMcMd+rqCGstwG6C5pv+WqobE9f+hz4U2/blyIRzhX9e/Kg61UXM8SOisRA==
X-Received: by 2002:a19:7001:0:b0:50e:4fa2:4fe4 with SMTP id h1-20020a197001000000b0050e4fa24fe4mr2218128lfc.66.1706024248871;
        Tue, 23 Jan 2024 07:37:28 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id h23-20020a19ca57000000b0050ee3e540e4sm2386790lfj.65.2024.01.23.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:37:28 -0800 (PST)
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
Subject: [PATCH net-next 2/5] net: switchdev: Add helpers to display switchdev objects as strings
Date: Tue, 23 Jan 2024 16:37:04 +0100
Message-Id: <20240123153707.550795-3-tobias@waldekranz.com>
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

Useful both in error messages and in tracepoints.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h       |  14 ++
 net/switchdev/Makefile        |   2 +-
 net/switchdev/switchdev-str.c | 278 ++++++++++++++++++++++++++++++++++
 3 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 net/switchdev/switchdev-str.c

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 76eabf95c647..250053748c08 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -391,6 +391,20 @@ int switchdev_handle_port_attr_set(struct net_device *dev,
 			int (*set_cb)(struct net_device *dev, const void *ctx,
 				      const struct switchdev_attr *attr,
 				      struct netlink_ext_ack *extack));
+
+/* switchdev-str.c */
+ssize_t switchdev_attr_str(const struct switchdev_attr *attr,
+			   char *buf, size_t len);
+ssize_t switchdev_obj_str(const struct switchdev_obj *obj,
+			  char *buf, size_t len);
+ssize_t switchdev_fdb_info_str(enum switchdev_notifier_type nt,
+			       const struct switchdev_notifier_fdb_info *fdbi,
+			       char *buf, size_t len);
+ssize_t switchdev_brport_str(const struct switchdev_brport *brport,
+			     char *buf, size_t len);
+ssize_t switchdev_notifier_str(enum switchdev_notifier_type nt,
+			       const struct switchdev_notifier_info *info,
+			       char *buf, size_t len);
 #else
 
 static inline int
diff --git a/net/switchdev/Makefile b/net/switchdev/Makefile
index c5561d7f3a7c..a40e4421087b 100644
--- a/net/switchdev/Makefile
+++ b/net/switchdev/Makefile
@@ -3,4 +3,4 @@
 # Makefile for the Switch device API
 #
 
-obj-y += switchdev.o
+obj-y += switchdev.o switchdev-str.o
diff --git a/net/switchdev/switchdev-str.c b/net/switchdev/switchdev-str.c
new file mode 100644
index 000000000000..a1fa7315cc28
--- /dev/null
+++ b/net/switchdev/switchdev-str.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/if_bridge.h>
+#include <net/switchdev.h>
+
+static ssize_t switchdev_str_write_id(char *buf, size_t len, unsigned long id,
+				      const char *const *names, size_t n_names)
+{
+	if (id < n_names && names[id])
+		return snprintf(buf, len, "%s", names[id]);
+
+	return snprintf(buf, len, "UNKNOWN<%lu>", id);
+}
+
+ssize_t switchdev_attr_str(const struct switchdev_attr *attr,
+			   char *buf, size_t len)
+{
+#define _ATTR_ID_STRINGER(_id) [SWITCHDEV_ATTR_ID_ ## _id] = #_id
+	static const char *const attr_id_strs[] = {
+		SWITCHDEV_ATTR_ID_MAPPER(_ATTR_ID_STRINGER)
+	};
+#undef _ATTR_ID_STRINGER
+
+	static const char *const stp_state_strs[] = {
+		[BR_STATE_DISABLED] = "disabled",
+		[BR_STATE_LISTENING] = "listening",
+		[BR_STATE_LEARNING] = "learning",
+		[BR_STATE_FORWARDING] = "forwarding",
+		[BR_STATE_BLOCKING] = "blocking",
+	};
+
+	char *cur = buf;
+	ssize_t n;
+
+	n = switchdev_str_write_id(cur, len, attr->id, attr_id_strs,
+				   ARRAY_SIZE(attr_id_strs));
+	if (n < 0)
+		return n;
+
+	cur += n;
+	len -= n;
+
+	n = snprintf(cur, len, "(flags %#x orig %s) ", attr->flags,
+		     attr->orig_dev ? netdev_name(attr->orig_dev) : "(null)");
+	if (n < 0)
+		return n;
+
+	cur += n;
+	len -= n;
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
+		n = switchdev_str_write_id(cur, len, attr->u.stp_state,
+					   stp_state_strs, ARRAY_SIZE(stp_state_strs));
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_MST_STATE:
+		n = snprintf(cur, len, "msti %u", attr->u.mst_state.msti);
+		if (n < 0)
+			return n;
+
+		cur += n;
+		len -= n;
+
+		n = switchdev_str_write_id(cur, len, attr->u.mst_state.state,
+					   stp_state_strs, ARRAY_SIZE(stp_state_strs));
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		n = snprintf(cur, len, "val %#lx mask %#lx",
+			     attr->u.brport_flags.val,
+			     attr->u.brport_flags.mask);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_MROUTER:
+	case SWITCHDEV_ATTR_ID_BRIDGE_MROUTER:
+		n = snprintf(cur, len, "%s",
+			     attr->u.mrouter ? "enabled" : "disabled");
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
+		n = snprintf(cur, len, "%ums",
+			     jiffies_to_msecs(clock_t_to_jiffies(attr->u.ageing_time)));
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
+		n = snprintf(cur, len, "%s",
+			     attr->u.vlan_filtering ? "enabled" : "disabled");
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL:
+		n = snprintf(cur, len, "%#x", attr->u.vlan_protocol);
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED:
+		n = snprintf(cur, len, "%s",
+			     attr->u.mc_disabled ? "active" : "inactive");
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_MST:
+		n = snprintf(cur, len, "%s",
+			     attr->u.mst ? "enabled" : "disabled");
+		break;
+	case SWITCHDEV_ATTR_ID_VLAN_MSTI:
+		n = snprintf(cur, len, "vid %u msti %u",
+			     attr->u.vlan_msti.vid, attr->u.vlan_msti.msti);
+		break;
+	default:
+		/* Trim trailing space */
+		return --cur - buf;
+	}
+
+	if (n < 0)
+		return n;
+
+	cur += n;
+	return cur - buf;
+}
+EXPORT_SYMBOL_GPL(switchdev_attr_str);
+
+ssize_t switchdev_obj_str(const struct switchdev_obj *obj,
+			  char *buf, size_t len)
+{
+#define _OBJ_ID_STRINGER(_id) [SWITCHDEV_OBJ_ID_ ## _id] = #_id
+	static const char *const obj_id_strs[] = {
+		SWITCHDEV_OBJ_ID_MAPPER(_OBJ_ID_STRINGER)
+	};
+#undef _OBJ_ID_STRINGER
+
+	const struct switchdev_obj_port_vlan *vlan;
+	const struct switchdev_obj_port_mdb *mdb;
+	char *cur = buf;
+	ssize_t n;
+
+	n = switchdev_str_write_id(cur, len, obj->id, obj_id_strs,
+				   ARRAY_SIZE(obj_id_strs));
+	if (n < 0)
+		return n;
+
+	cur += n;
+	len -= n;
+
+	n = snprintf(cur, len, "(flags %#x orig %s) ", obj->flags,
+		     obj->orig_dev ? netdev_name(obj->orig_dev) : "(null)");
+	if (n < 0)
+		return n;
+
+	cur += n;
+	len -= n;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+		n = snprintf(cur, len, "vid %u flags %#x%s", vlan->vid,
+			     vlan->flags, vlan->changed ? "(changed)" : "");
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		mdb = SWITCHDEV_OBJ_PORT_MDB(obj);
+		n = snprintf(cur, len, "vid %u addr %pM", mdb->vid, mdb->addr);
+		break;
+	default:
+		/* Trim trailing space */
+		return --cur - buf;
+	}
+
+	if (n < 0)
+		return n;
+
+	cur += n;
+	return cur - buf;
+}
+EXPORT_SYMBOL_GPL(switchdev_obj_str);
+
+ssize_t switchdev_fdb_info_str(enum switchdev_notifier_type nt,
+			       const struct switchdev_notifier_fdb_info *fdbi,
+			       char *buf, size_t len)
+{
+	switch (nt) {
+	case SWITCHDEV_FDB_FLUSH_TO_BRIDGE:
+		return snprintf(buf, len, "vid %u", fdbi->vid);
+	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
+	case SWITCHDEV_FDB_DEL_TO_BRIDGE:
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+	case SWITCHDEV_FDB_OFFLOADED:
+	case SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE:
+	case SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE:
+	case SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE:
+	case SWITCHDEV_VXLAN_FDB_OFFLOADED:
+		return snprintf(buf, len, "vid %u addr %pM%s%s%s%s",
+				fdbi->vid, fdbi->addr,
+				fdbi->added_by_user ? " added_by_user" : "",
+				fdbi->is_local ? " is_local" : "",
+				fdbi->locked ? " locked" : "",
+				fdbi->offloaded ? " offloaded" : "");
+	default:
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(switchdev_fdb_info_str);
+
+ssize_t switchdev_brport_str(const struct switchdev_brport *brport,
+			     char *buf, size_t len)
+{
+	return snprintf(buf, len, "dev %s%s",
+			brport->dev ? netdev_name(brport->dev) : "(null)",
+			brport->tx_fwd_offload ? " tx_fwd_offload" : "");
+}
+EXPORT_SYMBOL_GPL(switchdev_brport_str);
+
+ssize_t switchdev_notifier_str(enum switchdev_notifier_type nt,
+			       const struct switchdev_notifier_info *info,
+			       char *buf, size_t len)
+{
+#define _TYPE_STRINGER(_id) [SWITCHDEV_ ## _id] = #_id
+	static const char *const type_strs[] = {
+		SWITCHDEV_TYPE_MAPPER(_TYPE_STRINGER)
+	};
+#undef _TYPE_STRINGER
+
+	const struct switchdev_notifier_port_attr_info *attri;
+	const struct switchdev_notifier_brport_info *brporti;
+	const struct switchdev_notifier_port_obj_info *obji;
+	const struct switchdev_notifier_fdb_info *fdbi;
+	char *cur = buf;
+	ssize_t n;
+
+	n = switchdev_str_write_id(cur, len, nt, type_strs,
+				   ARRAY_SIZE(type_strs));
+	if (n < 0)
+		return n;
+
+	cur += n;
+	len -= n;
+
+	if (len > 0) {
+		*cur++ = ' ';
+		len--;
+	}
+
+	switch (nt) {
+	case SWITCHDEV_FDB_FLUSH_TO_BRIDGE:
+	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
+	case SWITCHDEV_FDB_DEL_TO_BRIDGE:
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+	case SWITCHDEV_FDB_OFFLOADED:
+	case SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE:
+	case SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE:
+	case SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE:
+	case SWITCHDEV_VXLAN_FDB_OFFLOADED:
+		fdbi = container_of(info, typeof(*fdbi), info);
+		n = switchdev_fdb_info_str(nt, fdbi, cur, len);
+		break;
+	case SWITCHDEV_PORT_OBJ_ADD:
+	case SWITCHDEV_PORT_OBJ_DEL:
+		obji = container_of(info, typeof(*obji), info);
+		n = switchdev_obj_str(obji->obj, cur, len);
+		break;
+	case SWITCHDEV_PORT_ATTR_SET:
+		attri = container_of(info, typeof(*attri), info);
+		n = switchdev_attr_str(attri->attr, cur, len);
+		break;
+	case SWITCHDEV_BRPORT_OFFLOADED:
+	case SWITCHDEV_BRPORT_UNOFFLOADED:
+	case SWITCHDEV_BRPORT_REPLAY:
+		brporti = container_of(info, typeof(*brporti), info);
+		n = switchdev_brport_str(&brporti->brport, cur, len);
+		break;
+	default:
+		/* Trim trailing space */
+		return --cur - buf;
+	}
+
+	if (n < 0)
+		return n;
+
+	cur += n;
+	return cur - buf;
+}
+EXPORT_SYMBOL_GPL(switchdev_notifier_str);
-- 
2.34.1

