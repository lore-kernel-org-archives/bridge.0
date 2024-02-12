Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098547A66
	for <bridge@lists.linux.dev>; Mon, 12 Feb 2024 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765562; cv=none; b=FmKahsrkWWwfrB9E793lHM57Og3aXdcYiURXhsr6IItf0HiQ293chnSvLuMWdZKTNS+VgQPE7qfacOs7R8rcmnp37ze+VGxTbzuD+4RKDySKA1wq9MGksrBUQv2ueTIFs6kMbU5y6n1qaX1HGErX8V+F27RvUHBEozn2vEKO9Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765562; c=relaxed/simple;
	bh=xt3z2xnIUrk/4/VdB4kDhMVeLVQCaGtrfW959KnFOsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aNptIjg+rb3BvB/XF6ubKZviainiCXCV7Ak2sjL+gEGtxecgn2nAOje1iJqZPU+pEerPaldhtPaM+ZtF1tacD0fU0xIKD098+FtsQ2LGvnuZj5FMSsd/+nYdNzmye8rtjou9YGDWUqqcAPgwq6E45FtCMnJXCLq+KV+kox+C5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=ZPw5hbvE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="ZPw5hbvE"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51147d0abd1so3938162e87.1
        for <bridge@lists.linux.dev>; Mon, 12 Feb 2024 11:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1707765558; x=1708370358; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4aPTI/TekCf0Wf8qkbCCSdiPoUh0mxEL9Qdf46LyBjI=;
        b=ZPw5hbvEsX7WjDkMk0Zz23ygRz+mn1ocdji35NQuR2gyxmxUpxIOh1JFA6bXUTj9Mw
         Di4Tita5kVsiM+TOQASbhnqCioNM5AooToCozPBlysDT3YbTdEzefeljkiq7ZUsdWM++
         AsdrZ0FEsJvGn+6gWYTfTuBUr04ujYyrkqLdLUiaFecmOd88NrHILmtde1RIxOW7i13x
         cpyn2uEnSCM6HbW6fNPb9G4cRdonuREuKGj/h6kSSbyOzXTmYJ4Tl9T4t43EuzZubun/
         2ImcvjwWGdPtwj31bdiawWMht+j/+EMDnPdOpNX/HG5bwpr8AkpPIRBTViiTKfsqLTNQ
         9qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707765558; x=1708370358;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4aPTI/TekCf0Wf8qkbCCSdiPoUh0mxEL9Qdf46LyBjI=;
        b=FqZxgsqalkq1N/OB4POxWEsF06MHGCbQn3FV3SLM4NJwaLPMFd2cnItNgrH/eVYauR
         OcRtcscFnyP5nRHKHsYadFpkAXuJ27Yp2AkLVxCKS2Fbl7Y7G0Gs6P6MIh/+9MOxWyou
         doR++LanxJcJmO7anffPdj06BpW6vleZGKYrPrVfTY+E6VeP9eSsXAGo5qtcdBSzYRCW
         Uqx0S8FwcZb9xDlIKHUhGJob/R5kj3lh3P/ORYbriwYLNC0XQghzXkMCC0QlrOFragG1
         WSwYBT638y32ycOei9Gge0zgE/Ze236tZzUQOhuRAMcttMftxzKHtF+QWzfQc02SsByh
         /ELg==
X-Gm-Message-State: AOJu0YynPZ3U2TipcUfdJ0X1X12VZWjYIwUm2jMOSJRV89aYzpd6ZUow
	8yyxddDjvi9WkJmZ4ZcKTo2XmzkhX0BsB3TCanB8BQcUHOsNiyYgC4J2nvhoq+8=
