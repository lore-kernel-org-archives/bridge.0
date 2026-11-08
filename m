Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136606;
	b=YN2setFgxWFc0tv0mEQbcns1nY/mNKh9ZF0DUVyQ80/6w93ed+TUiS1pG4dawYeDp/Tx
	 STrtuY0wFXCrwregWemRLex2m/dszdTXRvvZeR8VR4r4iw206DC9OBxE/UfqCYhaY04L/
	 /IuyJT4jdhrJjKok4OFumWd+kxAzaaO/I7oa4N9s3ll3Iyw3SEAZkL2NV+Qa+tiCKJToV
	 h9yQymHZSCPUdwiU0q6hmxerNAGSEs4jn3FbuysYetIFslGC5GkBXHJwC/DfUr2eSnt1x
	 MPliCJDuljxTFcr2uiJ7vvmkG+e3Sg9p2ABC7bOs0/LwZYbOpAAymfygi+4ttyG33Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EP97KCqcACuZR8x/O/WoysPLrZt4tckt8Ahh2JLLpHg=;
	b=lRvEdKRJEpBCvFfnIVCf0tvpIuFhAxHESuReyMgrozZLg9QivzAlG6JnJOjwBIK+Cm/S
	 yMHqzoby8zUT56wqDNE9GSR/jjnOzSaQBILvZ8l+nLmW3OCe1IvPLeYOAT71PCB8joX6h
	 s+dy06PZI1w2L8mdAlWl4um96meEYHgAimwwtPU9aaTrEezkfBaycSFK4OJrn9Gn0I1Vl
	 erKGKxk6FWXGLzSGbbCiyZP8LUQjvD9WjajOpIKNwO5IZnJwrVbj4BImt4DKEpkaYtzxW
	 WqlnrrRuZ4sEIuTYKPxGZncpo/MiHTGsordTozfWfxNKJJz8JpbbrGJ6Xapon0Oty+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=e7FavZEU;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE34606D802
	for <bridge@lists.linux.dev>; Sun,  8 Nov 2026 11:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DE34606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=e7FavZEU
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4550d8ab15so5124566b.2
        for <bridge@lists.linux.dev>; Sun, 08 Nov 2026 03:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794136604; x=1794741404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EP97KCqcACuZR8x/O/WoysPLrZt4tckt8Ahh2JLLpHg=;
        b=e7FavZEUtEZs2F7Jg7AbFaoHtRgmmCGZNd7PJhcwIch2LzKblEJloSmL+frzdTYOrO
         9s2lr9ocIsvJRPNKcetv2X9K6V9PqDELH5iaon26JVrHFUvev56OKVQY9IaC7mX78JPi
         BoJQrXjAdXoYY0Ri/TGw90DFMHUWH7Kno1hk/PV4F4BktyozZ72tKYztQCtn3b2C9ubS
         Ko2GxmtXaGjQeRYDfDkefKeLBzKNxZH/Qk+0w8nbPd64eadMfxazkmLRMMLLRSyn6r/B
         ThWvkR8ZxS15S/nP8f0lr3knBWrbSETtaZI06mV0FBIZM3yxVIMjhgZ5bcP3z4xZrq2r
         PBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794136604; x=1794741404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EP97KCqcACuZR8x/O/WoysPLrZt4tckt8Ahh2JLLpHg=;
        b=PS3xLqO+YQINadrapGjf5KaQV1fvXDiaCZCYSBSDuYkx0kHTnw1zfWsrVCFDcqGjih
         zL/TBpfgq3KhxcunyxdYpTD33VQFP5lk3E5ZorItBVZCjIOe0IUT9S2dGKMSAgcn0MaT
         ZCrFb/CsBcQCiGyRmUJmZTVUWBOzezVLp8VAsy8h1rXtfRR/Qn1MlcaUfW8KXXENQw5l
         noeuYZ3pF9fpp6rzZC3nXsYqDot9BAJjHfm0k/pEdxJz4dW2eWUPY+YbY62wVbkz5apS
         z9Cl8nPAKH8TjNZ9iWgvEweZTsaLnkyK1xPM3OXfv0rOs8YQwwaDZaFBtPHQ0c/UHq6q
         nssA==
