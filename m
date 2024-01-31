Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D788E79DA3
	for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704559; cv=none; b=tBetL+BfcZGU+nPGQsfZdarMvKReEPTtOc0X26QrXt7ntVo9f8cbWk/fRAWMUK5DDRZyzMVzzcCJXsgVLCC+PvWuEWwHdZcRHexDOhlXLGk7ZlGECNMkKksYrUKR8FrDScM93FTlDVlenEdNo90CaPUor0SmGN/5y0zY5fLY5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704559; c=relaxed/simple;
	bh=go1CxnwkYrNSMMXZA9us4VqyOB02NCR6uu21U6/jbb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPnc2kO7kXpELo6WSk8vtLfDOIw3YHBSTScyJ9i7MVXRMDbivI9inZGqM1QxLrVrPVV0iXgnlkc+ZjboscODIA9bc6RzXt7zb0BG/WTRhtCWNaQAgu51W/9Fy49eZ6JV9iLJDN2e1UjK1UightqfhPAQhNFiaJccgMQ/S/JAFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=qrBWkj1B; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="qrBWkj1B"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso63006781fa.3
        for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 04:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706704556; x=1707309356; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QEiIF2a77a2NYlBdF0rnvbhZ9XEvtTWVhxdh+i0lTps=;
        b=qrBWkj1Bp/MZTv7CbjeEN+9kO3qHwsEDaPxE1eawk2JyPF3aFzzjDAkWKAv0llQab+
         EErBZFebY6EnqzuMTSQHO3PRW008nAXM4PPHnZ8CH8Drtfc09dJysX5XNJPLHGubJHfe
         X7EwswawuU/xfcfN2SF76OzJfVWRGhYPuZQ4Mt1K7QR9yWAVyHN1Lh/2GD1eOjLGBFNn
         3gVN6d/XVWq/AQ0mjFvrI97mj8WW2PFXlwDyFiwUPiQb2akcKL3aZMobJ7c4ivdcNp+5
         xsHsO+0VHrP+SDhAdG8XWi/E6pXXm9qq680l3RkONqHoyHvxzlKnvxB3q0p086gC8BL6
         4lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704556; x=1707309356;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEiIF2a77a2NYlBdF0rnvbhZ9XEvtTWVhxdh+i0lTps=;
        b=uL10JCSksjhSIiyxV1f+6/ro2mPfhEf9L7WWDm0ViW5ka25ydeBZ00XeqNYhbktJ4H
         L/no5l7Q7ctqAXxNwQrVD74tiwBZAU+6Fx/xASXMmIQe/nudV2xGtrMzc4/4rhvjwhD/
         TJYDYckO/1nzG354Z0017YafB9dWbhzRIKM3Hnb9FL2+yiVL0uLhYw4r4WrxuBfIft0T
         1FxQ8nizRt425Rr/KFoQAaN75gMYEH2bL62nYMQEYsEKXcZmkRtnh0MaoJB2EzinJzdn
         Kn0yh/IZAdV5Tno3yOOhkFcFIS7h4Fk3PZjCnb5EcVq8huX4rmFZg05s0ZAHCbu7FGpW
         vbAg==
X-Gm-Message-State: AOJu0Yx9pEG8/tgRske5gYlDft8rkTxFBJLj/Qs34JF8o4HubCZr4OnR
	m1E5+uOQu9Qs0/gF2MT4qwagfMOv7RjOGRup6hKXU4ajnldwPgXi+jwk1C9yZCM=
