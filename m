Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A42E7AE7E
	for <bridge@lists.linux.dev>; Fri, 23 Feb 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688815; cv=none; b=U+oUQPVVKWkw6pyzJ6WwyE2ef5HFnJAyirmt5mjT9cYIfryLLPuUDhy1Rt9h9GqckkjNOQLjkfqRz6ErUtjKvS3SUSKO5EkAfppGhrCy5nAoHR7RFN62NGq1JjlDszFy5dxMy3SLdU+7ga+d9FROE/4NUC0h54v95uU2JU0/OqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688815; c=relaxed/simple;
	bh=AL59q193AhGQ1MjN1i4e9LV1QO1+0Mpm+Q7EAlw3k8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+HNn85Sl/JOSjVfGYLNqw9w5jNLcvS5cvVxm5p4dg+K2CEphasnhGBjw5othTN02MhwqYEfg5yhgcUC5Ww5MRxPr4eBfAMYi+KQyU7T4dzujXlWPpXH63JhetvPflqmGxQvk04Pmvxe5cYKVmxRcI9331vsVPhsBAPluzqGi9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=p4J51yJa; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="p4J51yJa"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51197ca63f5so1222356e87.1
        for <bridge@lists.linux.dev>; Fri, 23 Feb 2024 03:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708688811; x=1709293611; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mBRSSCMEADMA+/NeZM3v/YJ5K3VaAW012IQALFAOI+E=;
        b=p4J51yJasyrzuwL3P5EOp8pSMrdehXACnfDfIgZMfOxk2QCF0o+yU3zLJ0024bbT9P
         98QP8Tucf8sG54S0e003kjADgMzLjV923qvhj4+o/tuxDAPk3pRuAbK/oW0WRXKKyKxT
         9mFWWtBSGoGH3BDBbl4xDhRQyG7YYIe5dOfKei1s3vA3pdG+QJtkHh5tlbnHs6a5tKks
         WGHi6/CpbDdrXxc0ZX7CbEVsJzXgvX0R25s7ojEIVX1lNKX42nw3GQ52jKFlxWDvsALi
         HeOEpGOshHylQAfhgRORDT71pwvXaflJmUxkVsUc+ui8dyJu3uuPyxe6endCAc00/j+C
         m7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688811; x=1709293611;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBRSSCMEADMA+/NeZM3v/YJ5K3VaAW012IQALFAOI+E=;
        b=CYLD+YjbU8jLZpL5ALkhZA9GnJm2NQbWo65hya97d+5lZTaMBQHONpbEabXWkIfHwT
         cG4bTKazs+ouJfQBwR2PXY4OPNSKNpPx6smXPzbeQv6jmZYCsMm3bxtqFzVfz2xvq643
         f9p6KM8q6LycPs7/AO9tOYYH3RZwPvQpAEZAiCCVaEvMGHO9YL5YiR3g1hc/I9sDmOtc
         HxGRibkPCEvZzmAB/JoZtHYSePllQTRKZAUV32bW6wy9TK+XAKIUQqTrOgdCZZcD6mrs
         xJRJWWHsw4YHe1kUtM0+PpdldphCI9mo1HhuVwnByWd5g1VWQTSmgyn+iH467X2iSI1B
         I0Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXnzZ2YtRWr2OcRs8ohdhYw/yKZ6q76NqJnyC6lyjKsE6ULkfRKUTg0mXoETBarAXFGGgNixUspBqV/G0jPfndef2ObMGAR
X-Gm-Message-State: AOJu0YzCXsFJoiBTfXIVDOg8h1WxTUq+y0k28SQtytNr3a+aPbeQINVn
	SQci+4tn8Qe69JHR7BGpS+43m8LmpJvmZupJVIoWEvoQMry30RdhKqJ4In2jh7Q4GGYlBbqhxSJ
	e
