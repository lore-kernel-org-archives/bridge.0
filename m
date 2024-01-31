Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB079DAC
	for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704559; cv=none; b=FVvZyJawtIZQqD2ujoHyxBbNmVQsB7gk8GTapMCC8eucq2/6hRFSuxJRyUfXH4tyYaXusTa12gb/3YjBbDrvc3I67wMtr+SfqfCpNj5tFymL8c3OCxivCtDscOlNMyMPoNRITowoxWtO91QsYJh6tBM3e5AEqPJmTUtapJOdiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704559; c=relaxed/simple;
	bh=m26awy1qzqb5RQAB1yDRqj2kQi7kNDLCcpHamrlHnHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SoQvG1QENzg5TTz4oMxPBoG2C6Hf138GWwVbK29gN9UGJxZG747vf6zUFFXVm559BhM6vSh6vw2T3MVCCzOqwEvrrNn1WCLRV/LT19VbAgoywH/BfOlTld52Ki9XbKPU6sks4JZJtulQG1HwD1C+bzaPMUXLzuOXjNmm3VPK6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=LPnX0TJ4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="LPnX0TJ4"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d04fb2f36bso32039211fa.2
        for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 04:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706704554; x=1707309354; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SMg02lM/CbIVQI4/Q7innU4UKi1k6bvYIXOkzFVqAIY=;
        b=LPnX0TJ4wysOruLPPrCYQavBPyKLimLGjXYUu7XCU5Q6fZdGUEygDpQcmwsFPh0kkA
         3Diu2fl8SVdm7It19pejPLwRR4hOusWUZt4kfG/YHYxL58K94fq19UXBPFC5oW3c0HhT
         SU3NVaH8P+3K0TZm77zzS1eGAqQRGIrQcXwpvDUO6TDqIiyt21DIul5XwXG4Rc6FdmAR
         bXnk1CRCNykfr/2Jfs3r5dsBKqPL1pcZvvT0aHdDaYtmL864Uqis6pULDVk+x37qZQ0J
         r634qXKZ7SDT7mFigvMdCj0cCj+uLViCPzcSkZxSyrskK3f8cJPtBkv2/6z4t3cT/Zwc
         tUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704554; x=1707309354;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMg02lM/CbIVQI4/Q7innU4UKi1k6bvYIXOkzFVqAIY=;
        b=vhgzmWO2th1doKDw+T9R1SkqU58IIMTWE4j/cLEr3fG2h9CSivVmDGPEp/xJCyoETt
         H0In1bWZA5GMchuI0KemuBfNxnURG1AuvCspaQ6E+yVZbw+UxhaT6YQGWJePyZ3qyLr1
         qa+/ipGO8OxdauHXONpblS0IFs7qL+Trb8+u7T0+/Gdclx5d3YJoxJwJvvCUi+cETSOR
         L6z2kURFVUkudi0CWTEJ2DMwqd6XZjZIJ1ms3qor7arAZZPviblai0iFC3PTF4lEB7G+
         DpCwD8x0kon1qVI/T2it4Xv+JrjLm5gBAOhEJ1rC20wnyb67KnoI7Q+oX10ytMBzhnDc
         t1Hg==
X-Gm-Message-State: AOJu0Yx000rnkC+vv3sgEUq4GhdgaUD/lk8HrsgDIRzq7WyTPFJFZSOC
	ji3CxLMaPYb4pjxG7uCdTHG4vBelRxnzP9d1DbkKjJ2PrSedDo9nq0BJRtS4ddo=
X-Google-Smtp-Source: AGHT+IHWomoXHEp+Qg2CxVD90b+O9m4lCUVtbzGn+2E4KUqnP7hhN4yeseuwxawWVqJoTgZPt/AGsQ==
X-Received: by 2002:a05:651c:2204:b0:2cf:1920:97 with SMTP id y4-20020a05651c220400b002cf19200097mr1447143ljq.12.1706704554198;
        Wed, 31 Jan 2024 04:35:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWGLMF6P5Mp6lAIC2kZRj/qq/gF6bKcoOFdWHkMUpJx7hDdLeNN6U5GyK/0c4BPrSugfijzXKWHPgASckRfi95WTB5OpRQCF+bVehmbNlxfaGxYroA44U0OVHHzPMxhBvetqlYEiKYdarLItKwp0vt3SnyBoih14c5svwvg3mn9cu6Nz1km32020wDJCtdHFsSF9m9B30kb4zPLAaPPCyAu4ZdqlKYYewkI53YcNHYBm9dpAceGe8YX0sLwMA==
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9bd5000000b002cdf4797fb7sm1913517ljj.125.2024.01.31.04.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:35:53 -0800 (PST)
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
Subject: [PATCH net 1/2] net: switchdev: Add helper to check if an object event is pending
Date: Wed, 31 Jan 2024 13:35:43 +0100
Message-Id: <20240131123544.462597-2-tobias@waldekranz.com>
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

When adding/removing a port to/from a bridge, the port must be brought
up to speed with the current state of the bridge. This is done by
replaying all relevant events, directly to the port in question.

In some situations, specifically when replaying the MDB, this process
may race against new events that are generated concurrently. So the
bridge must ensure that the event is not already pending on the
deferred queue. switchdev_port_obj_is_deferred answers this question.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h   |  3 ++
 net/switchdev/switchdev.c | 61 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index a43062d4c734..538851a93d9e 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -308,6 +308,9 @@ void switchdev_deferred_process(void);
 int switchdev_port_attr_set(struct net_device *dev,
 			    const struct switchdev_attr *attr,
 			    struct netlink_ext_ack *extack);
+bool switchdev_port_obj_is_deferred(struct net_device *dev,
+				    enum switchdev_notifier_type nt,
+				    const struct switchdev_obj *obj);
 int switchdev_port_obj_add(struct net_device *dev,
 			   const struct switchdev_obj *obj,
 			   struct netlink_ext_ack *extack);
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 5b045284849e..40bb17c7fdbf 100644
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
+			!memcmp(ma->addr, mb->addr, sizeof(ma->addr));
+	default:
+		break;
+	}
+
+	BUG();
+}
+
 static LIST_HEAD(deferred);
 static DEFINE_SPINLOCK(deferred_lock);
 
@@ -307,6 +336,38 @@ int switchdev_port_obj_del(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
 
+bool switchdev_port_obj_is_deferred(struct net_device *dev,
+				    enum switchdev_notifier_type nt,
+				    const struct switchdev_obj *obj)
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
+EXPORT_SYMBOL_GPL(switchdev_port_obj_is_deferred);
+
 static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
 static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
 
-- 
2.34.1