X-Google-Smtp-Source: AGHT+IF2YwYWLus8PuFNfKLdfhUbeyNe6T0Pteaa0qeEdznNQXcwqXUMLHRIieF9cyqckkxKrvd96g==
X-Received: by 2002:a2e:7011:0:b0:2cf:2ef2:87f7 with SMTP id l17-20020a2e7011000000b002cf2ef287f7mr942673ljc.53.1706704555700;
        Wed, 31 Jan 2024 04:35:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXKNd1C9bpqVIlZCyele8ttZpf1tBlvnerSbbAefCXaKrZ9qcLUqipgcsFtqQL0JE6dUPwKSW9ycDvkbhYZEyeBGqQQGQRmyNdWBEWtRO7bPAVKVJIH0G7DVWwRtCIWEUVUGEqGdCJCH1JCBL0Cl16qXWE39f+GQj/JSJzGr5GDGD9Yi/+/DLcpeIQk+wgowyHi9OjshEdiR0yVfEQsL1UbmUfHqoDaOW8jXidWxiLeTeVwKbJynh4YWiOYaQ==
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9bd5000000b002cdf4797fb7sm1913517ljj.125.2024.01.31.04.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:35:54 -0800 (PST)
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
Subject: [PATCH net 2/2] net: bridge: switchdev: Skip MDB replays of pending events
Date: Wed, 31 Jan 2024 13:35:44 +0100
Message-Id: <20240131123544.462597-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131123544.462597-1-tobias@waldekranz.com>
References: <20240131123544.462597-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Generating the list of events MDB to replay races against the IGMP/MLD
snooping logic, which may concurrently enqueue events to the switchdev
deferred queue, leading to duplicate events being sent to drivers.

Avoid this by grabbing the write-side lock of the MDB, and make sure
that a deferred version of a replay event is not already enqueued to
the switchdev deferred queue before adding it to the replay list.

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
port (x3) is notified of the host's membership twice: once in the
original event and once in a replay. Since DSA tracks host addresses
using reference counters, and only a single delete notification is
sent, the count remains at 1 when the bridge is destroyed.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 net/bridge/br_switchdev.c | 44 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ee84e783e1df..a3481190d5e6 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -595,6 +595,8 @@ br_switchdev_mdb_replay_one(struct notifier_block *nb, struct net_device *dev,
 }
 
 static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
+				      struct net_device *dev,
+				      unsigned long action,
 				      enum switchdev_obj_id id,
 				      const struct net_bridge_mdb_entry *mp,
 				      struct net_device *orig_dev)
@@ -608,8 +610,17 @@ static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
 	mdb->obj.id = id;
 	mdb->obj.orig_dev = orig_dev;
 	br_switchdev_mdb_populate(mdb, mp);
-	list_add_tail(&mdb->obj.list, mdb_list);
 
+	if (switchdev_port_obj_is_deferred(dev, action, &mdb->obj)) {
+		/* This event is already in the deferred queue of
+		 * events, so this replay must be elided, lest the
+		 * driver receives duplicate events for it.
+		 */
+		kfree(mdb);
+		return 0;
+	}
+
+	list_add_tail(&mdb->obj.list, mdb_list);
 	return 0;
 }
 
@@ -677,22 +688,26 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
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
+	/* br_switchdev_mdb_queue_one will take care to not queue a
+	 * replay of an event that is already pending in the switchdev
+	 * deferred queue. In order to safely determine that, there
+	 * must be no new deferred MDB notifications enqueued for the
+	 * duration of the MDB scan. Therefore, grab the write-side
+	 * lock to avoid racing with any concurrent IGMP/MLD snooping.
 	 */
-	rcu_read_lock();
+	spin_lock_bh(&br->multicast_lock);
 
 	hlist_for_each_entry_rcu(mp, &br->mdb_list, mdb_node) {
 		struct net_bridge_port_group __rcu * const *pp;
 		const struct net_bridge_port_group *p;
 
 		if (mp->host_joined) {
-			err = br_switchdev_mdb_queue_one(&mdb_list,
+			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_HOST_MDB,
 							 mp, br_dev);
 			if (err) {
@@ -706,7 +721,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 			if (p->key.port->dev != dev)
 				continue;
 
-			err = br_switchdev_mdb_queue_one(&mdb_list,
+			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_PORT_MDB,
 							 mp, dev);
 			if (err) {
@@ -716,12 +731,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
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
-- 
2.34.1