X-Google-Smtp-Source: AGHT+IESd8v5St3pTzCOqO9y59SeHmC5VbzjluC/Mfcgkw/g94D1BB0yTT56TWTkqPKDstaguRCkmw==
X-Received: by 2002:a05:6512:e83:b0:511:4e8c:7d02 with SMTP id bi3-20020a0565120e8300b005114e8c7d02mr6321893lfb.48.1707765558444;
        Mon, 12 Feb 2024 11:19:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEVdGQFb4Wv1nR+AofVjfUVbOQTk9Txk0mTx5VKxfsNh83BQ4Si/h++IzoyV4rF47xu+WnapcVbvMcg4Nv0dUE6Hl/0brXLpFVoxO1jASB05Gua6wuXp8IcsuUKxMzaHwsX80JNdUNtWkG0qFZoL8xXZRBv15/0XFzohHTZGDrpMiYGrUHTaGcry85/ecSieQtaiM7YvKHTY2L8+zy9QXLM/48dc7rQpnAiXBBRkTHH9ptpcqp0471EelqbjC2byX8lVv7fX4wZtvDGlh3gEUe
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id n9-20020ac24909000000b0051157349af3sm974647lfi.47.2024.02.12.11.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:19:17 -0800 (PST)
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
Subject: [PATCH v4 net 1/2] net: bridge: switchdev: Skip MDB replays of deferred events on offload
Date: Mon, 12 Feb 2024 20:18:43 +0100
Message-Id: <20240212191844.1055186-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212191844.1055186-1-tobias@waldekranz.com>
References: <20240212191844.1055186-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Before this change, generation of the list of MDB events to replay
would race against the creation of new group memberships, either from
the IGMP/MLD snooping logic or from user configuration.

While new memberships are immediately visible to walkers of
br->mdb_list, the notification of their existence to switchdev event
subscribers is deferred until a later point in time. So if a replay
list was generated during a time that overlapped with such a window,
it would also contain a replay of the not-yet-delivered event.

The driver would thus receive two copies of what the bridge internally
considered to be one single event. On destruction of the bridge, only
a single membership deletion event was therefore sent. As a
consequence of this, drivers which reference count memberships (at
least DSA), would be left with orphan groups in their hardware
database when the bridge was destroyed.

This is only an issue when replaying additions. While deletion events
may still be pending on the deferred queue, they will already have
been removed from br->mdb_list, so no duplicates can be generated in
that scenario.

To a user this meant that old group memberships, from a bridge in
which a port was previously attached, could be reanimated (in
hardware) when the port joined a new bridge, without the new bridge's
knowledge.

For example, on an mv88e6xxx system, create a snooping bridge and
immediately add a port to it:

    root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && \
    > ip link set dev x3 up master br0

And then destroy the bridge:

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

Then add the same port (or another port belonging to the same hardware
domain) to a new bridge, this time with snooping disabled:

    root@infix-06-0b-00:~$ ip link add dev br1 up type bridge mcast_snooping 0 && \
    > ip link set dev x3 up master br1

All multicast, including the two IPv6 groups from br0, should now be
flooded, according to the policy of br1. But instead the old
memberships are still active in the hardware database, causing the
switch to only forward traffic to those groups towards the CPU (port
0).

Eliminate the race in two steps:

1. Grab the write-side lock of the MDB while generating the replay
   list.

This prevents new memberships from showing up while we are generating
the replay list. But it leaves the scenario in which a deferred event
was already generated, but not delivered, before we grabbed the
lock. Therefore:

2. Make sure that no deferred version of a replay event is already
   enqueued to the switchdev deferred queue, before adding it to the
   replay list, when replaying additions.

Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-joined mdb entries")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h   |  3 ++
 net/bridge/br_switchdev.c | 74 ++++++++++++++++++++++++---------------
 net/switchdev/switchdev.c | 73 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 28 deletions(-)

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
index ee84e783e1df..6a7cb01f121c 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -595,21 +595,40 @@ br_switchdev_mdb_replay_one(struct notifier_block *nb, struct net_device *dev,
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
+	if (action == SWITCHDEV_PORT_OBJ_ADD &&
+	    switchdev_port_obj_act_is_deferred(dev, action, &mdb.obj)) {
+		/* This event is already in the deferred queue of
+		 * events, so this replay must be elided, lest the
+		 * driver receives duplicate events for it. This can
+		 * only happen when replaying additions, since
+		 * modifications are always immediately visible in
+		 * br->mdb_list, whereas actual event delivery may be
+		 * delayed.
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
 
@@ -677,51 +696,50 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
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

