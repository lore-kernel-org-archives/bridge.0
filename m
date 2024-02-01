Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9FA5D471
	for <bridge@lists.linux.dev>; Thu,  1 Feb 2024 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796049; cv=none; b=jOrmFiKmhYF4WoqJ2McOR1I/oOM3LGL54Jo4CLvK3+ve8e9Z3DtYioBr9icEUdh7aWacKm5tic0sa1ArfmxfMw/LzVTmBb/x4vYjY6CBdFsXgCkKlocRbESu0eB20mEUWnMaQWSAqIQ5mSbwuFxKUmycgHtFOUWKdWF3gcbEcuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796049; c=relaxed/simple;
	bh=LNgRYAdQD39RUDgvDGdXK308lS3xlcdlhql7U263toY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GTnAchDFaOshNcYSrzBP5i8FR7wWIyfVnAku0nbrD9muAiSgTqia0aV5atZ5+wnxzifAR7/+HS/SirUfwcz6RhI4d5a3pvy66BOZJ+CNv2nY47Gj0+h/JpoNZtWSqm9kUj7hh7nkW8HGsEjE1KCsm4rWAhhoJ8FKnXhF/jCmBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=jRKb6ngj; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="jRKb6ngj"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cf591d22dfso11217611fa.0
        for <bridge@lists.linux.dev>; Thu, 01 Feb 2024 06:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706796045; x=1707400845; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O1FHmOYzw5uv/04pVq1xhJ8wOA4Pzrud7JtVWrL7pos=;
        b=jRKb6ngjoaN+oR9oOMl/cjUvUHRlOGz4Co6gbmon9Pa/IPaKS7yxWAJ1yaJOcII7Cz
         yCF10CTj70uqEONDQlZy2nCMzX4C+ZXhR0WflrFywq4B8ACulsD0V4A2dtc0g1XWZbZd
         JlbMLybdXjjxUsQPNxn4kR0Gn1aUXQpBbj+jZxaK9pQwcTUBWskEa3F8b7viYCwJppkL
         Rkf1vdBDhTB+kes09r5fSCS5ky4FdzY/VPdOAIGj+q6rQv/q8K4Uyg+2eN43Zi1Q7XbW
         L96S3Uq5cCcWRPG4hVE9l5Lrbz0dtBbhQmPnalYVHbqaWZByLSarzapBxbwlpzUn89xu
         5lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796045; x=1707400845;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1FHmOYzw5uv/04pVq1xhJ8wOA4Pzrud7JtVWrL7pos=;
        b=Ck7z4yc5gxZHMOHEWl0o1s7fN/0KEBnb9Yc4YF8rzxsKhs/btn7MMnBLxFMZ5rU8xn
         rM/X73Ws07ePdU1dIf5lWwT5GYfTzPGqbxzwy2BufKdq/yuwYnqedbuau8BAQmk5POBl
         13TD6/p9tyjTElAjj8nuRicc6QO5InyQs0W+/mwudcD3UN7AyzcAiQJjFqR2bBoonTIk
         dm8tRWNkPmvjelNtgOs6/WhIsi8H27ZcHO3TlZMr6SKDWUP8mAMA70EtoyJxhEF+7Qs1
         KTjEfD6FJfFdJFxGLWmk6cm5M8r6VYay30NgAfDnwjSTjMVSIUXI46wD/YFwMLlJPBpG
         UDbw==
X-Gm-Message-State: AOJu0YwnjjHb/Kz4C3ibHz9kl45sN38LhqKP60wSBJfNPJ5DTNADuh7R
	SCgE7scgw9Kby2mfhq0ivr4EgzuGxJr1oqvLm/dLYUbz89xP83i8UeJiqLgOomk=
X-Google-Smtp-Source: AGHT+IG9HT3GFjLw3O/ciqhD7yVr0TrliBJWzLYwk3rvV561VjiDxjrjX/hg+GyTJFI/zwvbsA75AQ==
X-Received: by 2002:a2e:a706:0:b0:2cd:8ce7:71e1 with SMTP id s6-20020a2ea706000000b002cd8ce771e1mr3186698lje.4.1706796044968;
        Thu, 01 Feb 2024 06:00:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFDwn4wAAJtr3Ja07exN2YqFPFqZRtjbm/nwZyo5QIU3isOmdGK9H5Xhpz7cVwvDpUyQ1x5APd2Q++FyQ72Fd+AQLZMo3w6nbwZnJNWBMLifxAfn7qzAQrhxv/RXVBEcX5UrbmROhxrIsQqiIJF9bNuhOinu7K3+5FQyL/LpJho98aQXlkrbfSeHvtbjG2YUQY1QO/IG339rgQuGLfIya++CYWNRLXP/+DPwDqrUc5Yg5hYqOPkYd3GNpVGA==
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id k37-20020a05651c062500b002cdfc29b46dsm2428254lje.88.2024.02.01.06.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:00:44 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: olteanv@gmail.com,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com
Subject: [PATCH v2 net] net: bridge: switchdev: Skip MDB replays of pending events
Date: Thu,  1 Feb 2024 15:00:24 +0100
Message-Id: <20240201140024.1731494-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Before this change, generation of the list of events MDB to replay
would race against the IGMP/MLD snooping logic, which could concurrently
enqueue events to the switchdev deferred queue, leading to duplicate
events being sent to drivers. As a consequence of this, drivers which
reference count memberships (at least DSA), would be left with orphan
groups in their hardware database when the bridge was destroyed.

