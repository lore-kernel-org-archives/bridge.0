Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE111626AD
	for <bridge@lists.linux.dev>; Thu,  1 Feb 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803859; cv=none; b=pctXUI28WRZKou9hsHP+hM/OCGGB8CqJv/aGzpp+9Sm3pEPKNXM0iIRSDkls3mxWDsYm+0bydFG8VUP/ugRG5YTzd9IPJ5HbFLCJjBjN92dqwxXDLsayPyKygtrWgx5VHY9hJU1Ke9XHU1bWMoMI39zg4+q6e4v2R7PVq7Zf0jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803859; c=relaxed/simple;
	bh=7cgT8swYUHF5iJkB8D8jTLHsvEi1ThHpXgJDwGV1tMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WXz4bqXVdR85BX+TtJBngeWYfhKNElJ1XwwkST+qqDRED8edBZOZIryPNuerRAOjIkjv9C/GQilXnCyJztO6KQQfFk0Zn6owZmpQyr5wc5vqT8/tYD6r//pCISYmHP8u1mghFeE7vQ42JAmXvyD4iVveE1XGM9oKBxmRVL4kTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=prj/H0NZ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="prj/H0NZ"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d07f2696a4so3826231fa.3
        for <bridge@lists.linux.dev>; Thu, 01 Feb 2024 08:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706803854; x=1707408654; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUVoc0E/OYa+AToYGz8Q4BBQZXgHdlFQ4US1MgCl+mc=;
        b=prj/H0NZFVSHlc+VkTL71ro5wQeF/n7YQKWGWARKdieaU8wxciTMZhMMigWH52DNdQ
         BY2mqJ8InttJPm3rrc/UkaijTdT5Vw8qAAq80bm3v+M5IiEav0IKyzZnP3frKO7iqGr4
         Eg1k498E8L5/MbI6A8m/T9J37ldFwgtQf/+MYre9EztPimObpx8WlOxaYf62/HU2IYLm
         nYr+9ouyOb9VPRMrfVEmY/WYA3xnYtis1SlEUZLjdyrQ5Vdbu7OygQ3bcQuP7xMlcyot
         Fs5slEav7IMeTMG65hIQjTDP5RJby5B6JnvWm29SC/H64J0lacZiA+/m2pPk7XC2+GIu
         OsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706803854; x=1707408654;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUVoc0E/OYa+AToYGz8Q4BBQZXgHdlFQ4US1MgCl+mc=;
        b=fPPHvmtyA8xm/Rno23nH3nKZqkniV8a1Mbwl73MCTGPKntWlO+gt/fhKtxIjM1TkZA
         MPpxkuxo/GqNJf5zNjwRehvgUQm0SFaSH98/zPRswmRAY9IJ+U4gMqbFbMjY1RNuYbu7
         tg7/ICBQAtgbPFbugfpSP7JPFwLbtVSOXncLABbpBCGE2RzBSXYnE9Bf7hFOBBJeHowK
         2o6rTQRZjq7Jt/Zfu1qO+M3NC/LtpX45IOTXBr82BYfDfHRwg0adJx0f6YvgEjcwok52
         +xZbhIyNLdLIGVWt76qII/P2xQ1yaALpEet7SKHAtGvkSJ7oLTT0wAAeBw3tJdmG8cO7
         qU2w==
X-Gm-Message-State: AOJu0YyIJ4hW7G/vJ/USqpUTPeGJKg+BbbQ9Z/tB7MdKC2nr8gm/Oc5r
	sThIdJQuufh6dcOk23XPWQ6iqczMwcKgi5DiYQzYoNE6fvFWZf8TTTfCZfW8eh0=
X-Google-Smtp-Source: AGHT+IEdykIuN7/o5lMWik40LVDQK7zQYhARMjAg93ApuRHTe0/QCoSK6b2B/arIFRjh+NgB82J8WQ==
X-Received: by 2002:a2e:6e0b:0:b0:2cf:1535:9307 with SMTP id j11-20020a2e6e0b000000b002cf15359307mr3628705ljc.52.1706803854453;
        Thu, 01 Feb 2024 08:10:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGBcHjBKKa9Hp1Frq6z0IhePrlvdjjS5lMePe36KtqClUHsi+17zOCRo3fL/61kEee3EP22cbvJHlAJAOv1ZRrajV5LxO4jM8tr8svg78hkH1YJ18mrFkVwvjaT8j5ZPyo8ATuuaDkTwwQw54g6QhIbtk8LYOgI7emnOjzRFRa63HvcxYuA2woYcbhtHKRGty6n1+y1kIcSSmxEiy1JblXIq32EJ9JIuK0NcJufeKRkyGSi68W+o8EAEL0iZZxf3Ag5MveLRHRqF0zMESj02fb
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id y1-20020a2e95c1000000b002cd7a4a2611sm2427088ljh.35.2024.02.01.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:10:53 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: olteanv@gmail.com,
	atenart@kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com
Subject: [PATCH v3 net] net: bridge: switchdev: Skip MDB replays of pending events
Date: Thu,  1 Feb 2024 17:10:45 +0100
Message-Id: <20240201161045.1956074-1-tobias@waldekranz.com>
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
    
    v2 -> v3:
    
    - Fix unlocking in error paths
    - Access RCU protected port list via mlock_dereference, since MDB is
      guaranteed to remain constant for the duration of the scan.

 include/net/switchdev.h   |  3 ++
 net/bridge/br_switchdev.c | 69 +++++++++++++++++++++---------------
 net/switchdev/switchdev.c | 73 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 28 deletions(-)

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
index ee84e783e1df..6d3fb4292071 100644
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
 
@@ -677,51 +691,50 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
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
-				rcu_read_unlock();
+				spin_unlock_bh(&br->multicast_lock);
 				goto out_free_mdb;
 			}
 		}
 
-		for (pp = &mp->ports; (p = rcu_dereference(*pp)) != NULL;
+		for (pp = &mp->ports; (p = mlock_dereference(*pp, br)) != NULL;
 		     pp = &p->next) {
 			if (p->key.port->dev != dev)
 				continue;
 
-			err = br_switchdev_mdb_queue_one(&mdb_list,
+			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_PORT_MDB,
 							 mp, dev);
 			if (err) {
-				rcu_read_unlock();
+				spin_unlock_bh(&br->multicast_lock);
 				goto out_free_mdb;
 			}
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

