Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053560EE3
	for <bridge@lists.linux.dev>; Tue, 23 Jan 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024254; cv=none; b=IYddWmEGVXZvOH1cvArufpKnhfH04GJ5POp2QHpT7XzpD90ekiz5+Olartypn2J3WzgxWgjWgOuvHTlde2ulDW910Mq+/gKTiTNWq4H15vS3OEY1wAKn0wZNkxLcSzfF/EVeQYxaMHl9H0ttnYU0EGjEBCT09SFc+fsoTGDzeS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024254; c=relaxed/simple;
	bh=1TsJyYbT/1jV7UKlwxvsd6loFO5APSuHrGhqo+8jwhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IaVhJL67ArExkyLQNQyEClHTQBjp/HpJeko6BGOx0Q1pDELlRaLUcxwHOBQN17KkyTSg4AOTVkZU+PaVO+UI0fSRWyEx0B30GQ3bvfkzwgcIeglG5eR6W+05Pqff+MKg6qqQnYKJ9Hf6fszegZADyLVopy8hZ4f1t0X8V+nFPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=uGaw7eTf; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="uGaw7eTf"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5100893015fso862641e87.1
        for <bridge@lists.linux.dev>; Tue, 23 Jan 2024 07:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706024251; x=1706629051; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ummukqbZPLomPcHTqdN4PTAj0S043AFrvZ+O3aml3do=;
        b=uGaw7eTfIr23s8tYbAjnOJlUf+QZGqQHIdltvkm/4Om8VojoBJ59fmONMHTpjUM6VD
         6HgDqgdbi6cw9Dg0i6Vl/rxycrBJvkEqmguCBdqSw7KvHG6kGducluEEW7N51UcFBFxe
         wofUmKF6Tuw4RGCKKs2E2T+0lsrB9LBn/BmudBM4eUZwBAHjWcEkp0VHmbF+2oDnZi9X
         m4poP7EA0BD8PE41adRf0vedzpGJt+ySIIg/8Ig/fBopsC3wwZ4uqHZ+HepolLk0O9uP
         SwRHk0zbmd8PqThbI26AOKeus9kClDQDCd81r/UscuJnerEJxDWySqH7vY+DIOOwCu9f
         SAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024251; x=1706629051;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ummukqbZPLomPcHTqdN4PTAj0S043AFrvZ+O3aml3do=;
        b=bwKzn4cvZ2yy2cE4P0vdEb+9tKOW9E8Dh83StJDLw6OiS7pnSeDavwnHYeBB8NLrBP
         yVLfTTZMDR51kzQU9luMiUsMHKQxAOjptmBaJe4wioHzAEXp5lmhSjSaEzK7EbO7AIgL
         XR91JN1N3WmhT9NAjU9N8sVJyhXEsTOdHNMw0HN7FM2J4siIKinkve+yz5HzdDgw4nbv
         RgAqG7R9VBama436nzPJKCERCb42EdrDJIYqdCW2WB5BQduSNWmci802BoVNOl+/jUWg
         5/GTRoCW3g1bUVBU4nMt4Imd2drLYWuPtSjKj7fauhMzJj402udiZ2w+ylj+PhOgV6k6
         XDYg==
X-Gm-Message-State: AOJu0YxSYRcCZ702GCfKJZFD/uiicrRyRzLYoouLhC3SpVEefgZg+nOp
	WcWiCv8fvwsf8dm/lrL5SZrpqjRITKIAB2CfXaZO/ldQlAansTRtpcEHDkAmqJ8=
X-Google-Smtp-Source: AGHT+IF4GqCEHYFPDhgvrqbieCdj3I6rehdUcJG37iFiPhk/Neolyfflf2C05+vFqiv1ru5o6lhYKA==
X-Received: by 2002:ac2:5e32:0:b0:50e:c7b2:cc77 with SMTP id o18-20020ac25e32000000b0050ec7b2cc77mr1395317lfg.198.1706024250919;
        Tue, 23 Jan 2024 07:37:30 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id h23-20020a19ca57000000b0050ee3e540e4sm2386790lfj.65.2024.01.23.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:37:29 -0800 (PST)
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
Subject: [PATCH net-next 3/5] net: switchdev: Relay all replay messages through a central function
Date: Tue, 23 Jan 2024 16:37:05 +0100
Message-Id: <20240123153707.550795-4-tobias@waldekranz.com>
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
index 5b045284849e..05f22f971312 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -307,6 +307,23 @@ int switchdev_port_obj_del(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
 
+/**
+ *	switchdev_replay - Replay switchdev message to driver
+ *	@nb: notifier block to send the message to
+ *	@val: value passed unmodified to notifier function
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