Avoid this by grabbing the write-side lock of the MDB while generating
the replay list, making sure that no deferred version of a replay
event is already enqueued to the switchdev deferred queue, before
adding it to the replay list.

An easy way to reproduce this issue, on an mv88e6xxx system, was to
create a snooping bridge, and immediately add a port to it:

    root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && \
    > ip link set dev x3 up master br0
    root@infix-06-0b-00:~$ ip link del dev br0
    root@infix-06-0b-00:~$ mvls atu
    ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
    DEV:0 Marvell 88E6393X
    33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
    33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
    ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
    root@infix-06-0b-00:~$

The two IPv6 groups remain in the hardware database because the
port (x3) is notified of the host's membership twice: once via the
original event and once via a replay. Since only a single delete
notification is sent, the count remains at 1 when the bridge is
destroyed.

Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-joined mdb entries")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---

Notes:
    v1 -> v2:
    
    - Squash the previously separate addition of
      switchdev_port_obj_act_is_deferred into this patch.
    - Use ether_addr_equal to compare MAC addresses.
    - Document switchdev_port_obj_act_is_deferred (renamed from
      switchdev_port_obj_is_deferred in v1, to indicate that we also match
      on the action).
    - Delay allocations of MDB objects until we know they're needed.
    - Use non-RCU version of the hash list iterator, now that the MDB is
      not scanned while holding the RCU read lock.
    - Add Fixes tag to commit message

 include/net/switchdev.h   |  3 ++
 net/bridge/br_switchdev.c | 63 +++++++++++++++++++--------------
 net/switchdev/switchdev.c | 73 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+), 25 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index a43062d4c734..8346b0d29542 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -308,6 +308,9 @@ void switchdev_deferred_process(void);
 int switchdev_port_attr_set(struct net_device *dev,
 			    const struct switchdev_attr *attr,
 			    struct netlink_ext_ack *extack);
+bool switchdev_port_obj_act_is_deferred(struct net_device *dev,
+					enum switchdev_notifier_type nt,
+					const struct switchdev_obj *obj);
 int switchdev_port_obj_add(struct net_device *dev,
 			   const struct switchdev_obj *obj,
 			   struct netlink_ext_ack *extack);
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ee84e783e1df..69ed8f1675be 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -595,21 +595,35 @@ br_switchdev_mdb_replay_one(struct notifier_block *nb, struct net_device *dev,
 }
 
 static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
+				      struct net_device *dev,
+				      unsigned long action,
 				      enum switchdev_obj_id id,
 				      const struct net_bridge_mdb_entry *mp,
 				      struct net_device *orig_dev)
 {
-	struct switchdev_obj_port_mdb *mdb;
+	struct switchdev_obj_port_mdb mdb = {
+		.obj = {
+			.id = id,
+			.orig_dev = orig_dev,
+		},
+	};
+	struct switchdev_obj_port_mdb *pmdb;
 
-	mdb = kzalloc(sizeof(*mdb), GFP_ATOMIC);
-	if (!mdb)
-		return -ENOMEM;
+	br_switchdev_mdb_populate(&mdb, mp);
 
-	mdb->obj.id = id;
-	mdb->obj.orig_dev = orig_dev;
-	br_switchdev_mdb_populate(mdb, mp);
-	list_add_tail(&mdb->obj.list, mdb_list);
+	if (switchdev_port_obj_act_is_deferred(dev, action, &mdb.obj)) {
+		/* This event is already in the deferred queue of
+		 * events, so this replay must be elided, lest the
+		 * driver receives duplicate events for it.
+		 */
+		return 0;
+	}
+
+	pmdb = kmemdup(&mdb, sizeof(mdb), GFP_ATOMIC);
+	if (!pmdb)
+		return -ENOMEM;
 
+	list_add_tail(&pmdb->obj.list, mdb_list);
 	return 0;
 }
 
@@ -677,22 +691,26 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		return 0;
 