X-Forwarded-Encrypted: i=1; AL+hErH69y8VgnYDqXEsF8vq3lT5hIH/qWHxAcG0IrzkvO4Fy+8XixSQ1aIFl5bByXT0J+I+/TUIO54=@lists.linux.dev
X-Gm-Message-State: APuU4Z9JYJGbZFbHRcjGtu5b4zpz79PfON4U5Kbqc8Rm0lao3q3XQg0V
	g3iSw+ky+JVIQa22uQUBbOizIXvqCDOejiUjePMrhOGpi9zijIyKWltDt2UhtYSnsA==
X-Gm-Gg: AYBFou3PXLCRanm+jTu1oH653tgLaCF5f4/BcfM38/yxXb35jKah6eW6jflj4FZ03Ic
	zZ7k6Zl2RX+H3/+nSWM0AgHCOrz0zx5th5LHSa+2OMYxIB0O/C+rDQ/o3W2PvpXxs7EbWX3a45y
	so4JzD/zJBqY5NtNYN3oB3ZypVatrf79u7iq8MMckzjxchPW8HcbTmXB7dWYsx0H8ipfgOnO4ZW
	sf+ZsM20MO96tYxsyb3Po1nom5pSCIQepLgvcNeWD+hzPvhmKwaa+v6fs1tZ0zRP0lkMCmAtnIO
	2NNe0w/OzfvbS4OaSQQak9qJV8A+h89PiZ+07tAfEDSHLTpUsgNf0v8HypL6mJt0sE6tQNZXzri
	SzB2cvQYfvrlwK24UkJUhJE9qBPelvggc7YD9i1dmPqhSEoT/wvw/b1jIeG1vE/G51hVpczCI6S
	RGpwkeDRM4trteVnfh/8pwYo5aRt7HF8rjVl5Ygr0ctW6M98tVn126Asz7kYjq4em2483W3CMBO
	wjOMR1MKwwpDIKFN+N5hwX4bWp22WCtoPuXRgmj4i2RrcuIYL4JXtOB76pVPf/75QbIccyqVaRB
	RjOs1kQ/2B20m37SYns55j+TgIbr8hN+HogD6QunoEK0/FmbsEcgtMkBLY9u7VMZ0T83o0b4E3R
	WvAw3H0Q9toV8Q45rqFWsIf6/wHuqUVlZv/OiSXi2FYP0O2BfyN4GDk6ihPh20+gzMUVpgwE6Ly
	F7ZN2CBfPDNodMGWXs/c4TNUO1o9suRJlR0HsLzbKVj/hZ9UqGAHcmftrfKgGNLsAnHssGUgmy3
	gQhuH8iejeYVtF7FV2IvKVVa4NsK6iqvNXQ6D01kk4BnHTUZMriEHEIH+QZe13bA8s02AkZcq3d
	t4Q0CYu/zCjTTXhIdvk=
X-Received: by 2002:a17:907:c28:b0:c29:5d41:dfe8 with SMTP id a640c23a62f3a-c4d6d865a0cmr82961966b.43.1794136603862;
        Sun, 08 Nov 2026 03:16:43 -0800 (PST)
