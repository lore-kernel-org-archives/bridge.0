Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E797B3EB
	for <bridge@lists.linux.dev>; Fri, 23 Feb 2024 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688816; cv=none; b=gTE5uQNDC4L2L+QkukZ/FZ7Kt61Q7BsplUoHw3jLGW6ox2QA61cFG0EStq5/dCJD6mgbXRsx7zhL+lVF/miR5aGM6qQT3jciEH7ppUE9ewA4zDiZaIu4AYgs5gtJghhSHY3yZ8ahujU66lMqx0ocOX/bL4vD5gy2BDRuG4oIEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688816; c=relaxed/simple;
	bh=Aklu3AOTd5lHiK77HWRI2BGxuV00bQ+Z+t85v8TanpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/KTckv5n3ZjqudF2MDkLcQ3Usd6QTaEgNTOXmJkI40PTtsI7zTotEj7v36Se60Y2zgNxktaKUj1SZVrr1BtCFxfWus5Uq9HiEZwPXyT9tsV7vA7amCzhw6j9UOJo49MVQXCJWnYmlUmXDC+p10LfgpiNfxgz2GDPhcZCHK1Npc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=Sy0FYdD/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="Sy0FYdD/"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512cba0f953so890137e87.2
        for <bridge@lists.linux.dev>; Fri, 23 Feb 2024 03:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708688812; x=1709293612; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5fiokJc9zM6smEbrCoaTInj6Uw6RY6DPtGrC3zqaCf0=;
        b=Sy0FYdD/fiVxulkW/vJIMLhc7kHbqnPgark6C+LMq2H/KqS7urHV7z8vJp2Eno4EhR
         OMdZN4RtrnOgpzNfFdy0gzaiFOM7Ia78e+opjbAB0Lv58ac9ZD4STWLtYT9XoofR3C9v
         t1u9HbPhMgB9VZxSORSlceplYxyUGPM5na19FMeDp/Y1WQsdUaaiYcBs61VS6l0W1FQk
         0KmGtG8pNhWNdKrZ0kc3EPVhbxY18YNFsrqyHAfZtSi0kAkCOf+pHvwo3weDySWkD3EH
         QTrPGZm9aXO+BDqXyPqiGzgAOoEylDkwKS3JjfgTgcxqmFB2Afxfy/KUJof4sNMHFJtb
         w5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688812; x=1709293612;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fiokJc9zM6smEbrCoaTInj6Uw6RY6DPtGrC3zqaCf0=;
        b=YrpxGZvgXqv+g3qmKs4p48NZtqOhwArYR1lRzn2vL9Fc2tMaRZzjW+/buxXeuhLeko
         ie0IivBGr7lfRhT+PJ/NWrW/EFcOSuY7L+D28z343adPdo6sVZobkgak6jslHprrbhjd
         AbXtleErTGQAUh0XmTn/GEaplkEX/wNcuLn6ixZ/eyEdbX3t8C3cHUJGbbuCpfsE8M5h
         N4pbiFxIq0ZyxZc++DSLIIukQDtPu291auCbH4n4mOC0NWRy57RDvxMYEb1PMAqb6FhK
         f0s0bjZvhQC15tc/sg/dqIWp8Xnngx+uNNF5v1kwlwT7nqMRI50olALdiKPCdLfwl0iM
         Fw1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGcUPNglHveLEq+kPbRzj0QrTUg4Xl3Q2NjK8G9eaI4AqhWtkyddfJ5lvlHM84G6CISHXQNzJjv+N3SuWLmeJvnxPrAmsr
X-Gm-Message-State: AOJu0YxTHlJEonnF8raQlBksSWewdXdhFEuPBqd5tI/ei9/HNDzq0qUv
	NbbAVwYvHX8L4njkjsAjs+iMrvypI/Af9Qxyn2QbyouYETIK2TiNjQ4YBXxoDKs=
