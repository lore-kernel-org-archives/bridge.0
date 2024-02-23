Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E967A719
	for <bridge@lists.linux.dev>; Fri, 23 Feb 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688814; cv=none; b=KtvFKoxrexBHcA1+RrhQqm5bGlQwipjkVFtSPbVRYfWAIaimUmzL9Rjkw88q29vfW79yj4tt+No7V0PaE7QpOw6uznnEo85bsN7OAatLYY/iCk5qT/yCoWMxOSqPOrH0BLTA9U6jF9BlSjr68lck06XEhqFczX1oi+itIr0dNzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688814; c=relaxed/simple;
	bh=8I/5DOW5gW4lbco+7gFw8uvyQqN/6Ux3tmUrXsaJIkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCZm4U1LX6rhW3OMaTw+P84WiBdXUX+AEVQ9KKJrOfqKzOAjWrpKra4RfS1yO8Nq5gzADylpY83E5oYI9C68u5ySRknMz6eo0Qs+G3C5fElXFucdDk7CuPIoAsc5xMCJ5o2TrphtaRzUxX5YxQzMNr/1hTe6Zpa4YDs1krYmTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=Dh4wInBZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="Dh4wInBZ"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso985578e87.3
        for <bridge@lists.linux.dev>; Fri, 23 Feb 2024 03:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708688810; x=1709293610; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HiVTpXcFGxZ36jj3cKnJQtbHcUpuJpU/8Cq1LhZQMSg=;
        b=Dh4wInBZiuYEGLtJDU0KPutlwrC90+qo1VT8MJ82KoliB+m8kT3QBtCYOyjLjMr95C
         ni6tWX0NB41+QLHipT8WK7wbZpX/8z1TvAMYBZ5apF+71Wzf44FVN7kdmVRFu9dPiz8T
         eRikydU2hjMifEjX7k5/YSC94AQRF32nXYgHOlJwDCLUX2R2LgGdEl0W90sPk7cvy3bN
         heYi4V1UBhpst9wMxpJHRCNS0LoAjzmseFyjPESjKPitlNL7D0C9jfVfkHsC1jld/Ts9
         5HVOJCee6Zs+WJvhIwxtDGwV7WXdy7DQ+bEPx7OcwsU6wSuLa7IM7o32SdnTD6wfPyUk
         yEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688810; x=1709293610;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiVTpXcFGxZ36jj3cKnJQtbHcUpuJpU/8Cq1LhZQMSg=;
        b=vZL8Mv1OoJu/0/O0U5/rEHvtB2QdGjkWesWaFhEfkOaPeqO3MbvyDHmffe+eGfGPhT
         KnJ8lmc5WLkutR1CVrGV6S6Bh34UA+HGrgvSuiPVfWwgfedodh7019x3p8xaVzhlxuG+
         tAZ9yHYrtc1//iHCi7gwdu5Djd2iIxVZicHptC2Mepiakijm/E/RXO/JOaOIEwalNvWW
         mp5Xfgg3M6tD+m+xmtmlzCohvHftBoHQjLt+fhEsLDHPGnFZXG0UB+EUHnRhwY+9fkrI
         9M5WKBU8Q6hd1q+wyXS2phSdFnF0iitJuCQjVFC0zd7wT5C4l63pNrWWWnz/9gC3JR95
         7zpA==
X-Forwarded-Encrypted: i=1; AJvYcCWLuVghVzwvqQ6YWwZZjKaEVIrlj8IavS6JLREbsMrmBHUPVc4/Et2hOic76t+Z1IENm1+seo4Mreizh0mY8fzEF8/QgQNa
X-Gm-Message-State: AOJu0YyitG8iWekeb5Qcu4t5JjM01iWz6suDPkzTWZY26kQ5RFqxymbA
	YFSckY5suveoT/RZMZiG/EaOY/v3eDc2or8neDPDu6CR+snGjU5NHg/9TRN2im4=
X-Google-Smtp-Source: AGHT+IHnvrfG+0bMJ2aDuSPshp30LXi/eioIOLjyUv8r3s1ySbENhqicUXk6EzkNy603h2zbbzTOmA==
X-Received: by 2002:ac2:5049:0:b0:512:9e9f:2f1d with SMTP id a9-20020ac25049000000b005129e9f2f1dmr1156913lfm.58.1708688810303;
        Fri, 23 Feb 2024 03:46:50 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b00512d180fd3asm1011694lfq.144.2024.02.23.03.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:46:49 -0800 (PST)
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
Subject: [PATCH v3 net-next 2/4] net: switchdev: Add helpers to display switchdev objects as strings
Date: Fri, 23 Feb 2024 12:44:51 +0100
Message-Id: <20240223114453.335809-3-tobias@waldekranz.com>
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

Useful both in error messages and in tracepoints.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h       |  14 ++
 net/switchdev/Makefile        |   2 +-
 net/switchdev/switchdev-str.c | 278 ++++++++++++++++++++++++++++++++++
 3 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 net/switchdev/switchdev-str.c

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 86298a21c6c8..9bf387664e71 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -394,6 +394,20 @@ int switchdev_handle_port_attr_set(struct net_device *dev,
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