Received: from Desktop (p54afff19.dip0.t-ipconnect.de. [84.175.255.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a99320bsm54261166b.67.2026.11.08.03.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:16:42 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: dsa: fix host fdb refcount when a bridge fdb entry roams
Date: Sun,  8 Nov 2026 12:16:39 +0100
Message-ID: <682c2f99d3e5c61e620d768a31107b2cc7db51a6.1794134495.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794134495.git.julius@bairaktaris.de>
References: <cover.1794134495.git.julius@bairaktaris.de>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bridge FDB entry on a foreign port is a host address on every user
port in the bridge. When the entry roams, br_fdb_update() notifies the
deletion from the old port and the addition on the new one without a
lock. With two CPUs receiving the address on different ports, DSA can
get two deletions for one addition, an addition for a port the entry
already left, or the deletion before the addition. Counting these
events either makes a deletion find no reference left on the CPU port,
or leaks a reference, which keeps the address on the CPU port after the
entry moved to a user port or was deleted. The first ends in this
error, here from dsa_loop:

  port 1 failed to delete 02:5a:0b:a2:1a:46 vid 0 from fdb: -2

Instead of counting, each user port records the host addresses it
holds, and on every event holds the address while the bridge has the
entry on a foreign port and notifies switchdev of it. A deletion that
still finds the entry on its own port was sent before the bridge
changed the port, so the address is released. An entry on a user port,
also one of another tree, is notified only to that port and is not
held; an addition there releases the address on the other ports of the
bridge, which also covers a "bridge fdb replace" onto a user port that
notifies no deletion. Replayed deletions release the address without
the lookup. When the port leaves the bridge, or fails to join it, the
workqueue is flushed before the bridge is freed and the records left
are released. Addresses local to the bridge do not roam and are still
counted. The software bridge is not changed.

In QEMU, with dsa_loop given FDB operations and assisted learning, two
veth ports in its bridge and one source address sent from both on two
CPUs for 5 s, the deletion fails and the address stays on the CPU port
after both veth ports go down in 4 of 5 boots. With this change neither
happens in 5 of 5 boots, and the address is removed when the user ports
leave the bridge. A "bridge fdb replace" of the address onto a user port
leaves it on the CPU port in 5 of 5 boots without this change and
removes it in 5 of 5 with it.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/dsa/port.c |  36 +++++++--
 net/dsa/port.h |   6 ++
 net/dsa/user.c | 216 +++++++++++++++++++++++++++++++++++++++++++++----
 net/dsa/user.h |   8 ++
 4 files changed, 242 insertions(+), 24 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 1f5536c0dffc2..e270a0c5e6641 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -457,7 +457,13 @@ static void dsa_port_bridge_destroy(struct dsa_port *dp,
 {
 	struct dsa_bridge *bridge = dp->bridge;
 
-	dp->bridge = NULL;
+	WRITE_ONCE(dp->bridge, NULL);
+
+	/* Wait for the FDB events that still see the bridge, then release the
+	 * host addresses the port holds, before the drivers are told it left.
+	 */
+	dsa_flush_workqueue();
+	dsa_user_bridge_host_fdb_purge(dp, bridge);
 
 	if (!refcount_dec_and_test(&bridge->refcount))
 		return;
@@ -528,7 +534,9 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 					&dsa_user_switchdev_blocking_notifier);
 	dsa_flush_workqueue();
 out_rollback_unbridge:
+	dsa_port_bridge_destroy(dp, br);
 	dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);
+	return err;
 out_rollback:
 	dsa_port_bridge_destroy(dp, br);
 	return err;
@@ -1040,13 +1048,14 @@ int dsa_port_standalone_host_fdb_add(struct dsa_port *dp,
 	return dsa_port_host_fdb_add(dp, addr, vid, db);
 }
 
-int dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
-				 const unsigned char *addr, u16 vid)
+int __dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
+				   const struct dsa_bridge *bridge,
+				   const unsigned char *addr, u16 vid)
 {
 	struct net_device *conduit = dsa_port_to_conduit(dp);
 	struct dsa_db db = {
 		.type = DSA_DB_BRIDGE,
-		.bridge = *dp->bridge,
+		.bridge = *bridge,
 	};
 	int err;
 
@@ -1066,6 +1075,12 @@ int dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
 	return dsa_port_host_fdb_add(dp, addr, vid, db);
 }
 
+int dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
+				 const unsigned char *addr, u16 vid)
+{
+	return __dsa_port_bridge_host_fdb_add(dp, dp->bridge, addr, vid);
+}
+
 static int dsa_port_host_fdb_del(struct dsa_port *dp,
 				 const unsigned char *addr, u16 vid,
 				 struct dsa_db db)
@@ -1091,13 +1106,14 @@ int dsa_port_standalone_host_fdb_del(struct dsa_port *dp,
 	return dsa_port_host_fdb_del(dp, addr, vid, db);
 }
 
-int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
-				 const unsigned char *addr, u16 vid)
+int __dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
+				   const struct dsa_bridge *bridge,
+				   const unsigned char *addr, u16 vid)
 {
 	struct net_device *conduit = dsa_port_to_conduit(dp);
 	struct dsa_db db = {
 		.type = DSA_DB_BRIDGE,
-		.bridge = *dp->bridge,
+		.bridge = *bridge,
 	};
 	int err;
 
@@ -1113,6 +1129,12 @@ int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
 	return dsa_port_host_fdb_del(dp, addr, vid, db);
 }
 
