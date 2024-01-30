Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1818762C8
	for <bridge@lists.linux.dev>; Tue, 30 Jan 2024 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645991; cv=none; b=ig5hbDfyNElh/dEDwJ4nN9Xx5vyGNZq46nNj7ieeH0HMj194rYXchw1vIPA8wi9qYo5hNy6mH2wkhN0XetPpILJeA5OWPcxzKj32YXsD/TReb9bpPU+bJUKjqWOxcXEiZHQsMGd6WNRUqm+5wLquvW0iknTSuoOtBJmqb7InpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645991; c=relaxed/simple;
	bh=dDP0qs8DhKtLjMFYjmLFo4VHMamdrl6xaZ2AkfXYAoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hMlwgWrocofJlhZQRt1kNgaUcfcJoB3a/XGHwVnz05gDY05pY0HA1jIW5F/JPlZCp0tsDkSQheaVazLwu8juWSwGVxRK/unRHBrlpWPV8C4yAtcKApKQnMmjAubAOg5iLcDFQGEwJGzPt8XrVLpyKhASyNwRivEOn+CIAEkv93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=wyRizWex; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="wyRizWex"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51032058f17so3648663e87.3
        for <bridge@lists.linux.dev>; Tue, 30 Jan 2024 12:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706645988; x=1707250788; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AsxS6NRjh94C5E7qE0lZySKxuu+izJy1bIEhTVzYMDA=;
        b=wyRizWexY1FBBH66A8UoECl2fK2Eu4lP+MHDSLvO9hd5rrBoxSxwuY/auh1TtZBIKs
         sYf3IoA6B3qOA0o1Hn2CWkrJbFNoiufiwawx6Y2oCmA1ppNPYhiLJ0mS42UwSPY7nWX8
         keW7PLbvvGn0mGcE2Zk9UEvrB4W+dyWdfHp4qHplAxRq8eZ8KybTqtSuAGIDEPM1rFHR
         qyut31kWtRUT5toli899+98eGv2DDq8aYgA/YzTqXR3mlkXRLO00w2iin66spe6hIpyD
         JLla8KH3gbblgATn+gyBfeOXB0OP4C+56t8eIfK4cWnZQhJP2eOn4bk8HyB5RH4bJtqs
         /Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706645988; x=1707250788;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsxS6NRjh94C5E7qE0lZySKxuu+izJy1bIEhTVzYMDA=;
        b=oIxrIgUtJRsEFAi8hWeoK07phtG7WCN2JEigNCoYofSw2koA4UCthZau/i1gX/ZVH7
         qx4WNNcAD+rGhBqtAhfXFdAzzsRCwjtjHuAOkZl6Alu8u1nhKuefw49WyChBbRN+f3IL
         CRnnIF8v66fkpp6StTr/idczznkoPPneiy+R0re+414gVtYK/d6M+mPI+R8lPP3+WdIE
         m9mREePRHAYZfhsXPmDK5xq60e3zrfA+Fu9Wrdv/ckxwl7QmAR2Hof3SVaUCIGGw9Z8R
         diYcRPrEFni72jbJc2QnzLW2dY29V6rHumB0C5j5K1UIJo51WqzvVy9vS8ORQj8Z8756
         6wtg==
X-Gm-Message-State: AOJu0YzA5VIEKIG+74u4buDXBqGhrEqGpfj77hZIP++1Qkp0o70UR82D
	sSOlktHL2iqCwnSoSemg/IJJ2y7Rhqek76WhOnEWkIOsS1Z9n0Ltu1lUjZ/Ape4=
X-Google-Smtp-Source: AGHT+IF8GONpbLNPK+lC7Gr5bM7GG2hs5GaIlwvCk3P5ob0qBim2niYmBL22jido4U3k8fFb0UdVAw==
X-Received: by 2002:a05:6512:11e2:b0:510:44d9:ccdb with SMTP id p2-20020a05651211e200b0051044d9ccdbmr294255lfs.59.1706645988125;
        Tue, 30 Jan 2024 12:19:48 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id eo15-20020a056512480f00b0051011f64e1bsm1553239lfb.142.2024.01.30.12.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:19:47 -0800 (PST)
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
Subject: [PATCH v2 net-next 3/5] net: switchdev: Relay all replay messages through a central function
Date: Tue, 30 Jan 2024 21:19:35 +0100
Message-Id: <20240130201937.1897766-4-tobias@waldekranz.com>
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

This will make it easier to add a tracepoint for all replay messages
later on.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h   |  3 +++
 net/bridge/br_switchdev.c | 10 +++++-----
 net/switchdev/switchdev.c | 17 +++++++++++++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 250053748c08..974cd8467131 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -337,6 +337,9 @@ int switchdev_port_obj_add(struct net_device *dev,
 int switchdev_port_obj_del(struct net_device *dev,
 			   const struct switchdev_obj *obj);
 
+int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
+			  struct switchdev_notifier_info *info);
+
 int register_switchdev_notifier(struct notifier_block *nb);
 int unregister_switchdev_notifier(struct notifier_block *nb);
 int call_switchdev_notifiers(unsigned long val, struct net_device *dev,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ee84e783e1df..b9e69b522544 100644
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
index 5b045284849e..e50863a03095 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -307,6 +307,23 @@ int switchdev_port_obj_del(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
 
+/**
+ *	switchdev_call_replay - Replay switchdev message to driver
+ *	@nb: notifier block to send the message to
+ *	@type: value passed unmodified to notifier function
+ *	@info: notifier information data
+ *
+ *	Typically issued by the bridge, as a response to a replay
+ *	request initiated by a port that is either attaching to, or
+ *	detaching from, that bridge.
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