X-Google-Smtp-Source: AGHT+IE1FodzdIAUfG29+EdpmzWKwJ/TMGMZMZ1OL3CbEJZ1hWlBLWck+b5rA0SpDIRUtCsXMcBquw==
X-Received: by 2002:a05:6512:12cb:b0:512:be57:6dcf with SMTP id p11-20020a05651212cb00b00512be576dcfmr1554566lfg.8.1708688811358;
        Fri, 23 Feb 2024 03:46:51 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b00512d180fd3asm1011694lfq.144.2024.02.23.03.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:46:50 -0800 (PST)
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
Subject: [PATCH v3 net-next 3/4] net: switchdev: Relay all replay messages through a central function
Date: Fri, 23 Feb 2024 12:44:52 +0100
Message-Id: <20240223114453.335809-4-tobias@waldekranz.com>
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

This will make it easier to add a tracepoint for all replay messages
later on.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h   |  3 +++
 net/bridge/br_switchdev.c | 10 +++++-----
 net/switchdev/switchdev.c | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 9bf387664e71..df4db720183f 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -340,6 +340,9 @@ int switchdev_port_obj_add(struct net_device *dev,
 int switchdev_port_obj_del(struct net_device *dev,
 			   const struct switchdev_obj *obj);
 
+int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
+			  struct switchdev_notifier_info *info);
+
 int register_switchdev_notifier(struct notifier_block *nb);
 int unregister_switchdev_notifier(struct notifier_block *nb);
 int call_switchdev_notifiers(unsigned long val, struct net_device *dev,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 7b41ee8740cb..cc9ed7f6bf1c 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -306,7 +306,7 @@ br_switchdev_fdb_replay_one(struct net_bridge *br, struct notifier_block *nb,
 
 	br_switchdev_fdb_populate(br, &item, fdb, ctx);
 
-	err = nb->notifier_call(nb, action, &item);
+	err = switchdev_call_replay(nb, action, &item.info);
 	return notifier_to_errno(err);
 }
 
@@ -376,8 +376,8 @@ static int br_switchdev_vlan_attr_replay(struct net_device *br_dev,
 			attr.u.vlan_msti.vid = v->vid;
 			attr.u.vlan_msti.msti = v->msti;
 
-			err = nb->notifier_call(nb, SWITCHDEV_PORT_ATTR_SET,
-						&attr_info);
+			err = switchdev_call_replay(nb, SWITCHDEV_PORT_ATTR_SET,
+						    &attr_info.info);
 			err = notifier_to_errno(err);
 			if (err)
 				return err;
@@ -404,7 +404,7 @@ br_switchdev_vlan_replay_one(struct notifier_block *nb,
 	};
 	int err;
 
-	err = nb->notifier_call(nb, action, &obj_info);
+	err = switchdev_call_replay(nb, action, &obj_info.info);
 	return notifier_to_errno(err);
 }
 
@@ -590,7 +590,7 @@ br_switchdev_mdb_replay_one(struct notifier_block *nb, struct net_device *dev,
 	};
 	int err;
 
-	err = nb->notifier_call(nb, action, &obj_info);
+	err = switchdev_call_replay(nb, action, &obj_info.info);
 	return notifier_to_errno(err);
 }
 
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index c9189a970eec..f73249269a87 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -380,6 +380,24 @@ bool switchdev_port_obj_act_is_deferred(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_act_is_deferred);
 
+/**
+ *	switchdev_call_replay - Replay switchdev message to driver
+ *
+ *	@nb: notifier block to send the message to
+ *	@type: value passed unmodified to notifier function
+ *	@info: notifier information data
+ *
+ *	Called by a bridge, in a response to a replay request
+ *	initiated by a port that is either attaching to, or detaching
+ *	from, that bridge.
+ */
+int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
+			  struct switchdev_notifier_info *info)
+{
+	return nb->notifier_call(nb, type, info);
+}
+EXPORT_SYMBOL_GPL(switchdev_call_replay);
+
 static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
 static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
 
-- 
2.34.1