+int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
+				 const unsigned char *addr, u16 vid)
+{
+	return __dsa_port_bridge_host_fdb_del(dp, dp->bridge, addr, vid);
+}
+
 int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 			 u16 vid)
 {
diff --git a/net/dsa/port.h b/net/dsa/port.h
index 6bc3291573c02..6524f67a37a20 100644
--- a/net/dsa/port.h
+++ b/net/dsa/port.h
@@ -54,8 +54,14 @@ int dsa_port_standalone_host_fdb_add(struct dsa_port *dp,
 				     const unsigned char *addr, u16 vid);
 int dsa_port_standalone_host_fdb_del(struct dsa_port *dp,
 				     const unsigned char *addr, u16 vid);
+int __dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
+				   const struct dsa_bridge *bridge,
+				   const unsigned char *addr, u16 vid);
 int dsa_port_bridge_host_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 				 u16 vid);
+int __dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
+				   const struct dsa_bridge *bridge,
+				   const unsigned char *addr, u16 vid);
 int dsa_port_bridge_host_fdb_del(struct dsa_port *dp, const unsigned char *addr,
 				 u16 vid);
 int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 041f9060c8ef0..7f18c7885b9c5 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -43,6 +43,8 @@ struct dsa_switchdev_event_work {
 	unsigned char addr[ETH_ALEN];
 	u16 vid;
 	bool host_addr;
+	bool sync;
+	bool replay;
 };
 
 enum dsa_standalone_event {
@@ -2813,6 +2815,7 @@ int dsa_user_create(struct dsa_port *port)
 
 	p->dp = port;
 	INIT_LIST_HEAD(&p->mall_tc_list);
+	INIT_LIST_HEAD(&p->bridge_host_fdbs);
 	port->user = user_dev;
 	dsa_user_setup_tagger(user_dev);
 
@@ -3627,6 +3630,22 @@ static int dsa_user_netdevice_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static bool dsa_foreign_dev_check(const struct net_device *dev,
+				  const struct net_device *foreign_dev)
+{
+	const struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_switch_tree *dst = dp->ds->dst;
+
+	if (netif_is_bridge_master(foreign_dev))
+		return !dsa_tree_offloads_bridge_dev(dst, foreign_dev);
+
+	if (netif_is_bridge_port(foreign_dev))
+		return !dsa_tree_offloads_bridge_port(dst, foreign_dev);
+
+	/* Everything else is foreign */
+	return true;
+}
+
 static void
 dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work)
 {
@@ -3639,6 +3658,171 @@ dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work)
 				 switchdev_work->orig_dev, &info.info, NULL);
 }
 