-	/* We cannot walk over br->mdb_list protected just by the rtnl_mutex,
-	 * because the write-side protection is br->multicast_lock. But we
-	 * need to emulate the [ blocking ] calling context of a regular
-	 * switchdev event, so since both br->multicast_lock and RCU read side
-	 * critical sections are atomic, we have no choice but to pick the RCU
-	 * read side lock, queue up all our events, leave the critical section
-	 * and notify switchdev from blocking context.
+	if (adding)
+		action = SWITCHDEV_PORT_OBJ_ADD;
+	else
+		action = SWITCHDEV_PORT_OBJ_DEL;
+
+	/* br_switchdev_mdb_queue_one() will take care to not queue a
+	 * replay of an event that is already pending in the switchdev
+	 * deferred queue. In order to safely determine that, there
+	 * must be no new deferred MDB notifications enqueued for the
+	 * duration of the MDB scan. Therefore, grab the write-side
+	 * lock to avoid racing with any concurrent IGMP/MLD snooping.
 	 */
-	rcu_read_lock();
+	spin_lock_bh(&br->multicast_lock);
 
-	hlist_for_each_entry_rcu(mp, &br->mdb_list, mdb_node) {
+	hlist_for_each_entry(mp, &br->mdb_list, mdb_node) {
 		struct net_bridge_port_group __rcu * const *pp;
 		const struct net_bridge_port_group *p;
 
 		if (mp->host_joined) {
-			err = br_switchdev_mdb_queue_one(&mdb_list,
+			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_HOST_MDB,
 							 mp, br_dev);
 			if (err) {
@@ -706,7 +724,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 			if (p->key.port->dev != dev)
 				continue;
 
-			err = br_switchdev_mdb_queue_one(&mdb_list,
+			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_PORT_MDB,
 							 mp, dev);
 			if (err) {
@@ -716,12 +734,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 		}
 	}
 
-	rcu_read_unlock();
-
-	if (adding)
-		action = SWITCHDEV_PORT_OBJ_ADD;
-	else
-		action = SWITCHDEV_PORT_OBJ_DEL;
+	spin_unlock_bh(&br->multicast_lock);
 
 	list_for_each_entry(obj, &mdb_list, list) {
 		err = br_switchdev_mdb_replay_one(nb, dev,
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 5b045284849e..7d11f31820df 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -19,6 +19,35 @@
 #include <linux/rtnetlink.h>
 #include <net/switchdev.h>
 
+static bool switchdev_obj_eq(const struct switchdev_obj *a,
+			     const struct switchdev_obj *b)
+{
+	const struct switchdev_obj_port_vlan *va, *vb;
+	const struct switchdev_obj_port_mdb *ma, *mb;
+
+	if (a->id != b->id || a->orig_dev != b->orig_dev)
+		return false;
+
+	switch (a->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		va = SWITCHDEV_OBJ_PORT_VLAN(a);
+		vb = SWITCHDEV_OBJ_PORT_VLAN(b);
+		return va->flags == vb->flags &&
+			va->vid == vb->vid &&
+			va->changed == vb->changed;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		ma = SWITCHDEV_OBJ_PORT_MDB(a);
+		mb = SWITCHDEV_OBJ_PORT_MDB(b);
+		return ma->vid == mb->vid &&
+			ether_addr_equal(ma->addr, mb->addr);
+	default:
+		break;
+	}
+
+	BUG();
+}
+
 static LIST_HEAD(deferred);
 static DEFINE_SPINLOCK(deferred_lock);
 
@@ -307,6 +336,50 @@ int switchdev_port_obj_del(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
 
+/**
+ *	switchdev_port_obj_act_is_deferred - Is object action pending?
+ *
+ *	@dev: port device
+ *	@nt: type of action; add or delete
+ *	@obj: object to test
+ *
+ *	Returns true if a deferred item is exists, which is equivalent
+ *	to the action @nt of an object @obj.
+ *
+ *	rtnl_lock must be held.
+ */
+bool switchdev_port_obj_act_is_deferred(struct net_device *dev,
+					enum switchdev_notifier_type nt,
+					const struct switchdev_obj *obj)
+{
+	struct switchdev_deferred_item *dfitem;
+	bool found = false;
+
+	ASSERT_RTNL();
+
+	spin_lock_bh(&deferred_lock);
+
+	list_for_each_entry(dfitem, &deferred, list) {
+		if (dfitem->dev != dev)
+			continue;
+
+		if ((dfitem->func == switchdev_port_obj_add_deferred &&
+		     nt == SWITCHDEV_PORT_OBJ_ADD) ||
+		    (dfitem->func == switchdev_port_obj_del_deferred &&
+		     nt == SWITCHDEV_PORT_OBJ_DEL)) {
+			if (switchdev_obj_eq((const void *)dfitem->data, obj)) {
+				found = true;
+				break;
+			}
+		}
+	}
+
+	spin_unlock_bh(&deferred_lock);
+
+	return found;
+}
+EXPORT_SYMBOL_GPL(switchdev_port_obj_act_is_deferred);
+
 static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
 static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
 
-- 
2.34.1