X-Google-Smtp-Source: AGHT+IGBYXLp3kgxZ52vrpr0KeBz25IpYvIgdCgnLA0WXvBUzRaSDJyjGBlXkb3ZmlOXmDfSlXQQtw==
X-Received: by 2002:a05:6512:6d0:b0:512:ac4a:4e07 with SMTP id u16-20020a05651206d000b00512ac4a4e07mr1773844lff.30.1708688812362;
        Fri, 23 Feb 2024 03:46:52 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b00512d180fd3asm1011694lfq.144.2024.02.23.03.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:46:51 -0800 (PST)
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
Subject: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
Date: Fri, 23 Feb 2024 12:44:53 +0100
Message-Id: <20240223114453.335809-5-tobias@waldekranz.com>
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

Add a basic set of tracepoints:

- switchdev_defer: Fires whenever an operation is enqueued to the
  switchdev workqueue for deferred delivery.

- switchdev_call_{atomic,blocking}: Fires whenever a notification is
  sent to the corresponding switchdev notifier chain.

- switchdev_call_replay: Fires whenever a notification is sent to a
  specific driver's notifier block, in response to a replay request.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/trace/events/switchdev.h | 74 ++++++++++++++++++++++++++++++++
 net/switchdev/switchdev.c        | 71 +++++++++++++++++++++++++-----
 2 files changed, 135 insertions(+), 10 deletions(-)
 create mode 100644 include/trace/events/switchdev.h

diff --git a/include/trace/events/switchdev.h b/include/trace/events/switchdev.h
new file mode 100644
index 000000000000..dcaf6870d017
--- /dev/null
+++ b/include/trace/events/switchdev.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM	switchdev
+
+#if !defined(_TRACE_SWITCHDEV_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SWITCHDEV_H
+
+#include <linux/tracepoint.h>
+#include <net/switchdev.h>
+
+#define SWITCHDEV_TRACE_MSG_MAX 128
+
+DECLARE_EVENT_CLASS(switchdev_call,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, val)
+		__string(dev, info->dev ? netdev_name(info->dev) : "(null)")
+		__field(const struct switchdev_notifier_info *, info)
+		__field(int, err)
+		__array(char, msg, SWITCHDEV_TRACE_MSG_MAX)
+	),
+
+	TP_fast_assign(
+		__entry->val = val;
+		__assign_str(dev, info->dev ? netdev_name(info->dev) : "(null)");
+		__entry->info = info;
+		__entry->err = err;
+		switchdev_notifier_str(val, info, __entry->msg, SWITCHDEV_TRACE_MSG_MAX);
+	),
+
+	TP_printk("dev %s %s -> %d", __get_str(dev), __entry->msg, __entry->err)
+);
+
+DEFINE_EVENT(switchdev_call, switchdev_defer,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err)
+);
+
+DEFINE_EVENT(switchdev_call, switchdev_call_atomic,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err)
+);
+
+DEFINE_EVENT(switchdev_call, switchdev_call_blocking,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err)
+);
+
+DEFINE_EVENT(switchdev_call, switchdev_call_replay,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err)
+);
+
+#endif /* _TRACE_SWITCHDEV_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index f73249269a87..74d715166981 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -19,6 +19,9 @@
 #include <linux/rtnetlink.h>
 #include <net/switchdev.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/switchdev.h>