+/* The bridge notifies a roaming entry without a lock, so with two CPUs the
+ * deletion from the old port and the addition on the new one can arrive
+ * twice or out of order. Hold the host address while the bridge has the
+ * entry on a foreign port. A deletion that still finds the entry on its own
+ * port was sent before the bridge changed the port. An entry on a user port,
+ * also one of another tree, is notified only to that port.
+ */
+static bool dsa_user_bridge_host_fdb_wanted(struct net_device *dev,
+					    const struct dsa_bridge *bridge,
+					    const unsigned char *addr, u16 vid,
+					    const struct net_device *leaving)
+{
+	struct net_device *brport;
+	bool want;
+
+	rcu_read_lock();
+	brport = br_switchdev_fdb_find_port(bridge->dev, addr, vid);
+	want = brport && brport != leaving && !dsa_user_dev_check(brport) &&
+	       dsa_foreign_dev_check(dev, brport);
+	rcu_read_unlock();
+
+	return want;
+}
+
+static void dsa_user_bridge_host_fdb_set(struct net_device *dev,
+					 const struct dsa_bridge *bridge,
+					 const unsigned char *addr, u16 vid,
+					 bool want)
+{
+	struct dsa_user_priv *p = netdev_priv(dev);
+	struct dsa_port *dp = p->dp;
+	struct dsa_mac_addr *a;
+	bool held = false;
+	int err;
+
+	list_for_each_entry(a, &p->bridge_host_fdbs, list) {
+		if (ether_addr_equal(a->addr, addr) && a->vid == vid) {
+			held = true;
+			break;
+		}
+	}
+
+	if (want == held)
+		return;
+
+	if (want) {
+		a = kzalloc_obj(*a);
+		if (!a)
+			return;
+
+		err = __dsa_port_bridge_host_fdb_add(dp, bridge, addr, vid);
+		if (err) {
+			dev_err(dp->ds->dev,
+				"port %d failed to add %pM vid %d to fdb: %d\n",
+				dp->index, addr, vid, err);
+			kfree(a);
+			return;
+		}
+
+		ether_addr_copy(a->addr, addr);
+		a->vid = vid;
+		list_add(&a->list, &p->bridge_host_fdbs);
+	} else {
+		err = __dsa_port_bridge_host_fdb_del(dp, bridge, addr, vid);
+		if (err) {
+			dev_err(dp->ds->dev,
+				"port %d failed to delete %pM vid %d from fdb: %d\n",
+				dp->index, addr, vid, err);
+			return;
+		}
+
+		list_del(&a->list);
+		kfree(a);
+	}
+}
+
+static void
+dsa_user_bridge_host_fdb_sync(struct dsa_switchdev_event_work *switchdev_work)
+{
+	bool del = switchdev_work->event == SWITCHDEV_FDB_DEL_TO_DEVICE;
+	struct net_device *dev = switchdev_work->dev;
+	const struct dsa_bridge *bridge;
+	bool want = false;
+
+	/* Cleared before the workqueue is flushed and the bridge is freed */
+	bridge = READ_ONCE(dsa_user_to_port(dev)->bridge);
+	if (!bridge)
+		return;
+
+	if (!(del && switchdev_work->replay))
+		want = dsa_user_bridge_host_fdb_wanted(dev, bridge,
+						       switchdev_work->addr,
+						       switchdev_work->vid,
+						       del ? switchdev_work->orig_dev : NULL);
+
+	dsa_user_bridge_host_fdb_set(dev, bridge, switchdev_work->addr,
+				     switchdev_work->vid, want);
+	if (want && !del)
+		dsa_fdb_offload_notify(switchdev_work);
+}
+
+/* Only the user port an entry is on gets its events, so when the entry roams
+ * there, release it on the ports of the bridge that still hold it.
+ */
+static void dsa_user_bridge_host_fdb_release_work(struct work_struct *work)
+{
+	struct dsa_switchdev_event_work *switchdev_work =
+		container_of(work, struct dsa_switchdev_event_work, work);
+	struct dsa_port *dp = dsa_user_to_port(switchdev_work->dev);
+	const unsigned char *addr = switchdev_work->addr;
+	const struct dsa_bridge *bridge = READ_ONCE(dp->bridge);
+	u16 vid = switchdev_work->vid;
+	struct dsa_port *other;
+
+	if (bridge) {
+		dsa_tree_for_each_user_port(other, dp->ds->dst) {
+			if (dsa_port_offloads_bridge_dev(other, bridge->dev) &&
+			    !dsa_user_bridge_host_fdb_wanted(other->user, bridge,
+							     addr, vid, NULL))
+				dsa_user_bridge_host_fdb_set(other->user, bridge,
+							     addr, vid, false);
+		}
+	}
+
+	kfree(switchdev_work);
+}
+
+static int dsa_user_bridge_host_fdb_release(struct net_device *dev,
+					    const unsigned char *addr, u16 vid)
+{
+	struct dsa_switchdev_event_work *switchdev_work;
+
+	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
+	if (!switchdev_work)
+		return -ENOMEM;
+
+	INIT_WORK(&switchdev_work->work, dsa_user_bridge_host_fdb_release_work);
+	switchdev_work->dev = dev;
+	ether_addr_copy(switchdev_work->addr, addr);
+	switchdev_work->vid = vid;
+
+	dsa_schedule_work(&switchdev_work->work);
+
+	return 0;
+}
+
+void dsa_user_bridge_host_fdb_purge(struct dsa_port *dp,
+				    const struct dsa_bridge *bridge)
+{
+	struct dsa_user_priv *p = netdev_priv(dp->user);
+	struct dsa_mac_addr *a, *tmp;
+	int err;
+
+	list_for_each_entry_safe(a, tmp, &p->bridge_host_fdbs, list) {
+		err = __dsa_port_bridge_host_fdb_del(dp, bridge, a->addr,
+						     a->vid);
+		if (err)
+			dev_err(dp->ds->dev,
+				"port %d failed to delete %pM vid %d from fdb: %d\n",
+				dp->index, a->addr, a->vid, err);
+		list_del(&a->list);
+		kfree(a);
+	}
+}
+
 static void dsa_user_switchdev_event_work(struct work_struct *work)
 {
 	struct dsa_switchdev_event_work *switchdev_work =
@@ -3653,6 +3837,12 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 	dp = dsa_user_to_port(dev);
 	ds = dp->ds;
 
+	if (switchdev_work->sync) {
+		dsa_user_bridge_host_fdb_sync(switchdev_work);
+		kfree(switchdev_work);
+		return;
+	}
+
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 		if (switchdev_work->host_addr)
@@ -3689,22 +3879,6 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 	kfree(switchdev_work);
 }
 
-static bool dsa_foreign_dev_check(const struct net_device *dev,
-				  const struct net_device *foreign_dev)
-{
-	const struct dsa_port *dp = dsa_user_to_port(dev);
-	struct dsa_switch_tree *dst = dp->ds->dst;
-
-	if (netif_is_bridge_master(foreign_dev))
-		return !dsa_tree_offloads_bridge_dev(dst, foreign_dev);
-
-	if (netif_is_bridge_port(foreign_dev))
-		return !dsa_tree_offloads_bridge_port(dst, foreign_dev);
-
-	/* Everything else is foreign */
-	return true;
-}
-
 static int dsa_user_fdb_event(struct net_device *dev,
 			      struct net_device *orig_dev,
 			      unsigned long event, const void *ctx,
@@ -3723,7 +3897,9 @@ static int dsa_user_fdb_event(struct net_device *dev,
 
 	if (switchdev_fdb_is_dynamically_learned(fdb_info)) {
 		if (dsa_port_offloads_bridge_port(dp, orig_dev))
-			return 0;
+			return event == SWITCHDEV_FDB_ADD_TO_DEVICE ?
+			       dsa_user_bridge_host_fdb_release(dev, fdb_info->addr,
+								fdb_info->vid) : 0;
 
 		/* FDB entries learned by the software bridge or by foreign
 		 * bridge ports should be installed as host addresses only if
@@ -3768,9 +3944,15 @@ static int dsa_user_fdb_event(struct net_device *dev,
 	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
 	switchdev_work->vid = fdb_info->vid;
 	switchdev_work->host_addr = host_addr;
+	switchdev_work->sync = host_addr && !fdb_info->is_local;
+	switchdev_work->replay = !!ctx;
 
 	dsa_schedule_work(&switchdev_work->work);
 
+	if (!host_addr && event == SWITCHDEV_FDB_ADD_TO_DEVICE)
+		return dsa_user_bridge_host_fdb_release(dev, fdb_info->addr,
+							fdb_info->vid);
+
 	return 0;
 }
 
diff --git a/net/dsa/user.h b/net/dsa/user.h
index 016884bead3cd..dd38104162da4 100644
--- a/net/dsa/user.h
+++ b/net/dsa/user.h
@@ -33,6 +33,12 @@ struct dsa_user_priv {
 
 	/* TC context */
 	struct list_head	mall_tc_list;
+
+	/* Host addresses of bridge FDB entries held through this port,
+	 * changed from the DSA workqueue, or with the port out of the bridge
+	 * and the workqueue flushed
+	 */
+	struct list_head	bridge_host_fdbs;
 };
 
 void dsa_user_mii_bus_init(struct dsa_switch *ds);
@@ -47,6 +53,8 @@ void dsa_user_host_uc_uninstall(struct net_device *dev);
 void dsa_user_sync_ha(struct net_device *dev);
 void dsa_user_unsync_ha(struct net_device *dev);
 void dsa_user_setup_tagger(struct net_device *user);
+void dsa_user_bridge_host_fdb_purge(struct dsa_port *dp,
+				    const struct dsa_bridge *bridge);
 int dsa_user_change_mtu(struct net_device *dev, int new_mtu);
 int dsa_user_change_conduit(struct net_device *dev, struct net_device *conduit,
 			    struct netlink_ext_ack *extack);
-- 
2.53.0