+
 static bool switchdev_obj_eq(const struct switchdev_obj *a,
 			     const struct switchdev_obj *b)
 {
@@ -180,8 +183,20 @@ static void switchdev_port_attr_set_deferred(struct net_device *dev,
 static int switchdev_port_attr_set_defer(struct net_device *dev,
 					 const struct switchdev_attr *attr)
 {
-	return switchdev_deferred_enqueue(dev, attr, sizeof(*attr),
-					  switchdev_port_attr_set_deferred);
+	int err;
+
+	err = switchdev_deferred_enqueue(dev, attr, sizeof(*attr),
+					 switchdev_port_attr_set_deferred);
+
+	if (trace_switchdev_defer_enabled()) {
+		struct switchdev_notifier_port_attr_info attr_info = {
+			.info.dev = dev,
+			.attr = attr,
+		};
+
+		trace_switchdev_defer(SWITCHDEV_PORT_ATTR_SET, &attr_info.info, err);
+	}
+	return err;
 }
 
 /**
@@ -263,8 +278,20 @@ static void switchdev_port_obj_add_deferred(struct net_device *dev,
 static int switchdev_port_obj_add_defer(struct net_device *dev,
 					const struct switchdev_obj *obj)
 {
-	return switchdev_deferred_enqueue(dev, obj, switchdev_obj_size(obj),
-					  switchdev_port_obj_add_deferred);
+	int err;
+
+	err = switchdev_deferred_enqueue(dev, obj, switchdev_obj_size(obj),
+					 switchdev_port_obj_add_deferred);
+
+	if (trace_switchdev_defer_enabled()) {
+		struct switchdev_notifier_port_obj_info obj_info = {
+			.info.dev = dev,
+			.obj = obj,
+		};
+
+		trace_switchdev_defer(SWITCHDEV_PORT_OBJ_ADD, &obj_info.info, err);
+	}
+	return err;
 }
 
 /**
@@ -313,8 +340,20 @@ static void switchdev_port_obj_del_deferred(struct net_device *dev,
 static int switchdev_port_obj_del_defer(struct net_device *dev,
 					const struct switchdev_obj *obj)
 {
-	return switchdev_deferred_enqueue(dev, obj, switchdev_obj_size(obj),
-					  switchdev_port_obj_del_deferred);
+	int err;
+
+	err = switchdev_deferred_enqueue(dev, obj, switchdev_obj_size(obj),
+					 switchdev_port_obj_del_deferred);
+
+	if (trace_switchdev_defer_enabled()) {
+		struct switchdev_notifier_port_obj_info obj_info = {
+			.info.dev = dev,
+			.obj = obj,
+		};
+
+		trace_switchdev_defer(SWITCHDEV_PORT_OBJ_DEL, &obj_info.info, err);
+	}
+	return err;
 }
 
 /**
@@ -394,7 +433,11 @@ EXPORT_SYMBOL_GPL(switchdev_port_obj_act_is_deferred);
 int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
 			  struct switchdev_notifier_info *info)
 {
-	return nb->notifier_call(nb, type, info);
+	int ret;
+
+	ret = nb->notifier_call(nb, type, info);
+	trace_switchdev_call_replay(type, info, notifier_to_errno(ret));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(switchdev_call_replay);
 
@@ -437,9 +480,13 @@ int call_switchdev_notifiers(unsigned long val, struct net_device *dev,
 			     struct switchdev_notifier_info *info,
 			     struct netlink_ext_ack *extack)
 {
+	int ret;
+
 	info->dev = dev;
 	info->extack = extack;
-	return atomic_notifier_call_chain(&switchdev_notif_chain, val, info);
+	ret = atomic_notifier_call_chain(&switchdev_notif_chain, val, info);
+	trace_switchdev_call_atomic(val, info, notifier_to_errno(ret));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(call_switchdev_notifiers);
 
@@ -463,10 +510,14 @@ int call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
 				      struct switchdev_notifier_info *info,
 				      struct netlink_ext_ack *extack)
 {
+	int ret;
+
 	info->dev = dev;
 	info->extack = extack;
-	return blocking_notifier_call_chain(&switchdev_blocking_notif_chain,
-					    val, info);
+	ret = blocking_notifier_call_chain(&switchdev_blocking_notif_chain,
+					   val, info);
+	trace_switchdev_call_blocking(val, info, notifier_to_errno(ret));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(call_switchdev_blocking_notifiers);
 
-- 
2.34.1

